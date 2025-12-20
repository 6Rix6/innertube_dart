import 'package:innertube_dart/src/models/renderer/chip_cloud_renderer.dart';

class PageHeader {
  final List<ChipCloudChipRenderer>? chips;
  final bool? horizontalScrollable;
  final int? collapsedRowCount;

  const PageHeader({
    this.chips,
    this.horizontalScrollable,
    this.collapsedRowCount,
  });
}
