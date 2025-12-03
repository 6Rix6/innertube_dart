import 'package:innertube_dart/src/models/renderer/music_responsive_header_renderer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

/// Represents a music artist
@JsonSerializable()
class Artist {
  final String name;
  final String? id;

  const Artist({required this.name, this.id});

  static List<Artist> generateArtistsFromMusicResponsiveHeaderRenderer(
    MusicResponsiveHeaderRenderer renderer,
  ) {
    final artists = <Artist>[];
    final runs = renderer.straplineTextOne?.runs;
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

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Artist &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
