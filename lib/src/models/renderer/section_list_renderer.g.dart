// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_list_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionListRenderer _$SectionListRendererFromJson(Map<String, dynamic> json) =>
    SectionListRenderer(
      contents: (json['contents'] as List<dynamic>?)
          ?.map(
            (e) =>
                SectionListRendererContents.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      continuations: (json['continuations'] as List<dynamic>?)
          ?.map((e) => Continuations.fromJson(e as Map<String, dynamic>))
          .toList(),
      trackingParams: json['trackingParams'] as String?,
      header: json['header'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SectionListRendererToJson(
  SectionListRenderer instance,
) => <String, dynamic>{
  'contents': instance.contents,
  'continuations': instance.continuations,
  'trackingParams': instance.trackingParams,
  'header': instance.header,
};

SectionListRendererContents _$SectionListRendererContentsFromJson(
  Map<String, dynamic> json,
) => SectionListRendererContents(
  musicCarouselShelfRenderer: json['musicCarouselShelfRenderer'] == null
      ? null
      : MusicCarouselShelfRenderer.fromJson(
          json['musicCarouselShelfRenderer'] as Map<String, dynamic>,
        ),
  musicShelfRenderer: json['musicShelfRenderer'] == null
      ? null
      : MusicShelfRenderer.fromJson(
          json['musicShelfRenderer'] as Map<String, dynamic>,
        ),
  musicResponsiveHeaderRenderer: json['musicResponsiveHeaderRenderer'] == null
      ? null
      : MusicResponsiveHeaderRenderer.fromJson(
          json['musicResponsiveHeaderRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SectionListRendererContentsToJson(
  SectionListRendererContents instance,
) => <String, dynamic>{
  'musicCarouselShelfRenderer': instance.musicCarouselShelfRenderer,
  'musicShelfRenderer': instance.musicShelfRenderer,
  'musicResponsiveHeaderRenderer': instance.musicResponsiveHeaderRenderer,
};
