import 'package:json_annotation/json_annotation.dart';
import '../context.dart';

part 'browse_body.g.dart';

/// Request body for browse API
@JsonSerializable()
class BrowseBody {
  final Context context;
  final String? browseId;
  final String? params;
  final String? continuation;

  const BrowseBody({
    required this.context,
    this.browseId,
    this.params,
    this.continuation,
  });

  factory BrowseBody.fromJson(Map<String, dynamic> json) =>
      _$BrowseBodyFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseBodyToJson(this);
}
