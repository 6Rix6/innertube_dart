import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';

import '../models/playlist_item.dart';
import '../models/song_item.dart';
import '../models/response/browse_response.dart';

/// Represents a parsed playlist page with songs
class PlaylistPage {
  final PlaylistItem playlist;
  final List<SongItem> songs;
  final String? songsContinuation;
  final List<Continuations>? continuations;

  final Thumbnails? background;
  final BrowseResponse response;

  const PlaylistPage({
    required this.playlist,
    required this.songs,
    this.songsContinuation,
    this.continuations,
    this.background,
    required this.response,
  });

  /// Parse PlaylistPage from BrowseResponse
  static PlaylistPage? fromBrowseResponse(
    BrowseResponse response,
    String playlistId,
  ) {
    try {
      final contents = response.contents?.twoColumnBrowseResultsRenderer;
      final header = contents?.musicResponsiveHeaderRenderer;
      if (contents == null || header == null) return null;

      final title = header.titleText;
      if (title == null) return null;

      final author = header.playlistAuthor;
      final thumbnail = header.thumbnails;
      final songCountText = header.songCountText;
      final playEndpoint = header.playEndpoint;
      final menu = header.buttons?[2];
      final shuffleEndpoint = menu?.menuRenderer?.items
          ?.firstWhere(
            (item) =>
                item.menuNavigationItemRenderer?.icon.iconType ==
                'MUSIC_SHUFFLE',
            orElse: () => MenuRendererItem(
              menuNavigationItemRenderer: null,
              toggleMenuServiceItemRenderer: null,
            ),
          )
          .menuNavigationItemRenderer
          ?.navigationEndpoint
          ?.watchPlaylistEndpoint;
      final radioEndpoint = menu?.menuRenderer?.items
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

      final playlistItem = PlaylistItem(
        id: playlistId,
        title: title,
        author: author,
        songCountText: songCountText,
        thumbnails: thumbnail,
        watchEndpoint: playEndpoint,
        shuffleEndpoint: shuffleEndpoint,
        radioEndpoint: radioEndpoint,
      );

      final sectionListRendererContents = contents.sectionListRendererContents;
      final playlistShelf =
          sectionListRendererContents?.first.musicPlaylistShelfRenderer;

      if (playlistShelf == null) return null;

      final songs = playlistShelf.songs;
      final songsContinuation = playlistShelf.continuation;
      final background = response.backgroundThumbnails;
      final continuations =
          contents.secondaryContents?.sectionListRenderer?.continuations;
      return PlaylistPage(
        playlist: playlistItem,
        songs: songs,
        songsContinuation: songsContinuation,
        continuations: continuations,
        response: response,
        background: background,
      );
    } catch (e) {
      // print('Error parsing playlist page: $e');
      return null;
    }
  }

  // TODO: implement getContinuation
  // TODO: implement getSongsContinuation

  @override
  String toString() =>
      'PlaylistPage(playlist: ${playlist.title}, songs: ${songs.length})';
}
