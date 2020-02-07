// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'McqModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mcq _$McqFromJson(Map<String, dynamic> json) {
  return Mcq(
    paperId: json['paperId'] as String,
    mcqAns: (json['mcqAns'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$McqToJson(Mcq instance) => <String, dynamic>{
      'paperId': instance.paperId,
      'mcqAns': instance.mcqAns,
    };
