import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/thumbnail_renderer.dart';
import 'package:json_annotation/json_annotation.dart';
import '../runs.dart';
import 'music_two_row_item_renderer.dart';

part 'music_carousel_shelf_renderer.g.dart';

/// Represents a carousel shelf containing multiple items
@JsonSerializable()
class MusicCarouselShelfRenderer {
  final MusicCarouselShelfBasicHeader? header;
  final List<MusicCarouselShelfRendererContent> contents;

  const MusicCarouselShelfRenderer({this.header, required this.contents});

  factory MusicCarouselShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicCarouselShelfRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicCarouselShelfRendererToJson(this);
}

@JsonSerializable()
class MusicCarouselShelfBasicHeader {
  final MusicCarouselShelfBasicHeaderRenderer?
  musicCarouselShelfBasicHeaderRenderer;

  const MusicCarouselShelfBasicHeader({
    this.musicCarouselShelfBasicHeaderRenderer,
  });

  factory MusicCarouselShelfBasicHeader.fromJson(Map<String, dynamic> json) =>
      _$MusicCarouselShelfBasicHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$MusicCarouselShelfBasicHeaderToJson(this);
}

/// Header for carousel shelf
@JsonSerializable()
class MusicCarouselShelfBasicHeaderRenderer {
  final Runs? title;
  final Runs? strapline;
  final MoreContentButton? moreContentButton;
  final String? trackingParams;
  final String? headerStyle;
  final ThumbnailRenderer? thumbnail;

  const MusicCarouselShelfBasicHeaderRenderer({
    this.title,
    this.strapline,
    this.moreContentButton,
    this.trackingParams,
    this.headerStyle,
    this.thumbnail,
  });

  factory MusicCarouselShelfBasicHeaderRenderer.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicCarouselShelfBasicHeaderRendererFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MusicCarouselShelfBasicHeaderRendererToJson(this);
}

/// More content button
@JsonSerializable()
class MoreContentButton {
  final ButtonRenderer? buttonRenderer;

  const MoreContentButton({this.buttonRenderer});

  factory MoreContentButton.fromJson(Map<String, dynamic> json) =>
      _$MoreContentButtonFromJson(json);

  Map<String, dynamic> toJson() => _$MoreContentButtonToJson(this);
}

@JsonSerializable()
class MusicCarouselShelfRendererContent {
  final MusicTwoRowItemRenderer? musicTwoRowItemRenderer;
  final MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;

  const MusicCarouselShelfRendererContent({
    this.musicTwoRowItemRenderer,
    this.musicResponsiveListItemRenderer,
  });

  factory MusicCarouselShelfRendererContent.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicCarouselShelfRendererContentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MusicCarouselShelfRendererContentToJson(this);
}
