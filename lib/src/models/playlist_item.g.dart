// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistItem _$PlaylistItemFromJson(Map<String, dynamic> json) => PlaylistItem(
  id: json['id'] as String,
  title: json['title'] as String,
  author: json['author'] == null
      ? null
      : Artist.fromJson(json['author'] as Map<String, dynamic>),
  songCountText: json['songCountText'] as String?,
  thumbnails: json['thumbnails'] == null
      ? null
      : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  isEditable: json['isEditable'] as bool? ?? false,
  watchEndpoint: json['watchEndpoint'] == null
      ? null
      : WatchEndpoint.fromJson(json['watchEndpoint'] as Map<String, dynamic>),
  watchPlaylistEndpoint: json['watchPlaylistEndpoint'] == null
      ? null
      : WatchPlaylistEndpoint.fromJson(
          json['watchPlaylistEndpoint'] as Map<String, dynamic>,
        ),
  shuffleEndpoint: json['shuffleEndpoint'] == null
      ? null
      : WatchPlaylistEndpoint.fromJson(
          json['shuffleEndpoint'] as Map<String, dynamic>,
        ),
  radioEndpoint: json['radioEndpoint'] == null
      ? null
      : WatchPlaylistEndpoint.fromJson(
          json['radioEndpoint'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PlaylistItemToJson(PlaylistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'songCountText': instance.songCountText,
      'thumbnails': instance.thumbnails,
      'isEditable': instance.isEditable,
      'watchEndpoint': instance.watchEndpoint,
      'watchPlaylistEndpoint': instance.watchPlaylistEndpoint,
      'shuffleEndpoint': instance.shuffleEndpoint,
      'radioEndpoint': instance.radioEndpoint,
    };
