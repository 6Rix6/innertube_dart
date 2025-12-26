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
          ?.map((e) => Continuation.fromJson(e as Map<String, dynamic>))
          .toList(),
      trackingParams: json['trackingParams'] as String?,
      bottomText: json['bottomText'] == null
          ? null
          : Runs.fromJson(json['bottomText'] as Map<String, dynamic>),
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
      'bottomText': instance.bottomText,
      'bottomEndpoint': instance.bottomEndpoint,
    };
