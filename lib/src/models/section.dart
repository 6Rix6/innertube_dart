import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/renderer/music_card_shelf_renderer.dart';
import 'package:innertube_dart/src/models/renderer/music_shelf_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
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
    this.bottomText,
    this.bottomEndpoint,
  });

  factory MusicShelfSection.fromRenderer(MusicShelfRenderer renderer) {
    final items = renderer.parseItems<YTItem>();

    return MusicShelfSection(
      bottomText: renderer.bottomText?.toString(),
      bottomEndpoint: renderer.bottomEndpoint,
      contents: items,
      title: renderer.title?.toString(),
    );
  }
}

class MusicCardShelfSection extends Section {
  final Thumbnails? thumbnails;
  final Runs? subtitle;
  final List<ButtonRenderer>? buttons;
  final MenuRenderer? menu;
  final String? contentTitle;

  /// Browse endpoint
  final NavigationEndpoint? endpoint;

  const MusicCardShelfSection({
    super.itemType = SectionItemType.musicResponsiveListItem,
    super.type = SectionType.musicCardShelf,
    super.contents,
    super.title,
    this.thumbnails,
    this.subtitle,
    this.buttons,
    this.menu,
    this.endpoint,
    this.contentTitle,
  });

  factory MusicCardShelfSection.fromRenderer(MusicCardShelfRenderer renderer) {
    final items = renderer.parseItems<YTItem>();
    final buttons = renderer.buttons?.map((e) => e.buttonRenderer).toList();
    final contentTitle = renderer.getContentTitle();

    return MusicCardShelfSection(
      thumbnails: renderer.thumbnail?.musicThumbnailRenderer?.thumbnail,
      subtitle: renderer.subtitle,
      buttons: buttons,
      menu: renderer.menu?.menuRenderer,
      endpoint: renderer.onTap,
      contents: items,
      title: renderer.title?.toString(),
      contentTitle: contentTitle,
    );
  }
}
