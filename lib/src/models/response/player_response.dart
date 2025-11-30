import 'package:json_annotation/json_annotation.dart';
import '../renderer/thumbnails.dart';

part 'player_response.g.dart';

/// Player response from YouTube InnerTube API
@JsonSerializable(explicitToJson: true)
class PlayerResponse {
  final PlayabilityStatus playabilityStatus;
  final PlayerConfig? playerConfig;
  final StreamingData? streamingData;
  final VideoDetails? videoDetails;
  final PlaybackTracking? playbackTracking;

  PlayerResponse({
    required this.playabilityStatus,
    this.playerConfig,
    this.streamingData,
    this.videoDetails,
    this.playbackTracking,
  });

  factory PlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerResponseToJson(this);
}

/// Playability status of the video
@JsonSerializable()
class PlayabilityStatus {
  final String status;
  final String? reason;

  PlayabilityStatus({required this.status, this.reason});

  factory PlayabilityStatus.fromJson(Map<String, dynamic> json) =>
      _$PlayabilityStatusFromJson(json);

  Map<String, dynamic> toJson() => _$PlayabilityStatusToJson(this);
}

/// Player configuration
@JsonSerializable(explicitToJson: true)
class PlayerConfig {
  final AudioConfig audioConfig;

  PlayerConfig({required this.audioConfig});

  factory PlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$PlayerConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerConfigToJson(this);
}

/// Audio configuration
@JsonSerializable()
class AudioConfig {
  final double? loudnessDb;
  final double? perceptualLoudnessDb;

  AudioConfig({this.loudnessDb, this.perceptualLoudnessDb});

  factory AudioConfig.fromJson(Map<String, dynamic> json) =>
      _$AudioConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AudioConfigToJson(this);
}

/// Streaming data containing formats
@JsonSerializable(explicitToJson: true)
class StreamingData {
  final List<Format>? formats;
  final List<Format> adaptiveFormats;
  final String expiresInSeconds; // Changed from int to String
  final String? serverAbrStreamingUrl;

  StreamingData({
    this.formats,
    required this.adaptiveFormats,
    required this.expiresInSeconds,
    this.serverAbrStreamingUrl,
  });

  factory StreamingData.fromJson(Map<String, dynamic> json) =>
      _$StreamingDataFromJson(json);

  Map<String, dynamic> toJson() => _$StreamingDataToJson(this);
}

/// Format information for streaming
@JsonSerializable(explicitToJson: true)
class Format {
  final int itag;
  final String? url;
  final String mimeType;
  final int bitrate;
  final int? width;
  final int? height;
  final String? contentLength; // Changed from int? to String?
  final String quality;
  final int? fps;
  final String? qualityLabel;
  final int? averageBitrate;
  final String? audioQuality;
  final String? approxDurationMs;
  final String? audioSampleRate; // Changed from int? to String?
  final int? audioChannels;
  final double? loudnessDb;
  final String? lastModified; // Changed from int? to String?
  final String? signatureCipher;
  final AudioTrack? audioTrack;

  Format({
    required this.itag,
    this.url,
    required this.mimeType,
    required this.bitrate,
    this.width,
    this.height,
    this.contentLength,
    required this.quality,
    this.fps,
    this.qualityLabel,
    this.averageBitrate,
    this.audioQuality,
    this.approxDurationMs,
    this.audioSampleRate,
    this.audioChannels,
    this.loudnessDb,
    this.lastModified,
    this.signatureCipher,
    this.audioTrack,
  });

  /// Check if this format is audio only
  bool get isAudio => width == null;

  /// Check if this is original audio (not auto-dubbed)
  bool get isOriginal => audioTrack?.isAutoDubbed == null;

  factory Format.fromJson(Map<String, dynamic> json) => _$FormatFromJson(json);

  Map<String, dynamic> toJson() => _$FormatToJson(this);

  @override
  String toString() {
    return 'Format(url: $url)';
  }

  // String toString() {
  //   return 'Format(itag: $itag, mimeType: $mimeType, bitrate: $bitrate, width: $width, height: $height, contentLength: $contentLength, quality: $quality, fps: $fps, qualityLabel: $qualityLabel, averageBitrate: $averageBitrate, audioQuality: $audioQuality, approxDurationMs: $approxDurationMs, audioSampleRate: $audioSampleRate, audioChannels: $audioChannels, loudnessDb: $loudnessDb, lastModified: $lastModified, signatureCipher: $signatureCipher, audioTrack: $audioTrack)';
  // }
}

/// Audio track information
@JsonSerializable()
class AudioTrack {
  final String? displayName;
  final String? id;
  final bool? isAutoDubbed;

  AudioTrack({this.displayName, this.id, this.isAutoDubbed});

  factory AudioTrack.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackFromJson(json);

  Map<String, dynamic> toJson() => _$AudioTrackToJson(this);
}

/// Video details
@JsonSerializable(explicitToJson: true)
class VideoDetails {
  final String videoId;
  final String? title;
  final String? author;
  final String channelId;
  final String lengthSeconds;
  final String? musicVideoType;
  final String? viewCount;
  final Thumbnails thumbnail;

  VideoDetails({
    required this.videoId,
    this.title,
    this.author,
    required this.channelId,
    required this.lengthSeconds,
    this.musicVideoType,
    this.viewCount,
    required this.thumbnail,
  });

  factory VideoDetails.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDetailsToJson(this);
}

/// Playback tracking URLs
@JsonSerializable(explicitToJson: true)
class PlaybackTracking {
  final VideostatsPlaybackUrl? videostatsPlaybackUrl;
  final VideostatsWatchtimeUrl? videostatsWatchtimeUrl;
  final AtrUrl? atrUrl;

  PlaybackTracking({
    this.videostatsPlaybackUrl,
    this.videostatsWatchtimeUrl,
    this.atrUrl,
  });

  factory PlaybackTracking.fromJson(Map<String, dynamic> json) =>
      _$PlaybackTrackingFromJson(json);

  Map<String, dynamic> toJson() => _$PlaybackTrackingToJson(this);
}

/// Video stats playback URL
@JsonSerializable()
class VideostatsPlaybackUrl {
  final String? baseUrl;

  VideostatsPlaybackUrl({this.baseUrl});

  factory VideostatsPlaybackUrl.fromJson(Map<String, dynamic> json) =>
      _$VideostatsPlaybackUrlFromJson(json);

  Map<String, dynamic> toJson() => _$VideostatsPlaybackUrlToJson(this);
}

/// Video stats watchtime URL
@JsonSerializable()
class VideostatsWatchtimeUrl {
  final String? baseUrl;

  VideostatsWatchtimeUrl({this.baseUrl});

  factory VideostatsWatchtimeUrl.fromJson(Map<String, dynamic> json) =>
      _$VideostatsWatchtimeUrlFromJson(json);

  Map<String, dynamic> toJson() => _$VideostatsWatchtimeUrlToJson(this);
}

/// ATR URL
@JsonSerializable()
class AtrUrl {
  final String? baseUrl;

  AtrUrl({this.baseUrl});

  factory AtrUrl.fromJson(Map<String, dynamic> json) => _$AtrUrlFromJson(json);

  Map<String, dynamic> toJson() => _$AtrUrlToJson(this);
}
