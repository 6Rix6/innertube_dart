// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) => Command(
  trackingParams: json['trackingParams'] as String,
  addToToastAction: json['addToToastAction'] == null
      ? null
      : AddToToastAction.fromJson(
          json['addToToastAction'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'addToToastAction': instance.addToToastAction,
};

AddToToastAction _$AddToToastActionFromJson(Map<String, dynamic> json) =>
    AddToToastAction(item: json['item']);

Map<String, dynamic> _$AddToToastActionToJson(AddToToastAction instance) =>
    <String, dynamic>{'item': instance.item};

ToastActionItem _$ToastActionItemFromJson(Map<String, dynamic> json) =>
    ToastActionItem(notificationTextRenderer: json['notificationTextRenderer']);

Map<String, dynamic> _$ToastActionItemToJson(ToastActionItem instance) =>
    <String, dynamic>{
      'notificationTextRenderer': instance.notificationTextRenderer,
    };

NotificationTextRenderer _$NotificationTextRendererFromJson(
  Map<String, dynamic> json,
) => NotificationTextRenderer(
  trackingParams: json['trackingParams'] as String,
  successResponseText: Runs.fromJson(
    json['successResponseText'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$NotificationTextRendererToJson(
  NotificationTextRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'successResponseText': instance.successResponseText,
};
