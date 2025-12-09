import 'package:innertube_dart/src/models/renderer/music_two_row_item_renderer.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';
import 'yt_item.dart';
import 'artist.dart';
import '../utils/utils.dart';

part 'album_item.g.dart';

/// Represents an album item
@JsonSerializable()
class AlbumItem extends YTItem {
  final String browseId;
  final String playlistId;

  @override
  final String id;

  @override
  final String title;

  final Runs? subtitle;
  final List<Artist>? artists;
  final String? year;
  final String? albumTypeText;
  final String? songCountText;
  final String? durationText;
  final Thumbnails? artistThumbnails;

  @override
  final Thumbnails thumbnails;

  @override
  final bool explicit;

  const AlbumItem({
    required this.browseId,
    required this.playlistId,
    String? id,
    required this.title,
    this.subtitle,
    this.artists,
    this.year,
    this.albumTypeText,
    this.songCountText,
    this.durationText,
    this.artistThumbnails,
    required this.thumbnails,
    this.explicit = false,
  }) : id = id ?? browseId;

  @override
  String get shareLink => 'https://music.youtube.com/playlist?list=$playlistId';

  factory AlbumItem.fromJson(Map<String, dynamic> json) =>
      _$AlbumItemFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumItemToJson(this);

  static AlbumItem? fromMusicTwoRowItemRenderer(
    MusicTwoRowItemRenderer renderer,
  ) {
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId;
    if (browseId == null) return null;

    final title = renderer.title?.runs?.firstOrNull?.text;
    if (title == null) return null;

    final playlistId = renderer
        .thumbnailOverlay
        ?.musicItemThumbnailOverlayRenderer
        ?.content
        ?.musicPlayButtonRenderer
        ?.playNavigationEndpoint
        ?.watchPlaylistEndpoint
        ?.playlistId;

    final thumbnails =
        renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail;

    final year = renderer.subtitle?.runs?.lastOrNull?.text;

    final explicit = isExplicit(renderer.subtitleBadges);
    final artists = parseArtistRuns(renderer.subtitle?.runs);
    final albumTypeText = renderer.subtitle?.runs?.firstOrNull?.text;

    return AlbumItem(
      browseId: browseId,
      playlistId: playlistId!,
      title: title,
      subtitle: renderer.subtitle,
      artists: artists,
      year: year,
      albumTypeText: albumTypeText,
      thumbnails: thumbnails!,
      explicit: explicit,
    );
  }

  @override
  String toString() {
    final artistStr = artists?.map((a) => a.name).join(", ") ?? 'Unknown';
    return '$title by $artistStr${year != null ? " ($year)" : ""}';
  }
}
