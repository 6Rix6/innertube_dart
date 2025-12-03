// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_renderers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleButtonRenderer _$ToggleButtonRendererFromJson(
  Map<String, dynamic> json,
) => ToggleButtonRenderer(
  trackingParams: json['trackingParams'] as String,
  isToggled: json['isToggled'] as bool?,
  isDisabled: json['isDisabled'] as bool?,
  defaultIcon: json['defaultIcon'] == null
      ? null
      : Icon.fromJson(json['defaultIcon'] as Map<String, dynamic>),
  toggledIcon: json['toggledIcon'] == null
      ? null
      : Icon.fromJson(json['toggledIcon'] as Map<String, dynamic>),
  defaultServiceEndpoint: json['defaultServiceEndpoint'],
  toggledServiceEndpoint: json['toggledServiceEndpoint'],
  accessibilityData: json['accessibilityData'] == null
      ? null
      : AccessibilityData.fromJson(
          json['accessibilityData'] as Map<String, dynamic>,
        ),
  toggledAccessibilityData: json['toggledAccessibilityData'] == null
      ? null
      : AccessibilityData.fromJson(
          json['toggledAccessibilityData'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ToggleButtonRendererToJson(
  ToggleButtonRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'isToggled': instance.isToggled,
  'isDisabled': instance.isDisabled,
  'defaultIcon': instance.defaultIcon,
  'toggledIcon': instance.toggledIcon,
  'defaultServiceEndpoint': instance.defaultServiceEndpoint,
  'toggledServiceEndpoint': instance.toggledServiceEndpoint,
  'accessibilityData': instance.accessibilityData,
  'toggledAccessibilityData': instance.toggledAccessibilityData,
};

MusicPlayButtonRenderer _$MusicPlayButtonRendererFromJson(
  Map<String, dynamic> json,
) => MusicPlayButtonRenderer(
  trackingParams: json['trackingParams'] as String,
  playIcon: json['playIcon'] == null
      ? null
      : Icon.fromJson(json['playIcon'] as Map<String, dynamic>),
  pauseIcon: json['pauseIcon'] == null
      ? null
      : Icon.fromJson(json['pauseIcon'] as Map<String, dynamic>),
  playIngIcon: json['playIngIcon'] == null
      ? null
      : Icon.fromJson(json['playIngIcon'] as Map<String, dynamic>),
  playNavigationEndpoint: json['playNavigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['playNavigationEndpoint'] as Map<String, dynamic>,
        ),
  accessibilityPlayData: json['accessibilityPlayData'] == null
      ? null
      : AccessibilityData.fromJson(
          json['accessibilityPlayData'] as Map<String, dynamic>,
        ),
  accessibilityPauseData: json['accessibilityPauseData'] == null
      ? null
      : AccessibilityData.fromJson(
          json['accessibilityPauseData'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MusicPlayButtonRendererToJson(
  MusicPlayButtonRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'playIcon': instance.playIcon,
  'pauseIcon': instance.pauseIcon,
  'playIngIcon': instance.playIngIcon,
  'playNavigationEndpoint': instance.playNavigationEndpoint,
  'accessibilityPlayData': instance.accessibilityPlayData,
  'accessibilityPauseData': instance.accessibilityPauseData,
};
