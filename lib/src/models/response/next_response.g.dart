// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextResponse _$NextResponseFromJson(Map<String, dynamic> json) => NextResponse(
  contents: json['contents'] == null
      ? null
      : SingleColumnMusicWatchNextResults.fromJson(
          json['contents'] as Map<String, dynamic>,
        ),
  responseContext: json['responseContext'] as Map<String, dynamic>?,
  currentVideoEndpoint: json['currentVideoEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['currentVideoEndpoint'] as Map<String, dynamic>,
        ),
  playerOverlays: json['playerOverlays'] as Map<String, dynamic>?,
  videoReporting: json['videoReporting'] as Map<String, dynamic>?,
  trackingParams: json['trackingParams'] as String?,
  queueContextParams: json['queueContextParams'] as String?,
);

Map<String, dynamic> _$NextResponseToJson(NextResponse instance) =>
    <String, dynamic>{
      'responseContext': instance.responseContext,
      'contents': instance.contents,
      'currentVideoEndpoint': instance.currentVideoEndpoint,
      'playerOverlays': instance.playerOverlays,
      'videoReporting': instance.videoReporting,
      'trackingParams': instance.trackingParams,
      'queueContextParams': instance.queueContextParams,
    };
