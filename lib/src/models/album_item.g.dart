// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumItem _$AlbumItemFromJson(Map<String, dynamic> json) => AlbumItem(
  browseId: json['browseId'] as String,
  playlistId: json['playlistId'] as String,
  id: json['id'] as String?,
  title: json['title'] as String,
  artists: (json['artists'] as List<dynamic>?)
      ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList(),
  year: json['year'] as String?,
  thumbnail: json['thumbnail'] as String,
  explicit: json['explicit'] as bool? ?? false,
);

Map<String, dynamic> _$AlbumItemToJson(AlbumItem instance) => <String, dynamic>{
  'browseId': instance.browseId,
  'playlistId': instance.playlistId,
  'id': instance.id,
  'title': instance.title,
  'artists': instance.artists,
  'year': instance.year,
  'thumbnail': instance.thumbnail,
  'explicit': instance.explicit,
};
