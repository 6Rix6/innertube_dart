import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/yt_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_shelf_renderer.g.dart';

/// Represents a list shelf containing multiple items (songs)
@JsonSerializable()
class MusicShelfRenderer {
  final Runs? title;
  final List<MusicResponsiveListItem>? contents;
  final List<Continuation>? continuations;
  final String? trackingParams;
  final Runs? bottomText;
  final NavigationEndpoint? bottomEndpoint;

  const MusicShelfRenderer({
    this.title,
    this.contents,
    this.continuations,
    this.trackingParams,
    this.bottomText,
    this.bottomEndpoint,
  });

  factory MusicShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicShelfRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicShelfRendererToJson(this);

  /// Parses the contents of the shelf
  List<T> parseItems<T extends YTItem>() {
    return [
      if (contents != null)
        for (final content in contents!)
          if (content.toYTItem() case T item) item,
    ];
  }
}
