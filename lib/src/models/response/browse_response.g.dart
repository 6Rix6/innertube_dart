// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseResponse _$BrowseResponseFromJson(Map<String, dynamic> json) =>
    BrowseResponse(
      header: json['header'] as Map<String, dynamic>?,
      contents: json['contents'] == null
          ? null
          : BrowseResponseContent.fromJson(
              json['contents'] as Map<String, dynamic>,
            ),
      microformat: json['microformat'] as Map<String, dynamic>?,
      background: json['background'] as Map<String, dynamic>?,
      continuationContents:
          json['continuationContents'] as Map<String, dynamic>?,
      trackingParams: json['trackingParams'] as String?,
    );

Map<String, dynamic> _$BrowseResponseToJson(BrowseResponse instance) =>
    <String, dynamic>{
      'header': instance.header,
      'contents': instance.contents,
      'microformat': instance.microformat,
      'background': instance.background,
      'continuationContents': instance.continuationContents,
      'trackingParams': instance.trackingParams,
    };

BrowseResponseContent _$BrowseResponseContentFromJson(
  Map<String, dynamic> json,
) => BrowseResponseContent(
  singleColumnBrowseResultsRenderer:
      json['singleColumnBrowseResultsRenderer'] == null
      ? null
      : SingleColumnBrowseResultsRenderer.fromJson(
          json['singleColumnBrowseResultsRenderer'] as Map<String, dynamic>,
        ),
  twoColumnBrowseResultsRenderer: json['twoColumnBrowseResultsRenderer'] == null
      ? null
      : TwoColumnBrowseResultsRenderer.fromJson(
          json['twoColumnBrowseResultsRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$BrowseResponseContentToJson(
  BrowseResponseContent instance,
) => <String, dynamic>{
  'singleColumnBrowseResultsRenderer':
      instance.singleColumnBrowseResultsRenderer,
  'twoColumnBrowseResultsRenderer': instance.twoColumnBrowseResultsRenderer,
};

SingleColumnBrowseResultsRenderer _$SingleColumnBrowseResultsRendererFromJson(
  Map<String, dynamic> json,
) => SingleColumnBrowseResultsRenderer(
  tabs: (json['tabs'] as List<dynamic>?)
      ?.map(
        (e) =>
            ColumnBrowseResultsRendererTab.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$SingleColumnBrowseResultsRendererToJson(
  SingleColumnBrowseResultsRenderer instance,
) => <String, dynamic>{'tabs': instance.tabs};

TwoColumnBrowseResultsRenderer _$TwoColumnBrowseResultsRendererFromJson(
  Map<String, dynamic> json,
) => TwoColumnBrowseResultsRenderer(
  tabs: (json['tabs'] as List<dynamic>?)
      ?.map(
        (e) =>
            ColumnBrowseResultsRendererTab.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  secondaryContents: json['secondaryContents'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$TwoColumnBrowseResultsRendererToJson(
  TwoColumnBrowseResultsRenderer instance,
) => <String, dynamic>{
  'tabs': instance.tabs,
  'secondaryContents': instance.secondaryContents,
};

ColumnBrowseResultsRendererTab _$ColumnBrowseResultsRendererTabFromJson(
  Map<String, dynamic> json,
) => ColumnBrowseResultsRendererTab(
  tabRenderer: json['tabRenderer'] == null
      ? null
      : TabRenderer.fromJson(json['tabRenderer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ColumnBrowseResultsRendererTabToJson(
  ColumnBrowseResultsRendererTab instance,
) => <String, dynamic>{'tabRenderer': instance.tabRenderer};

TabRenderer _$TabRendererFromJson(Map<String, dynamic> json) => TabRenderer(
  content: json['content'] == null
      ? null
      : TabRendererContent.fromJson(json['content'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TabRendererToJson(TabRenderer instance) =>
    <String, dynamic>{'content': instance.content};

TabRendererContent _$TabRendererContentFromJson(Map<String, dynamic> json) =>
    TabRendererContent(
      sectionListRenderer: json['sectionListRenderer'] == null
          ? null
          : SectionListRenderer.fromJson(
              json['sectionListRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TabRendererContentToJson(TabRendererContent instance) =>
    <String, dynamic>{'sectionListRenderer': instance.sectionListRenderer};
