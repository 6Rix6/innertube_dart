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
  albumTypeText: json['albumTypeText'] as String?,
  songCountText: json['songCountText'] as String?,
  durationText: json['durationText'] as String?,
  thumbnails: Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  explicit: json['explicit'] as bool? ?? false,
);

Map<String, dynamic> _$AlbumItemToJson(AlbumItem instance) => <String, dynamic>{
  'browseId': instance.browseId,
  'playlistId': instance.playlistId,
  'id': instance.id,
  'title': instance.title,
  'artists': instance.artists,
  'year': instance.year,
  'albumTypeText': instance.albumTypeText,
  'songCountText': instance.songCountText,
  'durationText': instance.durationText,
  'thumbnails': instance.thumbnails,
  'explicit': instance.explicit,
};
