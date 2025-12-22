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
