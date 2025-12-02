// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBody _$AccountBodyFromJson(Map<String, dynamic> json) => AccountBody(
  context: Context.fromJson(json['context'] as Map<String, dynamic>),
  deviceTheme: json['deviceTheme'] as String? ?? 'DEVICE_THEME_SELECTED',
  userInterfaceTheme:
      json['userInterfaceTheme'] as String? ?? 'USER_INTERFACE_THEME_LIGHT',
);

Map<String, dynamic> _$AccountBodyToJson(AccountBody instance) =>
    <String, dynamic>{
      'context': instance.context,
      'deviceTheme': instance.deviceTheme,
      'userInterfaceTheme': instance.userInterfaceTheme,
    };
