import '../models/playlist_item.dart';
import '../models/song_item.dart';
import '../models/artist.dart';
import '../models/album.dart';
import '../models/response/browse_response.dart';
import '../models/renderer/music_item_renderer.dart';
import '../models/runs.dart';
import '../utils/parse_time.dart';

/// Represents a parsed playlist page with songs
class PlaylistPage {
  final PlaylistItem playlist;
  final List<SongItem> songs;
  final String? songsContinuation;
  final String? continuation;
  final BrowseResponse response;
  const PlaylistPage({
    required this.playlist,
    required this.songs,
    this.songsContinuation,
    this.continuation,
    required this.response,
  });

  /// Parse PlaylistPage from BrowseResponse
  static PlaylistPage? fromBrowseResponse(
    BrowseResponse response,
    String playlistId,
  ) {
    try {
      final title = response.getTitle();
      if (title == null) return null;
      final author = response.getAuthor();
      final thumbnail = response.getThumbnailUrl();
      final songCountText = response.getSongCountText();

      final playlistItem = PlaylistItem(
        id: playlistId,
        title: title,
        author: author,
        songCountText: songCountText,
        thumbnail: thumbnail,
      );
      final songs = _parseSongs(response, playlistItem);
      final continuation = _parseContinuation(response);
      return PlaylistPage(
        playlist: playlistItem,
        songs: songs,
        songsContinuation: continuation,
        continuation: continuation,
        response: response,
      );
    } catch (e) {
      // TODO: handle error
      print('Error parsing playlist page: $e');
      return null;
    }
  }

  static List<SongItem> _parseSongs(
    BrowseResponse response,
    PlaylistItem playlist,
  ) {
    final songs = <SongItem>[];
    final contents =
        response
                .contents
                ?.twoColumnBrowseResultsRenderer
                ?.secondaryContents
                ?.sectionListRenderer
                ?.contents
                ?.first
                .musicPlaylistShelfRenderer?["contents"]
            as List?;
    if (contents != null && contents.isNotEmpty) {
      for (final item in contents) {
        final renderer = item['musicResponsiveListItemRenderer'];
        if (renderer != null) {
          final song = _parseSong(renderer as Map<String, dynamic>, playlist);
          if (song != null) songs.add(song);
        }
      }
    }
    return songs;
  }

  static SongItem? _parseSong(
    Map<String, dynamic> rendererJson,
    PlaylistItem playlist,
  ) {
    try {
      final renderer = MusicResponsiveListItemRenderer.fromJson(rendererJson);
      final videoId = renderer.playlistItemData?.videoId;
      if (videoId == null) return null;
      final titleRuns = renderer.flexColumns.firstOrNull?.renderer?.text?.runs;
      final title = titleRuns?.firstOrNull?.text;
      if (title == null) return null;
      final artistRuns = renderer.flexColumns
          .elementAtOrNull(1)
          ?.renderer
          ?.text
          ?.runs;
      final artists =
          artistRuns?.oddElements().map((run) {
            return Artist(
              name: run.text,
              id: run.navigationEndpoint?.browseEndpoint?.browseId,
            );
          }).toList() ??
          [];
      Album? album;
      final albumRun = renderer.flexColumns
          .elementAtOrNull(2)
          ?.renderer
          ?.text
          ?.runs
          ?.firstOrNull;
      if (albumRun != null &&
          albumRun.navigationEndpoint?.browseEndpoint?.browseId != null) {
        album = Album(
          name: albumRun.text,
          id: albumRun.navigationEndpoint!.browseEndpoint!.browseId!,
        );
      }
      final durationText = renderer
          .fixedColumns
          ?.firstOrNull
          ?.renderer
          ?.text
          ?.runs
          ?.firstOrNull
          ?.text;
      final duration = parseTime(durationText);
      final thumbnail = renderer.thumbnail?.getThumbnailUrl();
      if (thumbnail == null) return null;
      final explicit =
          renderer.badges?.any(
            (badge) =>
                badge.musicInlineBadgeRenderer?.icon?.iconType ==
                'MUSIC_EXPLICIT_BADGE',
          ) ==
          true;
      return SongItem(
        id: videoId,
        title: title,
        artists: artists,
        album: album,
        duration: duration,
        thumbnail: thumbnail,
        explicit: explicit,
      );
    } catch (e) {
      print('Error parsing playlist song: $e');
      return null;
    }
  }

  static String? _parseContinuation(BrowseResponse response) {
    final contents =
        response
                .contents
                ?.twoColumnBrowseResultsRenderer
                ?.secondaryContents
                ?.sectionListRenderer
                ?.contents
                ?.first
                .musicPlaylistShelfRenderer?["contents"]
            as List?;
    if (contents != null && contents.isNotEmpty) {
      final lastItem = contents.last;
      return lastItem['continuationItemRenderer']?['continuationEndpoint']?['continuationCommand']?['token']
          as String?;
    }
    return null;
  }

  @override
  String toString() =>
      'PlaylistPage(playlist: ${playlist.title}, songs: ${songs.length})';
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? elementAtOrNull(int index) =>
      index >= 0 && index < length ? this[index] : null;
}
