import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/section.dart';
import 'package:innertube_dart/src/models/response/browse_response.dart';
import 'package:innertube_dart/src/models/renderer/section_list_renderer.dart';

class HomePage {
  final List<Section> sections;
  final List<Continuations>? continuations;

  const HomePage({required this.sections, this.continuations});

  factory HomePage.fromBrowseResponse(
    BrowseResponse response, {
    bool isContinuation = false,
  }) {
    final sections = <Section>[];
    SectionListRenderer sectionListRenderer;
    if (isContinuation) {
      sectionListRenderer = SectionListRenderer.fromJson(
        response.continuationContents?['sectionListContinuation'],
      );
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
    );
  }
}
