import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';

abstract class API{
  List<Subject> getSubjects(Course course);
  List<Paper> getPapers(Course course, Subject subject);
  void addSubject(Subject subject);
  void addPaper(Paper paper);
  List<int> getYears();
}