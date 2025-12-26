// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongItem _$SongItemFromJson(Map<String, dynamic> json) => SongItem(
  id: json['id'] as String,
  title: json['title'] as String,
  artists: (json['artists'] as List<dynamic>?)
      ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList(),
  album: json['album'] == null
      ? null
      : Album.fromJson(json['album'] as Map<String, dynamic>),
  duration: json['duration'] == null
      ? null
      : Duration(microseconds: (json['duration'] as num).toInt()),
  chartPosition: (json['chartPosition'] as num?)?.toInt(),
  chartChange: json['chartChange'] as String?,
  viewCount: json['viewCount'] as String?,
  typeText: json['typeText'] as String?,
  subtitle: json['subtitle'] == null
      ? null
      : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
  thumbnails: json['thumbnails'] == null
      ? null
      : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
  isVideo: json['isVideo'] as bool? ?? false,
  explicit: json['explicit'] as bool? ?? false,
  setVideoId: json['setVideoId'] as String?,
  libraryAddToken: json['libraryAddToken'] as String?,
  libraryRemoveToken: json['libraryRemoveToken'] as String?,
  historyRemoveToken: json['historyRemoveToken'] as String?,
  menu: json['menu'] == null
      ? null
      : MenuRenderer.fromJson(json['menu'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SongItemToJson(SongItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'artists': instance.artists,
  'album': instance.album,
  'duration': instance.duration?.inMicroseconds,
  'chartPosition': instance.chartPosition,
  'chartChange': instance.chartChange,
  'viewCount': instance.viewCount,
  'typeText': instance.typeText,
  'subtitle': instance.subtitle,
  'isVideo': instance.isVideo,
  'menu': instance.menu,
  'thumbnails': instance.thumbnails,
  'explicit': instance.explicit,
  'setVideoId': instance.setVideoId,
  'libraryAddToken': instance.libraryAddToken,
  'libraryRemoveToken': instance.libraryRemoveToken,
  'historyRemoveToken': instance.historyRemoveToken,
};
