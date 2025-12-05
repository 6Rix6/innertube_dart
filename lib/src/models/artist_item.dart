import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';

part 'artist_item.g.dart';

/// Represents an artist/channel item
@JsonSerializable()
class ArtistItem extends YTItem {
  @override
  final String id;

  @override
  final String title;

  @override
  final Thumbnails? thumbnails;

  final String? channelId;

  final WatchPlaylistEndpoint? shuffleEndpoint;
  final WatchPlaylistEndpoint? radioEndpoint;

  const ArtistItem({
    required this.id,
    required this.title,
    this.thumbnails,
    this.channelId,
    this.shuffleEndpoint,
    this.radioEndpoint,
  });

  @override
  bool get explicit => false; // Artists are never marked as explicit

  @override
  String get shareLink => 'https://music.youtube.com/channel/$id';

  factory ArtistItem.fromJson(Map<String, dynamic> json) =>
      _$ArtistItemFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistItemToJson(this);

  @override
  String toString() => title;
}
