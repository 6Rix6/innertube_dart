import 'package:innertube_dart/src/models/page_header.dart';
import 'package:innertube_dart/src/models/renderer/chip_cloud_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_playlist_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_responsive_header_renderer.dart';
import 'package:innertube_dart/src/models/yt_item.dart';
import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/renderer/music_carousel_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_shelf_renderer.dart';
import 'package:innertube_dart/src/models/section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section_list_renderer.g.dart';

@JsonSerializable()
class SectionList {
  final SectionListRenderer? sectionListRenderer;
  final List<Continuations>? continuations;

  const SectionList({this.sectionListRenderer, this.continuations});

  factory SectionList.fromJson(Map<String, dynamic> json) =>
      _$SectionListFromJson(json);

  Map<String, dynamic> toJson() => _$SectionListToJson(this);
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
  Section? toSection() {
    // Try parsing as MusicShelfRenderer (for songs)
    if (musicShelfRenderer != null) {
      return MusicShelfSection.fromMusicShelfRenderer(musicShelfRenderer!);
    }

    // Try parsing as MusicCarouselShelfRenderer (for albums/playlists)
    if (musicCarouselShelfRenderer != null) {
      return _parseMusicCarouselShelfRenderer(musicCarouselShelfRenderer!);
    }

    return null;
  }

  /// Parse MusicShelfRenderer section (songs list)
  // Section? _parseMusicShelfRenderer(MusicShelfRenderer shelfData) {
  //   try {
  //     final items = <YTItem>[];
  //     if (shelfData.contents != null) {
  //       for (final content in shelfData.contents!) {
  //         final renderer = content.musicResponsiveListItemRenderer;
  //         try {
  //           final item = renderer.toYTItem();
  //           if (item != null) items.add(item);
  //         } catch (e) {
  //           // Skip invalid items
  //           continue;
  //         }
  //       }
  //     }

  //     return Section(
  //       contents: items,
  //       type: SectionType.musicShelf,
  //       itemType: SectionItemType.musicResponsiveListItem,
  //     );
  //   } catch (e) {
  //     return null;
  //   }
  // }

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
          final item = container.musicResponsiveListItemRenderer!.toYTItem();
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
        contents: items,
        moreEndpoint: moreEndpoint,
        type: SectionType.musicCarouselShelf,
        itemType: itemType,
        header: header,
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

  PageHeader toPageHeader() {
    return PageHeader(
      chips:
          chipCloudRenderer?.chips
              ?.map((e) => e.chipCloudChipRenderer)
              .toList() ??
          [],
      horizontalScrollable: chipCloudRenderer?.horizontalScrollable,
      collapsedRowCount: chipCloudRenderer?.collapsedRowCount,
    );
  }
}
