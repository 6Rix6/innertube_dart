import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:json_annotation/json_annotation.dart';
import '../runs.dart';
import 'music_two_row_item_renderer.dart';
import '../navigation_endpoint.dart';

part 'music_carousel_shelf_renderer.g.dart';

/// Represents a carousel shelf containing multiple items
@JsonSerializable()
class MusicCarouselShelfRenderer {
  final MusicCarouselShelfBasicHeaderRenderer? header;
  final List<MusicCarouselShelfRendererContent> contents;

  const MusicCarouselShelfRenderer({this.header, required this.contents});

  factory MusicCarouselShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicCarouselShelfRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicCarouselShelfRendererToJson(this);
}

/// Header for carousel shelf
@JsonSerializable()
class MusicCarouselShelfBasicHeaderRenderer {
  final Runs? title;
  final MoreContentButton? moreContentButton;
  final String? trackingParams;
  final String? headerStyle;

  const MusicCarouselShelfBasicHeaderRenderer({
    this.title,
    this.moreContentButton,
    this.trackingParams,
    this.headerStyle,
  });

  factory MusicCarouselShelfBasicHeaderRenderer.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicCarouselShelfBasicHeaderRendererFromJson(
    json['musicCarouselShelfBasicHeaderRenderer'],
  );

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

/// Button renderer
@JsonSerializable()
class ButtonRenderer {
  final String? style;
  final bool? isDisabled;
  final Runs? text;
  final NavigationEndpoint? navigationEndpoint;
  final String? trackingParams;

  const ButtonRenderer({
    this.style,
    this.isDisabled,
    this.text,
    this.navigationEndpoint,
    this.trackingParams,
  });

  factory ButtonRenderer.fromJson(Map<String, dynamic> json) =>
      _$ButtonRendererFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonRendererToJson(this);
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
