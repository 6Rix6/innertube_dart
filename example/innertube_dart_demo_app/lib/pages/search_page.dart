import 'package:flutter/material.dart';
import 'package:innertube_dart/innertube_dart.dart';

class SearchPage extends StatefulWidget {
  final YouTube youtube;
  const SearchPage({super.key, required this.youtube});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  List<YTItem> _searchResults = [];

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
      final result = await widget.youtube.search(
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 54,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for music...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(27.0),
                        ),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (_) => _performSearch(),
                  ),
                )),
                const SizedBox(width: 8),
                SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed: _isLoading ? null : _performSearch,
                      child: const Text('Search'),
                    )),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
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
                          leading: item.thumbnails.thumbnails.isNotEmpty
                              ? Image.network(
                                  item.thumbnails.thumbnails.last.url,
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
                          // trailing: IconButton(
                          //   icon: Icon(
                          //     _currentVideoId == item.id && _audioPlayer.playing
                          //         ? Icons.pause_circle
                          //         : Icons.play_circle,
                          //   ),
                          //   onPressed: () {
                          //     if (_currentVideoId == item.id &&
                          //         _audioPlayer.playing) {
                          //       _togglePlayback();
                          //     } else {
                          //       _playVideo(item.id);
                          //     }
                          //   },
                          // ),
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}
