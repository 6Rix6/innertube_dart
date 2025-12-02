import 'package:json_annotation/json_annotation.dart';

part 'navigation_endpoint.g.dart';

/// Navigation endpoint  for YouTube content
@JsonSerializable()
class NavigationEndpoint {
  final BrowseEndpoint? browseEndpoint;
  final WatchEndpoint? watchEndpoint;
  final WatchPlaylistEndpoint? watchPlaylistEndpoint;
  final String? clickTrackingParams;

  const NavigationEndpoint({
    this.browseEndpoint,
    this.watchEndpoint,
    this.watchPlaylistEndpoint,
    this.clickTrackingParams,
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
  final String playlistId;
  final String? params;

  const WatchPlaylistEndpoint({required this.playlistId, this.params});

  factory WatchPlaylistEndpoint.fromJson(Map<String, dynamic> json) =>
      _$WatchPlaylistEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$WatchPlaylistEndpointToJson(this);

  @override
  String toString() {
    return 'WatchPlaylistEndpoint(playlistId: $playlistId, params: $params)';
  }
}
