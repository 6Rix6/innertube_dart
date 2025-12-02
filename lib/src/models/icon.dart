import 'package:json_annotation/json_annotation.dart';

part 'icon.g.dart';

@JsonSerializable()
class Icon {
  final String iconType;

  const Icon({required this.iconType});

  factory Icon.fromJson(Map<String, dynamic> json) => _$IconFromJson(json);
  Map<String, dynamic> toJson() => _$IconToJson(this);
}
