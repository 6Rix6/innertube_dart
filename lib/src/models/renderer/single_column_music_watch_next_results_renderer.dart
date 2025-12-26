import 'package:innertube_dart/src/models/renderer/tabbed_renderer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'single_column_music_watch_next_results_renderer.g.dart';

@JsonSerializable()
class SingleColumnMusicWatchNextResults {
  final SingleColumnMusicWatchNextResultsRenderer
  singleColumnMusicWatchNextResultsRenderer;

  const SingleColumnMusicWatchNextResults({
    required this.singleColumnMusicWatchNextResultsRenderer,
  });

  factory SingleColumnMusicWatchNextResults.fromJson(
    Map<String, dynamic> json,
  ) => _$SingleColumnMusicWatchNextResultsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SingleColumnMusicWatchNextResultsToJson(this);
}

@JsonSerializable()
class SingleColumnMusicWatchNextResultsRenderer {
  final TabbedRenderer? tabbedRenderer;

  SingleColumnMusicWatchNextResultsRenderer({this.tabbedRenderer});

  factory SingleColumnMusicWatchNextResultsRenderer.fromJson(
    Map<String, dynamic> json,
  ) => _$SingleColumnMusicWatchNextResultsRendererFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SingleColumnMusicWatchNextResultsRendererToJson(this);
}
