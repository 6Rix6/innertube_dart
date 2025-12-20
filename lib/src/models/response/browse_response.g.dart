// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseResponse _$BrowseResponseFromJson(Map<String, dynamic> json) =>
    BrowseResponse(
      header: json['header'] == null
          ? null
          : BrowseHeaderRenderer.fromJson(
              json['header'] as Map<String, dynamic>,
            ),
      contents: json['contents'] == null
          ? null
          : BrowseResponseContent.fromJson(
              json['contents'] as Map<String, dynamic>,
            ),
      microformat: json['microformat'] as Map<String, dynamic>?,
      background: json['background'] == null
          ? null
          : BrowseResponseBackground.fromJson(
              json['background'] as Map<String, dynamic>,
            ),
      continuationContents: json['continuationContents'] == null
          ? null
          : BrowseResponseContinuation.fromJson(
              json['continuationContents'] as Map<String, dynamic>,
            ),
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
      ?.map((e) => Tab.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SingleColumnBrowseResultsRendererToJson(
  SingleColumnBrowseResultsRenderer instance,
) => <String, dynamic>{'tabs': instance.tabs};

TwoColumnBrowseResultsRenderer _$TwoColumnBrowseResultsRendererFromJson(
  Map<String, dynamic> json,
) => TwoColumnBrowseResultsRenderer(
  tabs: (json['tabs'] as List<dynamic>?)
      ?.map((e) => Tab.fromJson(e as Map<String, dynamic>))
      .toList(),
  secondaryContents: json['secondaryContents'] == null
      ? null
      : SectionList.fromJson(json['secondaryContents'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TwoColumnBrowseResultsRendererToJson(
  TwoColumnBrowseResultsRenderer instance,
) => <String, dynamic>{
  'tabs': instance.tabs,
  'secondaryContents': instance.secondaryContents,
};

BrowseResponseBackground _$BrowseResponseBackgroundFromJson(
  Map<String, dynamic> json,
) => BrowseResponseBackground(
  musicThumbnailRenderer: json['musicThumbnailRenderer'] == null
      ? null
      : MusicThumbnailRenderer.fromJson(
          json['musicThumbnailRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$BrowseResponseBackgroundToJson(
  BrowseResponseBackground instance,
) => <String, dynamic>{
  'musicThumbnailRenderer': instance.musicThumbnailRenderer,
};

BrowseResponseContinuation _$BrowseResponseContinuationFromJson(
  Map<String, dynamic> json,
) => BrowseResponseContinuation(
  sectionListContinuation: json['sectionListContinuation'] == null
      ? null
      : SectionListRenderer.fromJson(
          json['sectionListContinuation'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$BrowseResponseContinuationToJson(
  BrowseResponseContinuation instance,
) => <String, dynamic>{
  'sectionListContinuation': instance.sectionListContinuation,
};
