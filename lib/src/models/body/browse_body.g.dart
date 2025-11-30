// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseBody _$BrowseBodyFromJson(Map<String, dynamic> json) => BrowseBody(
  context: Context.fromJson(json['context'] as Map<String, dynamic>),
  browseId: json['browseId'] as String?,
  params: json['params'] as String?,
);

Map<String, dynamic> _$BrowseBodyToJson(BrowseBody instance) =>
    <String, dynamic>{
      'context': instance.context,
      'browseId': instance.browseId,
      'params': instance.params,
    };
