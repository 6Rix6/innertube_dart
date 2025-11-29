import 'package:innertube_dart/src/models/album_item.dart';
import 'package:innertube_dart/src/models/artist_item.dart';
import 'package:innertube_dart/src/models/artist_section.dart';
import 'package:innertube_dart/src/models/playlist_item.dart';
import 'package:innertube_dart/src/models/renderer/navigation_endpoint.dart';
import 'package:innertube_dart/src/models/song_item.dart';
import 'package:innertube_dart/src/models/response/browse_response.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_two_row_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_carousel_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_shelf_renderer.dart';
import 'package:innertube_dart/src/models/artist.dart';
import 'package:innertube_dart/src/models/yt_item.dart';

/// Represents an artist page with sections
class ArtistPage {
  final String browseId;
  final String name;
  final String? description;
  final String? thumbnailUrl;
  final String? subscriberCountText;
  final List<ArtistSection> sections;

  const ArtistPage({
    required this.browseId,
    required this.name,
    this.description,
    this.thumbnailUrl,
    this.subscriberCountText,
    required this.sections,
  });

  /// Parse an artist page from a BrowseResponse
  factory ArtistPage.fromBrowseResponse(
    BrowseResponse response,
    String browseId,
  ) {
    final contents = response.contents;
    if (contents == null) {
      throw Exception('No contents in browse response');
    }

    // Get section list renderer
    final sectionListRenderer =
        contents['singleColumnBrowseResultsRenderer']?['tabs']?[0]?['tabRenderer']?['content']?['sectionListRenderer'];

    if (sectionListRenderer == null) {
      throw Exception('No section list renderer found');
    }

    final sectionContents =
        sectionListRenderer['contents'] as List<dynamic>? ?? [];

    // Parse artist metadata from header
    final header =
        response.header?['musicImmersiveHeaderRenderer'] ??
        response.header?['musicVisualHeaderRenderer'];

    final name =
        header?['title']?['runs']?[0]?['text'] as String? ?? 'Unknown Artist';

    final description = header?['description']?['runs']?[0]?['text'] as String?;

    final thumbnailUrl =
        (header?['thumbnail']?['musicThumbnailRenderer']?['thumbnail']?['thumbnails']
                    as List<dynamic>?)
                ?.lastOrNull?['url']
            as String?;

    final subscriberCountText =
        header?['subscriptionButton']?['subscribeButtonRenderer']?['subscriberCountText']?['runs']?[0]?['text']
            as String?;

    // Parse sections
    final sections = <ArtistSection>[];
    for (final content in sectionContents) {
      final contentMap = content as Map<String, dynamic>?;
      if (contentMap == null) continue;

      final section = _parseSectionContent(contentMap);
      if (section != null) {
        sections.add(section);
      }
    }

    return ArtistPage(
      browseId: browseId,
      name: name,
      description: description,
      thumbnailUrl: thumbnailUrl,
      subscriberCountText: subscriberCountText,
      sections: sections,
    );
  }

  /// Parse a section content (either music shelf or carousel shelf)
  static ArtistSection? _parseSectionContent(Map<String, dynamic> content) {
    // Try parsing as MusicShelfRenderer (for songs)
    if (content.containsKey('musicShelfRenderer')) {
      return _parseMusicShelfRenderer(content['musicShelfRenderer']);
    }

    // Try parsing as MusicCarouselShelfRenderer (for albums/playlists)
    if (content.containsKey('musicCarouselShelfRenderer')) {
      return _parseMusicCarouselShelfRenderer(
        content['musicCarouselShelfRenderer'],
      );
    }

    return null;
  }

  /// Parse MusicShelfRenderer section (songs list)
  static ArtistSection? _parseMusicShelfRenderer(
    Map<String, dynamic> shelfData,
  ) {
    try {
      final shelf = MusicShelfRenderer.fromJson(shelfData);
      final title = shelf.title?.runs?.firstOrNull?.text ?? 'Songs';

      final moreEndpoint = shelf.bottomEndpoint?.browseEndpoint?.browseId;

      final items = <SongItem>[];
      if (shelf.contents != null) {
        for (final content in shelf.contents!) {
          final renderer = content['musicResponsiveListItemRenderer'];
          if (renderer != null) {
            try {
              final item = _parseSongFromRenderer(
                MusicResponsiveListItemRenderer.fromJson(renderer),
              );
              if (item != null) items.add(item);
            } catch (e) {
              // Skip invalid items
              continue;
            }
          }
        }
      }

      return ArtistSection(
        title: title,
        items: items,
        moreEndpoint: moreEndpoint,
      );
    } catch (e) {
      return null;
    }
  }

  /// Parse MusicCarouselShelfRenderer section (albums/playlists carousel)
  static ArtistSection? _parseMusicCarouselShelfRenderer(
    Map<String, dynamic> carouselData,
  ) {
    try {
      final carousel = MusicCarouselShelfRenderer.fromJson(carouselData);
      final title = carousel.header?.title?.runs?.firstOrNull?.text ?? 'Albums';

      final moreEndpoint = carousel
          .header
          ?.moreContentButton
          ?.buttonRenderer
          ?.navigationEndpoint
          ?.browseEndpoint
          ?.browseId;

      final items = <YTItem>[];
      for (final container in carousel.contents) {
        final renderer = container.musicTwoRowItemRenderer;
        if (renderer != null) {
          final item = _parseItemFromTwoRowRenderer(renderer);
          if (item != null) items.add(item);
        }
      }

      return ArtistSection(
        title: title,
        items: items,
        moreEndpoint: moreEndpoint,
      );
    } catch (e) {
      return null;
    }
  }

  /// Parse a song from MusicResponsiveListItemRenderer
  static SongItem? _parseSongFromRenderer(
    MusicResponsiveListItemRenderer renderer,
  ) {
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
      final thumbnailUrl = renderer.thumbnail?.getThumbnailUrl();

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
        thumbnail: thumbnailUrl!,
        explicit: explicit,
      );
    } catch (e) {
      return null;
    }
  }

  /// Parse an item from MusicTwoRowItemRenderer
  static dynamic _parseItemFromTwoRowRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
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
  static SongItem? _parseSongFromTwoRowRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
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

    final thumbnailUrl = renderer.thumbnailRenderer?.getThumbnailUrl();

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
      thumbnail: thumbnailUrl!,
      explicit: explicit,
    );
  }

  /// Parse album from two-row renderer
  static AlbumItem? _parseAlbumFromTwoRowRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
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

    final thumbnailUrl = renderer.thumbnailRenderer?.getThumbnailUrl();

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
      thumbnail: thumbnailUrl!,
      explicit: explicit,
    );
  }

  /// Parse playlist from two-row renderer
  static PlaylistItem? _parsePlaylistFromTwoRowRenderer(
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

    final thumbnailUrl = renderer.thumbnailRenderer?.getThumbnailUrl();

    final playEndpoint = renderer
        .thumbnailOverlay
        ?.musicItemThumbnailOverlayRenderer
        ?.content
        ?.musicPlayButtonRenderer
        ?.playNavigationEndpoint
        ?.watchPlaylistEndpoint;

    final shuffleEndpoint = renderer.menu?.items
        ?.firstWhere(
          (item) =>
              item.menuNavigationItemRenderer?['icon']?['iconType'] ==
              'MUSIC_SHUFFLE',
          orElse: () => MenuItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer?['navigationEndpoint']?['watchPlaylistEndpoint'];
    final radioEndpoint = renderer.menu?.items
        ?.firstWhere(
          (item) =>
              item.menuNavigationItemRenderer?['icon']?['iconType'] == 'MIX',
          orElse: () => MenuItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer?['navigationEndpoint']?['watchPlaylistEndpoint'];

    return PlaylistItem(
      id: id,
      title: title,
      author: author,
      songCountText: null,
      thumbnail: thumbnailUrl,
      playEndpoint: playEndpoint,
      shuffleEndpoint: shuffleEndpoint != null
          ? WatchPlaylistEndpoint.fromJson(shuffleEndpoint)
          : null,
      radioEndpoint: radioEndpoint != null
          ? WatchPlaylistEndpoint.fromJson(radioEndpoint)
          : null,
    );
  }

  /// Parse artist from two-row renderer
  static ArtistItem? _parseArtistFromTwoRowRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final title = renderer.title?.runs?.lastOrNull?.text;
    if (title == null) return null;

    final thumbnailUrl = renderer.thumbnailRenderer?.getThumbnailUrl();

    final channelId =
        renderer.menu?.items
                ?.firstWhere(
                  (item) =>
                      item.toggleMenuServiceItemRenderer?['defaultIcon']?['iconType'] ==
                      'SUBSCRIBE',
                  orElse: () => MenuItem(
                    menuNavigationItemRenderer: null,
                    toggleMenuServiceItemRenderer: null,
                  ),
                )
                .toggleMenuServiceItemRenderer?['defaultServiceEndpoint']?['subscribeEndpoint']?['channelIds']?[0]
            as String?;

    final shuffleEndpoint = renderer.menu?.items
        ?.firstWhere(
          (item) =>
              item.menuNavigationItemRenderer?['icon']?['iconType'] ==
              'MUSIC_SHUFFLE',
          orElse: () => MenuItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer?['navigationEndpoint']?['watchPlaylistEndpoint'];

    final radioEndpoint = renderer.menu?.items
        ?.firstWhere(
          (item) =>
              item.menuNavigationItemRenderer?['icon']?['iconType'] == 'MIX',
          orElse: () => MenuItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer?['navigationEndpoint']?['watchPlaylistEndpoint'];

    return ArtistItem(
      id: browseId,
      title: title,
      thumbnail: thumbnailUrl,
      channelId: channelId,
      shuffleEndpoint: shuffleEndpoint != null
          ? WatchPlaylistEndpoint.fromJson(shuffleEndpoint)
          : null,
      radioEndpoint: radioEndpoint != null
          ? WatchPlaylistEndpoint.fromJson(radioEndpoint)
          : null,
    );
  }

  @override
  String toString() {
    return 'ArtistPage(browseId: $browseId, name: $name, description: $description, thumbnailUrl: $thumbnailUrl, subscriberCountText: $subscriberCountText, sections: $sections)';
  }
}
