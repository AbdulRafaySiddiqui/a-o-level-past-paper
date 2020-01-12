import 'dart:collection';

import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/API.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';

class SubjectsViewModel extends BaseViewModel{

var api = locator<API>();

  SubjectsViewModel(){
    _subjects = api.getSubjects(Course.ALevel);
    //A Comparator function represents such a total ordering by returning a negative integer 
    //if a is smaller than b, zero if a is equal to b, and a positive integer if a is greater than b.
    _subjects.sort((a,b)=> a.isFavorite == b.isFavorite? 0 : a.isFavorite? 1 : -1);
  }
  List<Subject> _subjects;
  UnmodifiableListView get subject => UnmodifiableListView(_subjects.where((subject)=> subject.isVisible));
  bool isSearching = false;

  toggleSubjectFavorite(Subject subject){
    _subjects.sort((a,b)=> a.isFavorite == b.isFavorite? 0 : a.isFavorite? 1 : -1);
    subject.toggleFavorite();
    notifyListeners();
  }

  //search a string in the 
  search(String searchText){
    //if search is empty reset the list
    if(searchText.isEmpty){
      cancleSearch();
      return;
    }

    //search the test in the list
    isSearching = true;
    searchText = searchText.toLowerCase();
    for(var subject in _subjects){
      subject.isVisible = subject.name.toLowerCase().contains(searchText);
    }
    notifyListeners();
  }

  cancleSearch(){
    for(var subject in _subjects){
      subject.isVisible = true;
    }
    isSearching = false;
    notifyListeners();
  }

  addSubject(Subject subject){
    api.addSubject(subject);
    _subjects = api.getSubjects(Course.ALevel);
  }

  navigate(Subject subject){
    navigation.navigateTo('paper',arguments: subject);
  }

}