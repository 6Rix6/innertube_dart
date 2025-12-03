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
  final BrowseResponse response;
  final bool isArtist;

  const ArtistPage({
    required this.browseId,
    required this.name,
    this.description,
    this.thumbnailUrl,
    this.subscriberCountText,
    required this.sections,
    required this.response,
    required this.isArtist,
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
    final sectionListRenderer = response
        .contents
        ?.singleColumnBrowseResultsRenderer
        ?.tabs?[0]
        .tabRenderer
        .content
        ?.sectionListRenderer;

    final sectionContents = sectionListRenderer?.contents ?? [];

    String name;
    String? description;
    String? thumbnailUrl;
    String? subscriberCountText;
    bool isArtist;

    if (response.header?.musicImmersiveHeaderRenderer != null) {
      final header = response.header!.musicImmersiveHeaderRenderer!;
      name = header.title.runs?[0].text ?? "Unknown Artist";
      description = header.description?.runs?[0].text;
      thumbnailUrl = header.thumbnail?.musicThumbnailRenderer?.thumbnail
          .getBest();
      subscriberCountText = header
          .subscriptionButton
          ?.subscribeButtonRenderer
          .subscriberCountText
          ?.runs?[0]
          .text;
      isArtist = true;
    } else if (response.header?.musicVisualHeaderRenderer != null) {
      name =
          response.header?.musicVisualHeaderRenderer?.title.runs?[0].text ??
          "Unknown Artist";
      thumbnailUrl = response
          .header
          ?.musicVisualHeaderRenderer
          ?.thumbnail
          ?.musicThumbnailRenderer
          ?.thumbnail
          .getBest();
      subscriberCountText = response
          .header
          ?.musicVisualHeaderRenderer
          ?.subscriptionButton
          ?.subscribeButtonRenderer
          .subscriberCountText
          ?.runs?[0]
          .text;
      isArtist = false;
    } else {
      throw Exception('No header found');
    }

    print("Artist: $name");
    print("Description: $description");
    print("Thumbnail URL: $thumbnailUrl");
    print("Subscriber Count: $subscriberCountText");

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
      response: response,
      isArtist: isArtist,
    );
  }

  @override
  String toString() {
    return 'ArtistPage(browseId: $browseId, name: $name, description: $description, thumbnailUrl: $thumbnailUrl, subscriberCountText: $subscriberCountText, sections: $sections)';
  }
}
