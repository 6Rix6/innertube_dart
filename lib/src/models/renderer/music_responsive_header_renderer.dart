import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_responsive_header_renderer.g.dart';

@JsonSerializable()
class MusicResponsiveHeaderRenderer {
  final Runs? title;
  final Runs? subtitle;
  final Runs? secondSubtitle;
  final Runs? straplineTextOne;
  final MusicResponsiveHeaderRendererThumbnail? thumbnail;
  final MusicResponsiveHeaderRendererThumbnail? straplineThumbnail;
  final List<MusicResponsiveHeaderRendererButton>? buttons;
  final String? trackingParams;
  final dynamic facepile;

  const MusicResponsiveHeaderRenderer({
    this.title,
    this.subtitle,
    this.secondSubtitle,
    this.straplineTextOne,
    this.thumbnail,
    this.straplineThumbnail,
    this.buttons,
    this.trackingParams,
    this.facepile,
  });

  factory MusicResponsiveHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicResponsiveHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicResponsiveHeaderRendererToJson(this);
}

@JsonSerializable()
class MusicResponsiveHeaderRendererThumbnail {
  final MusicThumbnailRenderer musicThumbnailRenderer;

  const MusicResponsiveHeaderRendererThumbnail({
    required this.musicThumbnailRenderer,
  });

  factory MusicResponsiveHeaderRendererThumbnail.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicResponsiveHeaderRendererThumbnailFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveHeaderRendererThumbnailToJson(this);
}

@JsonSerializable()
class MusicResponsiveHeaderRendererButton {
  final ToggleButtonRenderer? toggleButtonRenderer;
  final MusicPlayButtonRenderer? musicPlayButtonRenderer;
  final MenuRenderer? menuRenderer;

  const MusicResponsiveHeaderRendererButton({
    this.toggleButtonRenderer,
    this.musicPlayButtonRenderer,
    this.menuRenderer,
  });

  factory MusicResponsiveHeaderRendererButton.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicResponsiveHeaderRendererButtonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveHeaderRendererButtonToJson(this);
}
