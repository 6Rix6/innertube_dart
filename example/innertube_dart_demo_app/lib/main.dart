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
  final TextEditingController _searchController = TextEditingController();
  List<innertube.YTItem> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;
  innertube.PlayerResponse? _currentPlayerResponse;
  String? _currentVideoId;

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
        cookie:
            'YSC=G1kzae6sKZs; VISITOR_INFO1_LIVE=bdSpDSk0ses; VISITOR_PRIVACY_METADATA=CgJKUBIEGgAgVw%3D%3D; LOGIN_INFO=AFmmF2swRQIgV4tEUdOkpIx-2Cx2oDzczKXAnULdoBEDqqTTfOrQfaACIQDMMR6rUGMLxOKogaZ3fZTuiG0QMRQsO9zdtoe5q31flQ:QUQ3MjNmeUg3UDZmZUxEZU1PZHB3S3BqUGZOZkNCelJQaGh2ZGRfTHFPYU41czAwV0QzZHJsVHBaTXZUMmpIYnFKNnR5NkRNeG1mU0d1QnZiNVQ1NmdVaFNNTUxhSGo2X0hhSVV2Yk92dE44NldZemwxTDlEZkRQUE91Ml9IZVgwY0tRRE5uejduczB5cFVMRFpJRUdBVHRDNFl0UGVVRk1n; _gcl_au=1.1.976739750.1757334615; VISITOR_INFO1_LIVE=bdSpDSk0ses; VISITOR_PRIVACY_METADATA=CgJKUBIEGgAgVw%3D%3D; HSID=Ax-eno6m1GVFz020b; SSID=ApBq2XxuW5OTt2s2i; APISID=7wXeukWyAI3L4Gdu/Ar38BEB8JcKOdRbAE; SAPISID=Wi8ACq36QJZI9OnV/Ae-8FAEYZrmjOusJS; __Secure-1PAPISID=Wi8ACq36QJZI9OnV/Ae-8FAEYZrmjOusJS; __Secure-3PAPISID=Wi8ACq36QJZI9OnV/Ae-8FAEYZrmjOusJS; SID=g.a0003whzsva5qwvD9r4FVZZBegU5e_eBOslAHEXu1WtoSNprLSOe_bRo2GKmrVN-n9W2a8BP4wACgYKAXQSARYSFQHGX2MifebMXD_6gclfj3LmGXp7pBoVAUF8yKqwcrnufLTExWkz26MgTf9Q0076; __Secure-1PSID=g.a0003whzsva5qwvD9r4FVZZBegU5e_eBOslAHEXu1WtoSNprLSOezRK9MzG9WlgF-XZm4Wa2RgACgYKAZgSARYSFQHGX2Miw5KX5eGy-5bcMrSPRGDQXhoVAUF8yKpWXyoexrrqqYOKP_Ajdpfv0076; __Secure-3PSID=g.a0003whzsva5qwvD9r4FVZZBegU5e_eBOslAHEXu1WtoSNprLSOe29TJ2DnT0C5TbID8_RKKCAACgYKATsSARYSFQHGX2Mig8fAJaTu6UcMn_9embBLrBoVAUF8yKrETMvVuszxLgMfeGx5tkWH0076; PREF=tz=Asia.Tokyo&repeat=NONE&autoplay=true; __Secure-1PSIDTS=sidts-CjUBwQ9iIzr58evzBOYX2AZU9ozwg0y-3eZtYxpjZ-X6yOPE_0ncw28GZStiw-w35AZf06OaFBAA; __Secure-3PSIDTS=sidts-CjUBwQ9iIzr58evzBOYX2AZU9ozwg0y-3eZtYxpjZ-X6yOPE_0ncw28GZStiw-w35AZf06OaFBAA; __Secure-ROLLOUT_TOKEN=COGf8NzYz4D6DRCulr-61siPAxiEmuz24piRAw%3D%3D; SIDCC=AKEyXzVwOs8eLj6B5Ik-63FFIINE5jQetLCyYvR2g9EFNh60AoYhW3k_z0I4brUr7Euh92GE3MM; __Secure-1PSIDCC=AKEyXzWQNtmHCA7TCYFE8H6FTjgFx50CPZgQZXRg0mcu81aHOs6-elhPtjehFsYtNgD52veRlFk; __Secure-3PSIDCC=AKEyXzXX_Gp_3Fo6GwBO3vJASJAewkCNpnTPNohayihyIFOhdcrngpHmNgHBgUU0Uy7QG56i1a0',
        locale: const innertube.YouTubeLocale(gl: 'JP', hl: 'ja'));
    await _youtube.initialize();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _audioPlayer.dispose();
    _youtube.dispose();
    super.dispose();
  }

  /// Search for music on YouTube Music
  Future<void> _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _searchResults = [];
    });

    try {
      // Call search API with song filter
      final result = await _youtube.search(
        query,
        innertube.SearchFilter.songs,
      );

      result.when(
        success: (searchResult) {
          setState(() {
            _searchResults = searchResult.items;
            _isLoading = false;
          });
        },
        error: (error) {
          setState(() {
            _errorMessage = 'Search failed: $error';
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Unexpected error: $e';
        _isLoading = false;
      });
    }
  }

  /// Get player information and play audio
  Future<void> _playVideo(String videoId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _currentVideoId = videoId;
    });

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
            setState(() {
              _errorMessage =
                  'Cannot play: ${playerResponse.playabilityStatus.reason}';
              _isLoading = false;
            });
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
            setState(() {
              _errorMessage = 'No audio formats available';
              _isLoading = false;
            });
            return;
          }

          // Select best quality audio format
          final bestFormat = audioFormats.reduce(
            (a, b) => (a.bitrate > b.bitrate) ? a : b,
          );

          // Set URL and play
          await _audioPlayer.setUrl(bestFormat.url!);
          await _audioPlayer.play();

          setState(() {
            _isLoading = false;
          });
        },
        error: (error) {
          setState(() {
            _errorMessage = 'Player API failed: $error';
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Unexpected error: $e';
        _isLoading = false;
      });
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('InnerTube Dart Demo'),
      ),
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
              SearchPage(),
              PlayPage(),
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
