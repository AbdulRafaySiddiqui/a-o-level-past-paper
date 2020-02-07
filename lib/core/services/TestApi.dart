import 'dart:io';

import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/McqModel.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/CloudService.dart';
import 'package:past_papers/core/services/DatabaseService.dart';
import 'package:past_papers/core/services/Helper.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/utils/value_utils.dart';

class TestApi implements Api {
  var _db = locator<DatabaseService>();
  var _cs = locator<CloudService>();
  Course selectedCourse;
  List<Subject> _subjects;
  List<Paper> _papers;
  List<Mcq> _mcqs;
  List<int> years;
  bool isReady = false;

  @override
  Future<bool> deleteDatabase() async {
    try {
      await Helper.deleteFile('database');
      _subjects = [];
      _papers = [];
      _mcqs = [];
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> downloadDatabase({Function onProgress}) async {
    if (await _cs.exists('database/database')) {
      var path = await getApplicationDocumentsDirectory();
      //download database if it doesn't exists
      await _cs.downloadFile('database', '${path.path}/database', onProgress,
          fileType: FileType.Database);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> setupApi({Function function}) async {
    bool isCourseAsigned = true;
    //make sure database exists
    if (!await Helper.doesfileExists('database')) {
      await downloadDatabase(onProgress: function);
    }
    await _db.setupDatabase();

    //load selected course
    var course = await _db.read('course');
    if (course != null) {
      if (course == -1) {
        isCourseAsigned = false;
      } else {
        selectedCourse = Course.values[course];
      }
    } else {
      await _db.write('course', -1, type: StoreDataType.Num);
      isCourseAsigned = false;
    }

    //load subjects
    var subjects = await _db.read('subjects');
    _subjects = [];
    if (subjects != null) {
      for (var item in subjects) {
        _subjects.add(Subject.fromJson(cloneMap(item as Map<String, dynamic>)));
      }
    } else {
      await _db.write('subjects', []);
    }

    //load papers
    var papers = await _db.read('papers');
    _papers = [];
    if (papers != null) {
      for (var item in papers) {
        _papers.add(Paper.fromJson(cloneMap(item as Map<String, dynamic>)));
      }
    } else {
      await _db.write('papers', []);
    }

    //load mcqs
    var mcqs = await _db.read('mcqs');
    _mcqs = [];
    if (mcqs != null) {
      for (var item in mcqs) {
        _mcqs.add(Mcq.fromJson(cloneMap(item as Map<String, dynamic>)));
      }
    } else {
      await _db.write('mcqs', []);
    }

    //setup years
    years = [];
    for (var paper in _papers) {
      years.add(paper.year);
    }
    years = years.toSet().toList();
    years.sort();
    isReady = true;
    return isCourseAsigned;
  }

  @override
  List<int> getYears() {
    if (years.isEmpty) {
      return List<int>.generate(26, (index) => 2000 + index);
    }
    return years;
  }

  @override
  Future<DatabaseRespone> selectCourse(Course course) {
    selectedCourse = course;
    return _db.updateData('course', course.index, type: StoreDataType.Num);
  }

  //Getting subjects, papers, mcqs
  @override
  List<Subject> getSubjects() => _subjects.isEmpty
      ? []
      : _subjects.where((subject) => subject.course == selectedCourse).toList();

  @override
  List<Paper> getPapers(String _subjectId) => _papers.isEmpty
      ? []
      : _papers.where((paper) => paper.subjectId == _subjectId).toList();
  @override
  Mcq getMcq(String paperId) =>
      _mcqs.firstWhere((mcq) => mcq.paperId == paperId, orElse: () => null);

  Future<Object> readData(String key) async {
    return await _db.read(key);
  }

  //uploading subjects, papers, mcqs
  @override
  Future<DatabaseRespone> addPaper(Paper paper) async {
    try {
      //check if its a duplicate paper or not
      var _paper = _papers?.firstWhere(
          (_paper) =>
              _paper.subjectId == paper.subjectId &&
              _paper.paperType == paper.paperType &&
              _paper.paperNumberType == paper.paperNumberType &&
              _paper.paperVariantType == paper.paperVariantType &&
              _paper.seasonType == paper.seasonType &&
              _paper.year == paper.year,
          orElse: () => null);

      if (_paper == null) {
        _papers.add(paper);
        return await savePapers();
      }
    } catch (ex) {
      return DatabaseRespone.Error;
    }
    return DatabaseRespone.DuplicatePaper;
  }

  @override
  Future<DatabaseRespone> addSubject(Subject subject) async {
    _subjects.add(subject);
    return await saveSubjects();
  }

  @override
  Future<DatabaseRespone> addMcq(Mcq mcq) async {
    _mcqs.add(mcq);
    return await saveMcqs();
  }

  //update subjects, papers ,mcqs
  @override
  Future<DatabaseRespone> updatePaper(Paper paper) async {
    for (var i = 0; i < _papers.length; i++) {
      if (_papers[i].paperId == paper.paperId) {
        _papers[i] = paper;
        break;
      }
    }
    return await savePapers();
  }

  @override
  Future<DatabaseRespone> updateSubject(Subject subject) async {
    for (var i = 0; i < _subjects.length; i++) {
      if (_subjects[i].subjectId == subject.subjectId) {
        _subjects[i] = subject;
        break;
      }
    }
    return await saveSubjects();
  }

  @override
  Future<DatabaseRespone> updateMcq(Mcq mcq) async {
    for (var i = 0; i < _mcqs.length; i++) {
      if (_mcqs[i].paperId == mcq.paperId) {
        _mcqs[i] = mcq;
        break;
      }
    }
    return await saveMcqs();
  }

  @override
  Future<DatabaseRespone> savePapers() async {
    return await _db.updateData(
        'papers', _papers.map((paper) => paper.toJson()).toList());
  }

  @override
  Future<DatabaseRespone> saveSubjects() async {
    return await _db.updateData(
        'subjects', _subjects.map((subject) => subject.toJson()).toList());
  }

  @override
  Future<DatabaseRespone> saveMcqs() async {
    return await _db.updateData(
        'mcqs', _mcqs.map((mcq) => mcq.toJson()).toList());
  }

  //interaction with local storage
  @override
  Future<bool> downloadFile(
      String filename, Function(int, int) function) async {
    try {
      var path = await getApplicationDocumentsDirectory();
      await _cs.downloadFile(filename, '${path.path}/$filename', function);
      return true;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<DatabaseRespone> deletePaper(Paper paper) async {
    var removeMcqs = [];
    for (var mcq in _mcqs) {
      if (mcq.paperId == paper.paperId) {
        //delete mcq
        removeMcqs.add(mcq);
      }
    }
    for (var mcq in removeMcqs) {
      _mcqs.remove(mcq);
    }
    //delete paper
    _papers.remove(paper);
    await saveMcqs();
    return await savePapers();
  }

  @override
  Future<DatabaseRespone> deleteSubject(Subject subject) async {
    var removePapers = [];
    var removeMcqs = [];
    for (var paper in _papers) {
      if (paper.subjectId == subject.subjectId) {
        for (var mcq in _mcqs) {
          if (mcq.paperId == paper.paperId) {
            //queue mcq
            removeMcqs.add(mcq);
          }
        }
        //queue paper
        removePapers.add(paper);
      }
    }
    for (var paper in removePapers) {
      _papers.remove(paper);
    }
    for (var mcq in removeMcqs) {
      _mcqs.remove(mcq);
    }
    //delete subject
    _subjects.remove(subject);
    await savePapers();
    await saveMcqs();
    await saveSubjects();
    return DatabaseRespone.Success;
  }

  Future<bool> redownloadPdf(String filename, Function function) async {
    try {
      //first delete the file
      var path = await getApplicationDocumentsDirectory();
      final dir = Directory('${path.path}/$filename}');
      FileSystemEntity result = await dir.delete(recursive: true);
    } catch (ex) {
      // return false;
    }
    try {
      //download it
      return await downloadFile(filename, function);
    } catch (ex) {
      return false;
    }
  }

  syncDatabase({onProgress(int count, int total)}) async {
    int count = 0;
    int total =
        6 + _papers.where((paper) => paper.update == true).toList().length;
    _subjects.forEach((subject) => subject.isFavorite = false);
    await saveSubjects();
    onProgress(count++, total);
    var path = await getApplicationDocumentsDirectory();
    onProgress(count++, total);
    await _cs.deleteFile('database/database');
    onProgress(count++, total);
    await _db.updateData('course', -1, type: StoreDataType.Num);
    onProgress(count++, total);
    await _cs.uploadFile('${path.path}/database', 'database',
        fileType: FileType.Database);
    onProgress(count++, total);
    await _db.updateData('course', -1, type: StoreDataType.Num);
    onProgress(count++, total);
    for (var paper in _papers) {
      if (paper.update) {
        if (!await _cs.exists(paper.paperId)) {
          await _cs.uploadFile(paper.filePath, paper.paperId);
        } else {
          await _cs.deleteFile('pdf/${paper.paperId}');
          await _cs.uploadFile(paper.filePath, paper.paperId);
        }
        onProgress(count++, total);
        paper.update = false;
      }
    }
  }
}
