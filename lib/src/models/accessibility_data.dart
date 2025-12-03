import 'package:json_annotation/json_annotation.dart';

part 'accessibility_data.g.dart';

@JsonSerializable()
class Accessibility {
  final AccessibilityData? accessibilityData;

  const Accessibility({this.accessibilityData});

  factory Accessibility.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityFromJson(json);
  Map<String, dynamic> toJson() => _$AccessibilityToJson(this);
}

@JsonSerializable()
class AccessibilityData {
  final String? label;

  const AccessibilityData({this.label});

  factory AccessibilityData.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityDataFromJson(json);
  Map<String, dynamic> toJson() => _$AccessibilityDataToJson(this);
}
