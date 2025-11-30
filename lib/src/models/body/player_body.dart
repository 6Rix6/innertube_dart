import 'package:json_annotation/json_annotation.dart';
import '../context.dart';

part 'player_body.g.dart';

/// Request body for player endpoint
@JsonSerializable(explicitToJson: true)
class PlayerBody {
  final Context context;
  final String videoId;
  final String? playlistId;
  final PlaybackContext? playbackContext;
  final ServiceIntegrityDimensions? serviceIntegrityDimensions;
  final bool contentCheckOk;
  final bool racyCheckOk;

  PlayerBody({
    required this.context,
    required this.videoId,
    this.playlistId,
    this.playbackContext,
    this.serviceIntegrityDimensions,
    this.contentCheckOk = true,
    this.racyCheckOk = true,
  });

  factory PlayerBody.fromJson(Map<String, dynamic> json) =>
      _$PlayerBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerBodyToJson(this);
}

/// Playback context for player request
@JsonSerializable(explicitToJson: true)
class PlaybackContext {
  final ContentPlaybackContext contentPlaybackContext;

  PlaybackContext({required this.contentPlaybackContext});

  factory PlaybackContext.fromJson(Map<String, dynamic> json) =>
      _$PlaybackContextFromJson(json);

  Map<String, dynamic> toJson() => _$PlaybackContextToJson(this);
}

/// Content playback context with signature timestamp
@JsonSerializable()
class ContentPlaybackContext {
  final int signatureTimestamp;

  ContentPlaybackContext({required this.signatureTimestamp});

  factory ContentPlaybackContext.fromJson(Map<String, dynamic> json) =>
      _$ContentPlaybackContextFromJson(json);

  Map<String, dynamic> toJson() => _$ContentPlaybackContextToJson(this);
}

/// Service integrity dimensions for player request
@JsonSerializable()
class ServiceIntegrityDimensions {
  final String poToken;

  ServiceIntegrityDimensions({required this.poToken});

  factory ServiceIntegrityDimensions.fromJson(Map<String, dynamic> json) =>
      _$ServiceIntegrityDimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceIntegrityDimensionsToJson(this);
}
