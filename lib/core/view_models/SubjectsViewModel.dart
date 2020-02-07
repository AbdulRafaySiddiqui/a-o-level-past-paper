import 'dart:collection';

import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/Api.dart';

class SubjectsViewModel extends BaseViewModel {
  SubjectsViewModel() {
    loadSubjects();
  }
  
  var api = locator<Api>();
  List<Subject> _subjects;
  UnmodifiableListView get subject => _subjects == null
      ? UnmodifiableListView([])
      : UnmodifiableListView(_subjects?.where((subject) => subject.isVisible));
  bool isSearching = false;
  bool isLoading = true;
  bool isDeleting = false;

  loadSubjects() {
    _subjects = api.getSubjects();
    //A Comparator function represents such a total ordering by returning a negative integer
    //if a is smaller than b, zero if a is equal to b, and a positive integer if a is greater than b.
    _subjects.sort(
        (a, b) => a.isFavorite == b.isFavorite ? 0 : a.isFavorite ? -1 : 1);
    isLoading = false;
    notifyListeners();
  }

  toggleSubjectFavorite(Subject subject) {
    subject.isFavorite = !subject.isFavorite;
    _subjects.sort(
        (a, b) => a.isFavorite == b.isFavorite ? 0 : a.isFavorite ? -1 : 1);
    api.saveSubjects();
    notifyListeners();
  }

  //search a string in the
  search(String searchText) {
    //if search is empty reset the list
    if (searchText.isEmpty) {
      cancleSearch();
      return;
    }

    //search the test in the list
    isSearching = true;
    searchText = searchText.toLowerCase();
    for (var subject in _subjects) {
      subject.isVisible = subject.name.toLowerCase().contains(searchText);
    }
    notifyListeners();
  }

  cancleSearch() {
    for (var subject in _subjects) {
      subject.isVisible = true;
    }
    isSearching = false;
    notifyListeners();
  }

  addSubject(Subject subject) {
    api.addSubject(subject);
    _subjects = api.getSubjects();
  }

  deleteSubject(Subject subject) async {
    isDeleting = true;
    notifyListeners();
    await api.deleteSubject(subject);
    isDeleting = false;
    notifyListeners();
    closeDialoag();
  }

  closeDialoag() {
    navigation.goBack();
  }

  navigate(Subject subject) {
    navigation.navigateTo('paper', arguments: subject);
  }
}
