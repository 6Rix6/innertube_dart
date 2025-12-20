// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tab _$TabFromJson(Map<String, dynamic> json) => Tab(
  tabRenderer: TabRenderer.fromJson(
    json['tabRenderer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TabToJson(Tab instance) => <String, dynamic>{
  'tabRenderer': instance.tabRenderer,
};

TabRenderer _$TabRendererFromJson(Map<String, dynamic> json) => TabRenderer(
  content: json['content'] == null
      ? null
      : SectionList.fromJson(json['content'] as Map<String, dynamic>),
  title: json['title'] as String?,
  selected: json['selected'] as bool?,
  tabIdentifier: json['tabIdentifier'] as String?,
  trackingParams: json['trackingParams'] as String,
);

Map<String, dynamic> _$TabRendererToJson(TabRenderer instance) =>
    <String, dynamic>{
      'content': instance.content,
      'title': instance.title,
      'selected': instance.selected,
      'tabIdentifier': instance.tabIdentifier,
      'trackingParams': instance.trackingParams,
    };
