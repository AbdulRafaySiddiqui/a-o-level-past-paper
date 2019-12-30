import 'package:past_papers/enums/PaperNumberType.dart';
import 'package:past_papers/enums/PaperVariantType.dart';
import 'package:past_papers/enums/SeasonType.dart';

import 'constants/Course.dart';
import 'enums/PaperType.dart';
import 'models/PaperModel.dart';

List<Course> getCourseList() {
  return courseNames.map((f) => Course(title: f));
}

List<String> courseNames = [
  'Acounting (9706)',
  'Afrikaans-Language (8679)',
  'Applied Information',
  'Business Studies (9707)',
  'Business (9609)',
  'Biology (9700)',
  'Chemistry (9701)',
  'Chinese (9715)',
  'Computer Science (9608)',
  'Computing (9691)'
];

List<int> getYears(){
  List<int> years;
  for (var i = 2000; i < 2021; i++) {
   years.add(i); 
  }
  return years;
}
List<PaperModel> papermodel = [
  PaperModel(
      paperType: PaperType.QuestionPaper,
      paperNumberType: PaperNumberType.One,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Summer,
      year: 2018),
      PaperModel(
      paperType: PaperType.MarkingScheme,
      paperNumberType: PaperNumberType.One,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Winter,
      year: 2018),
      PaperModel(
      paperType: PaperType.GradeThreshold,
      paperNumberType: PaperNumberType.One,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.All,
      year: 2018),
      PaperModel(
      paperType: PaperType.ExaminorReport,
      paperNumberType: PaperNumberType.One,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Summer,
      year: 2018),
      PaperModel(
      paperType: PaperType.QuestionPaper,
      paperNumberType: PaperNumberType.Four,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Summer,
      year: 2017),
      PaperModel(
      paperType: PaperType.QuestionPaper,
      paperNumberType: PaperNumberType.One,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Summer,
      year: 2016),
      PaperModel(
      paperType: PaperType.MarkingScheme,
      paperNumberType: PaperNumberType.Four,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Summer,
      year: 2018),
      PaperModel(
      paperType: PaperType.MarkingScheme,
      paperNumberType: PaperNumberType.Four,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Summer,
      year: 2014),
      PaperModel(
      paperType: PaperType.MarkingScheme,
      paperNumberType: PaperNumberType.Four,
      paperVariantType: PaperVariantType.All,
      seasonType: SeasonType.Summer,
      year: 2015),
      PaperModel(
      paperType: PaperType.MarkingScheme,
      paperNumberType: PaperNumberType.All,
      paperVariantType: PaperVariantType.Two,
      seasonType: SeasonType.Summer,
      year: 2019),
      PaperModel(
      paperType: PaperType.MarkingScheme,
      paperNumberType: PaperNumberType.All,
      paperVariantType: PaperVariantType.All,
      seasonType: SeasonType.Summer,
      year: 2015),
];
