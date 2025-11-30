// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerBody _$PlayerBodyFromJson(Map<String, dynamic> json) => PlayerBody(
  context: Context.fromJson(json['context'] as Map<String, dynamic>),
  videoId: json['videoId'] as String,
  playlistId: json['playlistId'] as String?,
  playbackContext: json['playbackContext'] == null
      ? null
      : PlaybackContext.fromJson(
          json['playbackContext'] as Map<String, dynamic>,
        ),
  serviceIntegrityDimensions: json['serviceIntegrityDimensions'] == null
      ? null
      : ServiceIntegrityDimensions.fromJson(
          json['serviceIntegrityDimensions'] as Map<String, dynamic>,
        ),
  contentCheckOk: json['contentCheckOk'] as bool? ?? true,
  racyCheckOk: json['racyCheckOk'] as bool? ?? true,
);

Map<String, dynamic> _$PlayerBodyToJson(
  PlayerBody instance,
) => <String, dynamic>{
  'context': instance.context.toJson(),
  'videoId': instance.videoId,
  'playlistId': instance.playlistId,
  'playbackContext': instance.playbackContext?.toJson(),
  'serviceIntegrityDimensions': instance.serviceIntegrityDimensions?.toJson(),
  'contentCheckOk': instance.contentCheckOk,
  'racyCheckOk': instance.racyCheckOk,
};

PlaybackContext _$PlaybackContextFromJson(Map<String, dynamic> json) =>
    PlaybackContext(
      contentPlaybackContext: ContentPlaybackContext.fromJson(
        json['contentPlaybackContext'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PlaybackContextToJson(PlaybackContext instance) =>
    <String, dynamic>{
      'contentPlaybackContext': instance.contentPlaybackContext.toJson(),
    };

ContentPlaybackContext _$ContentPlaybackContextFromJson(
  Map<String, dynamic> json,
) => ContentPlaybackContext(
  signatureTimestamp: (json['signatureTimestamp'] as num).toInt(),
);

Map<String, dynamic> _$ContentPlaybackContextToJson(
  ContentPlaybackContext instance,
) => <String, dynamic>{'signatureTimestamp': instance.signatureTimestamp};

ServiceIntegrityDimensions _$ServiceIntegrityDimensionsFromJson(
  Map<String, dynamic> json,
) => ServiceIntegrityDimensions(poToken: json['poToken'] as String);

Map<String, dynamic> _$ServiceIntegrityDimensionsToJson(
  ServiceIntegrityDimensions instance,
) => <String, dynamic>{'poToken': instance.poToken};
