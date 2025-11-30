import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:innertube_dart/src/models/renderer/continuations.dart';
import 'package:innertube_dart/src/utils/result.dart';
import '../models/youtube_client.dart';
import '../models/youtube_locale.dart';
import '../models/body/browse_body.dart';
import '../models/body/search_body.dart';
import '../utils/utils.dart';

final _visitorRegex = RegExp(r"^Cg[t|s]");

class InnerTube {
  late Dio _httpClient;

  YouTubeLocale locale;
  String? visitorData;
  String? dataSyncId;
  String? _cookie;
  Map<String, String> _cookieMap = {};
  bool useLoginForBrowse = false;

  InnerTube({
    this.locale = YouTubeLocale.defaultLocale,
    this.visitorData,
    this.dataSyncId,
    String? cookie,
  }) {
    _cookie = cookie;
    if (cookie != null) {
      _cookieMap = parseCookieString(cookie);
    }
    _httpClient = _createClient();
  }

  /// Must be called after creating an instance.
  /// Automatically fetches visitorData if missing.
  Future<void> initialize() async {
    if (visitorData != null) return;

    final result = await _fetchVisitorData();
    result.when(
      success: (value) {
        visitorData = value;
      },
      error: (err) {
        print("Failed to fetch visitorData: $err");
      },
    );
  }

  Future<Result<String>> _fetchVisitorData() async {
    try {
      final res = await Dio(
        BaseOptions(responseType: ResponseType.plain),
      ).get("https://music.youtube.com/sw.js_data");

      if (res.statusCode != 200) {
        return Result.error("HTTP ${res.statusCode}");
      }

      final raw = res.data.toString();
      final trimmed = raw.substring(5);
      final json = jsonDecode(trimmed);

      final list = json[0][2] as List;
      for (final item in list) {
        if (item is String && _visitorRegex.hasMatch(item)) {
          return Result.success(item);
        }
      }
      return Result.error("VisitorData not found");
    } catch (e) {
      return Result.error(e);
    }
  }

  String? get cookie => _cookie;

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
    return dio;
  }

  void _ytClient(
    RequestOptions options,
    YouTubeClient client, {
    bool setLogin = false,
  }) {
    options.headers['X-Goog-Api-Format-Version'] = '1';
    options.headers['X-YouTube-Client-Name'] = client.clientId;
    options.headers['X-YouTube-Client-Version'] = client.clientVersion;
    options.headers['X-Origin'] = YouTubeClient.originYouTubeMusic;
    options.headers['Referer'] = YouTubeClient.refererYouTubeMusic;
    options.headers['User-Agent'] = client.userAgent;

    if (setLogin && client.loginSupported && _cookie != null) {
      options.headers['cookie'] = _cookie;

      if (_cookieMap.containsKey('SAPISID')) {
        final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final sapisidHash = sha1Hash(
          '$currentTime ${_cookieMap['SAPISID']} ${YouTubeClient.originYouTubeMusic}',
        );
        options.headers['Authorization'] =
            'SAPISIDHASH ${currentTime}_$sapisidHash';
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
        visitorData,
        useLoginForBrowse ? dataSyncId : null,
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
    Continuations? continuation,
    bool setLogin = false,
  }) async {
    final options = Options();
    _ytClient(
      options.toRequestOptions(),
      client,
      setLogin: setLogin || useLoginForBrowse,
    );

    final body = BrowseBody(
      context: client.toContext(
        locale,
        visitorData,
        (setLogin || useLoginForBrowse) ? dataSyncId : null,
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
      options: options,
      queryParameters: queryParams,
    );
  }

  void close() {
    _httpClient.close();
  }
}

extension on Options {
  RequestOptions toRequestOptions() {
    return RequestOptions(path: '', headers: headers);
  }
}
