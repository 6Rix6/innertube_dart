// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_two_row_item_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTwoRowItemRenderer _$MusicTwoRowItemRendererFromJson(
  Map<String, dynamic> json,
) => MusicTwoRowItemRenderer(
  thumbnailRenderer: json['thumbnailRenderer'] == null
      ? null
      : ThumbnailRenderer.fromJson(
          json['thumbnailRenderer'] as Map<String, dynamic>,
        ),
  thumbnailOverlay: json['thumbnailOverlay'] == null
      ? null
      : Overlay.fromJson(json['thumbnailOverlay'] as Map<String, dynamic>),
  navigationEndpoint: json['navigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['navigationEndpoint'] as Map<String, dynamic>,
        ),
  title: json['title'] == null
      ? null
      : Runs.fromJson(json['title'] as Map<String, dynamic>),
  subtitle: json['subtitle'] == null
      ? null
      : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
  subtitleBadges: (json['subtitleBadges'] as List<dynamic>?)
      ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
      .toList(),
  menu: json['menu'] == null
      ? null
      : Menu.fromJson(json['menu'] as Map<String, dynamic>),
  aspectRatio: json['aspectRatio'] as String?,
);

Map<String, dynamic> _$MusicTwoRowItemRendererToJson(
  MusicTwoRowItemRenderer instance,
) => <String, dynamic>{
  'thumbnailRenderer': instance.thumbnailRenderer,
  'thumbnailOverlay': instance.thumbnailOverlay,
  'navigationEndpoint': instance.navigationEndpoint,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'subtitleBadges': instance.subtitleBadges,
  'menu': instance.menu,
  'aspectRatio': instance.aspectRatio,
};
