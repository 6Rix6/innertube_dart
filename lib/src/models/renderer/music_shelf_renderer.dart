import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:json_annotation/json_annotation.dart';
import '../runs.dart';

part 'music_shelf_renderer.g.dart';

/// Represents a list shelf containing multiple items (songs)
@JsonSerializable()
class MusicShelfRenderer {
  final Runs? title;
  final List<MusicResponsiveListItem>? contents;
  final List<Map<String, dynamic>>? continuations;
  final String? trackingParams;
  final Runs? buttomText;
  final NavigationEndpoint? bottomEndpoint;

  const MusicShelfRenderer({
    this.title,
    this.contents,
    this.continuations,
    this.trackingParams,
    this.buttomText,
    this.bottomEndpoint,
  });

  factory MusicShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicShelfRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicShelfRendererToJson(this);

  /// Get continuation token if available
  String? getContinuation() {
    if (continuations == null || continuations!.isEmpty) return null;
    return continuations!.first['nextContinuationData']?['continuation']
        as String?;
  }

  List<SongItem> parseSongs() {
    final songs = <SongItem>[];

    if (contents != null && contents!.isNotEmpty) {
      for (final item in contents!) {
        final renderer = item.musicResponsiveListItemRenderer;
        final song = SongItem.fromMusicResponsiveListItemRenderer(renderer);
        if (song != null) songs.add(song);
      }
    }

    return songs;
  }
}
