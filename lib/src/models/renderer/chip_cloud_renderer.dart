import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chip_cloud_renderer.g.dart';

@JsonSerializable()
class ChipCloud {
  final ChipCloudChipRenderer chipCloudRenderer;

  const ChipCloud({required this.chipCloudRenderer});

  factory ChipCloud.fromJson(Map<String, dynamic> json) =>
      _$ChipCloudFromJson(json);

  Map<String, dynamic> toJson() => _$ChipCloudToJson(this);
}

@JsonSerializable()
class ChipCloudRenderer {
  final List<ChipCloudChip>? chips;
  final bool? horizontalScrollable;
  final int? collapsedRowCount;

  const ChipCloudRenderer({
    this.chips,
    this.horizontalScrollable,
    this.collapsedRowCount,
  });

  factory ChipCloudRenderer.fromJson(Map<String, dynamic> json) =>
      _$ChipCloudRendererFromJson(json);

  Map<String, dynamic> toJson() => _$ChipCloudRendererToJson(this);
}

@JsonSerializable()
class ChipCloudChip {
  final ChipCloudChipRenderer chipCloudChipRenderer;

  const ChipCloudChip({required this.chipCloudChipRenderer});

  factory ChipCloudChip.fromJson(Map<String, dynamic> json) =>
      _$ChipCloudChipFromJson(json);

  Map<String, dynamic> toJson() => _$ChipCloudChipToJson(this);
}

@JsonSerializable()
class ChipCloudChipRenderer {
  Runs? text;
  NavigationEndpoint? navigationEndpoint;
  NavigationEndpoint? onDeselectedCommand;
  bool isSelected;

  ChipCloudChipRenderer({
    this.text,
    this.navigationEndpoint,
    this.onDeselectedCommand,
    this.isSelected = false,
  });

  factory ChipCloudChipRenderer.fromJson(Map<String, dynamic> json) =>
      _$ChipCloudChipRendererFromJson(json);

  Map<String, dynamic> toJson() => _$ChipCloudChipRendererToJson(this);
}
