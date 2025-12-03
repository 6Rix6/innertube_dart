// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_header_renderes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseHeaderRenderer _$BrowseHeaderRendererFromJson(
  Map<String, dynamic> json,
) => BrowseHeaderRenderer(
  musicVisualHeaderRenderer: json['musicVisualHeaderRenderer'] == null
      ? null
      : MusicVisualHeaderRenderer.fromJson(
          json['musicVisualHeaderRenderer'] as Map<String, dynamic>,
        ),
  musicImmersiveHeaderRenderer: json['musicImmersiveHeaderRenderer'] == null
      ? null
      : MusicImmersiveHeaderRenderer.fromJson(
          json['musicImmersiveHeaderRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$BrowseHeaderRendererToJson(
  BrowseHeaderRenderer instance,
) => <String, dynamic>{
  'musicVisualHeaderRenderer': instance.musicVisualHeaderRenderer,
  'musicImmersiveHeaderRenderer': instance.musicImmersiveHeaderRenderer,
};

MusicVisualHeaderRenderer _$MusicVisualHeaderRendererFromJson(
  Map<String, dynamic> json,
) => MusicVisualHeaderRenderer(
  trackingParams: json['trackingParams'] as String,
  title: Runs.fromJson(json['title'] as Map<String, dynamic>),
  subscriptionButton: json['subscriptionButton'] == null
      ? null
      : SubscribeButton.fromJson(
          json['subscriptionButton'] as Map<String, dynamic>,
        ),
  thumbnail: json['thumbnail'] == null
      ? null
      : ThumbnailRenderer.fromJson(json['thumbnail'] as Map<String, dynamic>),
  menu: json['menu'] == null
      ? null
      : Menu.fromJson(json['menu'] as Map<String, dynamic>),
  foregroundThumbnail: json['foregroundThumbnail'] == null
      ? null
      : ThumbnailRenderer.fromJson(
          json['foregroundThumbnail'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MusicVisualHeaderRendererToJson(
  MusicVisualHeaderRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'title': instance.title,
  'thumbnail': instance.thumbnail,
  'menu': instance.menu,
  'subscriptionButton': instance.subscriptionButton,
  'foregroundThumbnail': instance.foregroundThumbnail,
};

MusicImmersiveHeaderRenderer _$MusicImmersiveHeaderRendererFromJson(
  Map<String, dynamic> json,
) => MusicImmersiveHeaderRenderer(
  trackingParams: json['trackingParams'] as String,
  title: Runs.fromJson(json['title'] as Map<String, dynamic>),
  subscriptionButton: json['subscriptionButton'] == null
      ? null
      : SubscribeButton.fromJson(
          json['subscriptionButton'] as Map<String, dynamic>,
        ),
  thumbnail: json['thumbnail'] == null
      ? null
      : ThumbnailRenderer.fromJson(json['thumbnail'] as Map<String, dynamic>),
  menu: json['menu'] == null
      ? null
      : Menu.fromJson(json['menu'] as Map<String, dynamic>),
  description: json['description'] == null
      ? null
      : Runs.fromJson(json['description'] as Map<String, dynamic>),
  moreButton: json['moreButton'] == null
      ? null
      : ToggleButton.fromJson(json['moreButton'] as Map<String, dynamic>),
  playButton: json['playButton'] as Map<String, dynamic>?,
  startRadioButton: json['startRadioButton'] as Map<String, dynamic>?,
  shareEndpoint: json['shareEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['shareEndpoint'] as Map<String, dynamic>,
        ),
  monthlyListenerCount: json['monthlyListenerCount'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$MusicImmersiveHeaderRendererToJson(
  MusicImmersiveHeaderRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'title': instance.title,
  'thumbnail': instance.thumbnail,
  'menu': instance.menu,
  'subscriptionButton': instance.subscriptionButton,
  'description': instance.description,
  'moreButton': instance.moreButton,
  'playButton': instance.playButton,
  'startRadioButton': instance.startRadioButton,
  'shareEndpoint': instance.shareEndpoint,
  'monthlyListenerCount': instance.monthlyListenerCount,
};
