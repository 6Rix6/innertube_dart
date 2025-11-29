import '../models/yt_item.dart';

/// Represents a search result page
class SearchResult {
  final List<YTItem> items;
  final String? continuation;

  const SearchResult({required this.items, this.continuation});

  @override
  String toString() =>
      'SearchResult(items: ${items.length}, hasContinuation: ${continuation != null})';
}

/// Search filter types
enum SearchFilter {
  all(''),
  songs('EgWKAQIIAWoKEAMQBBAKEAkQBQ%3D%3D'),
  videos('EgWKAQIQAWoKEAMQBBAKEAkQBQ%3D%3D'),
  albums('EgWKAQIYAWoKEAMQBBAKEAkQBQ%3D%3D'),
  artists('EgWKAQIgAWoKEAMQBBAKEAkQBQ%3D%3D'),
  playlists('EgWKAQIoAWoKEAMQBBAKEAkQBQ%3D%3D'),
  communityPlaylists('EgeKAQQoAEABagoQAxAEEAoQCRAF'),
  featuredPlaylists('EgeKAQQoADgBagwQAxAJEAQQDhAKEAU%3D'),
  uploads('EgWKAQIwAWoKEAMQBBAKEAkQBQ%3D%3D'),
  podcasts('EgWKAQJQAWoKEAMQBBAKEAkQBQ%3D%3D'),
  episodes('EgWKAQJQAWoKEAMQBBAKEAkQBQ%3D%3D');

  final String value;

  const SearchFilter(this.value);
}
