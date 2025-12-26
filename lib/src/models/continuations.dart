import 'package:json_annotation/json_annotation.dart';

part 'continuations.g.dart';

@JsonSerializable()
class Continuation {
  final NextContinuationData? nextContinuationData;
  final NextContinuationData? nextRadioContinuationData;

  const Continuation({
    this.nextContinuationData,
    this.nextRadioContinuationData,
  });

  factory Continuation.fromJson(Map<String, dynamic> json) =>
      _$ContinuationFromJson(json);

  Map<String, dynamic> toJson() => _$ContinuationToJson(this);

  @override
  String toString() {
    return 'Continuation(nextContinuationData: $nextContinuationData)';
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
