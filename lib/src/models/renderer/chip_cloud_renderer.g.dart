// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chip_cloud_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChipCloud _$ChipCloudFromJson(Map<String, dynamic> json) => ChipCloud(
  chipCloudRenderer: ChipCloudChipRenderer.fromJson(
    json['chipCloudRenderer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ChipCloudToJson(ChipCloud instance) => <String, dynamic>{
  'chipCloudRenderer': instance.chipCloudRenderer,
};

ChipCloudRenderer _$ChipCloudRendererFromJson(Map<String, dynamic> json) =>
    ChipCloudRenderer(
      chips: (json['chips'] as List<dynamic>?)
          ?.map((e) => ChipCloudChip.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChipCloudRendererToJson(ChipCloudRenderer instance) =>
    <String, dynamic>{'chips': instance.chips};

ChipCloudChip _$ChipCloudChipFromJson(Map<String, dynamic> json) =>
    ChipCloudChip(
      chipCloudChipRenderer: ChipCloudChipRenderer.fromJson(
        json['chipCloudChipRenderer'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ChipCloudChipToJson(ChipCloudChip instance) =>
    <String, dynamic>{'chipCloudChipRenderer': instance.chipCloudChipRenderer};

ChipCloudChipRenderer _$ChipCloudChipRendererFromJson(
  Map<String, dynamic> json,
) => ChipCloudChipRenderer(
  text: json['text'] == null
      ? null
      : Runs.fromJson(json['text'] as Map<String, dynamic>),
  navigationEndpoint: json['navigationEndpoint'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['navigationEndpoint'] as Map<String, dynamic>,
        ),
  onDeselectedCommand: json['onDeselectedCommand'] == null
      ? null
      : NavigationEndpoint.fromJson(
          json['onDeselectedCommand'] as Map<String, dynamic>,
        ),
  selected: json['selected'] as bool? ?? false,
);

Map<String, dynamic> _$ChipCloudChipRendererToJson(
  ChipCloudChipRenderer instance,
) => <String, dynamic>{
  'text': instance.text,
  'navigationEndpoint': instance.navigationEndpoint,
  'onDeselectedCommand': instance.onDeselectedCommand,
  'selected': instance.selected,
};
