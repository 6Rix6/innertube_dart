import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';
import 'artist.dart';

part 'album_item.g.dart';

/// Represents an album item
@JsonSerializable()
class AlbumItem extends YTItem {
  final String browseId;
  final String playlistId;

  @override
  final String id;

  @override
  final String title;

  final List<Artist>? artists;
  final String? year;
  final String? albumTypeText;
  final String? songCountText;
  final String? durationText;

  @override
  final Thumbnails thumbnails;

  @override
  final bool explicit;

  const AlbumItem({
    required this.browseId,
    required this.playlistId,
    String? id,
    required this.title,
    this.artists,
    this.year,
    this.albumTypeText,
    this.songCountText,
    this.durationText,
    required this.thumbnails,
    this.explicit = false,
  }) : id = id ?? browseId;

  @override
  String get shareLink => 'https://music.youtube.com/playlist?list=$playlistId';

  factory AlbumItem.fromJson(Map<String, dynamic> json) =>
      _$AlbumItemFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumItemToJson(this);

  @override
  String toString() {
    final artistStr = artists?.map((a) => a.name).join(", ") ?? 'Unknown';
    return '$title by $artistStr${year != null ? " ($year)" : ""}';
  }
}
