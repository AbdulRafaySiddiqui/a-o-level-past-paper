import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'McqModel.g.dart';

@JsonSerializable()
class Mcq {
  Mcq({@required this.paperId, @required this.mcqAns});
  String paperId;
  List<int> mcqAns;

  factory Mcq.fromJson(Map<String, dynamic> json) => _$McqFromJson(json);
  Map<String, dynamic> toJson() => _$McqToJson(this);
}
