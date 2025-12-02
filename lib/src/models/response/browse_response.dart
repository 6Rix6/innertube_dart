import 'package:json_annotation/json_annotation.dart';

import '../artist.dart';

part 'browse_response.g.dart';

/// Browse response from YouTube API
@JsonSerializable()
class BrowseResponse {
  final Map<String, dynamic>? header;
  final Map<String, dynamic>? contents;
  final Map<String, dynamic>? microformat;
  final Map<String, dynamic>? background;
  final Map<String, dynamic>? continuationContents;
  final String? trackingParams;

  const BrowseResponse({
    this.header,
    this.contents,
    this.microformat,
    this.background,
    this.continuationContents,
    this.trackingParams,
  });

  factory BrowseResponse.fromJson(Map<String, dynamic> json) =>
      _$BrowseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseResponseToJson(this);

  /// Helper to get playlist ID from microformat or header
  String? getPlaylistId() {
    // Try microformat first
    final urlCanonical =
        microformat?['microformatDataRenderer']?['urlCanonical'] as String?;
    if (urlCanonical != null && urlCanonical.contains('=')) {
      return urlCanonical.split('=').last;
    }

    return null;
  }

  /// Helper to get title from header
  String? getTitle() {
    // Try twoColumnBrowseResultsRenderer
    final musicHeader = _getMusicResponsiveHeader();
    if (musicHeader != null) {
      final runs = musicHeader['title']?['runs'] as List?;
      if (runs != null && runs.isNotEmpty) {
        return runs.first['text'] as String?;
      }
    }

    return null;
  }

  /// Helper to get author name from header (only for playlist)
  Artist? getAuthor() {
    Artist? author;
    // Try twoColumnBrowseResultsRenderer
    final musicHeader = _getMusicResponsiveHeader();
    if (musicHeader != null) {
      final avatarStackViewModel =
          musicHeader['facepile']?['avatarStackViewModel'];
      final name = avatarStackViewModel?['text']?['content'] as String?;
      final id =
          avatarStackViewModel?['rendererContext']?['commandContext']?['onTap']?['innertubeCommand']?['browseEndpoint']?['browseId']
              as String?;
      if (name != null && name.isNotEmpty) {
        author = Artist(name: name, id: id);
      }
    }

    return author;
  }

  /// Helper to get song count text from header (only for playlist)
  String? getSongCountText() {
    // Try twoColumnBrowseResultsRenderer
    final musicHeader = _getMusicResponsiveHeader();
    if (musicHeader != null) {
      final runs = musicHeader['secondSubtitle']?['runs'] as List?;
      if (runs != null && runs.isNotEmpty) {
        return runs[2]?['text'] as String?;
      }
    }

    return null;
  }

  /// Helper to get thumbnail URL
  String? getThumbnailUrl() {
    // Try background
    final bgUrl =
        background?['musicThumbnailRenderer']?['thumbnail']?['thumbnails']
                ?.last['url']
            as String?;
    if (bgUrl != null) return bgUrl;

    // Try music responsive header
    final musicHeader = _getMusicResponsiveHeader();
    final responsiveUrl =
        musicHeader?['thumbnail']?['musicThumbnailRenderer']?['thumbnail']?['thumbnails']
                ?.last['url']
            as String?;

    return responsiveUrl;
  }

  Map<String, dynamic>? _getMusicResponsiveHeader() {
    final tabs = contents?['twoColumnBrowseResultsRenderer']?['tabs'] as List?;
    if (tabs == null || tabs.isEmpty) return null;

    final sectionContents =
        tabs.first['tabRenderer']?['content']?['sectionListRenderer']?['contents']
            as List?;
    if (sectionContents == null || sectionContents.isEmpty) return null;

    return sectionContents.first['musicResponsiveHeaderRenderer']
        as Map<String, dynamic>?;
  }

  @override
  String toString() {
    return 'BrowseResponse(header: $header, contents: $contents, microformat: $microformat, background: $background)';
  }
}
