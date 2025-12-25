// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextBody _$NextBodyFromJson(Map<String, dynamic> json) => NextBody(
  context: Context.fromJson(json['context'] as Map<String, dynamic>),
  videoId: json['videoId'] as String?,
  playlistId: json['playlistId'] as String?,
  playlistSetVideoId: json['playlistSetVideoId'] as String?,
  index: (json['index'] as num?)?.toInt(),
  params: json['params'] as String?,
  continuation: json['continuation'] as String?,
);

Map<String, dynamic> _$NextBodyToJson(NextBody instance) => <String, dynamic>{
  'context': instance.context,
  'videoId': instance.videoId,
  'playlistId': instance.playlistId,
  'playlistSetVideoId': instance.playlistSetVideoId,
  'index': instance.index,
  'params': instance.params,
  'continuation': instance.continuation,
};
