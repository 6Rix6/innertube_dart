import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_shelf_renderer.dart';
import 'package:innertube_dart/src/models/yt_item.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';

enum SectionType { musicShelf, musicCarouselShelf, musicCardShelf }

enum SectionItemType { musicTwoRowItem, musicResponsiveListItem, mixed }

// TODO: make this abstract
class Section {
  final SectionItemType itemType;
  final SectionType type;
  final String? title;
  final List<YTItem>? contents;
  final NavigationEndpoint? moreEndpoint;
  final SectionHeader? header;

  const Section({
    required this.itemType,
    required this.type,
    this.title,
    this.contents,
    this.moreEndpoint,
    this.header,
  });

  @override
  String toString() {
    return 'Section(title: $title, items: ${contents?.length}, moreEndpoint: $moreEndpoint)';
  }
}

class SectionHeader {
  final String? title;
  final String? strapline;
  final NavigationEndpoint? moreEndpoint;
  final ButtonRenderer? moreButton;
  final Thumbnail? thumbnail;

  const SectionHeader({
    this.title,
    this.strapline,
    this.moreEndpoint,
    this.moreButton,
    this.thumbnail,
  });
}

class MusicShelfSection extends Section {
  final String? bottomText;
  final NavigationEndpoint? bottomEndpoint;

  const MusicShelfSection({
    super.itemType = SectionItemType.musicResponsiveListItem,
    super.type = SectionType.musicShelf,
    super.contents,
    super.title,
    super.moreEndpoint,
    this.bottomText,
    this.bottomEndpoint,
  });

  factory MusicShelfSection.fromMusicShelfRenderer(
    MusicShelfRenderer renderer,
  ) {
    return MusicShelfSection(
      bottomText: renderer.bottomText?.runs.toString(),
      bottomEndpoint: renderer.bottomEndpoint,
      contents: renderer.parseSongs(),
      title: renderer.title?.runs.toString(),
    );
  }
}
