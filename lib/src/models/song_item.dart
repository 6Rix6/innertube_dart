import 'package:innertube_dart/src/models/album_item.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:innertube_dart/src/utils/parse_time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';
import 'artist.dart';
import 'album.dart';

part 'song_item.g.dart';

/// Represents a song/video item
@JsonSerializable()
class SongItem extends YTItem {
  @override
  final String id;

  @override
  final String title;

  final List<Artist> artists;
  final Album? album;
  final int? duration;
  final int? chartPosition;
  final String? chartChange;
  final String? viewCount;

  @override
  final Thumbnails thumbnails;

  @override
  final bool explicit;

  final String? setVideoId;
  final String? libraryAddToken;
  final String? libraryRemoveToken;
  final String? historyRemoveToken;

  const SongItem({
    required this.id,
    required this.title,
    required this.artists,
    this.album,
    this.duration,
    this.chartPosition,
    this.chartChange,
    this.viewCount,
    required this.thumbnails,
    this.explicit = false,
    this.setVideoId,
    this.libraryAddToken,
    this.libraryRemoveToken,
    this.historyRemoveToken,
  });

  /// generate songItem from musicResponsiveListItemRenderer and albumItem
  static SongItem? fromMusicResponsiveListItemRenderer(
    MusicResponsiveListItemRenderer renderer,
    AlbumItem album,
  ) {
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
    final thumbnail =
        renderer.thumbnail?.musicThumbnailRenderer?.thumbnail ??
        album.thumbnails;

    return SongItem(
      id: videoId,
      title: title,
      artists: album.artists ?? [],
      album: Album(name: album.title, id: album.browseId),
      duration: duration,
      viewCount: viewCountText,
      thumbnails: thumbnail,
      setVideoId: renderer.playlistItemData?.playlistSetVideoId,
    );
  }

  @override
  String get shareLink => 'https://music.youtube.com/watch?v=$id';

  factory SongItem.fromJson(Map<String, dynamic> json) =>
      _$SongItemFromJson(json);

  Map<String, dynamic> toJson() => _$SongItemToJson(this);

  @override
  String toString() => '$title by ${artists.map((a) => a.name).join(", ")}';
}

extension _FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
