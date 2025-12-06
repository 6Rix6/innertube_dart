import 'package:innertube_dart/innertube_dart.dart';
import 'package:innertube_dart/src/models/renderer/button_renderers.dart';
import 'package:innertube_dart/src/models/renderer/menu_renderers.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
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
  final dynamic facepile;

  const MusicResponsiveHeaderRenderer({
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

  String? get titleText => title?.runs?.first.text;
  String? get typeText => subtitle?.runs?.first.text;
  String? get yearText => subtitle?.runs?.last.text;
  String? get songCountText => secondSubtitle?.runs?.first.text;
  String? get durationText => secondSubtitle?.runs?.last.text;
  Thumbnails? get thumbnails => thumbnail?.musicThumbnailRenderer.thumbnail;
  List<Artist> get artists => _parseArtists();
  Thumbnails? get artistThumbnails =>
      straplineThumbnail?.musicThumbnailRenderer.thumbnail;

  List<Artist> _parseArtists() {
    final artists = <Artist>[];
    final runs = straplineTextOne?.runs;
    if (runs != null) {
      // Get odd elements (artists, skipping separators)
      for (var i = 0; i < runs.length; i += 2) {
        final run = runs[i];
        final name = run.text;
        final id = run.navigationEndpoint?.browseEndpoint?.browseId;
        artists.add(Artist(name: name, id: id));
      }
    }
    return artists;
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
