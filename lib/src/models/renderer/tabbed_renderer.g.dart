// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabbed_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabbedRenderer _$TabbedRendererFromJson(Map<String, dynamic> json) =>
    TabbedRenderer(
      watchNextTabbedResultsRenderer:
          json['watchNextTabbedResultsRenderer'] == null
          ? null
          : WatchNextTabbedResultsRenderer.fromJson(
              json['watchNextTabbedResultsRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TabbedRendererToJson(TabbedRenderer instance) =>
    <String, dynamic>{
      'watchNextTabbedResultsRenderer': instance.watchNextTabbedResultsRenderer,
    };

WatchNextTabbedResultsRenderer _$WatchNextTabbedResultsRendererFromJson(
  Map<String, dynamic> json,
) => WatchNextTabbedResultsRenderer(
  tabs:
      (json['tabs'] as List<dynamic>?)
          ?.map((e) => Tab.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Tab>[],
);

Map<String, dynamic> _$WatchNextTabbedResultsRendererToJson(
  WatchNextTabbedResultsRenderer instance,
) => <String, dynamic>{'tabs': instance.tabs};
