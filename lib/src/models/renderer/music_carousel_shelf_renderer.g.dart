// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_carousel_shelf_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicCarouselShelfRenderer _$MusicCarouselShelfRendererFromJson(
  Map<String, dynamic> json,
) => MusicCarouselShelfRenderer(
  header: json['header'] == null
      ? null
      : MusicCarouselShelfBasicHeaderRenderer.fromJson(
          json['header'] as Map<String, dynamic>,
        ),
  contents: (json['contents'] as List<dynamic>)
      .map(
        (e) => MusicTwoRowItemRendererContainer.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$MusicCarouselShelfRendererToJson(
  MusicCarouselShelfRenderer instance,
) => <String, dynamic>{
  'header': instance.header,
  'contents': instance.contents,
};

MusicCarouselShelfBasicHeaderRenderer
_$MusicCarouselShelfBasicHeaderRendererFromJson(Map<String, dynamic> json) =>
    MusicCarouselShelfBasicHeaderRenderer(
      title: json['title'] == null
          ? null
          : Runs.fromJson(json['title'] as Map<String, dynamic>),
      moreContentButton: json['moreContentButton'] == null
          ? null
          : MoreContentButton.fromJson(
              json['moreContentButton'] as Map<String, dynamic>,
            ),
      trackingParams: json['trackingParams'] as String?,
      headerStyle: json['headerStyle'] as String?,
    );

Map<String, dynamic> _$MusicCarouselShelfBasicHeaderRendererToJson(
  MusicCarouselShelfBasicHeaderRenderer instance,
) => <String, dynamic>{
  'title': instance.title,
  'moreContentButton': instance.moreContentButton,
  'trackingParams': instance.trackingParams,
  'headerStyle': instance.headerStyle,
};

MoreContentButton _$MoreContentButtonFromJson(Map<String, dynamic> json) =>
    MoreContentButton(
      buttonRenderer: json['buttonRenderer'] == null
          ? null
          : ButtonRenderer.fromJson(
              json['buttonRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MoreContentButtonToJson(MoreContentButton instance) =>
    <String, dynamic>{'buttonRenderer': instance.buttonRenderer};

ButtonRenderer _$ButtonRendererFromJson(Map<String, dynamic> json) =>
    ButtonRenderer(
      style: json['style'] as String?,
      isDisabled: json['isDisabled'] as bool?,
      text: json['text'] == null
          ? null
          : Runs.fromJson(json['text'] as Map<String, dynamic>),
      navigationEndpoint: json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>,
            ),
      trackingParams: json['trackingParams'] as String?,
    );

Map<String, dynamic> _$ButtonRendererToJson(ButtonRenderer instance) =>
    <String, dynamic>{
      'style': instance.style,
      'isDisabled': instance.isDisabled,
      'text': instance.text,
      'navigationEndpoint': instance.navigationEndpoint,
      'trackingParams': instance.trackingParams,
    };
