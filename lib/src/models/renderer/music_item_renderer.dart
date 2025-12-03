import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:json_annotation/json_annotation.dart';
import '../runs.dart';
import '../thumbnails.dart';
import '../endpoints.dart';
import '../icon.dart';
import 'menu_renderers.dart';

part 'music_item_renderer.g.dart';

/// Music responsive list item renderer
@JsonSerializable()
class MusicResponsiveListItemRenderer {
  final List<FlexColumn> flexColumns;
  final List<FlexColumn>? fixedColumns;
  final ThumbnailRenderer? thumbnail;
  final PlaylistItemData? playlistItemData;
  final NavigationEndpoint? navigationEndpoint;
  final List<Badge>? badges;
  final MenuRenderer? menu;
  final Overlay? overlay;

  const MusicResponsiveListItemRenderer({
    required this.flexColumns,
    this.fixedColumns,
    this.thumbnail,
    this.playlistItemData,
    this.navigationEndpoint,
    this.badges,
    this.menu,
    this.overlay,
  });

  // Type detection helpers
  bool get isSong =>
      navigationEndpoint == null ||
      navigationEndpoint!.watchEndpoint != null ||
      navigationEndpoint!.watchPlaylistEndpoint != null;

  bool get isAlbum =>
      navigationEndpoint?.browseEndpoint != null && (!isArtist && !isPlaylist);

  bool get isArtist => navigationEndpoint?.browseEndpoint != null;

  bool get isPlaylist =>
      navigationEndpoint?.browseEndpoint?.browseId?.startsWith('VL') == true;

  factory MusicResponsiveListItemRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicResponsiveListItemRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveListItemRendererToJson(this);
}

@JsonSerializable()
class FlexColumn {
  @JsonKey(name: 'musicResponsiveListItemFlexColumnRenderer')
  final MusicResponsiveListItemFlexColumnRenderer? flexColumnRenderer;

  @JsonKey(name: 'musicResponsiveListItemFixedColumnRenderer')
  final MusicResponsiveListItemFlexColumnRenderer? fixedColumnRenderer;

  const FlexColumn({this.flexColumnRenderer, this.fixedColumnRenderer});

  MusicResponsiveListItemFlexColumnRenderer? get renderer =>
      flexColumnRenderer ?? fixedColumnRenderer;

  factory FlexColumn.fromJson(Map<String, dynamic> json) =>
      _$FlexColumnFromJson(json);
  Map<String, dynamic> toJson() => _$FlexColumnToJson(this);
}

@JsonSerializable()
class MusicResponsiveListItemFlexColumnRenderer {
  final Runs? text;

  const MusicResponsiveListItemFlexColumnRenderer({this.text});

  factory MusicResponsiveListItemFlexColumnRenderer.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicResponsiveListItemFlexColumnRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveListItemFlexColumnRendererToJson(this);
}

@JsonSerializable()
class ThumbnailRenderer {
  final MusicThumbnailRenderer? musicThumbnailRenderer;

  const ThumbnailRenderer({this.musicThumbnailRenderer});

  String? getThumbnailUrl() => musicThumbnailRenderer?.thumbnail.getBest();

  factory ThumbnailRenderer.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailRendererToJson(this);
}

@JsonSerializable()
class MusicThumbnailRenderer {
  final Thumbnails thumbnail;

  const MusicThumbnailRenderer({required this.thumbnail});

  factory MusicThumbnailRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicThumbnailRendererToJson(this);
}

@JsonSerializable()
class PlaylistItemData {
  final String videoId;
  final String? playlistSetVideoId;

  const PlaylistItemData({required this.videoId, this.playlistSetVideoId});

  factory PlaylistItemData.fromJson(Map<String, dynamic> json) =>
      _$PlaylistItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistItemDataToJson(this);
}

@JsonSerializable()
class Badge {
  final MusicInlineBadgeRenderer? musicInlineBadgeRenderer;

  const Badge({this.musicInlineBadgeRenderer});

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}

@JsonSerializable()
class MusicInlineBadgeRenderer {
  final Icon? icon;

  const MusicInlineBadgeRenderer({this.icon});

  factory MusicInlineBadgeRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicInlineBadgeRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicInlineBadgeRendererToJson(this);
}

// @JsonSerializable()
// class MenuRenderer {
//   final List<MenuItem>? items;

//   const MenuRenderer({this.items});

//   factory MenuRenderer.fromJson(Map<String, dynamic> json) =>
//       _$MenuRendererFromJson(json);

//   Map<String, dynamic> toJson() => _$MenuRendererToJson(this);
// }

// @JsonSerializable()
// class MenuItem {
//   final Map<String, dynamic>? menuNavigationItemRenderer;
//   final Map<String, dynamic>? toggleMenuServiceItemRenderer;
//   final Map<String, dynamic>? menuServiceItemRenderer;

//   const MenuItem({
//     this.menuNavigationItemRenderer,
//     this.toggleMenuServiceItemRenderer,
//     this.menuServiceItemRenderer,
//   });

//   factory MenuItem.fromJson(Map<String, dynamic> json) =>
//       _$MenuItemFromJson(json);

//   Map<String, dynamic> toJson() => _$MenuItemToJson(this);
// }

@JsonSerializable()
class Overlay {
  final MusicItemThumbnailOverlayRenderer? musicItemThumbnailOverlayRenderer;

  const Overlay({this.musicItemThumbnailOverlayRenderer});

  factory Overlay.fromJson(Map<String, dynamic> json) =>
      _$OverlayFromJson(json);
  Map<String, dynamic> toJson() => _$OverlayToJson(this);
}

@JsonSerializable()
class MusicItemThumbnailOverlayRenderer {
  final OverlayContent? content;

  const MusicItemThumbnailOverlayRenderer({this.content});

  factory MusicItemThumbnailOverlayRenderer.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicItemThumbnailOverlayRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicItemThumbnailOverlayRendererToJson(this);
}

@JsonSerializable()
class OverlayContent {
  final MusicPlayButtonRenderer? musicPlayButtonRenderer;

  const OverlayContent({this.musicPlayButtonRenderer});

  factory OverlayContent.fromJson(Map<String, dynamic> json) =>
      _$OverlayContentFromJson(json);
  Map<String, dynamic> toJson() => _$OverlayContentToJson(this);
}
