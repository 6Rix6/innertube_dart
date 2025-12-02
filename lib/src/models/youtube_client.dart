import 'package:json_annotation/json_annotation.dart';
import 'context.dart';
import 'youtube_locale.dart';

part 'youtube_client.g.dart';

/// YouTube API client configuration
@JsonSerializable()
class YouTubeClient {
  final String clientName;
  final String clientVersion;
  final String clientId;
  final String userAgent;
  final String? osName;
  final String? osVersion;
  final String? deviceMake;
  final String? deviceModel;
  final String? androidSdkVersion;
  final String? buildId;
  final String? cronetVersion;
  final String? packageName;
  final String? friendlyName;
  final bool loginSupported;
  final bool loginRequired;
  final bool useSignatureTimestamp;
  final bool isEmbedded;

  const YouTubeClient({
    required this.clientName,
    required this.clientVersion,
    required this.clientId,
    required this.userAgent,
    this.osName,
    this.osVersion,
    this.deviceMake,
    this.deviceModel,
    this.androidSdkVersion,
    this.buildId,
    this.cronetVersion,
    this.packageName,
    this.friendlyName,
    this.loginSupported = false,
    this.loginRequired = false,
    this.useSignatureTimestamp = false,
    this.isEmbedded = false,
  });

  /// Convert to Context for API requests
  Context toContext(
    YouTubeLocale locale,
    // String? visitorData,
    String? dataSyncId,
    SessionContext? sessionContext,
  ) {
    return Context(
      client: ContextClient(
        clientName: clientName,
        clientVersion: clientVersion,
        osName: osName,
        osVersion: osVersion,
        deviceMake: deviceMake,
        deviceModel: deviceModel,
        androidSdkVersion: androidSdkVersion,
        gl: locale.gl,
        hl: locale.hl,
        visitorData: sessionContext?.visitorData,
        remoteHost: sessionContext?.remoteHost,
        appInstallData: sessionContext?.appInstallData,
        deviceExperimentId: sessionContext?.deviceExperimentId,
        rolloutToken: sessionContext?.rolloutToken,
      ),
      user: loginSupported
          ? ContextUser(onBehalfOfUser: dataSyncId)
          : const ContextUser(),
      request: const ContextRequest(),
    );
  }

  factory YouTubeClient.fromJson(Map<String, dynamic> json) =>
      _$YouTubeClientFromJson(json);
  Map<String, dynamic> toJson() => _$YouTubeClientToJson(this);

  // Constants
  static const userAgentWeb =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Firefox/128.0';
  static const originYouTubeMusic = 'https://music.youtube.com';
  static const refererYouTubeMusic = '$originYouTubeMusic/';
  static const apiUrlYouTubeMusic = '$originYouTubeMusic/youtubei/v1/';

  // Predefined clients
  static const web = YouTubeClient(
    clientName: 'WEB',
    clientVersion: '2.20250312.04.00',
    clientId: '1',
    userAgent: userAgentWeb,
  );

  static const webRemix = YouTubeClient(
    clientName: 'WEB_REMIX',
    clientVersion: '1.20251125.01.00',
    clientId: '67',
    userAgent: userAgentWeb,
    loginSupported: true,
    useSignatureTimestamp: true,
  );

  static const webCreator = YouTubeClient(
    clientName: 'WEB_CREATOR',
    clientVersion: '1.20250312.03.01',
    clientId: '62',
    userAgent: userAgentWeb,
    loginSupported: true,
    loginRequired: true,
    useSignatureTimestamp: true,
  );

  static const android = YouTubeClient(
    clientName: 'ANDROID',
    clientVersion: '20.10.38',
    clientId: '3',
    userAgent:
        'com.google.android.youtube/20.10.38 (Linux; U; Android 11) gzip',
    loginSupported: true,
    useSignatureTimestamp: true,
  );
}
