// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
  name: json['name'] as String,
  id: json['id'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
);

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
  'thumbnailUrl': instance.thumbnailUrl,
};
