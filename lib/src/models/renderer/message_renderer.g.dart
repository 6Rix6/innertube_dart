// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageRenderer _$MessageRendererFromJson(Map<String, dynamic> json) =>
    MessageRenderer(
      trackingParams: json['trackingParams'] as String?,
      text: json['text'] == null
          ? null
          : Runs.fromJson(json['text'] as Map<String, dynamic>),
      style: json['style'] == null
          ? null
          : Style.fromJson(json['style'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageRendererToJson(MessageRenderer instance) =>
    <String, dynamic>{
      'trackingParams': instance.trackingParams,
      'text': instance.text,
      'style': instance.style,
    };
