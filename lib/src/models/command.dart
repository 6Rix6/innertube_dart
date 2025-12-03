import 'package:innertube_dart/src/models/runs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'command.g.dart';

@JsonSerializable()
class Command {
  final String trackingParams;
  final AddToToastAction? addToToastAction;

  const Command({required this.trackingParams, this.addToToastAction});

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);
  Map<String, dynamic> toJson() => _$CommandToJson(this);
}

@JsonSerializable()
class AddToToastAction {
  final dynamic item;

  const AddToToastAction({this.item});

  factory AddToToastAction.fromJson(Map<String, dynamic> json) =>
      _$AddToToastActionFromJson(json);
  Map<String, dynamic> toJson() => _$AddToToastActionToJson(this);
}

@JsonSerializable()
class ToastActionItem {
  final dynamic notificationTextRenderer;

  const ToastActionItem({this.notificationTextRenderer});

  factory ToastActionItem.fromJson(Map<String, dynamic> json) =>
      _$ToastActionItemFromJson(json);
  Map<String, dynamic> toJson() => _$ToastActionItemToJson(this);
}

@JsonSerializable()
class NotificationTextRenderer {
  final String trackingParams;
  final Runs successResponseText;

  const NotificationTextRenderer({
    required this.trackingParams,
    required this.successResponseText,
  });

  factory NotificationTextRenderer.fromJson(Map<String, dynamic> json) =>
      _$NotificationTextRendererFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationTextRendererToJson(this);
}
