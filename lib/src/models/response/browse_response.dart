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
  final BrowseResponseContinuation? continuationContents;
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
    print(urlCanonical);
    if (urlCanonical != null && urlCanonical.contains('=')) {
      return urlCanonical.split('=').last;
    }

    return null;
  }

  Thumbnails? get backgroundThumbnails =>
      background?.musicThumbnailRenderer?.thumbnail;

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
  final SectionList? secondaryContents; // album songs & foryou section

  TwoColumnBrowseResultsRenderer({this.tabs, this.secondaryContents});

  factory TwoColumnBrowseResultsRenderer.fromJson(Map<String, dynamic> json) =>
      _$TwoColumnBrowseResultsRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TwoColumnBrowseResultsRendererToJson(this);

  late final MusicResponsiveHeaderRenderer? musicResponsiveHeaderRenderer =
      _getMusicResponsiveHeader();
  late final List<SectionListRendererContent>? sectionListRendererContents =
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
  List<SectionListRendererContent>? _getSectionListRendererContents() {
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

@JsonSerializable()
class BrowseResponseContinuation {
  final SectionListRenderer? sectionListContinuation;

  const BrowseResponseContinuation({this.sectionListContinuation});

  factory BrowseResponseContinuation.fromJson(Map<String, dynamic> json) =>
      _$BrowseResponseContinuationFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseResponseContinuationToJson(this);
}
