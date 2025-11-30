import 'package:json_annotation/json_annotation.dart';

part 'continuations.g.dart';

@JsonSerializable()
class Continuations {
  final NextContinuationData? nextContinuationData;

  const Continuations({this.nextContinuationData});

  factory Continuations.fromJson(Map<String, dynamic> json) =>
      _$ContinuationsFromJson(json);

  Map<String, dynamic> toJson() => _$ContinuationsToJson(this);

  @override
  String toString() {
    return 'Continuations(nextContinuationData: $nextContinuationData)';
  }
}

@JsonSerializable()
class NextContinuationData {
  final String? continuation;
  final String? clickTrackingParams;

  const NextContinuationData({this.continuation, this.clickTrackingParams});

  factory NextContinuationData.fromJson(Map<String, dynamic> json) =>
      _$NextContinuationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NextContinuationDataToJson(this);

  @override
  String toString() {
    return 'NextContinuationData(continuation: $continuation, clickTrackingParams: $clickTrackingParams)';
  }
}
