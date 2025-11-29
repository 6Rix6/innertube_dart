import 'package:dio/dio.dart';
import '../models/youtube_client.dart';
import '../models/youtube_locale.dart';
import '../models/body/browse_body.dart';
import '../models/body/search_body.dart';
import '../utils/utils.dart';

/// Low-level InnerTube API client
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

    // Add JSON parsing interceptor
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

  /// Search API
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

  /// Browse API
  Future<Response> browse(
    YouTubeClient client, {
    String? browseId,
    String? params,
    String? continuation,
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
      continuation: continuation,
    );

    return _httpClient.post('browse', data: body.toJson(), options: options);
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
