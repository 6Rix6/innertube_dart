import 'package:innertube_dart/src/models/renderer/section_list_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';

import '../models/album_item.dart';
import '../models/song_item.dart';
import '../models/artist.dart';
import '../models/response/browse_response.dart';
import '../models/section.dart';

/// Represents a parsed album page with songs
class AlbumPage {
  final AlbumItem album;
  final List<SongItem> songs;
  final List<AlbumItem> otherVersions;
  final Section? forYouSection;
  final Thumbnails? backgroundThumbnails;
  final BrowseResponse response;

  const AlbumPage({
    required this.album,
    required this.songs,
    this.otherVersions = const [],
    this.forYouSection,
    this.backgroundThumbnails,
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
      final thumbnails = response.getThumbnails();
      final backgroundThumbnails = response.getBackgroundThumbnails();

      if (playlistId == null || title == null || thumbnails == null) {
        return null;
      }

      // Parse artists
      final artists = _parseArtists(response);

      // Parse info
      final subtitleRuns = _getSubtitleRuns(response);
      final secondSubtitleRuns = _getSecondSubtitleRuns(response);
      final albumTypeText = subtitleRuns?.runs?.first.text;
      final year = subtitleRuns?.runs?.last.text;
      final songCountText = secondSubtitleRuns?.runs?.first.text;
      final durationText = secondSubtitleRuns?.runs?.last.text;

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
      );

      // Parse songs
      final songs = _parseSongs(response, albumItem);

      // Parse for you section
      final forYouSection = _parseForYou(response);

      return AlbumPage(
        album: albumItem,
        songs: songs,
        response: response,
        forYouSection: forYouSection,
        backgroundThumbnails: backgroundThumbnails,
      );
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

  static List<SongItem> _parseSongs(BrowseResponse response, AlbumItem album) {
    final songs = <SongItem>[];

    final contents = _getSectionListRendererContents(response);
    final shelfContents = contents?.first.musicShelfRenderer?.contents;
    if (shelfContents != null && shelfContents.isNotEmpty) {
      for (final item in shelfContents) {
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

  static Section? _parseForYou(BrowseResponse response) {
    final contents = _getSectionListRendererContents(response);
    if (contents == null || contents.length < 2) return null;
    final shelf = contents[1];
    final section = shelf.parseSectionContent();
    return section;
  }

  static List<SectionListRendererContents>? _getSectionListRendererContents(
    BrowseResponse response,
  ) {
    final contents = response
        .contents
        ?.twoColumnBrowseResultsRenderer
        ?.secondaryContents
        ?.sectionListRenderer
        ?.contents;
    if (contents != null && contents.isNotEmpty) {
      return contents;
    }

    return null;
  }

  static Runs? _getSubtitleRuns(BrowseResponse response) {
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
          return header.subtitle;
        }
      }
    }
    return null;
  }

  static Runs? _getSecondSubtitleRuns(BrowseResponse response) {
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
          return header.secondSubtitle;
        }
      }
    }

    return null;
  }

  @override
  String toString() =>
      'AlbumPage(album: ${album.title}, songs: ${songs.length}, otherVersions: ${otherVersions.length})';
}
