// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerResponse _$PlayerResponseFromJson(Map<String, dynamic> json) =>
    PlayerResponse(
      playabilityStatus: PlayabilityStatus.fromJson(
        json['playabilityStatus'] as Map<String, dynamic>,
      ),
      playerConfig: json['playerConfig'] == null
          ? null
          : PlayerConfig.fromJson(json['playerConfig'] as Map<String, dynamic>),
      streamingData: json['streamingData'] == null
          ? null
          : StreamingData.fromJson(
              json['streamingData'] as Map<String, dynamic>,
            ),
      videoDetails: json['videoDetails'] == null
          ? null
          : VideoDetails.fromJson(json['videoDetails'] as Map<String, dynamic>),
      playbackTracking: json['playbackTracking'] == null
          ? null
          : PlaybackTracking.fromJson(
              json['playbackTracking'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PlayerResponseToJson(PlayerResponse instance) =>
    <String, dynamic>{
      'playabilityStatus': instance.playabilityStatus.toJson(),
      'playerConfig': instance.playerConfig?.toJson(),
      'streamingData': instance.streamingData?.toJson(),
      'videoDetails': instance.videoDetails?.toJson(),
      'playbackTracking': instance.playbackTracking?.toJson(),
    };

PlayabilityStatus _$PlayabilityStatusFromJson(Map<String, dynamic> json) =>
    PlayabilityStatus(
      status: json['status'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$PlayabilityStatusToJson(PlayabilityStatus instance) =>
    <String, dynamic>{'status': instance.status, 'reason': instance.reason};

PlayerConfig _$PlayerConfigFromJson(Map<String, dynamic> json) => PlayerConfig(
  audioConfig: AudioConfig.fromJson(
    json['audioConfig'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PlayerConfigToJson(PlayerConfig instance) =>
    <String, dynamic>{'audioConfig': instance.audioConfig.toJson()};

AudioConfig _$AudioConfigFromJson(Map<String, dynamic> json) => AudioConfig(
  loudnessDb: (json['loudnessDb'] as num?)?.toDouble(),
  perceptualLoudnessDb: (json['perceptualLoudnessDb'] as num?)?.toDouble(),
);

Map<String, dynamic> _$AudioConfigToJson(AudioConfig instance) =>
    <String, dynamic>{
      'loudnessDb': instance.loudnessDb,
      'perceptualLoudnessDb': instance.perceptualLoudnessDb,
    };

StreamingData _$StreamingDataFromJson(Map<String, dynamic> json) =>
    StreamingData(
      formats: (json['formats'] as List<dynamic>?)
          ?.map((e) => Format.fromJson(e as Map<String, dynamic>))
          .toList(),
      adaptiveFormats: (json['adaptiveFormats'] as List<dynamic>)
          .map((e) => Format.fromJson(e as Map<String, dynamic>))
          .toList(),
      expiresInSeconds: json['expiresInSeconds'] as String,
      serverAbrStreamingUrl: json['serverAbrStreamingUrl'] as String?,
    );

Map<String, dynamic> _$StreamingDataToJson(
  StreamingData instance,
) => <String, dynamic>{
  'formats': instance.formats?.map((e) => e.toJson()).toList(),
  'adaptiveFormats': instance.adaptiveFormats.map((e) => e.toJson()).toList(),
  'expiresInSeconds': instance.expiresInSeconds,
  'serverAbrStreamingUrl': instance.serverAbrStreamingUrl,
};

Format _$FormatFromJson(Map<String, dynamic> json) => Format(
  itag: (json['itag'] as num).toInt(),
  url: json['url'] as String?,
  mimeType: json['mimeType'] as String,
  bitrate: (json['bitrate'] as num).toInt(),
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  contentLength: json['contentLength'] as String?,
  quality: json['quality'] as String,
  fps: (json['fps'] as num?)?.toInt(),
  qualityLabel: json['qualityLabel'] as String?,
  averageBitrate: (json['averageBitrate'] as num?)?.toInt(),
  audioQuality: json['audioQuality'] as String?,
  approxDurationMs: json['approxDurationMs'] as String?,
  audioSampleRate: json['audioSampleRate'] as String?,
  audioChannels: (json['audioChannels'] as num?)?.toInt(),
  loudnessDb: (json['loudnessDb'] as num?)?.toDouble(),
  lastModified: json['lastModified'] as String?,
  signatureCipher: json['signatureCipher'] as String?,
  audioTrack: json['audioTrack'] == null
      ? null
      : AudioTrack.fromJson(json['audioTrack'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormatToJson(Format instance) => <String, dynamic>{
  'itag': instance.itag,
  'url': instance.url,
  'mimeType': instance.mimeType,
  'bitrate': instance.bitrate,
  'width': instance.width,
  'height': instance.height,
  'contentLength': instance.contentLength,
  'quality': instance.quality,
  'fps': instance.fps,
  'qualityLabel': instance.qualityLabel,
  'averageBitrate': instance.averageBitrate,
  'audioQuality': instance.audioQuality,
  'approxDurationMs': instance.approxDurationMs,
  'audioSampleRate': instance.audioSampleRate,
  'audioChannels': instance.audioChannels,
  'loudnessDb': instance.loudnessDb,
  'lastModified': instance.lastModified,
  'signatureCipher': instance.signatureCipher,
  'audioTrack': instance.audioTrack?.toJson(),
};

AudioTrack _$AudioTrackFromJson(Map<String, dynamic> json) => AudioTrack(
  displayName: json['displayName'] as String?,
  id: json['id'] as String?,
  isAutoDubbed: json['isAutoDubbed'] as bool?,
);

Map<String, dynamic> _$AudioTrackToJson(AudioTrack instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'id': instance.id,
      'isAutoDubbed': instance.isAutoDubbed,
    };

VideoDetails _$VideoDetailsFromJson(Map<String, dynamic> json) => VideoDetails(
  videoId: json['videoId'] as String,
  title: json['title'] as String?,
  author: json['author'] as String?,
  channelId: json['channelId'] as String,
  lengthSeconds: json['lengthSeconds'] as String,
  musicVideoType: json['musicVideoType'] as String?,
  viewCount: json['viewCount'] as String?,
  thumbnail: Thumbnails.fromJson(json['thumbnail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VideoDetailsToJson(VideoDetails instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'author': instance.author,
      'channelId': instance.channelId,
      'lengthSeconds': instance.lengthSeconds,
      'musicVideoType': instance.musicVideoType,
      'viewCount': instance.viewCount,
      'thumbnail': instance.thumbnail.toJson(),
    };

PlaybackTracking _$PlaybackTrackingFromJson(Map<String, dynamic> json) =>
    PlaybackTracking(
      videostatsPlaybackUrl: json['videostatsPlaybackUrl'] == null
          ? null
          : VideostatsPlaybackUrl.fromJson(
              json['videostatsPlaybackUrl'] as Map<String, dynamic>,
            ),
      videostatsWatchtimeUrl: json['videostatsWatchtimeUrl'] == null
          ? null
          : VideostatsWatchtimeUrl.fromJson(
              json['videostatsWatchtimeUrl'] as Map<String, dynamic>,
            ),
      atrUrl: json['atrUrl'] == null
          ? null
          : AtrUrl.fromJson(json['atrUrl'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaybackTrackingToJson(PlaybackTracking instance) =>
    <String, dynamic>{
      'videostatsPlaybackUrl': instance.videostatsPlaybackUrl?.toJson(),
      'videostatsWatchtimeUrl': instance.videostatsWatchtimeUrl?.toJson(),
      'atrUrl': instance.atrUrl?.toJson(),
    };

VideostatsPlaybackUrl _$VideostatsPlaybackUrlFromJson(
  Map<String, dynamic> json,
) => VideostatsPlaybackUrl(baseUrl: json['baseUrl'] as String?);

Map<String, dynamic> _$VideostatsPlaybackUrlToJson(
  VideostatsPlaybackUrl instance,
) => <String, dynamic>{'baseUrl': instance.baseUrl};

VideostatsWatchtimeUrl _$VideostatsWatchtimeUrlFromJson(
  Map<String, dynamic> json,
) => VideostatsWatchtimeUrl(baseUrl: json['baseUrl'] as String?);

Map<String, dynamic> _$VideostatsWatchtimeUrlToJson(
  VideostatsWatchtimeUrl instance,
) => <String, dynamic>{'baseUrl': instance.baseUrl};

AtrUrl _$AtrUrlFromJson(Map<String, dynamic> json) =>
    AtrUrl(baseUrl: json['baseUrl'] as String?);

Map<String, dynamic> _$AtrUrlToJson(AtrUrl instance) => <String, dynamic>{
  'baseUrl': instance.baseUrl,
};
