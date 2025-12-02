import 'package:json_annotation/json_annotation.dart';
import '../runs.dart';
import '../navigation_endpoint.dart';
import 'music_item_renderer.dart';

part 'music_two_row_item_renderer.g.dart';

/// Represents an item in a two-row carousel (albums, playlists, artists)
@JsonSerializable()
class MusicTwoRowItemRenderer {
  final ThumbnailRenderer? thumbnailRenderer;
  final Overlay? thumbnailOverlay;
  final NavigationEndpoint? navigationEndpoint;
  final Runs? title;
  final Runs? subtitle;
  final List<Badge>? subtitleBadges;
  final MenuRenderer? menu;

  const MusicTwoRowItemRenderer({
    this.thumbnailRenderer,
    this.thumbnailOverlay,
    this.navigationEndpoint,
    this.title,
    this.subtitle,
    this.subtitleBadges,
    this.menu,
  });

  factory MusicTwoRowItemRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicTwoRowItemRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MusicTwoRowItemRendererToJson(this);

  /// Check if this is a song item
  bool get isSong =>
      navigationEndpoint?.watchEndpoint != null ||
      navigationEndpoint?.watchPlaylistEndpoint != null;

  /// Check if this is an album item
  bool get isAlbum =>
      navigationEndpoint?.browseEndpoint?.browseId?.startsWith('MPREb_') ==
      true;

  /// Check if this is a playlist item
  bool get isPlaylist =>
      navigationEndpoint?.browseEndpoint?.browseId?.startsWith('VL') == true ||
      navigationEndpoint?.browseEndpoint?.browseId?.startsWith('RDCLAK') ==
          true;

  /// Check if this is an artist item
  bool get isArtist =>
      navigationEndpoint?.browseEndpoint?.pageType == 'MUSIC_PAGE_TYPE_ARTIST';
}
