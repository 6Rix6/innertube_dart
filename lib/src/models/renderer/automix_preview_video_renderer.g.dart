// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automix_preview_video_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutomixPreviewVideoRenderer _$AutomixPreviewVideoRendererFromJson(
  Map<String, dynamic> json,
) => AutomixPreviewVideoRenderer(
  content: AutomixPreviewVideoRendererContent.fromJson(
    json['content'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AutomixPreviewVideoRendererToJson(
  AutomixPreviewVideoRenderer instance,
) => <String, dynamic>{'content': instance.content};

AutomixPreviewVideoRendererContent _$AutomixPreviewVideoRendererContentFromJson(
  Map<String, dynamic> json,
) => AutomixPreviewVideoRendererContent(
  automixPlaylistVideoRenderer: json['automixPlaylistVideoRenderer'] == null
      ? null
      : AutomixPlaylistVideoRenderer.fromJson(
          json['automixPlaylistVideoRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AutomixPreviewVideoRendererContentToJson(
  AutomixPreviewVideoRendererContent instance,
) => <String, dynamic>{
  'automixPlaylistVideoRenderer': instance.automixPlaylistVideoRenderer,
};

AutomixPlaylistVideoRenderer _$AutomixPlaylistVideoRendererFromJson(
  Map<String, dynamic> json,
) => AutomixPlaylistVideoRenderer(
  navigationEndpoint: NavigationEndpoint.fromJson(
    json['navigationEndpoint'] as Map<String, dynamic>,
  ),
  trackingParams: json['trackingParams'] as String?,
  automixMode: json['automixMode'] as String?,
);

Map<String, dynamic> _$AutomixPlaylistVideoRendererToJson(
  AutomixPlaylistVideoRenderer instance,
) => <String, dynamic>{
  'navigationEndpoint': instance.navigationEndpoint,
  'trackingParams': instance.trackingParams,
  'automixMode': instance.automixMode,
};
