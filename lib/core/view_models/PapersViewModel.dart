import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/enums/PaperNumberType.dart';
import 'package:past_papers/core/enums/PaperType.dart';
import 'package:past_papers/core/enums/PaperVariantType.dart';
import 'package:past_papers/core/enums/SeasonType.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/API.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';

class PapersViewModel extends BaseViewModel {
  var api = locator<API>();

  List<Paper> _papers;
  PaperType paperType = PaperType.All;
  PaperNumberType paperNumberType = PaperNumberType.All;
  PaperVariantType paperVariantType = PaperVariantType.All;
  SeasonType seasonType = SeasonType.All;
  int startYear;
  int endYear;
  bool multiplePaperSelection = false;
  Paper selectedPaper;
  bool isSearching = false;

  IconData paperTypeIcon;
  IconData paperNumberTypeIcon;
  IconData seasonIcon;

  List<Paper> get papers =>
      _papers.where((paper) => paper.isFilterVisible && paper.isVisible);

  List<int> getYears() => api.getYears();

  search(String searchText) {
    //to reset the search
    if (searchText.isEmpty) {
      cancleSearch();
      return;
    }

    //to search the paper list
    isSearching = true;
    searchText = searchText.toLowerCase();
    _papers.forEach((paper) => paper.isVisible =
        paper.title.toLowerCase().contains(searchText) ||
            paper.subtitle.toLowerCase().contains(searchText) ||
            paper.season.toLowerCase().contains(searchText));
    notifyListeners();
  }

  cancleSearch() {
    _papers.forEach((paper) => paper.isVisible = true);
    isSearching = false;
    notifyListeners();
  }

  filter(var item) {
    if (item is PaperType) {
      paperType = item;
    } else if (item is PaperNumberType) {
      paperNumberType = item;
    } else if (item is SeasonType) {
      seasonType = item;
    }

    _papers.forEach((paper) => paper.isFilterVisible =
        (paper.year >= startYear && paper.year <= endYear) &&
            (paperType == PaperType.All || paper.paperType == paperType) &&
            (paperNumberType == PaperNumberType.All ||
                paper.paperNumberType == paperNumberType) &&
            (seasonType == SeasonType.All || paper.seasonType == seasonType));
    notifyListeners();
  }

  resetFilter() {
    _papers.forEach((paper) => paper.isFilterVisible = true);
  }

  selectPaper(Paper paper) {
    paper.isSelected = true;
    multiplePaperSelection = true;
    selectedPaper = paper;
    notifyListeners();
  }

  canclePaperSelection() {
    _papers.forEach((paper) => paper.isSelected = false);
    multiplePaperSelection = false;
    selectedPaper = null;
    notifyListeners();
  }

  addPaper(Paper paper) {
    api.addPaper(paper);
    _papers = api.getPapers(Course.ALevel, Subject('Accounting'));
    notifyListeners();
  }

  navigate(Paper paper) {
    navigation.navigateTo('paperViewer',
        arguments: multiplePaperSelection ? [selectedPaper, paper] : [paper]);
  }

  IconData getPaperTypeIcon(PaperType paperType) {
    IconData icon;
    switch (paperType) {
      case PaperType.All:
        icon = IconData(0xe900, fontFamily: 'icomoon');
        break;
      case PaperType.QuestionPaper:
        icon = IconData(0xe907, fontFamily: 'icomoon');
        break;
      case PaperType.MarkingScheme:
        icon = IconData(0xe905, fontFamily: 'icomoon');
        break;
      case PaperType.ExaminorReport:
        icon = IconData(0xe902, fontFamily: 'icomoon');
        break;
      case PaperType.GradeThreshold:
        icon = IconData(0xe904, fontFamily: 'icomoon');
        break;
    }

    return icon;
  }

  IconData getPaperNumberIcon(PaperNumberType paperNumberType) {
    IconData icon;
    switch (paperNumberType) {
      case PaperNumberType.All:
        icon = IconData(0xe901, fontFamily: 'icomoon');
        break;
      case PaperNumberType.One:
        icon = IconData(0xe906, fontFamily: 'icomoon');
        break;
      case PaperNumberType.Two:
        icon = IconData(0xe909, fontFamily: 'icomoon');
        break;
      case PaperNumberType.Three:
        icon = IconData(0xe908, fontFamily: 'icomoon');
        break;
      case PaperNumberType.Four:
        icon = IconData(0xe903, fontFamily: 'icomoon');
        break;
    }
    return icon;
  }

  IconData getSeasonIcon(SeasonType seasonType) {
    IconData icon;
    switch (seasonType) {
      case SeasonType.All:
        icon = IconData(0xe90b, fontFamily: 'icomoon');
        break;
      case SeasonType.Summer:
        icon = FontAwesomeIcons.solidSun;
        break;
      case SeasonType.Winter:
        icon = IconData(0xe90a, fontFamily: 'icomoon');
        break;
      case SeasonType.March:
        icon = FontAwesomeIcons.cloudSun;
        break;
    }
    return icon;
  }
}
