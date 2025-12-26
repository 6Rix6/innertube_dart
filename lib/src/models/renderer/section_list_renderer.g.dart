// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_list_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionList _$SectionListFromJson(Map<String, dynamic> json) => SectionList(
  sectionListRenderer: json['sectionListRenderer'] == null
      ? null
      : SectionListRenderer.fromJson(
          json['sectionListRenderer'] as Map<String, dynamic>,
        ),
  continuations: (json['continuations'] as List<dynamic>?)
      ?.map((e) => Continuation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SectionListToJson(SectionList instance) =>
    <String, dynamic>{
      'sectionListRenderer': instance.sectionListRenderer,
      'continuations': instance.continuations,
    };

SectionListRenderer _$SectionListRendererFromJson(Map<String, dynamic> json) =>
    SectionListRenderer(
      contents: (json['contents'] as List<dynamic>?)
          ?.map(
            (e) =>
                SectionListRendererContent.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      continuations: (json['continuations'] as List<dynamic>?)
          ?.map((e) => Continuation.fromJson(e as Map<String, dynamic>))
          .toList(),
      trackingParams: json['trackingParams'] as String?,
      header: json['header'] == null
          ? null
          : SectionListHeader.fromJson(json['header'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionListRendererToJson(
  SectionListRenderer instance,
) => <String, dynamic>{
  'contents': instance.contents,
  'continuations': instance.continuations,
  'trackingParams': instance.trackingParams,
  'header': instance.header,
};

SectionListRendererContent _$SectionListRendererContentFromJson(
  Map<String, dynamic> json,
) => SectionListRendererContent(
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
  musicPlaylistShelfRenderer: json['musicPlaylistShelfRenderer'] == null
      ? null
      : MusicPlaylistShelfRenderer.fromJson(
          json['musicPlaylistShelfRenderer'] as Map<String, dynamic>,
        ),
  musicCardShelfRenderer: json['musicCardShelfRenderer'] == null
      ? null
      : MusicCardShelfRenderer.fromJson(
          json['musicCardShelfRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SectionListRendererContentToJson(
  SectionListRendererContent instance,
) => <String, dynamic>{
  'musicCarouselShelfRenderer': instance.musicCarouselShelfRenderer,
  'musicShelfRenderer': instance.musicShelfRenderer,
  'musicResponsiveHeaderRenderer': instance.musicResponsiveHeaderRenderer,
  'musicPlaylistShelfRenderer': instance.musicPlaylistShelfRenderer,
  'musicCardShelfRenderer': instance.musicCardShelfRenderer,
};

SectionListHeader _$SectionListHeaderFromJson(Map<String, dynamic> json) =>
    SectionListHeader(
      chipCloudRenderer: json['chipCloudRenderer'] == null
          ? null
          : ChipCloudRenderer.fromJson(
              json['chipCloudRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SectionListHeaderToJson(SectionListHeader instance) =>
    <String, dynamic>{'chipCloudRenderer': instance.chipCloudRenderer};
