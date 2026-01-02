import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/response/account_menu_response.dart';
import 'package:innertube_dart/src/models/response/next_response.dart';
import 'package:innertube_dart/src/pages/account_menu_page.dart';
import 'package:innertube_dart/src/pages/artist_page.dart';
import 'package:innertube_dart/src/pages/home_page.dart';
import 'package:innertube_dart/src/pages/next_page.dart';
import 'package:innertube_dart/src/pages/search_page.dart';

import '../pages/album_page.dart';
import '../pages/search_result.dart';
import '../pages/playlist_page.dart';
import '../utils/result.dart';
import '../models/youtube_locale.dart';
import '../models/youtube_client.dart';
import '../models/response/browse_response.dart';
import '../models/response/search_response.dart';
import '../models/response/player_response.dart';
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

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  YouTube({
    YouTubeLocale locale = YouTubeLocale.defaultLocale,
    String? visitorData,
    String? dataSyncId,
    String? cookie,
    Function(String)? onCookieUpdate,
    int accountIndex = 0,
  }) {
    _innerTube = InnerTube(
      locale: locale,
      visitorData: visitorData,
      dataSyncId: dataSyncId,
      cookie: cookie,
      onCookieUpdate: onCookieUpdate,
      accountIndex: accountIndex,
    );
  }

  /// Initialize InnerTube
  ///
  /// Returns a Future that completes when initialization is complete
  Future<void> initialize() async {
    if (_isInitialized) return;
    await _innerTube.initialize();
    _isInitialized = true;
  }

  /// Wait for initialization to complete
  ///
  /// Returns a Future that completes when initialization is complete
  Future<void> waitForInitialization() async {
    while (!_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Search for content on YouTube Music
  ///
  /// [query] - Search query string
  /// [filter] - Filter results by type
  /// Returns a Result containing SearchResult or an error
  Future<Result<SearchPage>> search(String query, SearchFilter filter) async {
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

      return Result.success(SearchPage.fromSearchResponse(searchResponse));

      // // Get shelf contents and parse
      // final shelfContents = searchResponse.getMusicShelfContents();
      // final items = <YTItem>[];

      // for (final itemJson in shelfContents) {
      //   final renderer = itemJson.musicResponsiveListItemRenderer;
      //   // final item = SearchPage.toYTItem(
      //   //   MusicResponsiveListItemRenderer.fromJson(
      //   //     renderer,
      //   //   ),
      //   // );
      //   final item = SongItem.fromMusicResponsiveListItemRenderer(renderer);
      //   if (item != null) {
      //     items.add(item);
      //   }
      // }

      // final continuation = searchResponse.getContinuation();

      // return Result.success(
      //   SearchResult(items: items, continuation: continuation),
      // );
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

  /// Get home feed
  ///
  /// Returns a Result containing HomePage or an error
  Future<Result<HomePage>> home({Continuation? continuation}) async {
    try {
      // Call InnerTube browse API
      final response = await _innerTube.browse(
        YouTubeClient.webRemix,
        browseId: continuation == null ? 'FEmusic_home' : null,
        continuation: continuation,
      );

      // Parse response as BrowseResponse
      final browseResponse = BrowseResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Parse HomePage
      final homePage = HomePage.fromBrowseResponse(
        browseResponse,
        isContinuation: continuation != null,
      );

      return Result.success(homePage);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Get player response for a video
  ///
  /// [videoId] - Video ID
  /// [playlistId] - Optional playlist ID
  /// [client] - YouTube client to use (default: YouTubeClient.webRemix)
  /// [signatureTimestamp] - Optional signature timestamp
  /// Returns a Result containing PlayerResponse or an error
  Future<Result<PlayerResponse>> player(
    String videoId, {
    String? playlistId,
    YouTubeClient client = YouTubeClient.webRemix,
    int? signatureTimestamp,
  }) async {
    try {
      final response = await _innerTube.player(
        client,
        videoId: videoId,
        playlistId: playlistId,
        signatureTimestamp: signatureTimestamp,
      );

      final playerResponse = PlayerResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      return Result.success(playerResponse);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Get next response for a video
  /// Video ID or Playlist ID is required
  ///
  /// [videoId] - Video ID
  /// [playlistId] - Playlist ID
  /// [playlistSetVideoId] - Optional playlist set video ID
  /// [index] - Optional index
  /// [params] - Optional params
  /// [continuation] - Optional continuation
  /// Returns a Result containing NextResponse or an error
  Future<Result<NextPage>> next({
    String? videoId,
    String? playlistId,
    String? playlistSetVideoId,
    int? index,
    String? params,
    String? continuation,
  }) async {
    assert(videoId != null || playlistId != null);
    try {
      final response = await _innerTube.next(
        YouTubeClient.webRemix,
        videoId: videoId,
        playlistId: playlistId,
        playlistSetVideoId: playlistSetVideoId,
        index: index,
        params: params,
        continuation: continuation,
      );

      final nextResponse = NextResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      final nextPage = NextPage.fromNextResponse(nextResponse);

      return Result.success(nextPage);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Get playlist endpoint for a song
  ///
  /// [songId] - Song ID
  /// Returns a Result containing watchPlaylistEndpoint or an error
  Future<Result<WatchPlaylistEndpoint>> getPlaylistEndpoint(
    String songId,
  ) async {
    try {
      final response = await _innerTube.next(
        YouTubeClient.webRemix,
        videoId: songId,
      );

      final nextResponse = NextResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      final endpoint = nextResponse
          .contents
          ?.singleColumnMusicWatchNextResultsRenderer
          .tabbedRenderer
          ?.watchNextTabbedResultsRenderer
          ?.tabs
          .firstOrNull
          ?.tabRenderer
          .content
          ?.musicQueueRenderer
          ?.content
          ?.playlistPanelRenderer
          .contents
          ?.firstWhere((e) => e.automixPreviewVideoRenderer != null)
          .automixPreviewVideoRenderer
          ?.content
          .automixPlaylistVideoRenderer
          ?.navigationEndpoint
          .watchPlaylistEndpoint;

      if (endpoint == null) {
        throw Exception('Failed to get playlist endpoint');
      }

      return Result.success(endpoint);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Get account info
  ///
  /// [client] - YouTube client to use (default: YouTubeClient.webRemix)
  /// Returns a Result containing AccountMenuResponse or an error
  Future<Result<AccountMenuPage>> accountInfo({
    YouTubeClient client = YouTubeClient.webRemix,
  }) async {
    try {
      final response = await _innerTube.accountMenu(client);

      final accountMenuResponse = AccountMenuResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      final accountMenuPage = AccountMenuPage.fromAccountMenuResponse(
        accountMenuResponse,
      );

      return Result.success(accountMenuPage);
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
