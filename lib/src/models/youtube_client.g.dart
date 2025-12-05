// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YouTubeClient _$YouTubeClientFromJson(Map<String, dynamic> json) =>
    YouTubeClient(
      clientName: json['clientName'] as String,
      clientVersion: json['clientVersion'] as String,
      clientId: json['clientId'] as String,
      userAgent: json['userAgent'] as String,
      osName: json['osName'] as String?,
      osVersion: json['osVersion'] as String?,
      deviceMake: json['deviceMake'] as String?,
      deviceModel: json['deviceModel'] as String?,
      androidSdkVersion: json['androidSdkVersion'] as String?,
      buildId: json['buildId'] as String?,
      cronetVersion: json['cronetVersion'] as String?,
      packageName: json['packageName'] as String?,
      friendlyName: json['friendlyName'] as String?,
      platform: json['platform'] as String?,
      clientFormFactor: json['clientFormFactor'] as String?,
      loginSupported: json['loginSupported'] as bool? ?? false,
      loginRequired: json['loginRequired'] as bool? ?? false,
      useSignatureTimestamp: json['useSignatureTimestamp'] as bool? ?? false,
      isEmbedded: json['isEmbedded'] as bool? ?? false,
    );

Map<String, dynamic> _$YouTubeClientToJson(YouTubeClient instance) =>
    <String, dynamic>{
      'clientName': instance.clientName,
      'clientVersion': instance.clientVersion,
      'clientId': instance.clientId,
      'userAgent': instance.userAgent,
      'osName': instance.osName,
      'osVersion': instance.osVersion,
      'deviceMake': instance.deviceMake,
      'deviceModel': instance.deviceModel,
      'androidSdkVersion': instance.androidSdkVersion,
      'buildId': instance.buildId,
      'cronetVersion': instance.cronetVersion,
      'packageName': instance.packageName,
      'friendlyName': instance.friendlyName,
      'platform': instance.platform,
      'clientFormFactor': instance.clientFormFactor,
      'loginSupported': instance.loginSupported,
      'loginRequired': instance.loginRequired,
      'useSignatureTimestamp': instance.useSignatureTimestamp,
      'isEmbedded': instance.isEmbedded,
    };
