import 'package:innertube_dart/src/models/accessibility_data.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/icon.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'button_renderers.g.dart';

@JsonSerializable()
class ToggleButton {
  final ToggleButtonRenderer toggleButtonRenderer;

  const ToggleButton({required this.toggleButtonRenderer});

  factory ToggleButton.fromJson(Map<String, dynamic> json) =>
      _$ToggleButtonFromJson(json);
  Map<String, dynamic> toJson() => _$ToggleButtonToJson(this);
}

@JsonSerializable()
class ToggleButtonRenderer {
  final String trackingParams;
  final bool? isToggled;
  final bool? isDisabled;
  final Icon? defaultIcon;
  final Icon? toggledIcon;
  // TODO: create model
  final dynamic defaultServiceEndpoint;
  final dynamic toggledServiceEndpoint;
  final Accessibility? accessibilityData;
  final Accessibility? toggledAccessibilityData;

  const ToggleButtonRenderer({
    required this.trackingParams,
    this.isToggled,
    this.isDisabled,
    this.defaultIcon,
    this.toggledIcon,
    required this.defaultServiceEndpoint,
    required this.toggledServiceEndpoint,
    this.accessibilityData,
    this.toggledAccessibilityData,
  });

  factory ToggleButtonRenderer.fromJson(Map<String, dynamic> json) =>
      _$ToggleButtonRendererFromJson(json);
  Map<String, dynamic> toJson() => _$ToggleButtonRendererToJson(this);
}

@JsonSerializable()
class MusicPlayButtonRenderer {
  final String trackingParams;
  final Icon? playIcon;
  final Icon? pauseIcon;
  final Icon? playIngIcon;
  final NavigationEndpoint? playNavigationEndpoint;
  final Accessibility? accessibilityPlayData;
  final Accessibility? accessibilityPauseData;

  const MusicPlayButtonRenderer({
    required this.trackingParams,
    this.playIcon,
    this.pauseIcon,
    this.playIngIcon,
    this.playNavigationEndpoint,
    this.accessibilityPlayData,
    this.accessibilityPauseData,
  });

  factory MusicPlayButtonRenderer.fromJson(Map<String, dynamic> json) =>
      _$MusicPlayButtonRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicPlayButtonRendererToJson(this);
}

@JsonSerializable()
class SubscribeButton {
  final SubscribeButtonRenderer subscribeButtonRenderer;

  const SubscribeButton({required this.subscribeButtonRenderer});

  factory SubscribeButton.fromJson(Map<String, dynamic> json) =>
      _$SubscribeButtonFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribeButtonToJson(this);
}

@JsonSerializable()
class SubscribeButtonRenderer {
  final String channelId;
  final String trackingParams;
  final bool subscribed;
  final bool enabled;
  final Runs? subscriberCountText;
  final Runs? subscriberCountWithUnsubscribeText;
  final Runs? subscribedButtonText;
  final Runs? unsubscribedButtonText;
  final Runs? longSubscriberCountText;
  final Runs? shortSubscriberCountText;
  final List<NavigationEndpoint>? serviceEndpoints;
  final Accessibility? subscribeAccessibility;
  final Accessibility? unsubscribeAccessibility;

  const SubscribeButtonRenderer({
    required this.channelId,
    required this.trackingParams,
    required this.subscribed,
    required this.enabled,
    this.subscriberCountText,
    this.subscriberCountWithUnsubscribeText,
    this.subscribedButtonText,
    this.unsubscribedButtonText,
    this.longSubscriberCountText,
    this.shortSubscriberCountText,
    this.serviceEndpoints,
    this.subscribeAccessibility,
    this.unsubscribeAccessibility,
  });

  factory SubscribeButtonRenderer.fromJson(Map<String, dynamic> json) =>
      _$SubscribeButtonRendererFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribeButtonRendererToJson(this);
}
