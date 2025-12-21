import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/tab_renderer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

/// Search response from YouTube API
@JsonSerializable()
class SearchResponse {
  final SearchResponseContents? contents;
  final Map<String, dynamic>? continuationContents;

  const SearchResponse({this.contents, this.continuationContents});

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);

  /// Helper to get music shelf contents
  List<MusicResponsiveListItem> getMusicShelfContents() {
    // Try tabbedSearchResultsRenderer
    final tabs = _getTabs();
    if (tabs != null && tabs.isNotEmpty) {
      final shelves =
          tabs.first.tabRenderer.content?.sectionListRenderer?.contents;

      final musicShelfContents = shelves
          ?.where((e) => e.musicShelfRenderer != null)
          .first
          .musicShelfRenderer
          ?.contents;

      if (musicShelfContents != null) {
        return musicShelfContents;
      }
    }

    // Try continuationContents
    // final contContents =
    //     continuationContents?['musicShelfContinuation']?['contents'] as List?;
    // if (contContents != null) {
    //   return contContents.cast<Map<String, dynamic>>();
    // }

    return [];
  }

  List<MusicResponsiveListItem> getMusicCardShelfContents() {
    // Try tabbedSearchResultsRenderer
    final tabs = _getTabs();
    if (tabs != null && tabs.isNotEmpty) {
      final shelves =
          tabs.first.tabRenderer.content?.sectionListRenderer?.contents;

      final musicCardShelfContents = shelves
          ?.where((e) => e.musicCardShelfRenderer != null)
          .first
          .musicCardShelfRenderer
          ?.contents;

      if (musicCardShelfContents != null) {
        return musicCardShelfContents;
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

  List<Tab>? _getTabs() {
    return contents?.tabbedSearchResultsRenderer.tabs;
  }
}

@JsonSerializable()
class SearchResponseContents {
  final TabbedSearchResultsRenderer tabbedSearchResultsRenderer;

  const SearchResponseContents({required this.tabbedSearchResultsRenderer});

  factory SearchResponseContents.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseContentsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseContentsToJson(this);
}

@JsonSerializable()
class TabbedSearchResultsRenderer {
  final List<Tab> tabs;

  const TabbedSearchResultsRenderer({required this.tabs});

  factory TabbedSearchResultsRenderer.fromJson(Map<String, dynamic> json) =>
      _$TabbedSearchResultsRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TabbedSearchResultsRendererToJson(this);
}
