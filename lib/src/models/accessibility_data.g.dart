// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessibility_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accessibility _$AccessibilityFromJson(Map<String, dynamic> json) =>
    Accessibility(
      accessibilityData: json['accessibilityData'] == null
          ? null
          : AccessibilityData.fromJson(
              json['accessibilityData'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AccessibilityToJson(Accessibility instance) =>
    <String, dynamic>{'accessibilityData': instance.accessibilityData};

AccessibilityData _$AccessibilityDataFromJson(Map<String, dynamic> json) =>
    AccessibilityData(label: json['label'] as String?);

Map<String, dynamic> _$AccessibilityDataToJson(AccessibilityData instance) =>
    <String, dynamic>{'label': instance.label};
