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
      : MusicCarouselShelfBasicHeader.fromJson(
          json['header'] as Map<String, dynamic>,
        ),
  contents: (json['contents'] as List<dynamic>)
      .map(
        (e) => MusicCarouselShelfRendererContent.fromJson(
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

MusicCarouselShelfBasicHeader _$MusicCarouselShelfBasicHeaderFromJson(
  Map<String, dynamic> json,
) => MusicCarouselShelfBasicHeader(
  musicCarouselShelfBasicHeaderRenderer:
      json['musicCarouselShelfBasicHeaderRenderer'] == null
      ? null
      : MusicCarouselShelfBasicHeaderRenderer.fromJson(
          json['musicCarouselShelfBasicHeaderRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MusicCarouselShelfBasicHeaderToJson(
  MusicCarouselShelfBasicHeader instance,
) => <String, dynamic>{
  'musicCarouselShelfBasicHeaderRenderer':
      instance.musicCarouselShelfBasicHeaderRenderer,
};

MusicCarouselShelfBasicHeaderRenderer
_$MusicCarouselShelfBasicHeaderRendererFromJson(Map<String, dynamic> json) =>
    MusicCarouselShelfBasicHeaderRenderer(
      title: json['title'] == null
          ? null
          : Runs.fromJson(json['title'] as Map<String, dynamic>),
      strapline: json['strapline'] == null
          ? null
          : Runs.fromJson(json['strapline'] as Map<String, dynamic>),
      moreContentButton: json['moreContentButton'] == null
          ? null
          : MoreContentButton.fromJson(
              json['moreContentButton'] as Map<String, dynamic>,
            ),
      trackingParams: json['trackingParams'] as String?,
      headerStyle: json['headerStyle'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : ThumbnailRenderer.fromJson(
              json['thumbnail'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MusicCarouselShelfBasicHeaderRendererToJson(
  MusicCarouselShelfBasicHeaderRenderer instance,
) => <String, dynamic>{
  'title': instance.title,
  'strapline': instance.strapline,
  'moreContentButton': instance.moreContentButton,
  'trackingParams': instance.trackingParams,
  'headerStyle': instance.headerStyle,
  'thumbnail': instance.thumbnail,
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

MusicCarouselShelfRendererContent _$MusicCarouselShelfRendererContentFromJson(
  Map<String, dynamic> json,
) => MusicCarouselShelfRendererContent(
  musicTwoRowItemRenderer: json['musicTwoRowItemRenderer'] == null
      ? null
      : MusicTwoRowItemRenderer.fromJson(
          json['musicTwoRowItemRenderer'] as Map<String, dynamic>,
        ),
  musicResponsiveListItemRenderer:
      json['musicResponsiveListItemRenderer'] == null
      ? null
      : MusicResponsiveListItemRenderer.fromJson(
          json['musicResponsiveListItemRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MusicCarouselShelfRendererContentToJson(
  MusicCarouselShelfRendererContent instance,
) => <String, dynamic>{
  'musicTwoRowItemRenderer': instance.musicTwoRowItemRenderer,
  'musicResponsiveListItemRenderer': instance.musicResponsiveListItemRenderer,
};
