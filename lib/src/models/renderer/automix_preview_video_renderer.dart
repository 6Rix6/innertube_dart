import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/endpoints.dart';

part 'automix_preview_video_renderer.g.dart';

@JsonSerializable()
class AutomixPreviewVideoRenderer {
  final AutomixPreviewVideoRendererContent content;

  const AutomixPreviewVideoRenderer({required this.content});

  factory AutomixPreviewVideoRenderer.fromJson(Map<String, dynamic> json) =>
      _$AutomixPreviewVideoRendererFromJson(json);

  Map<String, dynamic> toJson() => _$AutomixPreviewVideoRendererToJson(this);
}

@JsonSerializable()
class AutomixPreviewVideoRendererContent {
  final AutomixPlaylistVideoRenderer? automixPlaylistVideoRenderer;

  const AutomixPreviewVideoRendererContent({this.automixPlaylistVideoRenderer});

  factory AutomixPreviewVideoRendererContent.fromJson(
    Map<String, dynamic> json,
  ) => _$AutomixPreviewVideoRendererContentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AutomixPreviewVideoRendererContentToJson(this);
}

@JsonSerializable()
class AutomixPlaylistVideoRenderer {
  final NavigationEndpoint navigationEndpoint;
  final String? trackingParams;
  final String? automixMode;

  const AutomixPlaylistVideoRenderer({
    required this.navigationEndpoint,
    this.trackingParams,
    this.automixMode,
  });

  factory AutomixPlaylistVideoRenderer.fromJson(Map<String, dynamic> json) =>
      _$AutomixPlaylistVideoRendererFromJson(json);

  Map<String, dynamic> toJson() => _$AutomixPlaylistVideoRendererToJson(this);
}
