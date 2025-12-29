import 'package:innertube_dart/src/models/artist_item.dart';
import 'package:innertube_dart/src/models/playlist_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/album.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/icon.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/thumbnail_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/accessibility_data.dart';
import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/song_item.dart';
import 'package:innertube_dart/src/models/yt_item.dart';
import 'package:innertube_dart/src/models/album_item.dart';
import 'package:innertube_dart/src/utils/parse_time.dart';
import 'package:innertube_dart/src/utils/utils.dart';

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

  YTItem? toYTItem() {
    return musicResponsiveListItemRenderer.toYTItem();
  }
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
      return _toSongItem();
    }
    if (isAlbum) {
      return _toAlbumItem();
    }
    if (isArtist) {
      return _toArtistItem();
    }
    if (isPlaylist) {
      return _toPlaylistItem();
    }
    return null;
  }

  SongItem? _toSongItem() {
    final videoId = playlistItemData?.videoId;
    if (videoId == null) return null;

    // Get title
    final titleRuns = flexColumns.firstOrNull?.renderer?.text?.runs;
    final title = titleRuns?.firstOrNull?.text;
    if (title == null) return null;

    // Get duration
    // try fixedColumns
    String? durationText =
        fixedColumns?.firstOrNull?.renderer?.text?.runs?.firstOrNull?.text;
    if (durationText == null || !isValidTimeFormat(durationText)) {
      // try flexColumns
      durationText = flexColumns
          .elementAtOrNull(1)
          ?.renderer
          ?.text
          ?.runs
          ?.firstWhere(
            (run) => isValidTimeFormat(run.text),
            orElse: () => Run(text: ""),
          )
          .text;
    }
    final duration = parseTimeText(durationText);

    // Get view count
    final viewCountText =
        flexColumns.lastOrNull?.renderer?.text?.runs?.firstOrNull?.text;

    // Get thumbnail
    final thumbnail = this.thumbnail?.musicThumbnailRenderer?.thumbnail;

    // Get artists
    final artistsRuns = flexColumns[1].flexColumnRenderer?.text?.runs;
    final artists = parseArtistRuns(artistsRuns);

    // Get album
    Album? album;
    final albumRun = flexColumns
        .elementAtOrNull(2)
        ?.renderer
        ?.text
        ?.runs
        ?.firstOrNull;
    if (albumRun != null &&
        albumRun.navigationEndpoint?.browseEndpoint?.browseId != null) {
      album = Album(
        name: albumRun.text,
        id: albumRun.navigationEndpoint!.browseEndpoint!.browseId!,
      );
    }

    final subtitleRunsList = flexColumns
        .skip(1) // skip title runs
        .map((e) => e.flexColumnRenderer?.text?.runs)
        .whereType<List<Run>>()
        .toList();
    final separator = Run(text: " • ");
    final List<Run> subtitleRuns = [
      for (int i = 0; i < subtitleRunsList.length; i++) ...[
        ...subtitleRunsList[i],
        if (i < subtitleRunsList.length - 1) separator,
      ],
    ];
    final subtitle = Runs(runs: subtitleRuns);

    // Get explicit
    final explicit = isExplicit(badges);

    return SongItem(
      id: videoId,
      title: title,
      artists: artists,
      duration: duration,
      viewCount: viewCountText,
      thumbnails: thumbnail,
      setVideoId: playlistItemData?.playlistSetVideoId,
      album: album,
      explicit: explicit,
      subtitle: subtitle,
    );
  }

  AlbumItem? _toAlbumItem() {
    if (isAlbum) {
      final browseId = navigationEndpoint?.browseEndpoint?.browseId;
      final playlistId = overlay
          ?.musicItemThumbnailOverlayRenderer
          ?.content
          ?.musicPlayButtonRenderer
          ?.playNavigationEndpoint
          ?.watchPlaylistEndpoint
          ?.playlistId;
      final title = flexColumns.firstOrNull?.renderer?.text?.toString();
      final thumbnail = this.thumbnail?.musicThumbnailRenderer?.thumbnail;

      if (browseId == null ||
          playlistId == null ||
          title == null ||
          thumbnail == null) {
        return null;
      }

      final subtitleRuns = flexColumns[1].renderer?.text;
      final artists = parseArtistRuns(subtitleRuns?.runs);
      final year = subtitleRuns?.runs?.lastOrNull?.text;
      final albumTypeText = subtitleRuns?.runs?.firstOrNull?.text;
      final explicit = isExplicit(badges);

      return AlbumItem(
        browseId: browseId,
        playlistId: playlistId,
        title: title,
        thumbnails: thumbnail,
        subtitle: subtitleRuns,
        artists: artists,
        year: year,
        albumTypeText: albumTypeText,
        explicit: explicit,
        menu: menu?.menuRenderer,
      );
    }
    return null;
  }

  ArtistItem? _toArtistItem() {
    final id = navigationEndpoint?.browseEndpoint?.browseId;
    final title = flexColumns.firstOrNull?.renderer?.text?.toString();

    if (id == null || title == null) {
      return null;
    }

    final thumbnail = this.thumbnail?.musicThumbnailRenderer?.thumbnail;
    final shuffleEndpoint = menu?.menuRenderer.items
        ?.firstWhere(
          (e) => e.menuNavigationItemRenderer?.icon.iconType == 'MUSIC_SHUFFLE',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;
    final radioEndpoint = menu?.menuRenderer.items
        ?.firstWhere(
          (e) => e.menuNavigationItemRenderer?.icon.iconType == 'MIX',
          orElse: () => MenuRendererItem(
            menuNavigationItemRenderer: null,
            toggleMenuServiceItemRenderer: null,
          ),
        )
        .menuNavigationItemRenderer
        ?.navigationEndpoint
        ?.watchPlaylistEndpoint;

    return ArtistItem(
      id: id,
      title: title,
      thumbnails: thumbnail,
      menu: menu?.menuRenderer,
      shuffleEndpoint: shuffleEndpoint,
      radioEndpoint: radioEndpoint,
    );
  }

  PlaylistItem? _toPlaylistItem() {
    final id = navigationEndpoint?.browseEndpoint?.browseId;
    final title = flexColumns.firstOrNull?.renderer?.text?.toString();

    if (id == null || title == null) return null;

    final subtitle = flexColumns[1].renderer?.text;
    final thumbnail = this.thumbnail?.musicThumbnailRenderer?.thumbnail;
    final author = parseArtistRuns(subtitle?.runs).firstOrNull;
    final watchPlaylistEndpoint = overlay
        ?.musicItemThumbnailOverlayRenderer
        ?.content
        ?.musicPlayButtonRenderer
        ?.playNavigationEndpoint
        ?.watchPlaylistEndpoint;

    return PlaylistItem(
      id: id,
      title: title,
      author: author,
      songCountText: null,
      thumbnails: thumbnail,
      isEditable: false,
      watchPlaylistEndpoint: watchPlaylistEndpoint,
      menu: menu?.menuRenderer,
    );
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
