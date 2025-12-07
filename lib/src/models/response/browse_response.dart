import 'package:innertube_dart/src/models/renderer/browse_header_renderes.dart';
import 'package:innertube_dart/src/models/renderer/music_responsive_header_renderer.dart';
import 'package:innertube_dart/src/models/renderer/section_list_renderer.dart';
import 'package:innertube_dart/src/models/renderer/tab_renderer.dart';
import 'package:innertube_dart/src/models/renderer/thumbnail_renderer.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';

part 'browse_response.g.dart';

/// Browse response from YouTube API
@JsonSerializable()
class BrowseResponse {
  final BrowseHeaderRenderer? header;
  final BrowseResponseContent? contents;
  final Map<String, dynamic>? microformat;
  final BrowseResponseBackground? background;
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
    final musicHeader = getMusicResponsiveHeader();
    if (musicHeader != null) {
      final runs = musicHeader.title?.runs;
      if (runs != null && runs.isNotEmpty) {
        return runs.first.text;
      }
    }

    return null;
  }

  /// Helper to get author name from header (only for playlist)
  // Artist? getAuthor() {
  //   Artist? author;
  //   // Try twoColumnBrowseResultsRenderer
  //   final musicHeader = getMusicResponsiveHeader();
  //   if (musicHeader != null) {
  //     final avatarStackViewModel = musicHeader.facepile?.avatarStackViewModel;
  //     final name = avatarStackViewModel?.text.content;
  //     final id = avatarStackViewModel
  //         ?.rendererContext
  //         .commandContext
  //         ?.onTap
  //         ?.innertubeCommand
  //         ?.browseEndpoint
  //         ?.browseId;
  //     final thumbnailUrl = avatarStackViewModel
  //         ?.avatars
  //         ?.first
  //         .avatarViewModel
  //         .image
  //         .sources
  //         .first
  //         .url;
  //     if (name != null && name.isNotEmpty) {
  //       author = Artist(name: name, id: id, thumbnailUrl: thumbnailUrl);
  //     }
  //   }

  //   return author;
  // }

  /// Helper to get song count text from header (only for playlist)
  String? getSongCountText() {
    // Try twoColumnBrowseResultsRenderer
    final musicHeader = getMusicResponsiveHeader();
    if (musicHeader != null) {
      final runs = musicHeader.secondSubtitle?.runs;
      if (runs != null && runs.isNotEmpty) {
        return runs[2].text;
      }
    }

    return null;
  }

  /// Helper to get thumbnail
  Thumbnails? getThumbnails() {
    final musicHeader = getMusicResponsiveHeader();
    final thumbnails = musicHeader?.thumbnail?.musicThumbnailRenderer.thumbnail;

    return thumbnails;
  }

  Thumbnails? get backgroundThumbnails =>
      background?.musicThumbnailRenderer?.thumbnail;

  MusicResponsiveHeaderRenderer? getMusicResponsiveHeader() {
    final tabs = contents?.twoColumnBrowseResultsRenderer?.tabs;
    if (tabs == null || tabs.isEmpty) return null;

    final sectionContents =
        tabs.first.tabRenderer.content?.sectionListRenderer?.contents;
    if (sectionContents == null || sectionContents.isEmpty) return null;

    return sectionContents.first.musicResponsiveHeaderRenderer;
  }

  @override
  String toString() {
    return 'BrowseResponse(header: $header, contents: $contents, microformat: $microformat, background: $background)';
  }
}

@JsonSerializable()
class BrowseResponseContent {
  final SingleColumnBrowseResultsRenderer? singleColumnBrowseResultsRenderer;
  final TwoColumnBrowseResultsRenderer? twoColumnBrowseResultsRenderer;

  const BrowseResponseContent({
    this.singleColumnBrowseResultsRenderer,
    this.twoColumnBrowseResultsRenderer,
  });

  factory BrowseResponseContent.fromJson(Map<String, dynamic> json) =>
      _$BrowseResponseContentFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseResponseContentToJson(this);
}

@JsonSerializable()
class SingleColumnBrowseResultsRenderer {
  final List<Tab>? tabs;

  const SingleColumnBrowseResultsRenderer({this.tabs});

  factory SingleColumnBrowseResultsRenderer.fromJson(
    Map<String, dynamic> json,
  ) => _$SingleColumnBrowseResultsRendererFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SingleColumnBrowseResultsRendererToJson(this);
}

@JsonSerializable()
class TwoColumnBrowseResultsRenderer {
  final List<Tab>? tabs; // album header
  final SecionList? secondaryContents; // album songs & foryou section

  TwoColumnBrowseResultsRenderer({this.tabs, this.secondaryContents});

  factory TwoColumnBrowseResultsRenderer.fromJson(Map<String, dynamic> json) =>
      _$TwoColumnBrowseResultsRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TwoColumnBrowseResultsRendererToJson(this);

  late final MusicResponsiveHeaderRenderer? musicResponsiveHeaderRenderer =
      _getMusicResponsiveHeader();
  late final List<SectionListRendererContents>? sectionListRendererContents =
      _getSectionListRendererContents();

  /// helper to get music header
  MusicResponsiveHeaderRenderer? _getMusicResponsiveHeader() {
    if (tabs != null && tabs!.isNotEmpty) {
      final sectionContents =
          tabs!.first.tabRenderer.content?.sectionListRenderer?.contents;
      if (sectionContents == null || sectionContents.isEmpty) return null;

      return sectionContents.first.musicResponsiveHeaderRenderer;
    }

    return null;
  }

  /// helper to get section list renderer contents
  List<SectionListRendererContents>? _getSectionListRendererContents() {
    final contents = secondaryContents?.sectionListRenderer?.contents;
    if (contents != null && contents.isNotEmpty) {
      return contents;
    }

    return null;
  }
}

@JsonSerializable()
class BrowseResponseBackground {
  final MusicThumbnailRenderer? musicThumbnailRenderer;

  const BrowseResponseBackground({this.musicThumbnailRenderer});

  factory BrowseResponseBackground.fromJson(Map<String, dynamic> json) =>
      _$BrowseResponseBackgroundFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseResponseBackgroundToJson(this);
}
