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
  thumbnail: json['thumbnail'] as String?,
  isEditable: json['isEditable'] as bool? ?? false,
  playEndpoint: json['playEndpoint'] == null
      ? null
      : WatchPlaylistEndpoint.fromJson(
          json['playEndpoint'] as Map<String, dynamic>,
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
      'thumbnail': instance.thumbnail,
      'isEditable': instance.isEditable,
      'playEndpoint': instance.playEndpoint,
      'shuffleEndpoint': instance.shuffleEndpoint,
      'radioEndpoint': instance.radioEndpoint,
    };
