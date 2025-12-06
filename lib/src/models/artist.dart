import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

/// Represents a music artist
@JsonSerializable()
class Artist {
  final String name;
  final String? id;
  final String? thumbnailUrl;

  const Artist({required this.name, this.id, this.thumbnailUrl});

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  @override
  String toString() =>
      'Artist(name: $name, id: $id, thumbnailUrl: $thumbnailUrl)';

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
