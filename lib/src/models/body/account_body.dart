import 'package:json_annotation/json_annotation.dart';
import 'package:innertube_dart/src/models/context.dart';

part 'account_body.g.dart';

@JsonSerializable()
class AccountBody {
  final Context context;
  final String deviceTheme;
  final String userInterfaceTheme;

  AccountBody({
    required this.context,
    this.deviceTheme = 'DEVICE_THEME_SELECTED',
    this.userInterfaceTheme = 'USER_INTERFACE_THEME_LIGHT',
  });

  factory AccountBody.fromJson(Map<String, dynamic> json) =>
      _$AccountBodyFromJson(json);
  Map<String, dynamic> toJson() => _$AccountBodyToJson(this);
}
