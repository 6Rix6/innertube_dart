import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_two_row_item_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';

part 'artist_item.g.dart';

/// Represents an artist/channel item
@JsonSerializable()
class ArtistItem extends YTItem {
  @override
  final String id;

  @override
  final String title;

  final Runs? subtitle;

  @override
  final Thumbnails? thumbnails;

  final String? channelId;

  final MenuRenderer? menu;

  final WatchPlaylistEndpoint? shuffleEndpoint;
  final WatchPlaylistEndpoint? radioEndpoint;

  const ArtistItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.thumbnails,
    this.channelId,
    this.menu,
    this.shuffleEndpoint,
    this.radioEndpoint,
  });

  @override
  bool get explicit => false; // Artists are never marked as explicit

  @override
  String get shareLink => 'https://music.youtube.com/channel/$id';

  factory ArtistItem.fromJson(Map<String, dynamic> json) =>
      _$ArtistItemFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistItemToJson(this);

  static ArtistItem? fromMusicTwoRowItemRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final title = renderer.title?.runs?.lastOrNull?.text;
    if (title == null) return null;

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final channelId =
        renderer.menu?.menuRenderer.items
                ?.firstWhere(
                  (item) =>
                      item.toggleMenuServiceItemRenderer?['defaultIcon']?['iconType'] ==
                      'SUBSCRIBE',
                  orElse: () => MenuRendererItem(
                    menuNavigationItemRenderer: null,
                    toggleMenuServiceItemRenderer: null,
                  ),
                )
                .toggleMenuServiceItemRenderer?['defaultServiceEndpoint']?['subscribeEndpoint']?['channelIds']?[0]
            as String?;

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

    return ArtistItem(
      id: browseId,
      title: title,
      subtitle: renderer.subtitle,
      thumbnails: thumbnails!,
      channelId: channelId,
      shuffleEndpoint: shuffleEndpoint,
      radioEndpoint: radioEndpoint,
    );
  }

  @override
  String toString() => title;
}
