// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_card_shelf_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicCardShelfRenderer _$MusicCardShelfRendererFromJson(
  Map<String, dynamic> json,
) => MusicCardShelfRenderer(
  trackingParams: json['trackingParams'] as String?,
  thumbnails: json['thumbnails'] == null
      ? null
      : ThumbnailRenderer.fromJson(json['thumbnails'] as Map<String, dynamic>),
  title: json['title'] == null
      ? null
      : Runs.fromJson(json['title'] as Map<String, dynamic>),
  subtitle: json['subtitle'] == null
      ? null
      : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
  contents: (json['contents'] as List<dynamic>?)
      ?.map((e) => MusicResponsiveListItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  buttons: (json['buttons'] as List<dynamic>?)
      ?.map((e) => Button.fromJson(e as Map<String, dynamic>))
      .toList(),
  menu: json['menu'] == null
      ? null
      : Menu.fromJson(json['menu'] as Map<String, dynamic>),
  onTap: json['onTap'] == null
      ? null
      : NavigationEndpoint.fromJson(json['onTap'] as Map<String, dynamic>),
  endIcon: json['endIcon'] == null
      ? null
      : Icon.fromJson(json['endIcon'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MusicCardShelfRendererToJson(
  MusicCardShelfRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'thumbnails': instance.thumbnails,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'contents': instance.contents,
  'buttons': instance.buttons,
  'menu': instance.menu,
  'onTap': instance.onTap,
  'endIcon': instance.endIcon,
};
