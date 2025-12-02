// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thumbnails _$ThumbnailsFromJson(Map<String, dynamic> json) => Thumbnails(
  thumbnails: (json['thumbnails'] as List<dynamic>)
      .map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ThumbnailsToJson(Thumbnails instance) =>
    <String, dynamic>{'thumbnails': instance.thumbnails};

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
  url: json['url'] as String,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
  'url': instance.url,
  'width': instance.width,
  'height': instance.height,
};
