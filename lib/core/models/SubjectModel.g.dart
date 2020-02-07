// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    name: json['name'] as String,
    subjectId: json['subjectId'] as String,
    isFavorite: json['isFavorite'] as bool,
    course: _$enumDecodeNullable(_$CourseEnumMap, json['course']),
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'name': instance.name,
      'isFavorite': instance.isFavorite,
      'subjectId': instance.subjectId,
      'course': _$CourseEnumMap[instance.course],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CourseEnumMap = {
  Course.OLevel: 'OLevel',
  Course.ALevel: 'ALevel',
};
