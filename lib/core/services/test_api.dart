import 'package:past_papers/core/enums/PaperNumberType.dart';
import 'package:past_papers/core/enums/PaperType.dart';
import 'package:past_papers/core/enums/PaperVariantType.dart';
import 'package:past_papers/core/enums/SeasonType.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/API.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';

class TestApi extends API {
  List<Subject> _subjects = [
    Subject('Acounting (9706)'),
    Subject('Afrikaans-Language (8679)'),
    Subject('Applied Information', isFavorite: true),
    Subject('Business Studies (9707)'),
    Subject('Business (9609)'),
    Subject('Biology (9700)', isFavorite: true),
    Subject('Chemistry (9701)', isFavorite: true),
    Subject('Chinese (9715)'),
    Subject('Computer Science (9608)'),
    Subject('Computing (9691)', isFavorite: true)
  ];

  List<Paper> _papers = [
    Paper(
        paperType: PaperType.QuestionPaper,
        paperNumberType: PaperNumberType.One,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Summer,
        year: 2018,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.MarkingScheme,
        paperNumberType: PaperNumberType.One,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Winter,
        year: 2018,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.GradeThreshold,
        paperNumberType: PaperNumberType.One,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.All,
        year: 2018,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.ExaminorReport,
        paperNumberType: PaperNumberType.One,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Summer,
        year: 2018,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.QuestionPaper,
        paperNumberType: PaperNumberType.Four,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Summer,
        year: 2017,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.QuestionPaper,
        paperNumberType: PaperNumberType.One,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Summer,
        year: 2016,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.MarkingScheme,
        paperNumberType: PaperNumberType.Four,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Summer,
        year: 2018,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.MarkingScheme,
        paperNumberType: PaperNumberType.Four,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Summer,
        year: 2014,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.MarkingScheme,
        paperNumberType: PaperNumberType.Four,
        paperVariantType: PaperVariantType.All,
        seasonType: SeasonType.Summer,
        year: 2015,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.MarkingScheme,
        paperNumberType: PaperNumberType.All,
        paperVariantType: PaperVariantType.Two,
        seasonType: SeasonType.Summer,
        year: 2019,
        subject: 'Acounting (9706)'),
    Paper(
        paperType: PaperType.MarkingScheme,
        paperNumberType: PaperNumberType.All,
        paperVariantType: PaperVariantType.All,
        seasonType: SeasonType.Summer,
        year: 2015,
        subject: 'Acounting (9706)'),
  ];

  List<int> getYears() {
    List<int> years = [];
    for (var i = 2000; i < 2021; i++) {
      years.add(i);
    }
    return years;
  }

  @override
  List<Subject> getSubjects(Course course) {
    return _subjects;
  }

  @override
  void addPaper(Paper paper) {
    _papers.add(paper);
  }

  @override
  void addSubject(Subject subject) {
    _subjects.add(subject);
  }

  @override
  List<Paper> getPapers(Course course, Subject subject) {
    return _papers;
  }
}
