# InnerTube Dart Demo App

A simple Flutter demo application showcasing the features of the `innertube_dart` package.

## Features

This demo app demonstrates:

- **Search API**: Search for music on YouTube Music
- **Player API**: Get streaming URLs and video information
- **Audio Playback**: Stream and play audio using `just_audio`
- **Simple UI**: Clean Material Design 3 interface

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher

### Installation

1. Navigate to the demo app directory:

```bash
cd example/innertube_dart_demo_app
```

2. Get dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## How to Use

1. **Search for Music**

   - Enter a song name, artist, or album in the search bar
   - Press "Search" or hit Enter
   - Browse the search results

2. **Play Audio**

   - Tap the play button (▶) on any search result
   - The app will fetch streaming URLs using the Player API
   - Audio will start playing automatically
   - Use the bottom player controls to pause/resume

3. **View Current Playback**
   - The bottom bar shows the currently playing track
   - Displays thumbnail, title, and artist
   - Shows playback progress

## API Usage Examples

### Search API

```dart
final result = await youtube.search(
  'your search query',
  SearchFilter.filterSong,
);
```

### Player API

```dart
final result = await youtube.player(
  videoId,
  client: YouTubeClient.android,
);
```

### Audio Streaming

```dart
final audioFormat = playerResponse.streamingData?.adaptiveFormats
    .where((f) => f.isAudio && f.url != null)
    .reduce((a, b) => (a.bitrate > b.bitrate) ? a : b);

await audioPlayer.setUrl(audioFormat.url!);
await audioPlayer.play();
```

## Code Structure

- `main.dart`: Main application entry point
  - `InnerTubeDemoApp`: Root widget
  - `HomePage`: Main page with search and player functionality
  - `_HomePageState`: State management for search results and playback

## Key Components

### YouTube API Client

The app initializes a `YouTube` instance on startup:

```dart
_youtube = YouTube();
await _youtube.initialize();
```

### Audio Player

Uses `just_audio` package for streaming:

```dart
final AudioPlayer _audioPlayer = AudioPlayer();
```

### Search Results

Displays search results in a scrollable list with thumbnails and play buttons.

### Now Playing Bar

Shows currently playing track with controls at the bottom of the screen.

## Notes

- Uses `YouTubeClient.android` for direct streaming URLs
- Automatically selects the highest quality audio format
- Includes error handling for API failures
- Shows loading states during network operations

## Troubleshooting

**Audio won't play:**

- Check your internet connection
- Some videos may have playback restrictions
- Try using a different `YouTubeClient` (e.g., `YouTubeClient.webRemix`)

**Search returns no results:**

- Verify your search query
- Check that the YouTube API is accessible from your network

## License

This demo app is provided as an example for the `innertube_dart` package.
