// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_responsive_header_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicResponsiveHeaderRenderer _$MusicResponsiveHeaderRendererFromJson(
  Map<String, dynamic> json,
) => MusicResponsiveHeaderRenderer(
  title: json['title'] == null
      ? null
      : Runs.fromJson(json['title'] as Map<String, dynamic>),
  subtitle: json['subtitle'] == null
      ? null
      : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
  secondSubtitle: json['secondSubtitle'] == null
      ? null
      : Runs.fromJson(json['secondSubtitle'] as Map<String, dynamic>),
  straplineTextOne: json['straplineTextOne'] == null
      ? null
      : Runs.fromJson(json['straplineTextOne'] as Map<String, dynamic>),
  thumbnail: json['thumbnail'] == null
      ? null
      : MusicResponsiveHeaderRendererThumbnail.fromJson(
          json['thumbnail'] as Map<String, dynamic>,
        ),
  straplineThumbnail: json['straplineThumbnail'] == null
      ? null
      : MusicResponsiveHeaderRendererThumbnail.fromJson(
          json['straplineThumbnail'] as Map<String, dynamic>,
        ),
  buttons: (json['buttons'] as List<dynamic>?)
      ?.map(
        (e) => MusicResponsiveHeaderRendererButton.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
  trackingParams: json['trackingParams'] as String?,
  facepile: json['facepile'],
);

Map<String, dynamic> _$MusicResponsiveHeaderRendererToJson(
  MusicResponsiveHeaderRenderer instance,
) => <String, dynamic>{
  'title': instance.title,
  'subtitle': instance.subtitle,
  'secondSubtitle': instance.secondSubtitle,
  'straplineTextOne': instance.straplineTextOne,
  'thumbnail': instance.thumbnail,
  'straplineThumbnail': instance.straplineThumbnail,
  'buttons': instance.buttons,
  'trackingParams': instance.trackingParams,
  'facepile': instance.facepile,
};

MusicResponsiveHeaderRendererThumbnail
_$MusicResponsiveHeaderRendererThumbnailFromJson(Map<String, dynamic> json) =>
    MusicResponsiveHeaderRendererThumbnail(
      musicThumbnailRenderer: MusicThumbnailRenderer.fromJson(
        json['musicThumbnailRenderer'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MusicResponsiveHeaderRendererThumbnailToJson(
  MusicResponsiveHeaderRendererThumbnail instance,
) => <String, dynamic>{
  'musicThumbnailRenderer': instance.musicThumbnailRenderer,
};

MusicResponsiveHeaderRendererButton
_$MusicResponsiveHeaderRendererButtonFromJson(Map<String, dynamic> json) =>
    MusicResponsiveHeaderRendererButton(
      toggleButtonRenderer: json['toggleButtonRenderer'] == null
          ? null
          : ToggleButtonRenderer.fromJson(
              json['toggleButtonRenderer'] as Map<String, dynamic>,
            ),
      musicPlayButtonRenderer: json['musicPlayButtonRenderer'] == null
          ? null
          : MusicPlayButtonRenderer.fromJson(
              json['musicPlayButtonRenderer'] as Map<String, dynamic>,
            ),
      menuRenderer: json['menuRenderer'] == null
          ? null
          : MenuRenderer.fromJson(json['menuRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MusicResponsiveHeaderRendererButtonToJson(
  MusicResponsiveHeaderRendererButton instance,
) => <String, dynamic>{
  'toggleButtonRenderer': instance.toggleButtonRenderer,
  'musicPlayButtonRenderer': instance.musicPlayButtonRenderer,
  'menuRenderer': instance.menuRenderer,
};
