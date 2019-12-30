import 'package:past_papers/enums/PaperNumberType.dart';
import 'package:past_papers/enums/PaperType.dart';
import 'package:past_papers/enums/PaperVariantType.dart';
import 'package:past_papers/enums/SeasonType.dart';

class PaperModel{
  PaperModel({this.paperType,this.paperVariantType,this.paperNumberType,this.year,this.seasonType});
  int year;
  PaperType paperType;
  PaperNumberType paperNumberType;
  PaperVariantType paperVariantType;
  SeasonType seasonType;
}