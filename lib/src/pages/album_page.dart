import '../models/album_item.dart';
import '../models/song_item.dart';
import '../models/artist.dart';
import '../models/response/browse_response.dart';

/// Represents a parsed album page with songs
class AlbumPage {
  final AlbumItem album;
  final List<SongItem> songs;
  final List<AlbumItem> otherVersions;
  final BrowseResponse response;

  const AlbumPage({
    required this.album,
    required this.songs,
    this.otherVersions = const [],
    required this.response,
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

      return AlbumPage(album: albumItem, songs: songs, response: response);
    } catch (e) {
      // TODO: handle error
      print('Error parsing album page: $e');
      return null;
    }
  }

  static List<Artist> _parseArtists(BrowseResponse response) {
    final artists = <Artist>[];

    final tabs = response.contents?.twoColumnBrowseResultsRenderer?.tabs;
    if (tabs != null && tabs.isNotEmpty) {
      final sectionContents =
          tabs.first.tabRenderer.content?.sectionListRenderer?.contents;
      if (sectionContents != null && sectionContents.isNotEmpty) {
        final header = sectionContents.first.musicResponsiveHeaderRenderer;
        if (header != null) {
          artists.addAll(
            Artist.generateArtistsFromMusicResponsiveHeaderRenderer(header),
          );
        }
      }
    }

    return artists;
  }

  static String? _parseYear(BrowseResponse response) {
    final tabs = response.contents?.twoColumnBrowseResultsRenderer?.tabs;
    if (tabs != null && tabs.isNotEmpty) {
      final sectionContents =
          tabs.first.tabRenderer.content?.sectionListRenderer?.contents;
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

    final contents = response
        .contents
        ?.twoColumnBrowseResultsRenderer
        ?.secondaryContents
        ?.sectionListRenderer
        ?.contents
        ?.first
        .musicShelfRenderer
        ?.contents;
    if (contents != null && contents.isNotEmpty) {
      for (final item in contents) {
        final renderer = item.musicResponsiveListItemRenderer;
        final song = SongItem.fromMusicResponsiveListItemRenderer(
          renderer,
          album,
        );
        if (song != null) songs.add(song);
      }
    }

    return songs;
  }

  // TODO: implement _parseRecommend
  // static dynamic _parseRecommend() {}

  @override
  String toString() =>
      'AlbumPage(album: ${album.title}, songs: ${songs.length}, otherVersions: ${otherVersions.length})';
}
