import 'package:past_papers/core/Base/BaseViewModel.dart';

class CourseViewModel extends BaseViewModel{
  Course _course;

  Course get course => _course;

  set course(Course course){
    navigation.navigateTo('subject');
    _course = course;
    notifyListeners();
  }
}

enum Course{
  OLevel,
  ALevel,
}