import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/runs.dart';

part 'playlist_panel_renderer.g.dart';

@JsonSerializable()
class PlaylistPanel {
  final PlaylistPanelRenderer playlistPanelRenderer;

  const PlaylistPanel({required this.playlistPanelRenderer});

  factory PlaylistPanel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistPanelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistPanelToJson(this);
}

@JsonSerializable()
class PlaylistPanelRenderer {
  final String? playlistId;
  final bool isInfinite;
  final int? numItemsToShow;
  final ToggleButton? shuffleToggleButton;
  final List<Continuation>? continuations;
  final List<PlaylistPanelVideo>? contents;

  const PlaylistPanelRenderer({
    this.playlistId,
    this.isInfinite = true,
    this.numItemsToShow,
    this.shuffleToggleButton,
    this.continuations,
    this.contents,
  });

  factory PlaylistPanelRenderer.fromJson(Map<String, dynamic> json) =>
      _$PlaylistPanelRendererFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistPanelRendererToJson(this);
}

@JsonSerializable()
class PlaylistPanelVideo {
  final PlaylistPanelVideoRenderer playlistPanelVideoRenderer;

  const PlaylistPanelVideo({required this.playlistPanelVideoRenderer});

  factory PlaylistPanelVideo.fromJson(Map<String, dynamic> json) =>
      _$PlaylistPanelVideoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistPanelVideoToJson(this);
}

@JsonSerializable()
class PlaylistPanelVideoRenderer {
  final Runs? title;
  final Runs? longBylineText;
  final Runs? shortBylineText;
  final Runs? lengthText;
  final Thumbnails? thumbnail;
  final bool selected;
  final bool canReorder;
  final NavigationEndpoint? navigationEndpoint;
  final NavigationEndpoint? queueNavigationEndpoint;
  final String? videoId;
  final String? playlistSetVideoId;
  final String? playlistEditParams;
  final Menu? menu;

  const PlaylistPanelVideoRenderer({
    this.title,
    this.longBylineText,
    this.shortBylineText,
    this.lengthText,
    this.thumbnail,
    this.selected = false,
    this.canReorder = true,
    this.navigationEndpoint,
    this.queueNavigationEndpoint,
    this.videoId,
    this.playlistSetVideoId,
    this.playlistEditParams,
    this.menu,
  });

  factory PlaylistPanelVideoRenderer.fromJson(Map<String, dynamic> json) =>
      _$PlaylistPanelVideoRendererFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistPanelVideoRendererToJson(this);
}
