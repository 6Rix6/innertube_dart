// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      contents: json['contents'] == null
          ? null
          : SearchResponseContents.fromJson(
              json['contents'] as Map<String, dynamic>,
            ),
      continuationContents:
          json['continuationContents'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'contents': instance.contents,
      'continuationContents': instance.continuationContents,
    };

SearchResponseContents _$SearchResponseContentsFromJson(
  Map<String, dynamic> json,
) => SearchResponseContents(
  tabbedSearchResultsRenderer: TabbedSearchResultsRenderer.fromJson(
    json['tabbedSearchResultsRenderer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$SearchResponseContentsToJson(
  SearchResponseContents instance,
) => <String, dynamic>{
  'tabbedSearchResultsRenderer': instance.tabbedSearchResultsRenderer,
};

TabbedSearchResultsRenderer _$TabbedSearchResultsRendererFromJson(
  Map<String, dynamic> json,
) => TabbedSearchResultsRenderer(
  tabs: (json['tabs'] as List<dynamic>)
      .map((e) => Tab.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TabbedSearchResultsRendererToJson(
  TabbedSearchResultsRenderer instance,
) => <String, dynamic>{'tabs': instance.tabs};
