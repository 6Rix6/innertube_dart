import 'package:json_annotation/json_annotation.dart';

part 'youtube_locale.g.dart';

/// Represents locale configuration for YouTube API
@JsonSerializable()
class YouTubeLocale {
  /// Geographic location (ISO 3166-1 alpha-2 country code)
  final String gl;

  /// Host language (IETF BCP 47 language tag)
  final String hl;

  const YouTubeLocale({required this.gl, required this.hl});

  factory YouTubeLocale.fromJson(Map<String, dynamic> json) =>
      _$YouTubeLocaleFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeLocaleToJson(this);

  /// Default locale (US English)
  static const defaultLocale = YouTubeLocale(gl: 'US', hl: 'en');

  @override
  String toString() => 'YouTubeLocale(gl: $gl, hl: $hl)';
}
