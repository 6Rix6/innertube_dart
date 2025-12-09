import 'package:innertube_dart/src/models/renderer/chip_cloud_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_playlist_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_responsive_header_renderer.dart';
import 'package:innertube_dart/src/models/yt_item.dart';
import 'package:innertube_dart/src/models/artist.dart';
import 'package:innertube_dart/src/models/song_item.dart';
import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/renderer/music_carousel_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_shelf_renderer.dart';
import 'package:innertube_dart/src/models/section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section_list_renderer.g.dart';

@JsonSerializable()
class SecionList {
  final SectionListRenderer? sectionListRenderer;
  final List<Continuations>? continuations;

  const SecionList({this.sectionListRenderer, this.continuations});

  factory SecionList.fromJson(Map<String, dynamic> json) =>
      _$SecionListFromJson(json);

  Map<String, dynamic> toJson() => _$SecionListToJson(this);
}

@JsonSerializable()
class SectionListRenderer {
  final List<SectionListRendererContent>? contents;
  final List<Continuations>? continuations;
  final String? trackingParams;
  final SectionListHeader? header;

  const SectionListRenderer({
    this.contents,
    this.continuations,
    this.trackingParams,
    this.header,
  });

  factory SectionListRenderer.fromJson(Map<String, dynamic> json) =>
      _$SectionListRendererFromJson(json);

  Map<String, dynamic> toJson() => _$SectionListRendererToJson(this);
}

@JsonSerializable()
class SectionListRendererContent {
  final MusicCarouselShelfRenderer? musicCarouselShelfRenderer;
  final MusicShelfRenderer? musicShelfRenderer;
  final MusicResponsiveHeaderRenderer? musicResponsiveHeaderRenderer;
  final MusicPlaylistShelfRenderer? musicPlaylistShelfRenderer;
  // TODO: Add support for music card shelf renderer
  final Map<String, dynamic>? musicCardShelfRenderer;

  const SectionListRendererContent({
    this.musicCarouselShelfRenderer,
    this.musicShelfRenderer,
    this.musicResponsiveHeaderRenderer,
    this.musicPlaylistShelfRenderer,
    this.musicCardShelfRenderer,
  });

  factory SectionListRendererContent.fromJson(Map<String, dynamic> json) =>
      _$SectionListRendererContentFromJson(json);

  Map<String, dynamic> toJson() => _$SectionListRendererContentToJson(this);

  /// Parse a section content (either music shelf or carousel shelf)
  Section? parseSectionContent() {
    // Try parsing as MusicShelfRenderer (for songs)
    if (musicShelfRenderer != null) {
      return _parseMusicShelfRenderer(musicShelfRenderer!);
    }

    // Try parsing as MusicCarouselShelfRenderer (for albums/playlists)
    if (musicCarouselShelfRenderer != null) {
      return _parseMusicCarouselShelfRenderer(musicCarouselShelfRenderer!);
    }

    return null;
  }

  /// Parse MusicShelfRenderer section (songs list)
  Section? _parseMusicShelfRenderer(MusicShelfRenderer shelfData) {
    try {
      final items = <SongItem>[];
      if (shelfData.contents != null) {
        for (final content in shelfData.contents!) {
          final renderer = content.musicResponsiveListItemRenderer;
          try {
            final item = _parseSongFromRenderer(renderer);
            if (item != null) items.add(item);
          } catch (e) {
            // Skip invalid items
            continue;
          }
        }
      }

      return Section(
        items: items,
        type: SectionType.musicShelf,
        itemType: SectionItemType.musicResponsiveListItem,
      );
    } catch (e) {
      return null;
    }
  }

  /// Parse MusicCarouselShelfRenderer section (albums/playlists carousel)
  Section? _parseMusicCarouselShelfRenderer(
    MusicCarouselShelfRenderer carouselData,
  ) {
    try {
      final title = carouselData
          .header
          ?.musicCarouselShelfBasicHeaderRenderer
          ?.title
          ?.runs
          ?.firstOrNull
          ?.text;

      final moreButton = carouselData
          .header
          ?.musicCarouselShelfBasicHeaderRenderer
          ?.moreContentButton
          ?.buttonRenderer;

      final moreEndpoint = moreButton?.navigationEndpoint;
      final itemType =
          carouselData.contents.firstOrNull?.musicTwoRowItemRenderer != null
          ? SectionItemType.musicTwoRowItem
          : SectionItemType.musicResponsiveListItem;

      final items = <YTItem>[];
      for (final container in carouselData.contents) {
        if (container.musicTwoRowItemRenderer != null) {
          final item = container.musicTwoRowItemRenderer!.toYTItem();
          if (item != null) items.add(item);
        } else if (container.musicResponsiveListItemRenderer != null) {
          final item = _parseSongFromRenderer(
            container.musicResponsiveListItemRenderer!,
          );
          if (item != null) items.add(item);
        }
      }

      final header = SectionHeader(
        title: title,
        strapline: carouselData
            .header
            ?.musicCarouselShelfBasicHeaderRenderer
            ?.strapline
            ?.runs
            ?.firstOrNull
            ?.text,
        thumbnail: carouselData
            .header
            ?.musicCarouselShelfBasicHeaderRenderer
            ?.thumbnail
            ?.musicThumbnailRenderer
            ?.thumbnail
            .thumbnails
            .firstOrNull,
        moreEndpoint: moreEndpoint,
        moreButton: moreButton,
      );

      return Section(
        title: title,
        items: items,
        moreEndpoint: moreEndpoint,
        type: SectionType.musicCarouselShelf,
        itemType: itemType,
        header: header,
      );
    } catch (e) {
      return null;
    }
  }

  /// Parse a song from MusicResponsiveListItemRenderer
  SongItem? _parseSongFromRenderer(MusicResponsiveListItemRenderer renderer) {
    try {
      final flexColumns = renderer.flexColumns;
      if (flexColumns.isEmpty) return null;

      final titleRuns = flexColumns[0].renderer?.text?.runs;
      if (titleRuns == null || titleRuns.isEmpty) return null;

      final title = titleRuns.first.text;
      final videoId =
          renderer.playlistItemData?.videoId ??
          renderer.navigationEndpoint?.watchEndpoint?.videoId;

      if (videoId == null) return null;

      // Parse artists
      final artists = <Artist>[];
      if (flexColumns.length > 1) {
        final artistRuns = flexColumns[1].renderer?.text?.runs;
        if (artistRuns != null) {
          for (final run in artistRuns) {
            if (run.navigationEndpoint?.browseEndpoint != null) {
              artists.add(
                Artist(
                  name: run.text,
                  id: run.navigationEndpoint!.browseEndpoint!.browseId,
                ),
              );
            }
          }
        }
      }

      // Get thumbnail
      final thumbnails = renderer.thumbnail?.musicThumbnailRenderer?.thumbnail;

      // Check if explicit
      final explicit =
          renderer.badges?.any(
            (badge) =>
                badge.musicInlineBadgeRenderer?.icon?.iconType ==
                'MUSIC_EXPLICIT_BADGE',
          ) ??
          false;

      return SongItem(
        id: videoId,
        title: title,
        artists: artists,
        album: null,
        duration: null,
        thumbnails: thumbnails!,
        explicit: explicit,
      );
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable()
class SectionListHeader {
  final ChipCloudRenderer? chipCloudRenderer;

  const SectionListHeader({this.chipCloudRenderer});

  factory SectionListHeader.fromJson(Map<String, dynamic> json) =>
      _$SectionListHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$SectionListHeaderToJson(this);
}
