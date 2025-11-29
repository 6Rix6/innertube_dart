import 'package:innertube_dart/src/pages/artist_page.dart';

import '../pages/album_page.dart';
import '../pages/search_result.dart';
import '../pages/search_page.dart';
import '../pages/playlist_page.dart';
import '../utils/result.dart';
import '../models/yt_item.dart';
import '../models/youtube_locale.dart';
import '../models/youtube_client.dart';
import '../models/response/browse_response.dart';
import '../models/response/search_response.dart';
import '../models/renderer/music_item_renderer.dart';
import 'innertube.dart';

/// High-level YouTube Music API client
class YouTube {
  late final InnerTube _innerTube;

  YouTubeLocale get locale => _innerTube.locale;
  set locale(YouTubeLocale value) => _innerTube.locale = value;

  String? get visitorData => _innerTube.visitorData;
  set visitorData(String? value) => _innerTube.visitorData = value;

  String? get dataSyncId => _innerTube.dataSyncId;
  set dataSyncId(String? value) => _innerTube.dataSyncId = value;

  String? get cookie => _innerTube.cookie;
  set cookie(String? value) => _innerTube.cookie = value;

  YouTube({
    YouTubeLocale locale = YouTubeLocale.defaultLocale,
    String? visitorData,
    String? dataSyncId,
    String? cookie,
  }) {
    _innerTube = InnerTube(
      locale: locale,
      visitorData: visitorData,
      dataSyncId: dataSyncId,
      cookie: cookie,
    );
  }

  /// Search for content on YouTube Music
  ///
  /// [query] - Search query string
  /// [filter] - Filter results by type
  /// Returns a Result containing SearchResult or an error
  Future<Result<SearchResult>> search(String query, SearchFilter filter) async {
    try {
      // Call InnerTube search API
      final response = await _innerTube.search(
        YouTubeClient.webRemix,
        query: query,
        params: filter.value,
      );

      // Parse response as SearchResponse
      final searchResponse = SearchResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Get shelf contents and parse
      final shelfContents = searchResponse.getMusicShelfContents();
      final items = <YTItem>[];

      for (final itemJson in shelfContents) {
        final renderer = itemJson['musicResponsiveListItemRenderer'];
        if (renderer != null) {
          final item = SearchPage.toYTItem(
            MusicResponsiveListItemRenderer.fromJson(
              renderer as Map<String, dynamic>,
            ),
          );
          if (item != null) {
            items.add(item);
          }
        }
      }

      final continuation = searchResponse.getContinuation();

      return Result.success(
        SearchResult(items: items, continuation: continuation),
      );
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Get album details
  ///
  /// [browseId] - Album browse ID
  /// [withSongs] - Whether to fetch songs (default: true)
  /// Returns a Result containing AlbumPage or an error
  Future<Result<AlbumPage>> album(
    String browseId, {
    bool withSongs = true,
  }) async {
    try {
      // Call InnerTube browse API
      final response = await _innerTube.browse(
        YouTubeClient.webRemix,
        browseId: browseId,
      );

      // Parse response as BrowseResponse
      final browseResponse = BrowseResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Parse AlbumPage
      final albumPage = AlbumPage.fromBrowseResponse(browseResponse, browseId);

      if (albumPage == null) {
        return Result.error(Exception('Failed to parse album page'));
      }

      return Result.success(albumPage);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Get playlist details
  ///
  /// [playlistId] - Playlist ID
  /// Returns a Result containing PlaylistPage or an error
  Future<Result<PlaylistPage>> playlist(String playlistId) async {
    try {
      // Convert playlistId to browseId (add VL prefix if not present)
      final browseId = playlistId.startsWith('VL')
          ? playlistId
          : 'VL$playlistId';

      // Call InnerTube browse API
      final response = await _innerTube.browse(
        YouTubeClient.webRemix,
        browseId: browseId,
      );

      // Parse response as BrowseResponse
      final browseResponse = BrowseResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Parse PlaylistPage (use original playlistId without VL prefix)
      final cleanPlaylistId = playlistId.startsWith('VL')
          ? playlistId.substring(2)
          : playlistId;
      final playlistPage = PlaylistPage.fromBrowseResponse(
        browseResponse,
        cleanPlaylistId,
      );

      if (playlistPage == null) {
        return Result.error(Exception('Failed to parse playlist page'));
      }

      return Result.success(playlistPage);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Get artist details
  ///
  /// [browseId] - Artist browse ID
  /// Returns a Result containing ArtistPage or an error
  Future<Result<ArtistPage>> artist(String browseId) async {
    try {
      // Call InnerTube browse API
      final response = await _innerTube.browse(
        YouTubeClient.webRemix,
        browseId: browseId,
      );

      // Parse response as BrowseResponse
      final browseResponse = BrowseResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Parse ArtistPage
      final artistPage = ArtistPage.fromBrowseResponse(
        browseResponse,
        browseId,
      );

      return Result.success(artistPage);
    } catch (e) {
      return Result.error(e);
    }
  }

  void dispose() {
    _innerTube.close();
  }

  @override
  String toString() => 'YouTube(locale: $locale)';
}
