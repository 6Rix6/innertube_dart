// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_renderers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuRenderer _$MenuRendererFromJson(Map<String, dynamic> json) => MenuRenderer(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => MenuRendererItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  accessibility: json['accessibility'] == null
      ? null
      : AccessibilityData.fromJson(
          json['accessibility'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MenuRendererToJson(MenuRenderer instance) =>
    <String, dynamic>{
      'items': instance.items,
      'accessibility': instance.accessibility,
    };

MenuRendererItem _$MenuRendererItemFromJson(Map<String, dynamic> json) =>
    MenuRendererItem(
      menuNavigationItemRenderer: json['menuNavigationItemRenderer'] == null
          ? null
          : MenuNavigationItemRenderer.fromJson(
              json['menuNavigationItemRenderer'] as Map<String, dynamic>,
            ),
      menuServiceItemRenderer: json['menuServiceItemRenderer'] == null
          ? null
          : MenuServiceItemRenderer.fromJson(
              json['menuServiceItemRenderer'] as Map<String, dynamic>,
            ),
      toggleMenuServiceItemRenderer:
          json['toggleMenuServiceItemRenderer'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MenuRendererItemToJson(MenuRendererItem instance) =>
    <String, dynamic>{
      'menuNavigationItemRenderer': instance.menuNavigationItemRenderer,
      'menuServiceItemRenderer': instance.menuServiceItemRenderer,
      'toggleMenuServiceItemRenderer': instance.toggleMenuServiceItemRenderer,
    };

MenuNavigationItemRenderer _$MenuNavigationItemRendererFromJson(
  Map<String, dynamic> json,
) => MenuNavigationItemRenderer(
  trackingParams: json['trackingParams'] as String,
  text: Runs.fromJson(json['text'] as Map<String, dynamic>),
  icon: Icon.fromJson(json['icon'] as Map<String, dynamic>),
  navigationEndpoint: json['navigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['navigationEndpoint'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MenuNavigationItemRendererToJson(
  MenuNavigationItemRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'text': instance.text,
  'icon': instance.icon,
  'navigationEndpoint': instance.navigationEndpoint,
};

MenuServiceItemRenderer _$MenuServiceItemRendererFromJson(
  Map<String, dynamic> json,
) => MenuServiceItemRenderer(
  trackingParams: json['trackingParams'] as String,
  text: Runs.fromJson(json['text'] as Map<String, dynamic>),
  icon: Icon.fromJson(json['icon'] as Map<String, dynamic>),
  serviceEndpoint: json['serviceEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['serviceEndpoint'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MenuServiceItemRendererToJson(
  MenuServiceItemRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'text': instance.text,
  'icon': instance.icon,
  'serviceEndpoint': instance.serviceEndpoint,
};
