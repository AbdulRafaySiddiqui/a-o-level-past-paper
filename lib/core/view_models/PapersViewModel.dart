import 'dart:math';

import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/Helper.dart';

class PapersViewModel extends BaseViewModel {
  PapersViewModel(this.subject) {
    paperTypeIcon = getPaperTypeIcon(0);
    paperNumberTypeIcon = getPaperNumberIcon(0);
    seasonIcon = getSeasonIcon(0);
    years = api.getYears();

    //to find max value
    endYear = years.reduce((curr, next) => curr > next ? curr : next);
    //to find min value
    startYear = years.reduce((curr, next) => curr < next ? curr : next);

    seasons = List.generate(4, (index) => false);
    paperTypes = List.generate(5, (index) => false);
    paperNumberTypes = List.generate(5, (index) => false);

    seasons[0] = true;
    paperTypes[0] = true;
    paperNumberTypes[0] = true;

    loadPapers();
  }

  var api = locator<Api>();
  Subject subject;
  List<Paper> _papers;
  int startYear;
  int endYear = 2019;
  List<int> years;
  bool multiplePaperSelection = false;
  Paper selectedPaper;
  bool isSearching = false;
  bool isDeleting = false;

  IconData paperTypeIcon;
  IconData paperNumberTypeIcon;
  IconData seasonIcon;

  List<bool> seasons;
  List<bool> paperTypes;
  List<bool> paperNumberTypes;

  List<Paper> get papers => _papers
      .where((paper) => paper.isFilterVisible && paper.isVisible)
      .toList();

  List<int> getYears() => api.getYears();

  loadPapers() {
    _papers = api.getPapers(subject.subjectId);
    filter();
    notifyListeners();
  }

  startSearch() {
    isSearching = true;
    notifyListeners();
  }

  search(String searchText) {
    isSearching = true;
    searchText = searchText.toLowerCase();
    _papers.forEach((paper) => paper.isVisible =
        paper.title.toLowerCase().contains(searchText) ||
            paper.subtitle.toLowerCase().contains(searchText) ||
            paper.seasonName.toLowerCase().contains(searchText));
    notifyListeners();
  }

  cancleSearch() {
    _papers.forEach((paper) => paper.isVisible = true);
    isSearching = false;
    notifyListeners();
  }

  filter() {
    int paperType = paperTypes.indexWhere((item) => item == true);
    int paperNumberType = paperNumberTypes.indexWhere((item) => item == true);
    int seasonType = seasons.indexWhere((item) => item == true);

    _papers.forEach((paper) => paper.isFilterVisible =
        (paper.year >= startYear && paper.year <= endYear) &&
            (paperType == 0 || paper.paperType == paperType) &&
            (paperNumberType == 0 ||
                paper.paperNumberType == paperNumberType) &&
            (seasonType == 0 || paper.seasonType == seasonType));
    paperTypeIcon = getPaperTypeIcon(paperType);
    paperNumberTypeIcon = getPaperNumberIcon(paperNumberType);
    seasonIcon = getSeasonIcon(seasonType);
    notifyListeners();
  }

  resetFilter() {
    _papers.forEach((paper) => paper.isFilterVisible = true);
  }

  selectPaper(Paper paper) {
    //if tile is already selected then deselect it
    if (paper.isSelected) {
      paper.isSelected = false;
      multiplePaperSelection = false;
      selectedPaper = null;
      notifyListeners();
      return;
    }
    if (selectedPaper != null) return;

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

  selectSeason(int value) {
    for (var i = 0; i < seasons.length; i++) {
      seasons[i] = value == i;
    }
    filter();
  }

  selectPaperType(int value) {
    for (var i = 0; i < paperTypes.length; i++) {
      paperTypes[i] = value == i;
    }
    filter();
  }

  selectPaperNumber(int value) {
    for (var i = 0; i < paperNumberTypes.length; i++) {
      paperNumberTypes[i] = value == i;
    }
    filter();
  }

  deletePaper(Paper paper) async {
    isDeleting = true;
    notifyListeners();
    await api.deletePaper(paper);
    isDeleting = false;
    notifyListeners();
    closeDialog();
    loadPapers();
  }

  closeDialog() {
    navigation.goBack();
  }

  navigate(Paper paper) {
    //if tile is already selected then deselect it
    if (paper.isSelected) {
      paper.isSelected = false;
      multiplePaperSelection = false;
      selectedPaper = null;
      notifyListeners();
      return;
    }
    navigation.navigateTo('paperViewer',
        arguments: multiplePaperSelection ? [selectedPaper, paper] : [paper]);
    selectedPaper?.isSelected = false;
    selectedPaper = null;
    multiplePaperSelection = false;
  }

  IconData getPaperTypeIcon(int value) => Helper.getPaperTypeIcon(value);

  IconData getPaperNumberIcon(int value) => Helper.getPaperNumberIcon(value);

  IconData getSeasonIcon(int value) => Helper.getSeasonIcon(value);
}
