// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_playlist_shelf_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicPlaylistShelfRenderer _$MusicPlaylistShelfRendererFromJson(
  Map<String, dynamic> json,
) => MusicPlaylistShelfRenderer(
  trackingParams: json['trackingParams'] as String,
  playlistId: json['playlistId'] as String,
  targetId: json['targetId'] as String?,
  collapsedItemCount: (json['collapsedItemCount'] as num?)?.toInt(),
  contents: (json['contents'] as List<dynamic>)
      .map(
        (e) => MusicPlaylistShelfRendererContent.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$MusicPlaylistShelfRendererToJson(
  MusicPlaylistShelfRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'playlistId': instance.playlistId,
  'targetId': instance.targetId,
  'collapsedItemCount': instance.collapsedItemCount,
  'contents': instance.contents,
};

MusicPlaylistShelfRendererContent _$MusicPlaylistShelfRendererContentFromJson(
  Map<String, dynamic> json,
) => MusicPlaylistShelfRendererContent(
  musicResponsiveListItemRenderer:
      json['musicResponsiveListItemRenderer'] == null
      ? null
      : MusicResponsiveListItemRenderer.fromJson(
          json['musicResponsiveListItemRenderer'] as Map<String, dynamic>,
        ),
  continuationItemRenderer:
      json['continuationItemRenderer'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$MusicPlaylistShelfRendererContentToJson(
  MusicPlaylistShelfRendererContent instance,
) => <String, dynamic>{
  'musicResponsiveListItemRenderer': instance.musicResponsiveListItemRenderer,
  'continuationItemRenderer': instance.continuationItemRenderer,
};
