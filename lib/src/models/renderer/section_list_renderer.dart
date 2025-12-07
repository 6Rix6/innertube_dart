import 'package:innertube_dart/src/models/album_item.dart';
import 'package:innertube_dart/src/models/artist_item.dart';
import 'package:innertube_dart/src/models/playlist_item.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_playlist_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_responsive_header_renderer.dart';
import 'package:innertube_dart/src/models/yt_item.dart';
import 'package:innertube_dart/src/models/artist.dart';
import 'package:innertube_dart/src/models/song_item.dart';
import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/renderer/music_carousel_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_two_row_item_renderer.dart';
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
  final List<SectionListRendererContents>? contents;
  final List<Continuations>? continuations;
  final String? trackingParams;
  final Map<String, dynamic>? header;

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
class SectionListRendererContents {
  final MusicCarouselShelfRenderer? musicCarouselShelfRenderer;
  final MusicShelfRenderer? musicShelfRenderer;
  final MusicResponsiveHeaderRenderer? musicResponsiveHeaderRenderer;
  final MusicPlaylistShelfRenderer? musicPlaylistShelfRenderer;
  // TODO: Add support for music card shelf renderer
  final Map<String, dynamic>? musicCardShelfRenderer;

  const SectionListRendererContents({
    this.musicCarouselShelfRenderer,
    this.musicShelfRenderer,
    this.musicResponsiveHeaderRenderer,
    this.musicPlaylistShelfRenderer,
    this.musicCardShelfRenderer,
  });

  factory SectionListRendererContents.fromJson(Map<String, dynamic> json) =>
      _$SectionListRendererContentsFromJson(json);

  Map<String, dynamic> toJson() => _$SectionListRendererContentsToJson(this);

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
  Section<SongItem>? _parseMusicShelfRenderer(MusicShelfRenderer shelfData) {
    try {
      final title = shelfData.title?.runs?.firstOrNull?.text ?? 'Songs';

      final moreEndpoint = shelfData.bottomEndpoint?.browseEndpoint?.browseId;

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

      return Section(title: title, items: items, moreEndpoint: moreEndpoint);
    } catch (e) {
      return null;
    }
  }

  /// Parse MusicCarouselShelfRenderer section (albums/playlists carousel)
  Section? _parseMusicCarouselShelfRenderer(
    MusicCarouselShelfRenderer carouselData,
  ) {
    try {
      final title =
          carouselData.header?.title?.runs?.firstOrNull?.text ?? 'Albums';

      final moreEndpoint = carouselData
          .header
          ?.moreContentButton
          ?.buttonRenderer
          ?.navigationEndpoint
          ?.browseEndpoint
          ?.browseId;

      final items = <YTItem>[];
      for (final container in carouselData.contents) {
        if (container.musicTwoRowItemRenderer != null) {
          final item = _parseItemFromTwoRowRenderer(
            container.musicTwoRowItemRenderer!,
          );
          if (item != null) items.add(item);
        } else if (container.musicResponsiveListItemRenderer != null) {
          final item = _parseSongFromRenderer(
            container.musicResponsiveListItemRenderer!,
          );
          if (item != null) items.add(item);
        }
      }

      return Section(title: title, items: items, moreEndpoint: moreEndpoint);
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

  /// Parse an item from MusicTwoRowItemRenderer
  dynamic _parseItemFromTwoRowRenderer(MusicTwoRowItemRenderer renderer) {
    try {
      if (renderer.isSong) {
        return _parseSongFromTwoRowRenderer(renderer);
      } else if (renderer.isAlbum) {
        return _parseAlbumFromTwoRowRenderer(renderer);
      } else if (renderer.isPlaylist) {
        return _parsePlaylistFromTwoRowRenderer(renderer);
      } else if (renderer.isArtist) {
        return _parseArtistFromTwoRowRenderer(renderer);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Parse song from two-row renderer
  SongItem? _parseSongFromTwoRowRenderer(MusicTwoRowItemRenderer renderer) {
    final videoId = renderer.navigationEndpoint?.watchEndpoint?.videoId;
    if (videoId == null) return null;

    final title = renderer.title?.runs?.firstOrNull?.text;
    if (title == null) return null;

    final artists = <Artist>[];
    final artistRun = renderer.subtitle?.runs?.firstOrNull;
    if (artistRun != null) {
      artists.add(
        Artist(
          name: artistRun.text,
          id: artistRun.navigationEndpoint?.browseEndpoint?.browseId,
        ),
      );
    }

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final explicit =
        renderer.subtitleBadges?.any(
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
  }

  /// Parse album from two-row renderer
  AlbumItem? _parseAlbumFromTwoRowRenderer(MusicTwoRowItemRenderer renderer) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final title = renderer.title?.runs?.firstOrNull?.text;
    if (title == null) return null;

    final playlistId = renderer
        .thumbnailOverlay
        ?.musicItemThumbnailOverlayRenderer
        ?.content
        ?.musicPlayButtonRenderer
        ?.playNavigationEndpoint
        ?.watchPlaylistEndpoint
        ?.playlistId;

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final year = renderer.subtitle?.runs?.lastOrNull?.text;

    final explicit =
        renderer.subtitleBadges?.any(
          (badge) =>
              badge.musicInlineBadgeRenderer?.icon?.iconType ==
              'MUSIC_EXPLICIT_BADGE',
        ) ??
        false;

    return AlbumItem(
      browseId: browseId,
      playlistId: playlistId!,
      title: title,
      artists: null, // always null
      year: year,
      thumbnails: thumbnails!,
      explicit: explicit,
    );
  }

  /// Parse playlist from two-row renderer
  PlaylistItem? _parsePlaylistFromTwoRowRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final id = browseId.startsWith('VL') ? browseId.substring(2) : browseId;
    final title = renderer.title?.runs?.firstOrNull?.text;
    if (title == null) return null;

    final author = Artist(
      name: renderer.subtitle?.runs?.lastOrNull?.text ?? '',
      id: null,
    );

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final playEndpoint = renderer
        .thumbnailOverlay
        ?.musicItemThumbnailOverlayRenderer
        ?.content
        ?.musicPlayButtonRenderer
        ?.playNavigationEndpoint
        ?.watchPlaylistEndpoint;

    final shuffleEndpoint = renderer.menu?.menuRenderer.items
        ?.firstWhere(
          (item) =>
              item.menuNavigationItemRenderer?.icon.iconType == 'MUSIC_SHUFFLE',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;
    final radioEndpoint = renderer.menu?.menuRenderer.items
        ?.firstWhere(
          (item) => item.menuNavigationItemRenderer?.icon.iconType == 'MIX',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;

    return PlaylistItem(
      id: id,
      title: title,
      author: author,
      songCountText: null,
      thumbnails: thumbnails!,
      watchPlaylistEndpoint: playEndpoint,
      shuffleEndpoint: shuffleEndpoint,
      radioEndpoint: radioEndpoint,
    );
  }

  /// Parse artist from two-row renderer
  ArtistItem? _parseArtistFromTwoRowRenderer(MusicTwoRowItemRenderer renderer) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final title = renderer.title?.runs?.lastOrNull?.text;
    if (title == null) return null;

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final channelId =
        renderer.menu?.menuRenderer.items
                ?.firstWhere(
                  (item) =>
                      item.toggleMenuServiceItemRenderer?['defaultIcon']?['iconType'] ==
                      'SUBSCRIBE',
                  orElse: () => MenuRendererItem(
                    menuNavigationItemRenderer: null,
                    toggleMenuServiceItemRenderer: null,
                  ),
                )
                .toggleMenuServiceItemRenderer?['defaultServiceEndpoint']?['subscribeEndpoint']?['channelIds']?[0]
            as String?;

    final shuffleEndpoint = renderer.menu?.menuRenderer.items
        ?.firstWhere(
          (item) =>
              item.menuNavigationItemRenderer?.icon.iconType == 'MUSIC_SHUFFLE',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;

    final radioEndpoint = renderer.menu?.menuRenderer.items
        ?.firstWhere(
          (item) => item.menuNavigationItemRenderer?.icon.iconType == 'MIX',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;

    return ArtistItem(
      id: browseId,
      title: title,
      thumbnails: thumbnails!,
      channelId: channelId,
      shuffleEndpoint: shuffleEndpoint,
      radioEndpoint: radioEndpoint,
    );
  }
}
