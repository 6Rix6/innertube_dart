// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailRenderer _$ThumbnailRendererFromJson(Map<String, dynamic> json) =>
    ThumbnailRenderer(
      musicThumbnailRenderer: json['musicThumbnailRenderer'] == null
          ? null
          : MusicThumbnailRenderer.fromJson(
              json['musicThumbnailRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ThumbnailRendererToJson(ThumbnailRenderer instance) =>
    <String, dynamic>{
      'musicThumbnailRenderer': instance.musicThumbnailRenderer,
    };

MusicThumbnailRenderer _$MusicThumbnailRendererFromJson(
  Map<String, dynamic> json,
) => MusicThumbnailRenderer(
  thumbnail: Thumbnails.fromJson(json['thumbnail'] as Map<String, dynamic>),
  onTap: json['onTap'] == null
      ? null
      : NavigationEndpoint.fromJson(json['onTap'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MusicThumbnailRendererToJson(
  MusicThumbnailRenderer instance,
) => <String, dynamic>{
  'thumbnail': instance.thumbnail,
  'onTap': instance.onTap,
};
