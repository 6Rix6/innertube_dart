import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/avater.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:innertube_dart/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'thumbnail_renderer.dart';

part 'music_responsive_header_renderer.g.dart';

/// Header of album, playlist and playlist page.
@JsonSerializable()
class MusicResponsiveHeaderRenderer {
  final Runs? title;
  final Runs? subtitle;
  final Runs? secondSubtitle;
  final Runs? straplineTextOne;
  final MusicResponsiveHeaderRendererThumbnail? thumbnail;
  final MusicResponsiveHeaderRendererThumbnail? straplineThumbnail;
  final List<MusicResponsiveHeaderRendererButton>? buttons;
  final String? trackingParams;
  final Facepile? facepile;

  MusicResponsiveHeaderRenderer({
    this.title,
    this.subtitle,
    this.secondSubtitle,
    this.straplineTextOne,
    this.thumbnail,
    this.straplineThumbnail,
    this.buttons,
    this.trackingParams,
    this.facepile,
  });

  factory MusicResponsiveHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicResponsiveHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicResponsiveHeaderRendererToJson(this);

  late final List<Artist> albumArtists = _parseAlbumArtists();
  late final Artist? playlistAuthor = _parsePlaylistAuthor();

  String? get titleText => title?.runs?.first.text;
  String? get typeText => subtitle?.runs?.first.text;
  String? get yearText => subtitle?.runs?.last.text;
  String? get songCountText => secondSubtitle?.runs?.first.text;
  String? get durationText => secondSubtitle?.runs?.last.text;
  Thumbnails? get thumbnails => thumbnail?.musicThumbnailRenderer.thumbnail;
  Thumbnails? get artistThumbnails =>
      straplineThumbnail?.musicThumbnailRenderer.thumbnail;
  WatchEndpoint? get playEndpoint => buttons?[1]
      .musicPlayButtonRenderer
      ?.playNavigationEndpoint
      ?.watchEndpoint;

  List<Artist> _parseAlbumArtists() {
    final artists = <Artist>[];
    final runs = straplineTextOne?.runs;
    if (runs != null) {
      artists.addAll(parseArtistRuns(runs));
    }
    return artists;
  }

  Artist? _parsePlaylistAuthor() {
    final avatarStackViewModel = facepile?.avatarStackViewModel;
    final name = avatarStackViewModel?.text.content;
    final id = avatarStackViewModel
        ?.rendererContext
        .commandContext
        ?.onTap
        ?.innertubeCommand
        ?.browseEndpoint
        ?.browseId;
    final thumbnailUrl = avatarStackViewModel
        ?.avatars
        ?.first
        .avatarViewModel
        .image
        .sources
        .first
        .url;
    if (name != null && name.isNotEmpty) {
      return Artist(name: name, id: id, thumbnailUrl: thumbnailUrl);
    }
    return null;
  }
}

@JsonSerializable()
class MusicResponsiveHeaderRendererThumbnail {
  final MusicThumbnailRenderer musicThumbnailRenderer;

  const MusicResponsiveHeaderRendererThumbnail({
    required this.musicThumbnailRenderer,
  });

  factory MusicResponsiveHeaderRendererThumbnail.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicResponsiveHeaderRendererThumbnailFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveHeaderRendererThumbnailToJson(this);
}

@JsonSerializable()
class MusicResponsiveHeaderRendererButton {
  final ToggleButtonRenderer? toggleButtonRenderer;
  final MusicPlayButtonRenderer? musicPlayButtonRenderer;
  final MenuRenderer? menuRenderer;

  const MusicResponsiveHeaderRendererButton({
    this.toggleButtonRenderer,
    this.musicPlayButtonRenderer,
    this.menuRenderer,
  });

  factory MusicResponsiveHeaderRendererButton.fromJson(
    Map<String, dynamic> json,
  ) => _$MusicResponsiveHeaderRendererButtonFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MusicResponsiveHeaderRendererButtonToJson(this);
}

@JsonSerializable()
class Facepile {
  final AvatarStackViewModel avatarStackViewModel;

  const Facepile({required this.avatarStackViewModel});

  factory Facepile.fromJson(Map<String, dynamic> json) =>
      _$FacepileFromJson(json);
  Map<String, dynamic> toJson() => _$FacepileToJson(this);
}
