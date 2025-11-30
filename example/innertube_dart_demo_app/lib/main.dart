import 'package:flutter/material.dart';
import 'package:innertube_dart/innertube_dart.dart';
import 'package:just_audio/just_audio.dart';

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
      home: const HomePage(),
    );
  }
}

/// Home page with search and player functionality
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // YouTube API client instance
  late final YouTube _youtube;

  // Audio player instance for streaming
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Controllers and state
  final TextEditingController _searchController = TextEditingController();
  List<YTItem> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;
  PlayerResponse? _currentPlayerResponse;
  String? _currentVideoId;

  @override
  void initState() {
    super.initState();
    _initializeYouTube();
  }

  /// Initialize YouTube API client
  Future<void> _initializeYouTube() async {
    _youtube = YouTube();
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
        SearchFilter.songs,
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
        client: YouTubeClient.android, // Use Android client for direct URLs
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

          // Show success message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Now playing: ${playerResponse.videoDetails?.title ?? "Unknown"}',
                ),
              ),
            );
          }
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
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for music...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _isLoading ? null : _performSearch,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),

          // Error message
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Loading indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),

          // Search results
          Expanded(
            child: _searchResults.isEmpty
                ? const Center(
                    child: Text(
                      'Search for music to see results',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final item = _searchResults[index];
                      if (item is! SongItem) return const SizedBox.shrink();

                      return ListTile(
                        leading: item.thumbnail.isNotEmpty
                            ? Image.network(
                                item.thumbnail,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.music_note),
                              )
                            : const Icon(Icons.music_note),
                        title: Text(item.title),
                        subtitle: Text(
                          item.artists.map((a) => a.name).join(', '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            _currentVideoId == item.id && _audioPlayer.playing
                                ? Icons.pause_circle
                                : Icons.play_circle,
                          ),
                          onPressed: () {
                            if (_currentVideoId == item.id &&
                                _audioPlayer.playing) {
                              _togglePlayback();
                            } else {
                              _playVideo(item.id);
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),

          // Now playing bar
          if (_currentPlayerResponse != null)
            Container(
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
                            ? position.inMilliseconds / duration.inMilliseconds
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
                              _currentPlayerResponse!
                                  .videoDetails!.thumbnail.thumbnails.first.url,
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
                                _currentPlayerResponse!.videoDetails?.author ??
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
        ],
      ),
    );
  }
}
