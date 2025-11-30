// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseResponse _$BrowseResponseFromJson(Map<String, dynamic> json) =>
    BrowseResponse(
      header: json['header'] as Map<String, dynamic>?,
      contents: json['contents'] as Map<String, dynamic>?,
      microformat: json['microformat'] as Map<String, dynamic>?,
      background: json['background'] as Map<String, dynamic>?,
      continuationContents:
          json['continuationContents'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BrowseResponseToJson(BrowseResponse instance) =>
    <String, dynamic>{
      'header': instance.header,
      'contents': instance.contents,
      'microformat': instance.microformat,
      'background': instance.background,
      'continuationContents': instance.continuationContents,
    };
