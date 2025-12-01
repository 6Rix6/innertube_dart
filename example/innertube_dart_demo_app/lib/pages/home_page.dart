import 'package:flutter/material.dart';
import 'package:innertube_dart/innertube_dart.dart' as innertube;

class HomePage extends StatefulWidget {
  final innertube.YouTube youtube;
  final Function(String videoId) onPlay;
  const HomePage({super.key, required this.youtube, required this.onPlay});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<innertube.Section> sections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHomePage();
  }

  Future<void> _loadHomePage() async {
    // wait for initialization
    // It is necessary youtube client's initialization for loading continuation
    // this is unnecessary if you set visitorData when creating YouTube client
    await widget.youtube.waitForInitialization();

    // load home page
    final result = await widget.youtube.home();
    result.when(
      success: (homePage) {
        setState(() {
          sections = homePage.sections;
          isLoading = false;
        });
        if (homePage.continuations?.isNotEmpty ?? false) {
          _loadContinuation(homePage.continuations!.first);
        }
      },
      error: (error) {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  Future<void> _loadContinuation(innertube.Continuations continuation) async {
    // load continuation
    final result = await widget.youtube.home(
      continuation: continuation,
    );

    // handle result
    result.when(
      success: (homePage) {
        setState(() {
          sections.addAll(homePage.sections);
        });

        // Load the next continuation if available.
        // It's recommended to load it based on scrolling.
        if (homePage.continuations?.isNotEmpty ?? false) {
          _loadContinuation(homePage.continuations!.first);
        }
      },
      error: (error) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('InnerTube Dart Demo'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  final section = sections[index];
                  return SectionItem(section: section, onPlay: widget.onPlay);
                },
              ));
  }
}

class SectionItem extends StatelessWidget {
  final innertube.Section section;
  final Function(String videoId) onPlay;
  const SectionItem({super.key, required this.section, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            section.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: section.items?.length ?? 0,
              itemBuilder: (context, index) {
                final item = section.items?[index];
                return YTItemTile(item: item!, onPlay: onPlay);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class YTItemTile extends StatelessWidget {
  final innertube.YTItem item;
  final Function(String videoId) onPlay;
  const YTItemTile({super.key, required this.item, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item is innertube.SongItem) {
          onPlay(item.id);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(item.thumbnail ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 150,
            child: Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (item is innertube.SongItem)
            Text(
              (item as innertube.SongItem)
                  .artists
                  .map((a) => a.name)
                  .join(", "),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}
