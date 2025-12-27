// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_panel_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistPanel _$PlaylistPanelFromJson(Map<String, dynamic> json) =>
    PlaylistPanel(
      playlistPanelRenderer: PlaylistPanelRenderer.fromJson(
        json['playlistPanelRenderer'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PlaylistPanelToJson(PlaylistPanel instance) =>
    <String, dynamic>{'playlistPanelRenderer': instance.playlistPanelRenderer};

PlaylistPanelRenderer _$PlaylistPanelRendererFromJson(
  Map<String, dynamic> json,
) => PlaylistPanelRenderer(
  playlistId: json['playlistId'] as String?,
  isInfinite: json['isInfinite'] as bool? ?? true,
  numItemsToShow: (json['numItemsToShow'] as num?)?.toInt(),
  shuffleToggleButton: json['shuffleToggleButton'] == null
      ? null
      : ToggleButton.fromJson(
          json['shuffleToggleButton'] as Map<String, dynamic>,
        ),
  continuations: (json['continuations'] as List<dynamic>?)
      ?.map((e) => Continuation.fromJson(e as Map<String, dynamic>))
      .toList(),
  contents: (json['contents'] as List<dynamic>?)
      ?.map(
        (e) => PlaylistPanelRendererContent.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$PlaylistPanelRendererToJson(
  PlaylistPanelRenderer instance,
) => <String, dynamic>{
  'playlistId': instance.playlistId,
  'isInfinite': instance.isInfinite,
  'numItemsToShow': instance.numItemsToShow,
  'shuffleToggleButton': instance.shuffleToggleButton,
  'continuations': instance.continuations,
  'contents': instance.contents,
};

PlaylistPanelRendererContent _$PlaylistPanelRendererContentFromJson(
  Map<String, dynamic> json,
) => PlaylistPanelRendererContent(
  playlistPanelVideoRenderer: json['playlistPanelVideoRenderer'] == null
      ? null
      : PlaylistPanelVideoRenderer.fromJson(
          json['playlistPanelVideoRenderer'] as Map<String, dynamic>,
        ),
  automixPreviewVideoRenderer: json['automixPreviewVideoRenderer'] == null
      ? null
      : AutomixPreviewVideoRenderer.fromJson(
          json['automixPreviewVideoRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PlaylistPanelRendererContentToJson(
  PlaylistPanelRendererContent instance,
) => <String, dynamic>{
  'playlistPanelVideoRenderer': instance.playlistPanelVideoRenderer,
  'automixPreviewVideoRenderer': instance.automixPreviewVideoRenderer,
};

PlaylistPanelVideo _$PlaylistPanelVideoFromJson(Map<String, dynamic> json) =>
    PlaylistPanelVideo(
      playlistPanelVideoRenderer: PlaylistPanelVideoRenderer.fromJson(
        json['playlistPanelVideoRenderer'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PlaylistPanelVideoToJson(PlaylistPanelVideo instance) =>
    <String, dynamic>{
      'playlistPanelVideoRenderer': instance.playlistPanelVideoRenderer,
    };

PlaylistPanelVideoRenderer _$PlaylistPanelVideoRendererFromJson(
  Map<String, dynamic> json,
) => PlaylistPanelVideoRenderer(
  title: Runs.fromJson(json['title'] as Map<String, dynamic>),
  longBylineText: json['longBylineText'] == null
      ? null
      : Runs.fromJson(json['longBylineText'] as Map<String, dynamic>),
  shortBylineText: json['shortBylineText'] == null
      ? null
      : Runs.fromJson(json['shortBylineText'] as Map<String, dynamic>),
  lengthText: json['lengthText'] == null
      ? null
      : Runs.fromJson(json['lengthText'] as Map<String, dynamic>),
  thumbnail: json['thumbnail'] == null
      ? null
      : Thumbnails.fromJson(json['thumbnail'] as Map<String, dynamic>),
  selected: json['selected'] as bool? ?? false,
  canReorder: json['canReorder'] as bool? ?? true,
  navigationEndpoint: json['navigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['navigationEndpoint'] as Map<String, dynamic>,
        ),
  queueNavigationEndpoint: json['queueNavigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['queueNavigationEndpoint'] as Map<String, dynamic>,
        ),
  videoId: json['videoId'] as String,
  playlistSetVideoId: json['playlistSetVideoId'] as String?,
  playlistEditParams: json['playlistEditParams'] as String?,
  menu: json['menu'] == null
      ? null
      : Menu.fromJson(json['menu'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlaylistPanelVideoRendererToJson(
  PlaylistPanelVideoRenderer instance,
) => <String, dynamic>{
  'title': instance.title,
  'longBylineText': instance.longBylineText,
  'shortBylineText': instance.shortBylineText,
  'lengthText': instance.lengthText,
  'thumbnail': instance.thumbnail,
  'selected': instance.selected,
  'canReorder': instance.canReorder,
  'navigationEndpoint': instance.navigationEndpoint,
  'queueNavigationEndpoint': instance.queueNavigationEndpoint,
  'videoId': instance.videoId,
  'playlistSetVideoId': instance.playlistSetVideoId,
  'playlistEditParams': instance.playlistEditParams,
  'menu': instance.menu,
};
