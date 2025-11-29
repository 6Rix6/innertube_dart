// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongItem _$SongItemFromJson(Map<String, dynamic> json) => SongItem(
  id: json['id'] as String,
  title: json['title'] as String,
  artists: (json['artists'] as List<dynamic>)
      .map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList(),
  album: json['album'] == null
      ? null
      : Album.fromJson(json['album'] as Map<String, dynamic>),
  duration: (json['duration'] as num?)?.toInt(),
  chartPosition: (json['chartPosition'] as num?)?.toInt(),
  chartChange: json['chartChange'] as String?,
  thumbnail: json['thumbnail'] as String,
  explicit: json['explicit'] as bool? ?? false,
  setVideoId: json['setVideoId'] as String?,
  libraryAddToken: json['libraryAddToken'] as String?,
  libraryRemoveToken: json['libraryRemoveToken'] as String?,
  historyRemoveToken: json['historyRemoveToken'] as String?,
);

Map<String, dynamic> _$SongItemToJson(SongItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'artists': instance.artists,
  'album': instance.album,
  'duration': instance.duration,
  'chartPosition': instance.chartPosition,
  'chartChange': instance.chartChange,
  'thumbnail': instance.thumbnail,
  'explicit': instance.explicit,
  'setVideoId': instance.setVideoId,
  'libraryAddToken': instance.libraryAddToken,
  'libraryRemoveToken': instance.libraryRemoveToken,
  'historyRemoveToken': instance.historyRemoveToken,
};
