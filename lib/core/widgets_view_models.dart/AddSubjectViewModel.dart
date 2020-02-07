import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/NavigationService.dart';

class AddSubjectViewModel extends BaseViewModel {
  AddSubjectViewModel(Subject subject) {
    if (subject != null) {
      edit = true;
      _subject = subject;
      name = subject.name;
      controller = TextEditingController();
      controller.text = name;
      notifyListeners();
    }
  }

  String name = '';
  bool uploading = false;
  bool isValid = true;
  bool edit = false;
  Subject _subject;
  TextEditingController controller;
  var api = locator<Api>();
  var navigation = locator<NavigationService>();
  setName(String value) {
    name = value;
    isValid = name.isNotEmpty;
    notifyListeners();
  }

  addSubject() async {
    uploading = true;
    isValid = name.isNotEmpty;
    notifyListeners();
    if (isValid) {
      if (edit) {
        await api.updateSubject(Subject(
            name: name,
            subjectId: _subject.subjectId,
            course: _subject.course));
      } else {
        await api.addSubject(Subject(
            name: name, subjectId: getGuid(), course: api.selectedCourse));
      }
    }
    uploading = false;
    if (isValid) {
      navigation.goBack();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
