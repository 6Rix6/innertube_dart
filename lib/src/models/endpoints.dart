import 'package:innertube_dart/src/models/command.dart';
import 'package:json_annotation/json_annotation.dart';

part 'endpoints.g.dart';

/// Navigation endpoint  for YouTube content
@JsonSerializable()
class NavigationEndpoint {
  final String clickTrackingParams;
  final BrowseEndpoint? browseEndpoint;
  final WatchEndpoint? watchEndpoint;
  final WatchPlaylistEndpoint? watchPlaylistEndpoint;
  final QueueAddEndpoint? queueAddEndpoint;
  final ServiceEndpoint? serviceEndpoint;

  // TODO: Add endpoints
  // subscribeEndpoint
  // signalServiceEndpoint

  const NavigationEndpoint({
    required this.clickTrackingParams,
    this.browseEndpoint,
    this.watchEndpoint,
    this.watchPlaylistEndpoint,
    this.queueAddEndpoint,
    this.serviceEndpoint,
  });

  factory NavigationEndpoint.fromJson(Map<String, dynamic> json) =>
      _$NavigationEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$NavigationEndpointToJson(this);
}

@JsonSerializable()
class BrowseEndpoint {
  final String? browseId;
  final String? params;
  final Map<String, dynamic>? browseEndpointContextSupportedConfigs;

  const BrowseEndpoint({
    this.browseId,
    this.params,
    this.browseEndpointContextSupportedConfigs,
  });

  factory BrowseEndpoint.fromJson(Map<String, dynamic> json) =>
      _$BrowseEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseEndpointToJson(this);

  /// Helper to get page type from context
  String? get pageType {
    return browseEndpointContextSupportedConfigs?['browseEndpointContextMusicConfig']?['pageType']
        as String?;
  }
}

@JsonSerializable()
class WatchEndpoint {
  final String videoId;
  final String? playlistId;
  final int? index;
  final String? params;

  const WatchEndpoint({
    required this.videoId,
    this.playlistId,
    this.index,
    this.params,
  });

  factory WatchEndpoint.fromJson(Map<String, dynamic> json) =>
      _$WatchEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$WatchEndpointToJson(this);
}

@JsonSerializable()
class WatchPlaylistEndpoint {
  final String? playlistId;
  final String? params;

  const WatchPlaylistEndpoint({this.playlistId, this.params});

  factory WatchPlaylistEndpoint.fromJson(Map<String, dynamic> json) =>
      _$WatchPlaylistEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$WatchPlaylistEndpointToJson(this);

  @override
  String toString() {
    return 'WatchPlaylistEndpoint(playlistId: $playlistId, params: $params)';
  }
}

@JsonSerializable()
class ServiceEndpoint {
  final String clickTrackingParams;
  final GetAccountSwitcherEndpoint? getAccountSwitcherEndpoint;

  const ServiceEndpoint({
    required this.clickTrackingParams,
    this.getAccountSwitcherEndpoint,
  });

  factory ServiceEndpoint.fromJson(Map<String, dynamic> json) =>
      _$ServiceEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceEndpointToJson(this);
}

@JsonSerializable()
class GetAccountSwitcherEndpoint {
  final bool hack;

  const GetAccountSwitcherEndpoint({required this.hack});

  factory GetAccountSwitcherEndpoint.fromJson(Map<String, dynamic> json) =>
      _$GetAccountSwitcherEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$GetAccountSwitcherEndpointToJson(this);
}

@JsonSerializable()
class SignalServiceEndpoint {
  final String signal;
  final List<String>? actions;

  const SignalServiceEndpoint({required this.signal, this.actions});

  factory SignalServiceEndpoint.fromJson(Map<String, dynamic> json) =>
      _$SignalServiceEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$SignalServiceEndpointToJson(this);
}

@JsonSerializable()
class SignalServiceEndpointAction {
  final String clickTrackingParams;
  final SendFeedbackAction sendFeedbackAction;

  const SignalServiceEndpointAction({
    required this.clickTrackingParams,
    required this.sendFeedbackAction,
  });

  factory SignalServiceEndpointAction.fromJson(Map<String, dynamic> json) =>
      _$SignalServiceEndpointActionFromJson(json);
  Map<String, dynamic> toJson() => _$SignalServiceEndpointActionToJson(this);
}

@JsonSerializable()
class SendFeedbackAction {
  final String bucket;

  const SendFeedbackAction({required this.bucket});

  factory SendFeedbackAction.fromJson(Map<String, dynamic> json) =>
      _$SendFeedbackActionFromJson(json);
  Map<String, dynamic> toJson() => _$SendFeedbackActionToJson(this);
}

@JsonSerializable()
class QueueAddEndpoint {
  final String? queueInsertPosition;
  final String? videoId;

  const QueueAddEndpoint({this.queueInsertPosition, this.videoId});

  factory QueueAddEndpoint.fromJson(Map<String, dynamic> json) =>
      _$QueueAddEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$QueueAddEndpointToJson(this);
}

@JsonSerializable()
class QueueTarget {
  final String playlistId;
  final NavigationEndpoint? onEmptyQueue;
  final List<Command>? commands;

  const QueueTarget({
    required this.playlistId,
    this.onEmptyQueue,
    this.commands,
  });

  factory QueueTarget.fromJson(Map<String, dynamic> json) =>
      _$QueueTargetFromJson(json);
  Map<String, dynamic> toJson() => _$QueueTargetToJson(this);
}
