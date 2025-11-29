import 'package:innertube_dart/innertube_dart.dart';

void main() async {
  // Create a YouTube Music API client
  final youtube = YouTube(
    locale: YouTubeLocale(gl: 'US', hl: 'en'),
  );

  print('YouTube Music API Client initialized');
  print('Locale: ${youtube.locale}');
  print('');

  // Note: API methods are stubs and will throw UnimplementedError
  // Future implementation will include:
  // - Search functionality
  // - Album retrieval
  // - Artist information
  // - Playlist management

  print('Available API methods (not yet implemented):');
  print('  - youtube.search(query, filter)');
  print('  - youtube.album(browseId)');
}
