import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/single_column_music_watch_next_results_renderer.dart';

part 'next_response.g.dart';

@JsonSerializable()
class NextResponse {
  final Map<String, dynamic>? responseContext;
  final SingleColumnMusicWatchNextResults? contents;
  final NavigationEndpoint? currentVideoEndpoint;
  final Map<String, dynamic>? playerOverlays;
  final Map<String, dynamic>? videoReporting;
  final String? trackingParams;
  final String? queueContextParams;

  NextResponse({
    this.contents,
    this.responseContext,
    this.currentVideoEndpoint,
    this.playerOverlays,
    this.videoReporting,
    this.trackingParams,
    this.queueContextParams,
  });

  factory NextResponse.fromJson(Map<String, dynamic> json) =>
      _$NextResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NextResponseToJson(this);
}
