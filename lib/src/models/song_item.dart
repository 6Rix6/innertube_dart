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

  @override
  final String thumbnail;

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
    required this.thumbnail,
    this.explicit = false,
    this.setVideoId,
    this.libraryAddToken,
    this.libraryRemoveToken,
    this.historyRemoveToken,
  });

  @override
  String get shareLink => 'https://music.youtube.com/watch?v=$id';

  factory SongItem.fromJson(Map<String, dynamic> json) =>
      _$SongItemFromJson(json);

  Map<String, dynamic> toJson() => _$SongItemToJson(this);

  @override
  String toString() => '$title by ${artists.map((a) => a.name).join(", ")}';
}
