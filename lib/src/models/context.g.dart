// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Context _$ContextFromJson(Map<String, dynamic> json) => Context(
  client: ContextClient.fromJson(json['client'] as Map<String, dynamic>),
  thirdParty: json['thirdParty'] == null
      ? null
      : ThirdParty.fromJson(json['thirdParty'] as Map<String, dynamic>),
  request: json['request'] == null
      ? null
      : ContextRequest.fromJson(json['request'] as Map<String, dynamic>),
  user: json['user'] == null
      ? null
      : ContextUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ContextToJson(Context instance) => <String, dynamic>{
  'client': instance.client,
  'thirdParty': instance.thirdParty,
  'request': ?instance.request,
  'user': ?instance.user,
};

ContextClient _$ContextClientFromJson(Map<String, dynamic> json) =>
    ContextClient(
      clientName: json['clientName'] as String,
      clientVersion: json['clientVersion'] as String,
      osName: json['osName'] as String?,
      osVersion: json['osVersion'] as String?,
      deviceMake: json['deviceMake'] as String?,
      deviceModel: json['deviceModel'] as String?,
      androidSdkVersion: json['androidSdkVersion'] as String?,
      gl: json['gl'] as String,
      hl: json['hl'] as String,
      visitorData: json['visitorData'] as String?,
    );

Map<String, dynamic> _$ContextClientToJson(ContextClient instance) =>
    <String, dynamic>{
      'clientName': instance.clientName,
      'clientVersion': instance.clientVersion,
      'osName': instance.osName,
      'osVersion': instance.osVersion,
      'deviceMake': instance.deviceMake,
      'deviceModel': instance.deviceModel,
      'androidSdkVersion': instance.androidSdkVersion,
      'gl': instance.gl,
      'hl': instance.hl,
      'visitorData': instance.visitorData,
    };

ThirdParty _$ThirdPartyFromJson(Map<String, dynamic> json) =>
    ThirdParty(embedUrl: json['embedUrl'] as String);

Map<String, dynamic> _$ThirdPartyToJson(ThirdParty instance) =>
    <String, dynamic>{'embedUrl': instance.embedUrl};

ContextRequest _$ContextRequestFromJson(Map<String, dynamic> json) =>
    ContextRequest(
      internalExperimentFlags:
          (json['internalExperimentFlags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      useSsl: json['useSsl'] as bool? ?? true,
    );

Map<String, dynamic> _$ContextRequestToJson(ContextRequest instance) =>
    <String, dynamic>{
      'internalExperimentFlags': instance.internalExperimentFlags,
      'useSsl': instance.useSsl,
    };

ContextUser _$ContextUserFromJson(Map<String, dynamic> json) => ContextUser(
  lockedSafetyMode: json['lockedSafetyMode'] as bool? ?? false,
  onBehalfOfUser: json['onBehalfOfUser'] as String?,
);

Map<String, dynamic> _$ContextUserToJson(ContextUser instance) =>
    <String, dynamic>{
      'lockedSafetyMode': instance.lockedSafetyMode,
      'onBehalfOfUser': instance.onBehalfOfUser,
    };
