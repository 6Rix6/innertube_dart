import 'package:innertube_dart/innertube_dart.dart';

/// Represents a section in an artist page (Songs, Albums, Singles, etc.)
class ArtistSection {
  final String title;
  final List<YTItem> items;
  final String? moreEndpoint;

  const ArtistSection({
    required this.title,
    required this.items,
    this.moreEndpoint,
  });

  @override
  String toString() {
    return 'ArtistSection(title: $title, items: $items, moreEndpoint: $moreEndpoint)';
  }
}
