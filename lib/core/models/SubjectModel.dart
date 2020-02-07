import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';

part 'SubjectModel.g.dart';

@JsonSerializable()
class Subject {
  Subject(
      {@required this.name, @required this.subjectId, this.isFavorite = false, this.course});

  String name;

  bool isFavorite;

  @JsonKey(ignore: true)
  bool isVisible = true;

  String subjectId;

  Course course;

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
