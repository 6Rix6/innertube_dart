// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationEndpoint _$NavigationEndpointFromJson(
  Map<String, dynamic> json,
) => NavigationEndpoint(
  clickTrackingParams: json['clickTrackingParams'] as String,
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
  queueAddEndpoint: json['queueAddEndpoint'] == null
      ? null
      : QueueAddEndpoint.fromJson(
          json['queueAddEndpoint'] as Map<String, dynamic>,
        ),
  serviceEndpoint: json['serviceEndpoint'] == null
      ? null
      : ServiceEndpoint.fromJson(
          json['serviceEndpoint'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$NavigationEndpointToJson(NavigationEndpoint instance) =>
    <String, dynamic>{
      'clickTrackingParams': instance.clickTrackingParams,
      'browseEndpoint': instance.browseEndpoint,
      'watchEndpoint': instance.watchEndpoint,
      'watchPlaylistEndpoint': instance.watchPlaylistEndpoint,
      'queueAddEndpoint': instance.queueAddEndpoint,
      'serviceEndpoint': instance.serviceEndpoint,
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
      videoId: json['videoId'] as String?,
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
  playlistId: json['playlistId'] as String?,
  params: json['params'] as String?,
);

Map<String, dynamic> _$WatchPlaylistEndpointToJson(
  WatchPlaylistEndpoint instance,
) => <String, dynamic>{
  'playlistId': instance.playlistId,
  'params': instance.params,
};

ServiceEndpoint _$ServiceEndpointFromJson(Map<String, dynamic> json) =>
    ServiceEndpoint(
      clickTrackingParams: json['clickTrackingParams'] as String,
      getAccountSwitcherEndpoint: json['getAccountSwitcherEndpoint'] == null
          ? null
          : GetAccountSwitcherEndpoint.fromJson(
              json['getAccountSwitcherEndpoint'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ServiceEndpointToJson(ServiceEndpoint instance) =>
    <String, dynamic>{
      'clickTrackingParams': instance.clickTrackingParams,
      'getAccountSwitcherEndpoint': instance.getAccountSwitcherEndpoint,
    };

GetAccountSwitcherEndpoint _$GetAccountSwitcherEndpointFromJson(
  Map<String, dynamic> json,
) => GetAccountSwitcherEndpoint(hack: json['hack'] as bool);

Map<String, dynamic> _$GetAccountSwitcherEndpointToJson(
  GetAccountSwitcherEndpoint instance,
) => <String, dynamic>{'hack': instance.hack};

SignalServiceEndpoint _$SignalServiceEndpointFromJson(
  Map<String, dynamic> json,
) => SignalServiceEndpoint(
  signal: json['signal'] as String,
  actions: (json['actions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SignalServiceEndpointToJson(
  SignalServiceEndpoint instance,
) => <String, dynamic>{'signal': instance.signal, 'actions': instance.actions};

SignalServiceEndpointAction _$SignalServiceEndpointActionFromJson(
  Map<String, dynamic> json,
) => SignalServiceEndpointAction(
  clickTrackingParams: json['clickTrackingParams'] as String,
  sendFeedbackAction: SendFeedbackAction.fromJson(
    json['sendFeedbackAction'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$SignalServiceEndpointActionToJson(
  SignalServiceEndpointAction instance,
) => <String, dynamic>{
  'clickTrackingParams': instance.clickTrackingParams,
  'sendFeedbackAction': instance.sendFeedbackAction,
};

SendFeedbackAction _$SendFeedbackActionFromJson(Map<String, dynamic> json) =>
    SendFeedbackAction(bucket: json['bucket'] as String);

Map<String, dynamic> _$SendFeedbackActionToJson(SendFeedbackAction instance) =>
    <String, dynamic>{'bucket': instance.bucket};

QueueAddEndpoint _$QueueAddEndpointFromJson(Map<String, dynamic> json) =>
    QueueAddEndpoint(
      queueInsertPosition: json['queueInsertPosition'] as String?,
      videoId: json['videoId'] as String?,
    );

Map<String, dynamic> _$QueueAddEndpointToJson(QueueAddEndpoint instance) =>
    <String, dynamic>{
      'queueInsertPosition': instance.queueInsertPosition,
      'videoId': instance.videoId,
    };

QueueTarget _$QueueTargetFromJson(Map<String, dynamic> json) => QueueTarget(
  playlistId: json['playlistId'] as String,
  onEmptyQueue: json['onEmptyQueue'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['onEmptyQueue'] as Map<String, dynamic>,
        ),
  commands: (json['commands'] as List<dynamic>?)
      ?.map((e) => Command.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QueueTargetToJson(QueueTarget instance) =>
    <String, dynamic>{
      'playlistId': instance.playlistId,
      'onEmptyQueue': instance.onEmptyQueue,
      'commands': instance.commands,
    };
