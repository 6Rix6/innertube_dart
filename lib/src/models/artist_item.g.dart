// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistItem _$ArtistItemFromJson(Map<String, dynamic> json) => ArtistItem(
  id: json['id'] as String,
  title: json['title'] as String,
  thumbnail: json['thumbnail'] as String?,
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
      'thumbnail': instance.thumbnail,
      'channelId': instance.channelId,
      'shuffleEndpoint': instance.shuffleEndpoint,
      'radioEndpoint': instance.radioEndpoint,
    };
