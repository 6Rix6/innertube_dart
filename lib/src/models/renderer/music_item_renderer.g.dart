// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_item_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicResponsiveListItemRenderer _$MusicResponsiveListItemRendererFromJson(
  Map<String, dynamic> json,
) => MusicResponsiveListItemRenderer(
  flexColumns: (json['flexColumns'] as List<dynamic>)
      .map((e) => FlexColumn.fromJson(e as Map<String, dynamic>))
      .toList(),
  fixedColumns: (json['fixedColumns'] as List<dynamic>?)
      ?.map((e) => FlexColumn.fromJson(e as Map<String, dynamic>))
      .toList(),
  thumbnail: json['thumbnail'] == null
      ? null
      : ThumbnailRenderer.fromJson(json['thumbnail'] as Map<String, dynamic>),
  playlistItemData: json['playlistItemData'] == null
      ? null
      : PlaylistItemData.fromJson(
          json['playlistItemData'] as Map<String, dynamic>,
        ),
  navigationEndpoint: json['navigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['navigationEndpoint'] as Map<String, dynamic>,
        ),
  badges: (json['badges'] as List<dynamic>?)
      ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
      .toList(),
  menu: json['menu'] == null
      ? null
      : MenuRenderer.fromJson(json['menu'] as Map<String, dynamic>),
  overlay: json['overlay'] == null
      ? null
      : Overlay.fromJson(json['overlay'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MusicResponsiveListItemRendererToJson(
  MusicResponsiveListItemRenderer instance,
) => <String, dynamic>{
  'flexColumns': instance.flexColumns,
  'fixedColumns': instance.fixedColumns,
  'thumbnail': instance.thumbnail,
  'playlistItemData': instance.playlistItemData,
  'navigationEndpoint': instance.navigationEndpoint,
  'badges': instance.badges,
  'menu': instance.menu,
  'overlay': instance.overlay,
};

FlexColumn _$FlexColumnFromJson(Map<String, dynamic> json) => FlexColumn(
  flexColumnRenderer: json['musicResponsiveListItemFlexColumnRenderer'] == null
      ? null
      : MusicResponsiveListItemFlexColumnRenderer.fromJson(
          json['musicResponsiveListItemFlexColumnRenderer']
              as Map<String, dynamic>,
        ),
  fixedColumnRenderer:
      json['musicResponsiveListItemFixedColumnRenderer'] == null
      ? null
      : MusicResponsiveListItemFlexColumnRenderer.fromJson(
          json['musicResponsiveListItemFixedColumnRenderer']
              as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$FlexColumnToJson(
  FlexColumn instance,
) => <String, dynamic>{
  'musicResponsiveListItemFlexColumnRenderer': instance.flexColumnRenderer,
  'musicResponsiveListItemFixedColumnRenderer': instance.fixedColumnRenderer,
};

MusicResponsiveListItemFlexColumnRenderer
_$MusicResponsiveListItemFlexColumnRendererFromJson(
  Map<String, dynamic> json,
) => MusicResponsiveListItemFlexColumnRenderer(
  text: json['text'] == null
      ? null
      : Runs.fromJson(json['text'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MusicResponsiveListItemFlexColumnRendererToJson(
  MusicResponsiveListItemFlexColumnRenderer instance,
) => <String, dynamic>{'text': instance.text};

ThumbnailRenderer _$ThumbnailRendererFromJson(Map<String, dynamic> json) =>
    ThumbnailRenderer(
      musicThumbnailRenderer: json['musicThumbnailRenderer'] == null
          ? null
          : MusicThumbnailRenderer.fromJson(
              json['musicThumbnailRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ThumbnailRendererToJson(ThumbnailRenderer instance) =>
    <String, dynamic>{
      'musicThumbnailRenderer': instance.musicThumbnailRenderer,
    };

MusicThumbnailRenderer _$MusicThumbnailRendererFromJson(
  Map<String, dynamic> json,
) => MusicThumbnailRenderer(
  thumbnail: Thumbnails.fromJson(json['thumbnail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MusicThumbnailRendererToJson(
  MusicThumbnailRenderer instance,
) => <String, dynamic>{'thumbnail': instance.thumbnail};

PlaylistItemData _$PlaylistItemDataFromJson(Map<String, dynamic> json) =>
    PlaylistItemData(
      videoId: json['videoId'] as String,
      playlistSetVideoId: json['playlistSetVideoId'] as String?,
    );

Map<String, dynamic> _$PlaylistItemDataToJson(PlaylistItemData instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'playlistSetVideoId': instance.playlistSetVideoId,
    };

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
  musicInlineBadgeRenderer: json['musicInlineBadgeRenderer'] == null
      ? null
      : MusicInlineBadgeRenderer.fromJson(
          json['musicInlineBadgeRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
  'musicInlineBadgeRenderer': instance.musicInlineBadgeRenderer,
};

MusicInlineBadgeRenderer _$MusicInlineBadgeRendererFromJson(
  Map<String, dynamic> json,
) => MusicInlineBadgeRenderer(
  icon: json['icon'] == null
      ? null
      : Icon.fromJson(json['icon'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MusicInlineBadgeRendererToJson(
  MusicInlineBadgeRenderer instance,
) => <String, dynamic>{'icon': instance.icon};

Icon _$IconFromJson(Map<String, dynamic> json) =>
    Icon(iconType: json['iconType'] as String?);

Map<String, dynamic> _$IconToJson(Icon instance) => <String, dynamic>{
  'iconType': instance.iconType,
};

MenuRenderer _$MenuRendererFromJson(Map<String, dynamic> json) => MenuRenderer(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MenuRendererToJson(MenuRenderer instance) =>
    <String, dynamic>{'items': instance.items};

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
  menuNavigationItemRenderer:
      json['menuNavigationItemRenderer'] as Map<String, dynamic>?,
  toggleMenuServiceItemRenderer:
      json['toggleMenuServiceItemRenderer'] as Map<String, dynamic>?,
  menuServiceItemRenderer:
      json['menuServiceItemRenderer'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
  'menuNavigationItemRenderer': instance.menuNavigationItemRenderer,
  'toggleMenuServiceItemRenderer': instance.toggleMenuServiceItemRenderer,
  'menuServiceItemRenderer': instance.menuServiceItemRenderer,
};

Overlay _$OverlayFromJson(Map<String, dynamic> json) => Overlay(
  musicItemThumbnailOverlayRenderer:
      json['musicItemThumbnailOverlayRenderer'] == null
      ? null
      : MusicItemThumbnailOverlayRenderer.fromJson(
          json['musicItemThumbnailOverlayRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$OverlayToJson(Overlay instance) => <String, dynamic>{
  'musicItemThumbnailOverlayRenderer':
      instance.musicItemThumbnailOverlayRenderer,
};

MusicItemThumbnailOverlayRenderer _$MusicItemThumbnailOverlayRendererFromJson(
  Map<String, dynamic> json,
) => MusicItemThumbnailOverlayRenderer(
  content: json['content'] == null
      ? null
      : OverlayContent.fromJson(json['content'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MusicItemThumbnailOverlayRendererToJson(
  MusicItemThumbnailOverlayRenderer instance,
) => <String, dynamic>{'content': instance.content};

OverlayContent _$OverlayContentFromJson(Map<String, dynamic> json) =>
    OverlayContent(
      musicPlayButtonRenderer: json['musicPlayButtonRenderer'] == null
          ? null
          : MusicPlayButtonRenderer.fromJson(
              json['musicPlayButtonRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$OverlayContentToJson(OverlayContent instance) =>
    <String, dynamic>{
      'musicPlayButtonRenderer': instance.musicPlayButtonRenderer,
    };

MusicPlayButtonRenderer _$MusicPlayButtonRendererFromJson(
  Map<String, dynamic> json,
) => MusicPlayButtonRenderer(
  playNavigationEndpoint: json['playNavigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['playNavigationEndpoint'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MusicPlayButtonRendererToJson(
  MusicPlayButtonRenderer instance,
) => <String, dynamic>{
  'playNavigationEndpoint': instance.playNavigationEndpoint,
};
