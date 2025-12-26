// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_renderers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleButton _$ToggleButtonFromJson(Map<String, dynamic> json) => ToggleButton(
  toggleButtonRenderer: ToggleButtonRenderer.fromJson(
    json['toggleButtonRenderer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ToggleButtonToJson(ToggleButton instance) =>
    <String, dynamic>{'toggleButtonRenderer': instance.toggleButtonRenderer};

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
  defaultServiceEndpoint: NavigationEndpoint.fromJson(
    json['defaultServiceEndpoint'] as Map<String, dynamic>,
  ),
  toggledServiceEndpoint: NavigationEndpoint.fromJson(
    json['toggledServiceEndpoint'] as Map<String, dynamic>,
  ),
  accessibilityData: json['accessibilityData'] == null
      ? null
      : Accessibility.fromJson(
          json['accessibilityData'] as Map<String, dynamic>,
        ),
  toggledAccessibilityData: json['toggledAccessibilityData'] == null
      ? null
      : Accessibility.fromJson(
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
      : Accessibility.fromJson(
          json['accessibilityPlayData'] as Map<String, dynamic>,
        ),
  accessibilityPauseData: json['accessibilityPauseData'] == null
      ? null
      : Accessibility.fromJson(
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

SubscribeButton _$SubscribeButtonFromJson(Map<String, dynamic> json) =>
    SubscribeButton(
      subscribeButtonRenderer: SubscribeButtonRenderer.fromJson(
        json['subscribeButtonRenderer'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SubscribeButtonToJson(SubscribeButton instance) =>
    <String, dynamic>{
      'subscribeButtonRenderer': instance.subscribeButtonRenderer,
    };

SubscribeButtonRenderer _$SubscribeButtonRendererFromJson(
  Map<String, dynamic> json,
) => SubscribeButtonRenderer(
  channelId: json['channelId'] as String,
  trackingParams: json['trackingParams'] as String,
  subscribed: json['subscribed'] as bool,
  enabled: json['enabled'] as bool,
  subscriberCountText: json['subscriberCountText'] == null
      ? null
      : Runs.fromJson(json['subscriberCountText'] as Map<String, dynamic>),
  subscriberCountWithUnsubscribeText:
      json['subscriberCountWithUnsubscribeText'] == null
      ? null
      : Runs.fromJson(
          json['subscriberCountWithUnsubscribeText'] as Map<String, dynamic>,
        ),
  subscribedButtonText: json['subscribedButtonText'] == null
      ? null
      : Runs.fromJson(json['subscribedButtonText'] as Map<String, dynamic>),
  unsubscribedButtonText: json['unsubscribedButtonText'] == null
      ? null
      : Runs.fromJson(json['unsubscribedButtonText'] as Map<String, dynamic>),
  longSubscriberCountText: json['longSubscriberCountText'] == null
      ? null
      : Runs.fromJson(json['longSubscriberCountText'] as Map<String, dynamic>),
  shortSubscriberCountText: json['shortSubscriberCountText'] == null
      ? null
      : Runs.fromJson(json['shortSubscriberCountText'] as Map<String, dynamic>),
  serviceEndpoints: (json['serviceEndpoints'] as List<dynamic>?)
      ?.map((e) => NavigationEndpoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  subscribeAccessibility: json['subscribeAccessibility'] == null
      ? null
      : Accessibility.fromJson(
          json['subscribeAccessibility'] as Map<String, dynamic>,
        ),
  unsubscribeAccessibility: json['unsubscribeAccessibility'] == null
      ? null
      : Accessibility.fromJson(
          json['unsubscribeAccessibility'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SubscribeButtonRendererToJson(
  SubscribeButtonRenderer instance,
) => <String, dynamic>{
  'channelId': instance.channelId,
  'trackingParams': instance.trackingParams,
  'subscribed': instance.subscribed,
  'enabled': instance.enabled,
  'subscriberCountText': instance.subscriberCountText,
  'subscriberCountWithUnsubscribeText':
      instance.subscriberCountWithUnsubscribeText,
  'subscribedButtonText': instance.subscribedButtonText,
  'unsubscribedButtonText': instance.unsubscribedButtonText,
  'longSubscriberCountText': instance.longSubscriberCountText,
  'shortSubscriberCountText': instance.shortSubscriberCountText,
  'serviceEndpoints': instance.serviceEndpoints,
  'subscribeAccessibility': instance.subscribeAccessibility,
  'unsubscribeAccessibility': instance.unsubscribeAccessibility,
};

ButtonRenderer _$ButtonRendererFromJson(Map<String, dynamic> json) =>
    ButtonRenderer(
      style: json['style'] as String?,
      isDisabled: json['isDisabled'] as bool?,
      text: json['text'] == null
          ? null
          : Runs.fromJson(json['text'] as Map<String, dynamic>),
      navigationEndpoint: json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>,
            ),
      command: json['command'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['command'] as Map<String, dynamic>,
            ),
      trackingParams: json['trackingParams'] as String?,
      icon: json['icon'] == null
          ? null
          : Icon.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ButtonRendererToJson(ButtonRenderer instance) =>
    <String, dynamic>{
      'style': instance.style,
      'isDisabled': instance.isDisabled,
      'text': instance.text,
      'navigationEndpoint': instance.navigationEndpoint,
      'command': instance.command,
      'trackingParams': instance.trackingParams,
      'icon': instance.icon,
    };

Button _$ButtonFromJson(Map<String, dynamic> json) => Button(
  buttonRenderer: ButtonRenderer.fromJson(
    json['buttonRenderer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
  'buttonRenderer': instance.buttonRenderer,
};
