// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_column_music_watch_next_results_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleColumnMusicWatchNextResults _$SingleColumnMusicWatchNextResultsFromJson(
  Map<String, dynamic> json,
) => SingleColumnMusicWatchNextResults(
  singleColumnMusicWatchNextResultsRenderer:
      SingleColumnMusicWatchNextResultsRenderer.fromJson(
        json['singleColumnMusicWatchNextResultsRenderer']
            as Map<String, dynamic>,
      ),
);

Map<String, dynamic> _$SingleColumnMusicWatchNextResultsToJson(
  SingleColumnMusicWatchNextResults instance,
) => <String, dynamic>{
  'singleColumnMusicWatchNextResultsRenderer':
      instance.singleColumnMusicWatchNextResultsRenderer,
};

SingleColumnMusicWatchNextResultsRenderer
_$SingleColumnMusicWatchNextResultsRendererFromJson(
  Map<String, dynamic> json,
) => SingleColumnMusicWatchNextResultsRenderer(
  tabbedRenderer: json['tabbedRenderer'] == null
      ? null
      : TabbedRenderer.fromJson(json['tabbedRenderer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SingleColumnMusicWatchNextResultsRendererToJson(
  SingleColumnMusicWatchNextResultsRenderer instance,
) => <String, dynamic>{'tabbedRenderer': instance.tabbedRenderer};
