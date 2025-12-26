import 'package:json_annotation/json_annotation.dart';

part 'style.g.dart';

@JsonSerializable()
class Style {
  final String styleType;

  const Style({required this.styleType});

  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);

  Map<String, dynamic> toJson() => _$StyleToJson(this);
}
