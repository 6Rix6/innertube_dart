import 'package:innertube_dart/src/models/renderer/tab_renderer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tabbed_renderer.g.dart';

@JsonSerializable()
class TabbedRenderer {
  final WatchNextTabbedResultsRenderer? watchNextTabbedResultsRenderer;

  const TabbedRenderer({this.watchNextTabbedResultsRenderer});

  factory TabbedRenderer.fromJson(Map<String, dynamic> json) =>
      _$TabbedRendererFromJson(json);

  Map<String, dynamic> toJson() => _$TabbedRendererToJson(this);
}

@JsonSerializable()
class WatchNextTabbedResultsRenderer {
  final List<Tab> tabs;

  const WatchNextTabbedResultsRenderer({this.tabs = const <Tab>[]});

  factory WatchNextTabbedResultsRenderer.fromJson(Map<String, dynamic> json) =>
      _$WatchNextTabbedResultsRendererFromJson(json);

  Map<String, dynamic> toJson() => _$WatchNextTabbedResultsRendererToJson(this);
}
