import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/enums/PaperNumberType.dart';
import 'package:past_papers/core/enums/PaperType.dart';
import 'package:past_papers/core/enums/PaperVariantType.dart';
import 'package:past_papers/core/enums/SeasonType.dart';

class Paper extends BaseViewModel{
  Paper(
      {@required this.paperType,
      @required this.paperVariantType,
      @required this.paperNumberType,
      @required this.year,
      @required this.seasonType,
      @required this.subject}) {
    //set title, subtitle & seasonicon
    setPaperTitle();
    setsubtitle();
    setSeasonIcon();
  }

  String subject;
  int year;
  PaperType paperType;
  PaperNumberType paperNumberType;
  PaperVariantType paperVariantType;
  SeasonType seasonType;
  bool isVisible = true;
  bool isFilterVisible = true;
  bool isSelected = false;

  String title;
  String subtitle;
  String season;
  IconData seasonIcon;

  setPaperTitle() {
    switch (paperType) {
      case PaperType.QuestionPaper:
        title = 'Question Paper';
        break;
      case PaperType.All:
        title = 'All';
        break;
      case PaperType.MarkingScheme:
        title = 'Marking Scheme';
        break;
      case PaperType.ExaminorReport:
        title = 'Examinor Report';
        break;
      case PaperType.GradeThreshold:
        title = 'Grade Threshold';
        break;
    }
  }

  setsubtitle() {
    String _paperNumber;
    String _paperVariant;

    switch (paperNumberType) {
      case PaperNumberType.All:
        _paperNumber = 'All Papers';
        break;
      case PaperNumberType.One:
        _paperNumber = 'Paper 1';
        break;
      case PaperNumberType.Two:
        _paperNumber = 'Paper 2';
        break;
      case PaperNumberType.Three:
        _paperNumber = 'Paper 3';
        break;
      case PaperNumberType.Four:
        _paperNumber = 'Paper 4';
        break;
    }

    switch (paperVariantType) {
      case PaperVariantType.All:
        _paperVariant = 'All Variants';
        break;
      case PaperVariantType.One:
        _paperVariant = 'Variant 1';
        break;
      case PaperVariantType.Two:
        _paperVariant = 'Variant 2';
        break;
      case PaperVariantType.Three:
        _paperVariant = 'Variant 3';
        break;
      case PaperVariantType.Four:
        _paperVariant = 'Variant 4';
        break;
    }

    subtitle = '$_paperNumber $_paperVariant';
  }

  setSeasonIcon() {
    switch (seasonType) {
      case SeasonType.All:
        seasonIcon = IconData(0xe90b, fontFamily: 'icomoon');
        season = 'All';
        break;
      case SeasonType.Summer:
        seasonIcon = FontAwesomeIcons.solidSun;
        season = 'Summer';
        break;
      case SeasonType.Winter:
        seasonIcon = IconData(0xe90a, fontFamily: 'icomoon');
        season = 'Winter';
        break;
      case SeasonType.March:
        seasonIcon = FontAwesomeIcons.cloudSun;
        season = 'March';
        break;
    }
  }
}
