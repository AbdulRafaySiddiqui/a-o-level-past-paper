import 'package:past_papers/core/models/McqModel.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/DatabaseService.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';

abstract class Api {
  Course selectedCourse;
  Future<DatabaseRespone> selectCourse(Course course);
  List<Subject> getSubjects();
  List<Paper> getPapers(String subjectId);
  Future<DatabaseRespone> addSubject(Subject subject);
  Future<DatabaseRespone> addPaper(Paper paper);
  Future<DatabaseRespone> deleteSubject(Subject subject);
  Future<DatabaseRespone> deletePaper(Paper paper);
  List<int> getYears();
  Mcq getMcq(String paperId);
  Future<DatabaseRespone> addMcq(Mcq mcq);
  Future<Object> readData(String key);
  Future<bool> setupApi({Function function});
  Future<DatabaseRespone> updateSubject(Subject subject);
  Future<DatabaseRespone> updatePaper(Paper paper);
  Future<DatabaseRespone> updateMcq(Mcq mcq);
  Future<DatabaseRespone> savePapers();
  Future<DatabaseRespone> saveSubjects();
  Future<DatabaseRespone> saveMcqs();
  Future<bool> downloadFile(String filename, Function(int, int) function);
  Future<bool> redownloadPdf(String filename, Function function);
  syncDatabase({onProgress(int progress, int total)});
  Future<bool> deleteDatabase();
  downloadDatabase({Function onProgress});
}
