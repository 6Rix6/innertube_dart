import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/renderer/chip_cloud_renderer.dart';
import 'package:innertube_dart/src/models/renderer/playlist_panel_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';

part 'music_queue_renderer.g.dart';

@JsonSerializable()
class MusicQueueRenderer {
  final PlaylistPanel? content;
  final MusicQueueHeader? header;
  final bool hack;
  final ChipCloud? subHeaderChipCloud;

  const MusicQueueRenderer({
    this.content,
    this.header,
    this.hack = true,
    this.subHeaderChipCloud,
  });

  factory MusicQueueRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicQueueRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicQueueRendererToJson(this);
}

@JsonSerializable()
class MusicQueueHeader {
  final MusicQueueHeaderRenderer? musicQueueHeaderRenderer;

  const MusicQueueHeader({this.musicQueueHeaderRenderer});

  factory MusicQueueHeader.fromJson(Map<String, dynamic> json) =>
      _$MusicQueueHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$MusicQueueHeaderToJson(this);
}

@JsonSerializable()
class MusicQueueHeaderRenderer {
  final Runs? title;
  final Runs? subtitle;
  final List<ChipCloudChip>? buttons;

  const MusicQueueHeaderRenderer({this.title, this.subtitle, this.buttons});

  factory MusicQueueHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicQueueHeaderRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicQueueHeaderRendererToJson(this);
}
