import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_two_row_item_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';
import 'artist.dart';

part 'playlist_item.g.dart';

/// Represents a playlist item
@JsonSerializable()
class PlaylistItem extends YTItem {
  @override
  final String id;

  @override
  final String title;

  final Runs? subtitle;
  final Artist? author;
  final String? songCountText;

  @override
  final Thumbnails? thumbnails;

  final bool isEditable;

  final WatchEndpoint? watchEndpoint;
  final WatchPlaylistEndpoint? watchPlaylistEndpoint;
  final WatchPlaylistEndpoint? shuffleEndpoint;
  final WatchPlaylistEndpoint? radioEndpoint;

  const PlaylistItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.author,
    this.songCountText,
    this.thumbnails,
    this.isEditable = false,
    this.watchEndpoint,
    this.watchPlaylistEndpoint,
    this.shuffleEndpoint,
    this.radioEndpoint,
  });

  @override
  bool get explicit => false; // Playlists are never marked as explicit

  @override
  String get shareLink => 'https://music.youtube.com/playlist?list=$id';

  factory PlaylistItem.fromJson(Map<String, dynamic> json) =>
      _$PlaylistItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistItemToJson(this);

  static PlaylistItem? fromMusicTwoRowItemRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final id = browseId.startsWith('VL') ? browseId.substring(2) : browseId;
    final title = renderer.title?.runs?.firstOrNull?.text;
    if (title == null) return null;

    final author = Artist(
      name: renderer.subtitle?.runs?.lastOrNull?.text ?? '',
      id: null,
    );

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final playEndpoint = renderer
        .thumbnailOverlay
        ?.musicItemThumbnailOverlayRenderer
        ?.content
        ?.musicPlayButtonRenderer
        ?.playNavigationEndpoint
        ?.watchPlaylistEndpoint;

    final shuffleEndpoint = renderer.menu?.menuRenderer.items
        ?.firstWhere(
          (item) =>
              item.menuNavigationItemRenderer?.icon.iconType == 'MUSIC_SHUFFLE',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;
    final radioEndpoint = renderer.menu?.menuRenderer.items
        ?.firstWhere(
          (item) => item.menuNavigationItemRenderer?.icon.iconType == 'MIX',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;

    final subtitle = renderer.subtitle;

    return PlaylistItem(
      id: id,
      title: title,
      author: author,
      songCountText: null,
      thumbnails: thumbnails!,
      watchPlaylistEndpoint: playEndpoint,
      shuffleEndpoint: shuffleEndpoint,
      radioEndpoint: radioEndpoint,
      subtitle: subtitle,
    );
  }

  @override
  String toString() {
    return '$title ${author?.name != null ? 'by ${author!.name}' : ''}';
  }
}
