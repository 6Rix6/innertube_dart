import 'package:json_annotation/json_annotation.dart';
import '../context.dart';

part 'next_body.g.dart';

@JsonSerializable()
class NextBody {
  final Context context;
  final String? videoId;
  final String? playlistId;
  final String? playlistSetVideoId;
  final int? index;
  final String? params;
  final String? continuation;

  NextBody({
    required this.context,
    this.videoId,
    this.playlistId,
    this.playlistSetVideoId,
    this.index,
    this.params,
    this.continuation,
  });

  factory NextBody.fromJson(Map<String, dynamic> json) =>
      _$NextBodyFromJson(json);

  Map<String, dynamic> toJson() => _$NextBodyToJson(this);
}
