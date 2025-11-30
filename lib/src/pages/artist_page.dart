import 'package:innertube_dart/src/models/renderer/section_list_renderer.dart';
import 'package:innertube_dart/src/models/section.dart';
import 'package:innertube_dart/src/models/response/browse_response.dart';

/// Represents an artist page with sections
class ArtistPage {
  final String browseId;
  final String name;
  final String? description;
  final String? thumbnailUrl;
  final String? subscriberCountText;
  final List<Section> sections;

  const ArtistPage({
    required this.browseId,
    required this.name,
    this.description,
    this.thumbnailUrl,
    this.subscriberCountText,
    required this.sections,
  });

  /// Parse an artist page from a BrowseResponse
  factory ArtistPage.fromBrowseResponse(
    BrowseResponse response,
    String browseId,
  ) {
    final contents = response.contents;
    if (contents == null) {
      throw Exception('No contents in browse response');
    }

    // Get section list renderer
    final sectionListRenderer = SectionListRenderer.fromJson(
      response
          .contents?['singleColumnBrowseResultsRenderer']?['tabs']?[0]?['tabRenderer']?['content']?['sectionListRenderer'],
    );

    final sectionContents = sectionListRenderer.contents ?? [];

    // Parse artist metadata from header
    final header =
        response.header?['musicImmersiveHeaderRenderer'] ??
        response.header?['musicVisualHeaderRenderer'];

    final name =
        header?['title']?['runs']?[0]?['text'] as String? ?? 'Unknown Artist';

    final description = header?['description']?['runs']?[0]?['text'] as String?;

    final thumbnailUrl =
        (header?['thumbnail']?['musicThumbnailRenderer']?['thumbnail']?['thumbnails']
                    as List<dynamic>?)
                ?.lastOrNull?['url']
            as String?;

    final subscriberCountText =
        header?['subscriptionButton']?['subscribeButtonRenderer']?['subscriberCountText']?['runs']?[0]?['text']
            as String?;

    // Parse sections
    final sections = <Section>[];
    for (final content in sectionContents) {
      final section = content.parseSectionContent();
      if (section != null) {
        sections.add(section);
      }
    }

    return ArtistPage(
      browseId: browseId,
      name: name,
      description: description,
      thumbnailUrl: thumbnailUrl,
      subscriberCountText: subscriberCountText,
      sections: sections,
    );
  }

  @override
  String toString() {
    return 'ArtistPage(browseId: $browseId, name: $name, description: $description, thumbnailUrl: $thumbnailUrl, subscriberCountText: $subscriberCountText, sections: $sections)';
  }
}
