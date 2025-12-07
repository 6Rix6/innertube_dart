import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_playlist_shelf_renderer.g.dart';

@JsonSerializable()
class MusicPlaylistShelfRenderer {
  final String trackingParams;
  final String playlistId;
  final String? targetId;
  final int? collapsedItemCount;
  final List<MusicPlaylistShelfRendererContent> contents;

  MusicPlaylistShelfRenderer({
    required this.trackingParams,
    required this.playlistId,
    this.targetId,
    this.collapsedItemCount,
    required this.contents,
  });

  factory MusicPlaylistShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicPlaylistShelfRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicPlaylistShelfRendererToJson(this);

  late final List<SongItem> songs = _parseSongs();
  late final String? continuation = _parseContinuation();

  List<SongItem> _parseSongs() {
    final songs = <SongItem>[];
    if (contents.isNotEmpty) {
      for (final item in contents) {
        final renderer = item.musicResponsiveListItemRenderer;
        if (renderer != null) {
          final song = SongItem.fromMusicResponsiveListItemRenderer(renderer);
          if (song != null) songs.add(song);
        }
      }
    }
    return songs;
  }

  String? _parseContinuation() {
    final continuationItemRenderer = contents.last.continuationItemRenderer;
    if (continuationItemRenderer != null) {
      return continuationItemRenderer['continuationEndpoint']?['continuationCommand']?['token']
          as String?;
    }
    return null;
  }
}

@JsonSerializable()
class MusicPlaylistShelfRendererContent {
  final MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;
  final Map<String, dynamic>? continuationItemRenderer;

  MusicPlaylistShelfRendererContent({
    this.musicResponsiveListItemRenderer,
    this.continuationItemRenderer,
  });

  factory MusicPlaylistShelfRendererContent.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicPlaylistShelfRendererContentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MusicPlaylistShelfRendererContentToJson(this);
}
