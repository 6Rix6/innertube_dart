import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

/// Represents a music album
@JsonSerializable()
class Album {
  final String name;
  final String id;

  const Album({required this.name, required this.id});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
