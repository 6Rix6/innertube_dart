import 'package:json_annotation/json_annotation.dart';

part 'context.g.dart';

/// Context for YouTube API requests
@JsonSerializable()
class Context {
  final ContextClient client;
  final ThirdParty? thirdParty;
  @JsonKey(includeIfNull: false)
  final ContextRequest? request;
  @JsonKey(includeIfNull: false)
  final ContextUser? user;

  const Context({
    required this.client,
    this.thirdParty,
    this.request,
    this.user,
  });

  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);
  Map<String, dynamic> toJson() => _$ContextToJson(this);
}

@JsonSerializable()
class ContextClient {
  final String clientName;
  final String clientVersion;
  final String? osName;
  final String? osVersion;
  final String? deviceMake;
  final String? deviceModel;
  final String? androidSdkVersion;
  final String gl;
  final String hl;
  final String? visitorData;

  const ContextClient({
    required this.clientName,
    required this.clientVersion,
    this.osName,
    this.osVersion,
    this.deviceMake,
    this.deviceModel,
    this.androidSdkVersion,
    required this.gl,
    required this.hl,
    this.visitorData,
  });

  factory ContextClient.fromJson(Map<String, dynamic> json) =>
      _$ContextClientFromJson(json);
  Map<String, dynamic> toJson() => _$ContextClientToJson(this);
}

@JsonSerializable()
class ThirdParty {
  final String embedUrl;

  const ThirdParty({required this.embedUrl});

  factory ThirdParty.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyFromJson(json);
  Map<String, dynamic> toJson() => _$ThirdPartyToJson(this);
}

@JsonSerializable()
class ContextRequest {
  final List<String> internalExperimentFlags;
  final bool useSsl;

  const ContextRequest({
    this.internalExperimentFlags = const [],
    this.useSsl = true,
  });

  factory ContextRequest.fromJson(Map<String, dynamic> json) =>
      _$ContextRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ContextRequestToJson(this);
}

@JsonSerializable()
class ContextUser {
  final bool lockedSafetyMode;
  final String? onBehalfOfUser;

  const ContextUser({this.lockedSafetyMode = false, this.onBehalfOfUser});

  factory ContextUser.fromJson(Map<String, dynamic> json) =>
      _$ContextUserFromJson(json);
  Map<String, dynamic> toJson() => _$ContextUserToJson(this);
}
