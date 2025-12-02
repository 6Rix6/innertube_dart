// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_endpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationEndpoint _$NavigationEndpointFromJson(
  Map<String, dynamic> json,
) => NavigationEndpoint(
  browseEndpoint: json['browseEndpoint'] == null
      ? null
      : BrowseEndpoint.fromJson(json['browseEndpoint'] as Map<String, dynamic>),
  watchEndpoint: json['watchEndpoint'] == null
      ? null
      : WatchEndpoint.fromJson(json['watchEndpoint'] as Map<String, dynamic>),
  watchPlaylistEndpoint: json['watchPlaylistEndpoint'] == null
      ? null
      : WatchPlaylistEndpoint.fromJson(
          json['watchPlaylistEndpoint'] as Map<String, dynamic>,
        ),
  clickTrackingParams: json['clickTrackingParams'] as String?,
);

Map<String, dynamic> _$NavigationEndpointToJson(NavigationEndpoint instance) =>
    <String, dynamic>{
      'browseEndpoint': instance.browseEndpoint,
      'watchEndpoint': instance.watchEndpoint,
      'watchPlaylistEndpoint': instance.watchPlaylistEndpoint,
      'clickTrackingParams': instance.clickTrackingParams,
    };

BrowseEndpoint _$BrowseEndpointFromJson(Map<String, dynamic> json) =>
    BrowseEndpoint(
      browseId: json['browseId'] as String?,
      params: json['params'] as String?,
      browseEndpointContextSupportedConfigs:
          json['browseEndpointContextSupportedConfigs']
              as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BrowseEndpointToJson(BrowseEndpoint instance) =>
    <String, dynamic>{
      'browseId': instance.browseId,
      'params': instance.params,
      'browseEndpointContextSupportedConfigs':
          instance.browseEndpointContextSupportedConfigs,
    };

WatchEndpoint _$WatchEndpointFromJson(Map<String, dynamic> json) =>
    WatchEndpoint(
      videoId: json['videoId'] as String,
      playlistId: json['playlistId'] as String?,
      index: (json['index'] as num?)?.toInt(),
      params: json['params'] as String?,
    );

Map<String, dynamic> _$WatchEndpointToJson(WatchEndpoint instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'playlistId': instance.playlistId,
      'index': instance.index,
      'params': instance.params,
    };

WatchPlaylistEndpoint _$WatchPlaylistEndpointFromJson(
  Map<String, dynamic> json,
) => WatchPlaylistEndpoint(
  playlistId: json['playlistId'] as String,
  params: json['params'] as String?,
);

Map<String, dynamic> _$WatchPlaylistEndpointToJson(
  WatchPlaylistEndpoint instance,
) => <String, dynamic>{
  'playlistId': instance.playlistId,
  'params': instance.params,
};
