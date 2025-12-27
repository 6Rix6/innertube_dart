import 'package:innertube_dart/src/models/continuations.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/response/next_response.dart';
import 'package:innertube_dart/src/models/song_item.dart';

class NextPage {
  final List<SongItem> items;
  final String title;
  final String subtitle;
  final String playlistId;
  final String? addPlaylistButtonText;
  final int? currentIndex;
  final NavigationEndpoint endpoint;
  final NavigationEndpoint? lyricsEndpoint;
  final NavigationEndpoint? relatedEndpoint;
  final NextContinuationData? continuation;

  const NextPage({
    required this.items,
    required this.title,
    required this.subtitle,
    required this.playlistId,
    this.addPlaylistButtonText,
    this.currentIndex,
    required this.endpoint,
    this.lyricsEndpoint,
    this.relatedEndpoint,
    this.continuation,
  });

  factory NextPage.fromNextResponse(NextResponse response) {
    final tabs = response
        .contents
        ?.singleColumnMusicWatchNextResultsRenderer
        .tabbedRenderer
        ?.watchNextTabbedResultsRenderer
        ?.tabs;

    final nextContentTab = tabs?.firstOrNull?.tabRenderer;

    final musicQueueRenderer = nextContentTab?.content?.musicQueueRenderer;
    final endpoint = response.currentVideoEndpoint;
    final panelRenderer = musicQueueRenderer?.content?.playlistPanelRenderer;

    if (nextContentTab == null ||
        musicQueueRenderer == null ||
        endpoint == null ||
        panelRenderer == null) {
      throw Exception('Failed to parse next page');
    }

    final header = musicQueueRenderer.header?.musicQueueHeaderRenderer;

    final title = header?.title?.toString() ?? '';
    final subtitle = header?.subtitle?.toString() ?? '';
    final buttonText =
        header?.buttons?.firstOrNull?.chipCloudChipRenderer.text?.toString() ??
        '';

    final panelContents = panelRenderer.contents;

    final items =
        panelContents
            ?.map((e) => e.playlistPanelVideoRenderer?.toSongItem())
            .whereType<SongItem>()
            .toList() ??
        <SongItem>[];

    final currentIndex = panelContents?.indexWhere(
      (e) => e.playlistPanelVideoRenderer?.selected ?? false,
    );

    return NextPage(
      items: items,
      title: title,
      subtitle: subtitle,
      playlistId: panelRenderer.playlistId ?? '',
      addPlaylistButtonText: buttonText,
      currentIndex: currentIndex,
      endpoint: endpoint,
      lyricsEndpoint: tabs?[1].tabRenderer.endpoint,
      relatedEndpoint: tabs?[2].tabRenderer.endpoint,
      continuation:
          panelRenderer.continuations?.firstOrNull?.nextRadioContinuationData,
    );
  }
}
