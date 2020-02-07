import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:past_papers/core/services/Helper.dart';

part 'PaperModel.g.dart';

@JsonSerializable()
class Paper {
  Paper(
      {@required this.paperType,
      @required this.paperVariantType,
      @required this.paperNumberType,
      @required this.year,
      @required this.seasonType,
      @required this.subjectId,
      @required this.paperId,
      this.filePath,
      this.downloadUrl,
      this.update = false}) {
    title = Helper.getPaperTitle(paperType);
    subtitle = Helper.getsubtitle(paperNumberType, paperVariantType);
    seasonIcon = Helper.getSeasonIcon(seasonType);

    seasonName =
        seasonType == 1 ? 'Summer' : seasonType == 2 ? 'March' : 'Winter';
  }

  factory Paper.fromJson(Map<String, dynamic> json) {
    var paper = _$PaperFromJson(json);
    paper.title = Helper.getPaperTitle(paper.paperType);
    paper.subtitle =
        Helper.getsubtitle(paper.paperNumberType, paper.paperVariantType);
    paper.seasonIcon = Helper.getSeasonIcon(paper.seasonType);

    paper.seasonName = paper.seasonType == 1
        ? 'Summer'
        : paper.seasonType == 2 ? 'March' : 'Winter';

    return paper;
  }

  Map<String, dynamic> toJson() => _$PaperToJson(this);

  String subjectId;

  String paperId;

  int year;

  int paperType;

  int paperNumberType;

  int paperVariantType;

  int seasonType;

  bool update;

  @JsonKey(ignore: true)
  //to searh easily with name
  String seasonName;

  String downloadUrl;

  String filePath;

  @JsonKey(ignore: true)
  bool isVisible = true;

  @JsonKey(ignore: true)
  bool isFilterVisible = true;

  @JsonKey(ignore: true)
  bool isSelected = false;

  @JsonKey(ignore: true)
  String title;

  @JsonKey(ignore: true)
  String subtitle;

  @JsonKey(ignore: true)
  IconData seasonIcon;
}
