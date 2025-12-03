import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thumbnail_renderer.g.dart';

@JsonSerializable()
class ThumbnailRenderer {
  final MusicThumbnailRenderer? musicThumbnailRenderer;

  const ThumbnailRenderer({this.musicThumbnailRenderer});

  String? getThumbnailUrl() => musicThumbnailRenderer?.thumbnail.getBest();

  factory ThumbnailRenderer.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailRendererToJson(this);
}

@JsonSerializable()
class MusicThumbnailRenderer {
  final Thumbnails thumbnail;

  const MusicThumbnailRenderer({required this.thumbnail});

  factory MusicThumbnailRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicThumbnailRendererToJson(this);
}
