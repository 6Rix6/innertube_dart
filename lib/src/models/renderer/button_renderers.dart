import 'package:innertube_dart/src/models/accessibility_data.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/icon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'button_renderers.g.dart';

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
  final AccessibilityData? accessibilityData;
  final AccessibilityData? toggledAccessibilityData;

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
  final AccessibilityData? accessibilityPlayData;
  final AccessibilityData? accessibilityPauseData;

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
