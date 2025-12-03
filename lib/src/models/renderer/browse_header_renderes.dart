import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:json_annotation/json_annotation.dart';
import 'thumbnail_renderer.dart';

part 'browse_header_renderes.g.dart';

@JsonSerializable()
class BrowseHeaderRenderer {
  final MusicVisualHeaderRenderer? musicVisualHeaderRenderer;
  final MusicImmersiveHeaderRenderer? musicImmersiveHeaderRenderer;

  const BrowseHeaderRenderer({
    this.musicVisualHeaderRenderer,
    this.musicImmersiveHeaderRenderer,
  });

  factory BrowseHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$BrowseHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseHeaderRendererToJson(this);
}

abstract class BrowseHeaderRendererBase {
  final String trackingParams;
  final Runs title;
  final ThumbnailRenderer? thumbnail;
  final Menu? menu;
  final SubscribeButton? subscriptionButton;

  const BrowseHeaderRendererBase({
    required this.trackingParams,
    required this.title,
    this.thumbnail,
    this.menu,
    this.subscriptionButton,
  });
}

@JsonSerializable()
class MusicVisualHeaderRenderer extends BrowseHeaderRendererBase {
  final ThumbnailRenderer? foregroundThumbnail;

  const MusicVisualHeaderRenderer({
    required super.trackingParams,
    required super.title,
    super.subscriptionButton,
    super.thumbnail,
    super.menu,
    this.foregroundThumbnail,
  });

  factory MusicVisualHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicVisualHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicVisualHeaderRendererToJson(this);
}

@JsonSerializable()
class MusicImmersiveHeaderRenderer extends BrowseHeaderRendererBase {
  final Runs? description;
  final ToggleButton? moreButton;
  //TODO: buttons
  final Map<String, dynamic>? playButton;
  final Map<String, dynamic>? startRadioButton;
  final NavigationEndpoint? shareEndpoint;
  final Map<String, dynamic>? monthlyListenerCount;

  const MusicImmersiveHeaderRenderer({
    required super.trackingParams,
    required super.title,
    super.subscriptionButton,
    super.thumbnail,
    super.menu,
    this.description,
    this.moreButton,
    this.playButton,
    this.startRadioButton,
    this.shareEndpoint,
    this.monthlyListenerCount,
  });

  factory MusicImmersiveHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicImmersiveHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicImmersiveHeaderRendererToJson(this);
}
