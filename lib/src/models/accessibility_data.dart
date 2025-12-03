import 'package:json_annotation/json_annotation.dart';

part 'accessibility_data.g.dart';

@JsonSerializable()
class AccessibilityData {
  final String? label;

  const AccessibilityData({this.label});

  factory AccessibilityData.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityDataFromJson(json);
  Map<String, dynamic> toJson() => _$AccessibilityDataToJson(this);
}
