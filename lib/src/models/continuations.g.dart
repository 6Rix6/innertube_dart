// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continuations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Continuation _$ContinuationFromJson(Map<String, dynamic> json) => Continuation(
  nextContinuationData: json['nextContinuationData'] == null
      ? null
      : NextContinuationData.fromJson(
          json['nextContinuationData'] as Map<String, dynamic>,
        ),
  nextRadioContinuationData: json['nextRadioContinuationData'] == null
      ? null
      : NextContinuationData.fromJson(
          json['nextRadioContinuationData'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ContinuationToJson(Continuation instance) =>
    <String, dynamic>{
      'nextContinuationData': instance.nextContinuationData,
      'nextRadioContinuationData': instance.nextRadioContinuationData,
    };

NextContinuationData _$NextContinuationDataFromJson(
  Map<String, dynamic> json,
) => NextContinuationData(
  continuation: json['continuation'] as String?,
  clickTrackingParams: json['clickTrackingParams'] as String?,
);

Map<String, dynamic> _$NextContinuationDataToJson(
  NextContinuationData instance,
) => <String, dynamic>{
  'continuation': instance.continuation,
  'clickTrackingParams': instance.clickTrackingParams,
};
