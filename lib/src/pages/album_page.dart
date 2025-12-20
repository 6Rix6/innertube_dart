import 'package:innertube_dart/src/models/thumbnails.dart';

import '../models/album_item.dart';
import '../models/song_item.dart';
import '../models/response/browse_response.dart';
import '../models/section.dart';

/// Represents a parsed album page with songs
class AlbumPage {
  final AlbumItem album;
  final List<SongItem> songs;
  final List<AlbumItem> otherVersions;
  final Section? forYouSection;
  final Thumbnails? background;
  final BrowseResponse response;

  const AlbumPage({
    required this.album,
    required this.songs,
    this.otherVersions = const [],
    this.forYouSection,
    this.background,
    required this.response,
  });

  /// Parse AlbumPage from BrowseResponse
  static AlbumPage? fromBrowseResponse(
    BrowseResponse response,
    String browseId,
  ) {
    try {
      final contents = response.contents?.twoColumnBrowseResultsRenderer;
      final header = contents?.musicResponsiveHeaderRenderer;
      if (contents == null || header == null) return null;

      final playlistId = response.getPlaylistId();
      final title = header.titleText;
      final thumbnails = header.thumbnails;
      final backgroundThumbnails = response.backgroundThumbnails;

      if (playlistId == null || title == null || thumbnails == null) {
        return null;
      }

      // Parse info
      final artists = header.albumArtists;
      final artistThumbnails = header.artistThumbnails;
      final albumTypeText = header.typeText;
      final year = header.yearText;
      final songCountText = header.songCountText;
      final durationText = header.durationText;

      final albumItem = AlbumItem(
        browseId: browseId,
        playlistId: playlistId,
        title: title,
        artists: artists.isNotEmpty ? artists : null,
        year: year,
        albumTypeText: albumTypeText,
        songCountText: songCountText,
        durationText: durationText,
        thumbnails: thumbnails,
        artistThumbnails: artistThumbnails,
      );

      final sectionListContents = contents.sectionListRendererContents;

      // Parse songs
      final musicShelfRenderer = sectionListContents?.first.musicShelfRenderer;
      final songs = musicShelfRenderer?.parseSongs() ?? [];

      // parse for you
      Section? forYouSection;
      if (sectionListContents != null && sectionListContents.length >= 2) {
        final shelfRenderer = sectionListContents[1];
        forYouSection = shelfRenderer.toSection();
      }

      return AlbumPage(
        album: albumItem,
        songs: songs,
        response: response,
        forYouSection: forYouSection,
        background: backgroundThumbnails,
      );
    } catch (e) {
      // print('Error parsing album page: $e');
      return null;
    }
  }

  @override
  String toString() =>
      'AlbumPage(album: ${album.title}, songs: ${songs.length}, otherVersions: ${otherVersions.length})';
}
