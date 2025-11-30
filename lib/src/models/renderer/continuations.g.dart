// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continuations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Continuations _$ContinuationsFromJson(Map<String, dynamic> json) =>
    Continuations(
      nextContinuationData: json['nextContinuationData'] == null
          ? null
          : NextContinuationData.fromJson(
              json['nextContinuationData'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ContinuationsToJson(Continuations instance) =>
    <String, dynamic>{'nextContinuationData': instance.nextContinuationData};

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
