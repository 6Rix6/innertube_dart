import 'package:json_annotation/json_annotation.dart';

part 'thumbnails.g.dart';

@JsonSerializable()
class Thumbnails {
  final List<Thumbnail> thumbnails;

  const Thumbnails({required this.thumbnails});

  /// Get best quality thumbnail URL
  String? getBest() => thumbnails.isNotEmpty ? thumbnails.last.url : null;

  factory Thumbnails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailsToJson(this);
}

@JsonSerializable()
class Thumbnail {
  final String url;
  final int? width;
  final int? height;

  const Thumbnail({required this.url, this.width, this.height});

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
