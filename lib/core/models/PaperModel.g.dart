// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaperModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paper _$PaperFromJson(Map<String, dynamic> json) {
  return Paper(
    paperType: json['paperType'] as int,
    paperVariantType: json['paperVariantType'] as int,
    paperNumberType: json['paperNumberType'] as int,
    year: json['year'] as int,
    seasonType: json['seasonType'] as int,
    subjectId: json['subjectId'] as String,
    paperId: json['paperId'] as String,
    update: json['update'] as bool,
  )
    ..downloadUrl = json['downloadUrl'] as String
    ..filePath = json['filePath'] as String;
}

Map<String, dynamic> _$PaperToJson(Paper instance) => <String, dynamic>{
      'subjectId': instance.subjectId,
      'paperId': instance.paperId,
      'year': instance.year,
      'paperType': instance.paperType,
      'paperNumberType': instance.paperNumberType,
      'paperVariantType': instance.paperVariantType,
      'seasonType': instance.seasonType,
      'downloadUrl': instance.downloadUrl,
      'filePath': instance.filePath,
      'update': instance.update,
    };
