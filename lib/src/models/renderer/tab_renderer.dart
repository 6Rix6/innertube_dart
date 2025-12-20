import 'package:innertube_dart/src/models/renderer/section_list_renderer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tab_renderer.g.dart';

@JsonSerializable()
class Tab {
  final TabRenderer tabRenderer;

  const Tab({required this.tabRenderer});

  factory Tab.fromJson(Map<String, dynamic> json) => _$TabFromJson(json);
  Map<String, dynamic> toJson() => _$TabToJson(this);
}

@JsonSerializable()
class TabRenderer {
  final SectionList? content;
  final String? title;
  final bool? selected;
  final String? tabIdentifier;
  final String trackingParams;

  const TabRenderer({
    this.content,
    this.title,
    this.selected,
    this.tabIdentifier,
    required this.trackingParams,
  });

  factory TabRenderer.fromJson(Map<String, dynamic> json) =>
      _$TabRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TabRendererToJson(this);
}

// @JsonSerializable()
// class TabRendererContent {
//   final SectionListRenderer? sectionListRenderer;

//   const TabRendererContent({this.sectionListRenderer});

//   factory TabRendererContent.fromJson(Map<String, dynamic> json) =>
//       _$TabRendererContentFromJson(json);
//   Map<String, dynamic> toJson() => _$TabRendererContentToJson(this);
// }
