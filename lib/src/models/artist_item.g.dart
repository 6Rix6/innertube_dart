// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistItem _$ArtistItemFromJson(Map<String, dynamic> json) => ArtistItem(
  id: json['id'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] == null
      ? null
      : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
  thumbnails: json['thumbnails'] == null
      ? null
      : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  channelId: json['channelId'] as String?,
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

Map<String, dynamic> _$ArtistItemToJson(ArtistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'thumbnails': instance.thumbnails,
      'channelId': instance.channelId,
      'shuffleEndpoint': instance.shuffleEndpoint,
      'radioEndpoint': instance.radioEndpoint,
    };
