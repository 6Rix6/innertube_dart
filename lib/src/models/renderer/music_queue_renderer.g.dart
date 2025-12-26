// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_queue_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicQueueRenderer _$MusicQueueRendererFromJson(Map<String, dynamic> json) =>
    MusicQueueRenderer(
      content: json['content'] == null
          ? null
          : PlaylistPanel.fromJson(json['content'] as Map<String, dynamic>),
      header: json['header'] == null
          ? null
          : MusicQueueHeader.fromJson(json['header'] as Map<String, dynamic>),
      hack: json['hack'] as bool? ?? true,
      subHeaderChipCloud: json['subHeaderChipCloud'] == null
          ? null
          : ChipCloud.fromJson(
              json['subHeaderChipCloud'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MusicQueueRendererToJson(MusicQueueRenderer instance) =>
    <String, dynamic>{
      'content': instance.content,
      'header': instance.header,
      'hack': instance.hack,
      'subHeaderChipCloud': instance.subHeaderChipCloud,
    };

MusicQueueHeader _$MusicQueueHeaderFromJson(Map<String, dynamic> json) =>
    MusicQueueHeader(
      musicQueueHeaderRenderer: json['musicQueueHeaderRenderer'] == null
          ? null
          : MusicQueueHeaderRenderer.fromJson(
              json['musicQueueHeaderRenderer'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MusicQueueHeaderToJson(MusicQueueHeader instance) =>
    <String, dynamic>{
      'musicQueueHeaderRenderer': instance.musicQueueHeaderRenderer,
    };

MusicQueueHeaderRenderer _$MusicQueueHeaderRendererFromJson(
  Map<String, dynamic> json,
) => MusicQueueHeaderRenderer(
  title: json['title'] == null
      ? null
      : Runs.fromJson(json['title'] as Map<String, dynamic>),
  subtitle: json['subtitle'] == null
      ? null
      : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
  buttons: (json['buttons'] as List<dynamic>?)
      ?.map((e) => ChipCloudChip.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MusicQueueHeaderRendererToJson(
  MusicQueueHeaderRenderer instance,
) => <String, dynamic>{
  'title': instance.title,
  'subtitle': instance.subtitle,
  'buttons': instance.buttons,
};
