import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/icon.dart';
import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_item_renderer.dart';
import 'package:innertube_dart/src/models/renderer/thumbnail_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/yt_item.dart';

part 'music_card_shelf_renderer.g.dart';

@JsonSerializable()
class MusicCardShelfRenderer {
  final String? trackingParams;
  final ThumbnailRenderer? thumbnail;
  final Runs? title;
  final Runs? subtitle;
  final List<MusicResponsiveListItem>? contents;
  final List<Button>? buttons;
  final Menu? menu;
  final NavigationEndpoint? onTap;
  final Icon? endIcon;

  const MusicCardShelfRenderer({
    this.trackingParams,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.contents,
    this.buttons,
    this.menu,
    this.onTap,
    this.endIcon,
  });

  factory MusicCardShelfRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicCardShelfRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicCardShelfRendererToJson(this);

  List<T> parseItems<T extends YTItem>() {
    return [
      if (contents != null)
        for (final content in contents!)
          if (content.toYTItem() case T item) item,
    ];
  }
}
