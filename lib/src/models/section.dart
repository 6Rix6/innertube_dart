import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/music_shelf_renderer.dart';

// TODO
class Section {
  final String? title;
  final List<YTItem>? items;
  final NavigationEndpoint? moreEndpoint;

  const Section({this.title, this.items, this.moreEndpoint});

  @override
  String toString() {
    return 'Section(title: $title, items: ${items?.length}, moreEndpoint: $moreEndpoint)';
  }
}

class MusicShelf extends Section {
  const MusicShelf({super.items});

  static MusicShelf fromRenderer(MusicShelfRenderer renderer) {
    List<SongItem> items = [];
    if (renderer.contents != null) {
      for (final content in renderer.contents!) {
        final song = SongItem.fromMusicResponsiveListItemRenderer(
          content.musicResponsiveListItemRenderer,
        );
        if (song != null) items.add(song);
      }
    }
    return MusicShelf(items: items);
  }
}
