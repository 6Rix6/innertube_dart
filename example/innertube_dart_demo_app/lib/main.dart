import 'package:flutter/material.dart';
import 'package:innertube_dart/innertube_dart.dart' as innertube;
import 'package:just_audio/just_audio.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/play_page.dart';

void main() {
  runApp(const InnerTubeDemoApp());
}

/// Main application widget
class InnerTubeDemoApp extends StatelessWidget {
  const InnerTubeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InnerTube Dart Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const DemoApp(),
    );
  }
}

/// Home page with search and player functionality
class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  // YouTube API client instance
  late final innertube.YouTube _youtube;

  // Audio player instance for streaming
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Controllers and state
  innertube.PlayerResponse? _currentPlayerResponse;

  // index of tab navigation
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeYouTube();
  }

  /// Initialize YouTube API client
  /// It is recommended to use one instance throughout your application
  Future<void> _initializeYouTube() async {
    _youtube = innertube.YouTube(
        locale: const innertube.YouTubeLocale(gl: 'JP', hl: 'ja'));
    await _youtube.initialize();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _youtube.dispose();
    super.dispose();
  }

  /// Get player information and play audio
  Future<void> _playVideo(String videoId) async {
    try {
      // Call player API to get streaming URLs
      final result = await _youtube.player(
        videoId,
        client: innertube
            .YouTubeClient.android, // Use Android client for direct URLs
      );

      await result.when(
        success: (playerResponse) async {
          // Check if video is playable
          if (playerResponse.playabilityStatus.status != 'OK') {
            return;
          }

          setState(() {
            _currentPlayerResponse = playerResponse;
          });

          // Find audio formats with direct URL
          final audioFormats = playerResponse.streamingData?.adaptiveFormats
              .where((f) => f.isAudio && f.url != null)
              .toList();

          if (audioFormats == null || audioFormats.isEmpty) {
            return;
          }

          // Select best quality audio format
          final bestFormat = audioFormats.reduce(
            (a, b) => (a.bitrate > b.bitrate) ? a : b,
          );

          // Set URL and play
          await _audioPlayer.setUrl(bestFormat.url!);
          await _audioPlayer.play();
        },
        error: (error) {},
      );
    } catch (e) {
      setState(() {});
    }
  }

  /// Pause/resume playback
  Future<void> _togglePlayback() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedIndex: _currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_arrow),
            label: 'Play',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Page content
          IndexedStack(
            index: _currentPageIndex,
            children: [
              HomePage(
                youtube: _youtube,
                onPlay: _playVideo,
              ),
              SearchPage(youtube: _youtube),
              const PlayPage(),
            ],
          ),
          // Now playing bar
          if (_currentPlayerResponse != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress bar
                    StreamBuilder<Duration>(
                      stream: _audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        final duration = _audioPlayer.duration ?? Duration.zero;

                        return LinearProgressIndicator(
                          value: duration.inMilliseconds > 0
                              ? position.inMilliseconds /
                                  duration.inMilliseconds
                              : 0,
                        );
                      },
                    ),

                    // Player controls
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Thumbnail
                          if (_currentPlayerResponse!.videoDetails?.thumbnail
                                  .thumbnails.isNotEmpty ==
                              true)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                _currentPlayerResponse!.videoDetails!.thumbnail
                                    .thumbnails.first.url,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.music_note),
                              ),
                            ),
                          const SizedBox(width: 12),

                          // Title and artist
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _currentPlayerResponse!.videoDetails?.title ??
                                      'Unknown',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  _currentPlayerResponse!
                                          .videoDetails?.author ??
                                      'Unknown',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Play/Pause button
                          StreamBuilder<bool>(
                            stream: _audioPlayer.playingStream,
                            builder: (context, snapshot) {
                              final playing = snapshot.data ?? false;
                              return IconButton(
                                icon: Icon(
                                  playing ? Icons.pause : Icons.play_arrow,
                                ),
                                onPressed: _togglePlayback,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

// body: Column(
//         children: [
//           // Search bar
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: const InputDecoration(
//                       hintText: 'Search for music...',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.search),
//                     ),
//                     onSubmitted: (_) => _performSearch(),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 FilledButton(
//                   onPressed: _isLoading ? null : _performSearch,
//                   child: const Text('Search'),
//                 ),
//               ],
//             ),
//           ),

//           // Error message
//           if (_errorMessage != null)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Card(
//                 color: Colors.red.shade50,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.error_outline, color: Colors.red),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//           // Loading indicator
//           if (_isLoading)
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: CircularProgressIndicator(),
//             ),

//           // Search results
//           Expanded(
//             child: _searchResults.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'Search for music to see results',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: _searchResults.length,
//                     itemBuilder: (context, index) {
//                       final item = _searchResults[index];
//                       if (item is! SongItem) return const SizedBox.shrink();

//                       return ListTile(
//                         leading: item.thumbnail.isNotEmpty
//                             ? Image.network(
//                                 item.thumbnail,
//                                 width: 56,
//                                 height: 56,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) =>
//                                     const Icon(Icons.music_note),
//                               )
//                             : const Icon(Icons.music_note),
//                         title: Text(item.title),
//                         subtitle: Text(
//                           item.artists.map((a) => a.name).join(', '),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         trailing: IconButton(
//                           icon: Icon(
//                             _currentVideoId == item.id && _audioPlayer.playing
//                                 ? Icons.pause_circle
//                                 : Icons.play_circle,
//                           ),
//                           onPressed: () {
//                             if (_currentVideoId == item.id &&
//                                 _audioPlayer.playing) {
//                               _togglePlayback();
//                             } else {
//                               _playVideo(item.id);
//                             }
//                           },
//                         ),
//                       );
//                     },
//                   ),
//           ),

//           // Now playing bar
//           if (_currentPlayerResponse != null)
//             Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surfaceContainerHighest,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.1),
//                     blurRadius: 4,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Progress bar
//                   StreamBuilder<Duration>(
//                     stream: _audioPlayer.positionStream,
//                     builder: (context, snapshot) {
//                       final position = snapshot.data ?? Duration.zero;
//                       final duration = _audioPlayer.duration ?? Duration.zero;

//                       return LinearProgressIndicator(
//                         value: duration.inMilliseconds > 0
//                             ? position.inMilliseconds / duration.inMilliseconds
//                             : 0,
//                       );
//                     },
//                   ),

//                   // Player controls
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                       children: [
//                         // Thumbnail
//                         if (_currentPlayerResponse!.videoDetails?.thumbnail
//                                 .thumbnails.isNotEmpty ==
//                             true)
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(4),
//                             child: Image.network(
//                               _currentPlayerResponse!
//                                   .videoDetails!.thumbnail.thumbnails.first.url,
//                               width: 48,
//                               height: 48,
//                               fit: BoxFit.cover,
//                               errorBuilder: (_, __, ___) =>
//                                   const Icon(Icons.music_note),
//                             ),
//                           ),
//                         const SizedBox(width: 12),

//                         // Title and artist
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 _currentPlayerResponse!.videoDetails?.title ??
//                                     'Unknown',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Text(
//                                 _currentPlayerResponse!.videoDetails?.author ??
//                                     'Unknown',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey.shade600,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         ),

//                         // Play/Pause button
//                         StreamBuilder<bool>(
//                           stream: _audioPlayer.playingStream,
//                           builder: (context, snapshot) {
//                             final playing = snapshot.data ?? false;
//                             return IconButton(
//                               icon: Icon(
//                                 playing ? Icons.pause : Icons.play_arrow,
//                               ),
//                               onPressed: _togglePlayback,
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
