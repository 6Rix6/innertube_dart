import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/accessibility_data.dart';
import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/yt_item.dart';
import 'package:json_annotation/json_annotation.dart';
import '../runs.dart';
import '../endpoints.dart';
import '../icon.dart';
import 'menu_renderers.dart';
import 'thumbnail_renderer.dart';

part 'music_item_renderer.g.dart';

@JsonSerializable()
class MusicResponsiveListItem {
  final MusicResponsiveListItemRenderer musicResponsiveListItemRenderer;

  const MusicResponsiveListItem({
    required this.musicResponsiveListItemRenderer,
  });

  factory MusicResponsiveListItem.fromJson(Map<String, dynamic> json) =>
      _$MusicResponsiveListItemFromJson(json);
  Map<String, dynamic> toJson() => _$MusicResponsiveListItemToJson(this);
}

/// Music responsive list item renderer
@JsonSerializable()
class MusicResponsiveListItemRenderer {
  final String trackingParams;
  final List<FlexColumn> flexColumns;
  final List<FlexColumn>? fixedColumns;
  final ThumbnailRenderer? thumbnail;
  final PlaylistItemData? playlistItemData;
  final NavigationEndpoint? navigationEndpoint;
  final List<Badge>? badges;
  final Menu? menu;
  final Overlay? overlay;
  final Runs? index;
  // TODO: multiSelectCheckbox

  const MusicResponsiveListItemRenderer({
    required this.trackingParams,
    required this.flexColumns,
    this.fixedColumns,
    this.thumbnail,
    this.playlistItemData,
    this.navigationEndpoint,
    this.badges,
    this.menu,
    this.overlay,
    this.index,
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

  YTItem? toYTItem() {
    if (isSong) {
      return SongItem.fromMusicResponsiveListItemRenderer(this);
    }
    if (isAlbum) {
      // return AlbumItem.fromMusicResponsiveListItemRenderer(this);
    }
    if (isArtist) {
      // return ArtistItem.fromMusicResponsiveListItemRenderer(this);
    }
    if (isPlaylist) {
      // return PlaylistItem.fromMusicResponsiveListItemRenderer(this);
    }
    return null;
  }
}

@JsonSerializable()
class FlexColumn {
  @JsonKey(name: 'musicResponsiveListItemFlexColumnRenderer')
  final MusicResponsiveListItemFlexColumnRenderer? flexColumnRenderer;

  // actually same as flexColumnRenderer
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
  final Accessibility? accessibility;

  const MusicResponsiveListItemFlexColumnRenderer({
    this.text,
    this.accessibility,
  });

  factory MusicResponsiveListItemFlexColumnRenderer.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicResponsiveListItemFlexColumnRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveListItemFlexColumnRendererToJson(this);
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
