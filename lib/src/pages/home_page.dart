import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/renderer/chip_cloud_renderer.dart';
import 'package:innertube_dart/src/models/section.dart';
import 'package:innertube_dart/src/models/response/browse_response.dart';
import 'package:innertube_dart/src/models/renderer/section_list_renderer.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';

class HomePage {
  final List<Section> sections;
  final List<Continuations>? continuations;
  final HomePageHeader? header;
  final Thumbnails? background;

  const HomePage({
    required this.sections,
    this.continuations,
    this.header,
    this.background,
  });

  factory HomePage.fromBrowseResponse(
    BrowseResponse response, {
    bool isContinuation = false,
  }) {
    SectionListRenderer sectionListRenderer;
    if (isContinuation) {
      sectionListRenderer =
          response.continuationContents?.sectionListContinuation ??
          SectionListRenderer();
    } else {
      sectionListRenderer =
          response
              .contents
              ?.singleColumnBrowseResultsRenderer
              ?.tabs
              ?.firstOrNull
              ?.tabRenderer
              .content
              ?.sectionListRenderer ??
          SectionListRenderer();
    }

    final header = HomePageHeader(
      chips: sectionListRenderer.header?.chipCloudRenderer?.chips
          ?.map((e) => e.chipCloudChipRenderer)
          .toList(),
    );

    final background = response.backgroundThumbnails;

    final sections = <Section>[];

    final contents = sectionListRenderer.contents;
    if (contents == null || contents.isEmpty) {
      return HomePage(sections: sections);
    }

    for (final content in contents) {
      final section = content.parseSectionContent();
      if (section != null) {
        sections.add(section);
      }
    }
    return HomePage(
      sections: sections,
      continuations: sectionListRenderer.continuations,
      header: header,
      background: background,
    );
  }
}

class HomePageHeader {
  final List<ChipCloudChipRenderer>? chips;

  const HomePageHeader({this.chips});

  @override
  String toString() {
    return 'HomePageHeader(chips: ${chips?.length})';
  }
}
