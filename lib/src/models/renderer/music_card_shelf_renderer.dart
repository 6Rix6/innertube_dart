import 'package:json_annotation/json_annotation.dart';

part 'music_card_shelf_renderer.g.dart';

@JsonSerializable()
class MusicCardShelfRenderer {
  final String? trackingParams;

  const MusicCardShelfRenderer({this.trackingParams});

  factory MusicCardShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicCardShelfRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicCardShelfRendererToJson(this);
}
