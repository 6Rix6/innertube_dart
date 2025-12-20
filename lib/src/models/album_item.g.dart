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
  subtitle: json['subtitle'] == null
      ? null
      : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
  artists: (json['artists'] as List<dynamic>?)
      ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList(),
  year: json['year'] as String?,
  albumTypeText: json['albumTypeText'] as String?,
  songCountText: json['songCountText'] as String?,
  durationText: json['durationText'] as String?,
  artistThumbnails: json['artistThumbnails'] == null
      ? null
      : Thumbnails.fromJson(json['artistThumbnails'] as Map<String, dynamic>),
  thumbnails: Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  menu: json['menu'] == null
      ? null
      : MenuRenderer.fromJson(json['menu'] as Map<String, dynamic>),
  explicit: json['explicit'] as bool? ?? false,
);

Map<String, dynamic> _$AlbumItemToJson(AlbumItem instance) => <String, dynamic>{
  'browseId': instance.browseId,
  'playlistId': instance.playlistId,
  'id': instance.id,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'artists': instance.artists,
  'year': instance.year,
  'albumTypeText': instance.albumTypeText,
  'songCountText': instance.songCountText,
  'durationText': instance.durationText,
  'artistThumbnails': instance.artistThumbnails,
  'menu': instance.menu,
  'thumbnails': instance.thumbnails,
  'explicit': instance.explicit,
};
