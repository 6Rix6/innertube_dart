import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_two_row_item_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:innertube_dart/src/utils/parse_time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';
import 'artist.dart';
import 'album.dart';
import '../utils/utils.dart';

part 'song_item.g.dart';

/// Represents a song/video item
@JsonSerializable()
class SongItem extends YTItem {
  @override
  final String id;

  @override
  final String title;

  final List<Artist>? artists;
  final Album? album;
  final Duration? duration;
  final int? chartPosition;
  final String? chartChange;
  final String? viewCount;
  final String? typeText;
  final Runs? subtitle;
  final bool isVideo;
  final MenuRenderer? menu;

  @override
  final Thumbnails? thumbnails;

  @override
  final bool explicit;

  final String? setVideoId;
  final String? playlistId;
  final String? libraryAddToken;
  final String? libraryRemoveToken;
  final String? historyRemoveToken;

  const SongItem({
    required this.id,
    required this.title,
    this.artists,
    this.album,
    this.duration,
    this.chartPosition,
    this.chartChange,
    this.viewCount,
    this.typeText,
    this.subtitle,
    this.thumbnails,
    this.isVideo = false,
    this.explicit = false,
    this.setVideoId,
    this.playlistId,
    this.libraryAddToken,
    this.libraryRemoveToken,
    this.historyRemoveToken,
    this.menu,
  });

  /// generate songItem from musicResponsiveListItemRenderer
  @Deprecated('Use MusicResponsiveListItemRenderer.toSongItem instead')
  static SongItem? fromMusicResponsiveListItemRenderer(
    MusicResponsiveListItemRenderer renderer,
  ) {
    final videoId = renderer.playlistItemData?.videoId;
    if (videoId == null) return null;

    // Get title
    final titleRuns = renderer.flexColumns.firstOrNull?.renderer?.text?.runs;
    final title = titleRuns?.firstOrNull?.text;
    if (title == null) return null;

    // Get duration
    // try fixedColumns
    String? durationText = renderer
        .fixedColumns
        ?.firstOrNull
        ?.renderer
        ?.text
        ?.runs
        ?.firstOrNull
        ?.text;
    if (durationText == null || !isValidTimeFormat(durationText)) {
      // try flexColumns
      durationText = renderer.flexColumns
          .elementAtOrNull(1)
          ?.renderer
          ?.text
          ?.runs
          ?.firstWhere(
            (run) => isValidTimeFormat(run.text),
            orElse: () => Run(text: ""),
          )
          .text;
    }
    final duration = parseTimeText(durationText);

    // Get view count
    final viewCountText = renderer
        .flexColumns
        .lastOrNull
        ?.renderer
        ?.text
        ?.runs
        ?.firstOrNull
        ?.text;

    // Get thumbnail
    final thumbnail = renderer.thumbnail?.musicThumbnailRenderer?.thumbnail;

    // Get artists
    final artistsRuns = renderer.flexColumns[1].flexColumnRenderer?.text?.runs;
    final artists = parseArtistRuns(artistsRuns);

    // Get album
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

    final subtitle = renderer.flexColumns[1].flexColumnRenderer?.text;

    // Get explicit
    final explicit = isExplicit(renderer.badges);

    return SongItem(
      id: videoId,
      title: title,
      artists: artists,
      duration: duration,
      viewCount: viewCountText,
      thumbnails: thumbnail,
      setVideoId: renderer.playlistItemData?.playlistSetVideoId,
      album: album,
      explicit: explicit,
      subtitle: subtitle,
    );
  }

  static SongItem? fromMusicTwoRowItemRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
    final videoId = renderer.navigationEndpoint?.watchEndpoint?.videoId;
    if (videoId == null) return null;

    final titleText = renderer.title?.runs?.firstOrNull?.text;
    if (titleText == null) return null;

    final playlistId = renderer.navigationEndpoint?.watchEndpoint?.playlistId;

    final artists = parseArtistRuns(renderer.subtitle?.runs);

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final explicit = isExplicit(renderer.subtitleBadges);

    final isVideo = checkIsVideo(renderer.aspectRatio);

    String? typeText;
    String? viewCount;
    if (isVideo) {
      viewCount = renderer.subtitle?.runs?.lastOrNull?.text;
    } else {
      typeText = renderer.subtitle?.runs?.firstOrNull?.text;
    }

    return SongItem(
      id: videoId,
      title: titleText,
      artists: artists,
      album: null,
      duration: null,
      viewCount: viewCount,
      typeText: typeText,
      subtitle: renderer.subtitle,
      thumbnails: thumbnails,
      explicit: explicit,
      isVideo: isVideo,
      playlistId: playlistId,
    );
  }

  @override
  String get shareLink => 'https://music.youtube.com/watch?v=$id';

  factory SongItem.fromJson(Map<String, dynamic> json) =>
      _$SongItemFromJson(json);

  Map<String, dynamic> toJson() => _$SongItemToJson(this);

  @override
  String toString() =>
      'SongItem(title: $title, artists: $artists, duration: $duration, viewCount: $viewCount)';
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? elementAtOrNull(int index) =>
      index >= 0 && index < length ? this[index] : null;
}
