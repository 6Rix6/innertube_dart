import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';
import 'artist.dart';

part 'playlist_item.g.dart';

/// Represents a playlist item
@JsonSerializable()
class PlaylistItem extends YTItem {
  @override
  final String id;

  @override
  final String title;

  final Artist? author;
  final String? songCountText;

  @override
  final Thumbnails? thumbnails;

  final bool isEditable;

  final WatchEndpoint? watchEndpoint;
  final WatchPlaylistEndpoint? watchPlaylistEndpoint;
  final WatchPlaylistEndpoint? shuffleEndpoint;
  final WatchPlaylistEndpoint? radioEndpoint;

  const PlaylistItem({
    required this.id,
    required this.title,
    this.author,
    this.songCountText,
    this.thumbnails,
    this.isEditable = false,
    this.watchEndpoint,
    this.watchPlaylistEndpoint,
    this.shuffleEndpoint,
    this.radioEndpoint,
  });

  @override
  bool get explicit => false; // Playlists are never marked as explicit

  @override
  String get shareLink => 'https://music.youtube.com/playlist?list=$id';

  factory PlaylistItem.fromJson(Map<String, dynamic> json) =>
      _$PlaylistItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistItemToJson(this);

  @override
  String toString() {
    return '$title ${author?.name != null ? 'by ${author!.name}' : ''}';
  }
}
