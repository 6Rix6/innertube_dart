import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:innertube_dart/src/models/body/account_body.dart';
import 'package:innertube_dart/src/models/body/browse_body.dart';
import 'package:innertube_dart/src/models/body/next_body.dart';
import 'package:innertube_dart/src/models/body/player_body.dart';
import 'package:innertube_dart/src/models/body/search_body.dart';
import 'package:innertube_dart/src/models/context.dart';
import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/youtube_client.dart';
import 'package:innertube_dart/src/models/youtube_locale.dart';

import 'package:innertube_dart/src/utils/result.dart';
import 'package:innertube_dart/src/utils/utils.dart';

class InnerTube {
  late Dio _httpClient;

  YouTubeLocale locale;
  String? visitorData;
  String? dataSyncId;
  int accountIndex = 0;
  Function(String)? onCookieUpdate;

  Map<String, String> _cookieMap = {};
  bool useLoginForBrowse = false;
  SessionContext sessionContext = SessionContext();

  String? _cookie;
  String? get cookie => _cookie;

  InnerTube({
    this.locale = YouTubeLocale.defaultLocale,
    this.visitorData,
    this.dataSyncId,
    this.accountIndex = 0,
    this.onCookieUpdate,
    String? cookie,
  }) {
    _cookie = cookie;
    if (cookie != null) {
      _cookieMap = parseCookieString(cookie);
    }
    _httpClient = _createClient();
  }

  /// Must be called after creating an instance.
  Future<void> initialize() async {
    final result = await _initSessionContext();
    result.when(
      success: (value) {
        sessionContext = value;
      },
      error: (err) {
        // TODO: Handle error
        print("Failed to fetch visitorData: $err");
      },
    );
  }

  Future<Result<SessionContext>> _initSessionContext() async {
    final visitorId = generateRandomString(11);
    try {
      final res = await Dio(
        BaseOptions(
          responseType: ResponseType.plain,
          headers: {
            'Accept-Language': locale.hl,
            'User-Agent': YouTubeClient.webRemix.userAgent,
            'Accept': '*/*',
            'Referer': 'https://music.youtube.com/sw.js',
            'Cookie': 'VISITOR_INFO1_LIVE=$visitorId',
          },
        ),
      ).get("https://music.youtube.com/sw.js_data");

      if (res.statusCode != 200) {
        return Result.error("HTTP ${res.statusCode}");
      }

      final text = res.data.toString();
      final cleaned = text.replaceFirst(RegExp(r"^\)\]\}'"), "");
      final data = jsonDecode(cleaned);

      final ytcfg = data[0][2];
      final deviceInfo = ytcfg[0][0];
      final apiKey = ytcfg[1];
      final configInfo = deviceInfo[61];
      final appInstallData = configInfo[configInfo.length - 1];

      return Result.success(
        SessionContext(
          remoteHost: deviceInfo[3],
          visitorData: visitorData ?? deviceInfo[13],
          appInstallData: appInstallData,
          deviceExperimentId: deviceInfo[103],
          rolloutToken: deviceInfo[107],
          apiKey: apiKey,
        ),
      );
    } catch (e) {
      return Result.error(e);
    }
  }

  set cookie(String? value) {
    _cookie = value;
    _cookieMap = value != null ? parseCookieString(value) : {};
  }

  Dio _createClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: YouTubeClient.apiUrlYouTubeMusic,
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    dio.options.contentType = Headers.jsonContentType;
    dio.options.responseType = ResponseType.json;

    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          final setCookies = response.headers['set-cookie'];

          if (setCookies != null && setCookies.isNotEmpty) {
            _updateCookiesFromHeader(setCookies);
          }

          return handler.next(response);
        },
      ),
    );
    return dio;
  }

  void _updateCookiesFromHeader(List<String> setCookies) {
    for (final cookieRaw in setCookies) {
      final keyValue = cookieRaw.split(';').first;
      final parts = keyValue.split('=');

      if (parts.length >= 2) {
        final key = parts[0].trim();
        final value = parts.sublist(1).join('=').trim();

        if (key.isNotEmpty) {
          _cookieMap[key] = value;
        }
      }
    }

    _cookie = _cookieMap.entries.map((e) => '${e.key}=${e.value}').join('; ');
    onCookieUpdate?.call(_cookie!);
  }

  void _ytClient(
    RequestOptions options,
    YouTubeClient client, {
    bool setLogin = false,
  }) {
    options.headers['X-Goog-Api-Format-Version'] = '2';
    options.headers['X-YouTube-Client-Name'] = client.clientId;
    options.headers['X-YouTube-Client-Version'] = client.clientVersion;
    options.headers['X-Origin'] = YouTubeClient.originYouTubeMusic;
    options.headers['Referer'] = YouTubeClient.refererYouTubeMusic;
    options.headers['User-Agent'] = client.userAgent;
    options.headers['X-Goog-Visitor-Id'] = visitorData;

    if (setLogin && client.loginSupported && _cookie != null) {
      options.headers['cookie'] = _cookie;

      if (_cookieMap.containsKey('SAPISID')) {
        final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final sapisidHash = sha1Hash(
          '$currentTime ${_cookieMap['SAPISID']} ${YouTubeClient.originYouTubeMusic}',
        );
        // print('SAPISIDHASH ${currentTime}_$sapisidHash');
        final value = '${currentTime}_$sapisidHash';
        options.headers['Authorization'] = 'SAPISIDHASH $value';
        options.headers['X-Goog-Authuser'] = accountIndex.toString();
      }
    }

    options.queryParameters['prettyPrint'] = 'false';
  }

  Future<Response> search(
    YouTubeClient client, {
    String? query,
    String? params,
    String? continuation,
  }) async {
    final options = Options();
    _ytClient(options.toRequestOptions(), client, setLogin: useLoginForBrowse);

    final body = SearchBody(
      context: client.toContext(
        locale,
        useLoginForBrowse ? dataSyncId : null,
        sessionContext,
      ),
      query: query,
      params: params,
    );

    final queryParams = <String, dynamic>{};
    if (continuation != null) {
      queryParams['continuation'] = continuation;
      queryParams['ctoken'] = continuation;
    }

    return _httpClient.post(
      'search',
      data: body.toJson(),
      options: options,
      queryParameters: queryParams,
    );
  }

  Future<Response> browse(
    YouTubeClient client, {
    String? browseId,
    String? params,
    Continuation? continuation,
    bool setLogin = true,
  }) async {
    final options = RequestOptions();
    _ytClient(options, client, setLogin: setLogin || useLoginForBrowse);

    final body = BrowseBody(
      context: client.toContext(
        locale,
        (setLogin || useLoginForBrowse) ? dataSyncId : null,
        sessionContext,
      ),
      browseId: browseId,
      params: params,
    );

    final queryParams = <String, dynamic>{};
    if (continuation != null && continuation.nextContinuationData != null) {
      queryParams['ctoken'] = continuation.nextContinuationData!.continuation;
      queryParams['continuation'] =
          continuation.nextContinuationData!.continuation;
      queryParams['type'] = 'next';
      queryParams['itct'] =
          continuation.nextContinuationData!.clickTrackingParams;
    }

    return _httpClient.post(
      'browse',
      data: body.toJson(),
      options: Options(headers: options.headers),
      queryParameters: queryParams,
    );
  }

  /// Get player response for a video
  Future<Response> player(
    YouTubeClient client, {
    required String videoId,
    String? playlistId,
    int? signatureTimestamp,
  }) async {
    final options = Options();
    _ytClient(options.toRequestOptions(), client, setLogin: true);

    final body = PlayerBody(
      context: client.toContext(locale, dataSyncId, null),
      videoId: videoId,
      playlistId: playlistId,
      playbackContext:
          (client.useSignatureTimestamp && signatureTimestamp != null)
          ? PlaybackContext(
              contentPlaybackContext: ContentPlaybackContext(
                signatureTimestamp: signatureTimestamp,
              ),
            )
          : null,
    );

    return _httpClient.post('player', data: body.toJson(), options: options);
  }

  Future<Response> next(
    YouTubeClient client, {
    String? videoId,
    String? playlistId,
    String? playlistSetVideoId,
    int? index,
    String? params,
    String? continuation,
  }) {
    final options = Options();
    _ytClient(options.toRequestOptions(), client, setLogin: true);

    final body = NextBody(
      context: client.toContext(locale, dataSyncId, null),
      videoId: videoId,
      playlistId: playlistId,
      playlistSetVideoId: playlistSetVideoId,
      index: index,
      params: params,
      continuation: continuation,
    );

    return _httpClient.post('next', data: body.toJson(), options: options);
  }

  Future<Response> accountMenu(YouTubeClient client) async {
    final options = RequestOptions();
    _ytClient(options, client, setLogin: true);

    final body = AccountBody(
      context: client.toContext(locale, dataSyncId, sessionContext),
    );

    return _httpClient.post(
      'account/account_menu',
      data: body.toJson(),
      options: Options(headers: options.headers),
    );
  }

  void close() {
    _httpClient.close();
  }
}

extension on Options {
  RequestOptions toRequestOptions() {
    return RequestOptions(path: '', headers: headers ?? {});
  }
}
