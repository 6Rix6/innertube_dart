import 'package:json_annotation/json_annotation.dart';

import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/style.dart';

part 'message_renderer.g.dart';

@JsonSerializable()
class MessageRenderer {
  final String? trackingParams;
  final Runs? text;
  final Style? style;

  const MessageRenderer({this.trackingParams, this.text, this.style});

  factory MessageRenderer.fromJson(Map<String, dynamic> json) =>
      _$MessageRendererFromJson(json);

  Map<String, dynamic> toJson() => _$MessageRendererToJson(this);
}
