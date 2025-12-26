import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/single_column_music_watch_next_results_renderer.dart';

part 'next_response.g.dart';

@JsonSerializable()
class NextResponse {
  final SingleColumnMusicWatchNextResults? contents;
  final NavigationEndpoint? currentVideoEndpoint;
  final Map<String, dynamic>? playerOverlays;
  final String? trackingParams;
  final String? queueContextParams;

  // unnecessary
  final Map<String, dynamic>? responseContext;
  final Map<String, dynamic>? videoReporting;

  NextResponse({
    this.contents,
    this.currentVideoEndpoint,
    this.playerOverlays,
    this.trackingParams,
    this.queueContextParams,
    this.responseContext,
    this.videoReporting,
  });

  factory NextResponse.fromJson(Map<String, dynamic> json) =>
      _$NextResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NextResponseToJson(this);
}
