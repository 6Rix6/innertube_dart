import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';

enum SectionType { musicShelf, musicCarouselShelf }

enum SectionItemType { musicTwoRowItem, musicResponsiveListItem }

class Section {
  final SectionItemType itemType;
  final SectionType type;
  final String? title;
  final List<YTItem>? items;
  final NavigationEndpoint? moreEndpoint;
  final SectionHeader? header;

  const Section({
    required this.itemType,
    required this.type,
    this.title,
    this.items,
    this.moreEndpoint,
    this.header,
  });

  @override
  String toString() {
    return 'Section(title: $title, items: ${items?.length}, moreEndpoint: $moreEndpoint)';
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
