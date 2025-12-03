import '../models/album_item.dart';
import '../models/song_item.dart';
import '../models/artist.dart';
import '../models/album.dart';
import '../models/response/browse_response.dart';
import '../models/renderer/music_item_renderer.dart';
import '../utils/parse_time.dart';

/// Represents a parsed album page with songs
class AlbumPage {
  final AlbumItem album;
  final List<SongItem> songs;
  final List<AlbumItem> otherVersions;

  const AlbumPage({
    required this.album,
    required this.songs,
    this.otherVersions = const [],
  });

  /// Parse AlbumPage from BrowseResponse
  static AlbumPage? fromBrowseResponse(
    BrowseResponse response,
    String browseId,
  ) {
    try {
      final playlistId = response.getPlaylistId();
      final title = response.getTitle();
      final thumbnail = response.getThumbnailUrl();

      if (playlistId == null || title == null || thumbnail == null) {
        return null;
      }

      // Parse artists
      final artists = _parseArtists(response);

      // Parse year
      final year = _parseYear(response);

      final albumItem = AlbumItem(
        browseId: browseId,
        playlistId: playlistId,
        title: title,
        artists: artists.isNotEmpty ? artists : null,
        year: year,
        thumbnail: thumbnail,
      );

      // Parse songs
      final songs = _parseSongs(response, albumItem);

      return AlbumPage(album: albumItem, songs: songs);
    } catch (e) {
      // TODO: handle error
      print('Error parsing album page: $e');
      return null;
    }
  }

  static List<Artist> _parseArtists(BrowseResponse response) {
    final artists = <Artist>[];

    // Try music responsive header
    final tabs = response.contents?.twoColumnBrowseResultsRenderer?.tabs;
    if (tabs != null && tabs.isNotEmpty) {
      final sectionContents =
          tabs.first.tabRenderer?.content?.sectionListRenderer?.contents;
      if (sectionContents != null && sectionContents.isNotEmpty) {
        final header = sectionContents.first.musicResponsiveHeaderRenderer;
        if (header != null) {
          final runs = header.straplineTextOne?.runs;
          if (runs != null) {
            // Get odd elements (artists, skipping separators)
            for (var i = 0; i < runs.length; i += 2) {
              final run = runs[i];
              final name = run.text;
              final id = run.navigationEndpoint?.browseEndpoint?.browseId;
              artists.add(Artist(name: name, id: id));
            }
          }
        }
      }
    }

    return artists;
  }

  static String? _parseYear(BrowseResponse response) {
    // Try music responsive header
    final tabs = response.contents?.twoColumnBrowseResultsRenderer?.tabs;
    if (tabs != null && tabs.isNotEmpty) {
      final sectionContents =
          tabs.first.tabRenderer?.content?.sectionListRenderer?.contents;
      if (sectionContents != null && sectionContents.isNotEmpty) {
        final header = sectionContents
            .where((e) => e.musicResponsiveHeaderRenderer != null)
            .first
            .musicResponsiveHeaderRenderer;
        if (header != null) {
          final runs = header.subtitle?.runs;
          if (runs != null && runs.isNotEmpty) {
            final lastText = runs.last.text;
            return lastText;
          }
        }
      }
    }

    return null;
  }

  static List<SongItem> _parseSongs(BrowseResponse response, AlbumItem album) {
    final songs = <SongItem>[];

    // Try twoColumnBrowseResultsRenderer
    final contents =
        response
                .contents
                ?.twoColumnBrowseResultsRenderer
                ?.secondaryContents?['sectionListRenderer']?['contents']
                ?.first?['musicShelfRenderer']?['contents']
            as List?;
    if (contents != null && contents.isNotEmpty) {
      for (final item in contents) {
        final renderer = item['musicResponsiveListItemRenderer'];
        if (renderer != null) {
          final song = _parseSong(renderer as Map<String, dynamic>, album);
          if (song != null) songs.add(song);
        }
      }
    }

    return songs;
  }

  static SongItem? _parseSong(
    Map<String, dynamic> rendererJson,
    AlbumItem album,
  ) {
    try {
      final renderer = MusicResponsiveListItemRenderer.fromJson(rendererJson);

      final videoId = renderer.playlistItemData?.videoId;
      if (videoId == null) return null;

      // Get title
      final titleRuns = renderer.flexColumns.firstOrNull?.renderer?.text?.runs;
      final title = titleRuns?.firstOrNull?.text;
      if (title == null) return null;

      // Get duration
      final durationText = renderer
          .fixedColumns
          ?.firstOrNull
          ?.renderer
          ?.text
          ?.runs
          ?.firstOrNull
          ?.text;
      final duration = parseTime(durationText);

      // Get thumbnail
      final thumbnail =
          renderer.thumbnail?.getThumbnailUrl() ?? album.thumbnail;

      return SongItem(
        id: videoId,
        title: title,
        artists: album.artists ?? [],
        album: Album(name: album.title, id: album.browseId),
        duration: duration,
        thumbnail: thumbnail,
        setVideoId: renderer.playlistItemData?.playlistSetVideoId,
      );
    } catch (e) {
      // TODO: handle error
      print('Error parsing song: $e');
      return null;
    }
  }

  @override
  String toString() =>
      'AlbumPage(album: ${album.title}, songs: ${songs.length}, otherVersions: ${otherVersions.length})';
}

extension _FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
