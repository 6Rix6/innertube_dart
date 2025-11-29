import '../models/yt_item.dart';
import '../models/song_item.dart';
import '../models/album_item.dart';
import '../models/artist_item.dart';
import '../models/playlist_item.dart';
import '../models/artist.dart';
import '../models/album.dart';
import '../models/renderer/music_item_renderer.dart';
import '../models/renderer/runs.dart';
import '../utils/parse_time.dart';

/// Search page parser
class SearchPage {
  /// Convert MusicResponsiveListItemRenderer to appropriate YTItem type
  static YTItem? toYTItem(MusicResponsiveListItemRenderer renderer) {
    // Get secondary line (contains artist, album, duration info)
    final secondaryLine = renderer.flexColumns
        .elementAtOrNull(1)
        ?.renderer
        ?.text
        ?.runs
        ?.splitBySeparator();

    if (secondaryLine == null) return null;

    // Determine type and parse accordingly
    if (renderer.isSong) {
      return _parseSong(renderer, secondaryLine);
    } else if (renderer.isArtist && !renderer.isAlbum && !renderer.isPlaylist) {
      return _parseArtist(renderer);
    } else if (renderer.isAlbum) {
      return _parseAlbum(renderer, secondaryLine);
    } else if (renderer.isPlaylist) {
      return _parsePlaylist(renderer, secondaryLine);
    }

    return null;
  }

  static SongItem? _parseSong(
    MusicResponsiveListItemRenderer renderer,
    List<List<Run>> secondaryLine,
  ) {
    final videoId = renderer.playlistItemData?.videoId;
    if (videoId == null) return null;

    final title = renderer
        .flexColumns
        .firstOrNull
        ?.renderer
        ?.text
        ?.runs
        ?.firstOrNull
        ?.text;
    if (title == null) return null;

    final artists = secondaryLine.firstOrNull?.oddElements().map((run) {
      return Artist(
        name: run.text,
        id: run.navigationEndpoint?.browseEndpoint?.browseId,
      );
    }).toList();

    if (artists == null || artists.isEmpty) return null;

    // Try to get album
    Album? album;
    final albumRun = secondaryLine.elementAtOrNull(1)?.firstOrNull;
    if (albumRun != null &&
        albumRun.navigationEndpoint?.browseEndpoint != null) {
      album = Album(
        name: albumRun.text,
        id: albumRun.navigationEndpoint!.browseEndpoint!.browseId!,
      );
    }

    // Get duration
    final durationText = secondaryLine.lastOrNull?.firstOrNull?.text;
    final duration = parseTime(durationText);

    final thumbnail = renderer.thumbnail?.getThumbnailUrl();
    if (thumbnail == null) return null;

    // Check explicit badge
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
  }

  static ArtistItem? _parseArtist(MusicResponsiveListItemRenderer renderer) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final title = renderer
        .flexColumns
        .firstOrNull
        ?.renderer
        ?.text
        ?.runs
        ?.firstOrNull
        ?.text;
    if (title == null) return null;

    final thumbnail = renderer.thumbnail?.getThumbnailUrl();
    if (thumbnail == null) return null;

    return ArtistItem(
      id: browseId,
      title: title,
      thumbnail: thumbnail,
      channelId: browseId,
    );
  }

  static AlbumItem? _parseAlbum(
    MusicResponsiveListItemRenderer renderer,
    List<List<Run>> secondaryLine,
  ) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    // Get playlistId from overlay
    final playlistId = renderer
        .overlay
        ?.musicItemThumbnailOverlayRenderer
        ?.content
        ?.musicPlayButtonRenderer
        ?.playNavigationEndpoint
        ?.watchPlaylistEndpoint
        ?.playlistId;
    if (playlistId == null) return null;

    final title = renderer
        .flexColumns
        .firstOrNull
        ?.renderer
        ?.text
        ?.runs
        ?.firstOrNull
        ?.text;
    if (title == null) return null;

    final artists = secondaryLine.elementAtOrNull(1)?.oddElements().map((run) {
      return Artist(
        name: run.text,
        id: run.navigationEndpoint?.browseEndpoint?.browseId,
      );
    }).toList();

    // Try to get year
    final year = secondaryLine.elementAtOrNull(2)?.firstOrNull?.text;

    final thumbnail = renderer.thumbnail?.getThumbnailUrl();
    if (thumbnail == null) return null;

    final explicit =
        renderer.badges?.any(
          (badge) =>
              badge.musicInlineBadgeRenderer?.icon?.iconType ==
              'MUSIC_EXPLICIT_BADGE',
        ) ==
        true;

    return AlbumItem(
      browseId: browseId,
      playlistId: playlistId,
      title: title,
      artists: artists,
      year: year,
      thumbnail: thumbnail,
      explicit: explicit,
    );
  }

  static PlaylistItem? _parsePlaylist(
    MusicResponsiveListItemRenderer renderer,
    List<List<Run>> secondaryLine,
  ) {
    var browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    // Remove VL prefix
    if (browseId.startsWith('VL')) {
      browseId = browseId.substring(2);
    }

    final title = renderer
        .flexColumns
        .firstOrNull
        ?.renderer
        ?.text
        ?.runs
        ?.firstOrNull
        ?.text;
    if (title == null) return null;

    final authorRun = secondaryLine.firstOrNull?.firstOrNull;
    if (authorRun == null) return null;

    final author = Artist(
      name: authorRun.text,
      id: authorRun.navigationEndpoint?.browseEndpoint?.browseId,
    );

    final songCountText = renderer.flexColumns
        .elementAtOrNull(1)
        ?.renderer
        ?.text
        ?.runs
        ?.lastOrNull
        ?.text;

    final thumbnail = renderer.thumbnail?.getThumbnailUrl();

    return PlaylistItem(
      id: browseId,
      title: title,
      author: author,
      songCountText: songCountText,
      thumbnail: thumbnail,
    );
  }
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? elementAtOrNull(int index) =>
      index >= 0 && index < length ? this[index] : null;
}
