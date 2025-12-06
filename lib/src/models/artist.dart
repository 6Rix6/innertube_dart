import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

/// Represents a music artist
@JsonSerializable()
class Artist {
  final String name;
  final String? id;

  const Artist({required this.name, this.id});

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
