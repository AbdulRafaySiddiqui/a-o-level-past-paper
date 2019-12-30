import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/enums/PaperNumberType.dart';
import 'package:past_papers/enums/PaperType.dart';
import 'package:past_papers/enums/PaperVariantType.dart';
import 'package:past_papers/enums/SeasonType.dart';
import 'package:past_papers/models/PaperModel.dart';


//The list of all the papers available for the selected course
class PaperListView extends StatefulWidget {
  PaperListView({@required this.paperModels});
  final List<PaperModel> paperModels;
  @override
  _PaperListViewState createState() => _PaperListViewState();
}

class _PaperListViewState extends State<PaperListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.paperModels.map((f)=> PaperTile(paperModel:f)).toList(),
    );
  }
}


//paper tile which contains paper number, variant number, year and session information about the paper
class PaperTile extends StatelessWidget {
  PaperTile({@required this.paperModel});

  final PaperModel paperModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: kPrimaryColor,
          child: Text(
            paperModel.year.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, color: kWhiteColor),
          ),
        ),
        title: Text(getPaperTitle(paperModel.paperType)),
        subtitle: Text(getsubtitle(paperModel.paperNumberType, paperModel.paperVariantType)),
        trailing: Icon(getSeasonIcon(paperModel.seasonType)),
      ),
    );
  }
}

String getPaperTitle(PaperType paperType){
  String title;
  switch(paperType){
    case PaperType.QuestionPaper: 
    title = 'Question Paper';
    break;
    case PaperType.All:
      title =  'All';
      break;
    case PaperType.MarkingScheme:
      title =  'Marking Scheme';
      break;
    case PaperType.ExaminorReport:
      title =  'Examinor Report';
      break;
    case PaperType.GradeThreshold:
      title =  'Grade Threshold';
      break;
  }
  return title;
}

String getsubtitle(PaperNumberType paperNumber,PaperVariantType paperVariant){
  String _paperNumber;
  String _paperVariant;

  switch(paperNumber){
    case PaperNumberType.All:
      _paperNumber = 'All Papers';
      break;
    case PaperNumberType.One:
      _paperNumber = 'Paper 1';
      break;
    case PaperNumberType.Two:
      _paperNumber = 'Paper 2';
      break;
    case PaperNumberType.Three:
     _paperNumber = 'Paper 3';
      break;
    case PaperNumberType.Four:
      _paperNumber = 'Paper 4';
      break;
  }

  switch (paperVariant) {
    case PaperVariantType.All:
      _paperVariant = 'All Variants';
      break;
    case PaperVariantType.One:
      _paperVariant = 'Variant 1';
      break;
    case PaperVariantType.Two:
      _paperVariant = 'Variant 2';
      break;
    case PaperVariantType.Three:
      _paperVariant = 'Variant 3';
      break;
    case PaperVariantType.Four:
      _paperVariant = 'Variant 4';
      break;
  }

  return '$_paperNumber $_paperVariant';
}

IconData getSeasonIcon(SeasonType seasonType){
  IconData icon;
  switch(seasonType){
    case SeasonType.All:
      icon =  FontAwesomeIcons.cloudSunRain;
      break;
    case SeasonType.Summer:
      icon =  FontAwesomeIcons.solidSun;
      break;
    case SeasonType.Winter:
      icon =  FontAwesomeIcons.cloudRain;
      break;
    case SeasonType.March:
      icon =  FontAwesomeIcons.cloudSun;
      break;
  }
  return icon;
}
