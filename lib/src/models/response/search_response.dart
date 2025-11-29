import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

/// Search response from YouTube API
@JsonSerializable()
class SearchResponse {
  final Map<String, dynamic>? contents;
  final Map<String, dynamic>? continuationContents;

  const SearchResponse({this.contents, this.continuationContents});

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);

  /// Helper to get music shelf contents
  List<Map<String, dynamic>> getMusicShelfContents() {
    // Try tabbedSearchResultsRenderer
    final tabs = _getTabs();
    if (tabs != null && tabs.isNotEmpty) {
      final shelfs =
          tabs.first['tabRenderer']?['content']?['sectionListRenderer']?['contents']
              as List?;

      final musicShelfContents =
          shelfs
                  ?.where((e) => e['musicShelfRenderer'] != null)
                  .first['musicShelfRenderer']?['contents']
              as List?;

      if (musicShelfContents != null) {
        return musicShelfContents.cast<Map<String, dynamic>>();
      }
    }

    // Try continuationContents
    final contContents =
        continuationContents?['musicShelfContinuation']?['contents'] as List?;
    if (contContents != null) {
      return contContents.cast<Map<String, dynamic>>();
    }

    return [];
  }

  List<Map<String, dynamic>> getMusicCardShelfContents() {
    // Try tabbedSearchResultsRenderer
    final tabs = _getTabs();
    if (tabs != null && tabs.isNotEmpty) {
      final shelfs =
          tabs.first['tabRenderer']?['content']?['sectionListRenderer']?['contents']
              as List?;

      final musicCardShelfContents =
          shelfs
                  ?.where((e) => e['musicCardShelfRenderer'] != null)
                  .first['musicCardShelfRenderer']?['contents']
              as List?;

      if (musicCardShelfContents != null) {
        return musicCardShelfContents.cast<Map<String, dynamic>>();
      }
    }

    return [];
  }

  /// Helper to get continuation token
  String? getContinuation() {
    final continuations =
        continuationContents?['musicShelfContinuation']?['continuations']
            as List?;
    if (continuations != null && continuations.isNotEmpty) {
      return continuations.first['nextContinuationData']?['continuation']
          as String?;
    }
    return null;
  }

  List<dynamic>? _getTabs() {
    return contents?['tabbedSearchResultsRenderer']?['tabs'] as List?;
  }
}
