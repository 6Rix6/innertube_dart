// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_shelf_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicShelfRenderer _$MusicShelfRendererFromJson(Map<String, dynamic> json) =>
    MusicShelfRenderer(
      title: json['title'] == null
          ? null
          : Runs.fromJson(json['title'] as Map<String, dynamic>),
      contents: (json['contents'] as List<dynamic>?)
          ?.map(
            (e) => MusicResponsiveListItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      continuations: (json['continuations'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      trackingParams: json['trackingParams'] as String?,
      buttomText: json['buttomText'] == null
          ? null
          : Runs.fromJson(json['buttomText'] as Map<String, dynamic>),
      bottomEndpoint: json['bottomEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['bottomEndpoint'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MusicShelfRendererToJson(MusicShelfRenderer instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contents': instance.contents,
      'continuations': instance.continuations,
      'trackingParams': instance.trackingParams,
      'buttomText': instance.buttomText,
      'bottomEndpoint': instance.bottomEndpoint,
    };
