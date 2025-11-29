import 'package:json_annotation/json_annotation.dart';
import '../context.dart';

part 'search_body.g.dart';

/// Request body for search API
@JsonSerializable()
class SearchBody {
  final Context context;
  final String? query;
  final String? params;

  const SearchBody({required this.context, this.query, this.params});

  factory SearchBody.fromJson(Map<String, dynamic> json) =>
      _$SearchBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SearchBodyToJson(this);
}
