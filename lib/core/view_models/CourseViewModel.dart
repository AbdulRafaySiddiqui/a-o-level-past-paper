import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/services/Api.dart';

class CourseViewModel extends BaseViewModel {
  Course _course;
  Course get course => _course;

  set course(Course course) {
    _course = course;
    var response = locator<Api>().selectCourse(course);
    notifyListeners();
    navigation.navigateTo('paper_video_selection');
  }
}

enum Course {
  OLevel,
  ALevel,
}
