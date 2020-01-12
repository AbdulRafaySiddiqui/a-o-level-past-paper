import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/enums/PaperNumberType.dart';
import 'package:past_papers/core/enums/PaperType.dart';
import 'package:past_papers/core/enums/SeasonType.dart';
import 'package:past_papers/core/view_models/PapersViewModel.dart';

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PapersViewModel>(
        builder: (BuildContext context, PapersViewModel model, Widget child) =>
            Container(
              color: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //year range
                  IconButton(
                    icon: Icon(FontAwesomeIcons.calendar),
                    color: kWhiteColor,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0)),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter setModelState) {
                              return Container(
                                height: 75.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('To'),
                                    DropdownButton(
                                      value: model.startYear,
                                      items: model
                                          .getYears()
                                          .map<DropdownMenuItem<int>>(
                                              (int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setModelState(() {
                                          model.startYear = value;
                                          model.filter(null);
                                        });
                                      },
                                    ),
                                    Text('From'),
                                    DropdownButton(
                                      value: model.endYear,
                                      items: model
                                          .getYears()
                                          .map<DropdownMenuItem<int>>(
                                              (int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setModelState(() {
                                          model.endYear = value;
                                          model.filter(null);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                  ),
                  //seasons
                  IconButton(
                    icon: Icon(model.seasonIcon),
                    color: kWhiteColor,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0)),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter setModelState) {
                              return Container(
                                height: 75.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      tooltip: 'All Months',
                                      icon: Icon(
                                          model.getSeasonIcon(SeasonType.All)),
                                      color: model.seasonType == SeasonType.All
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(SeasonType.All);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      tooltip: 'Summer',
                                      icon: Icon(model
                                          .getSeasonIcon(SeasonType.Summer)),
                                      color:
                                          model.seasonType == SeasonType.Summer
                                              ? kselectionColor
                                              : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(SeasonType.Summer);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      tooltip: 'March',
                                      icon: Icon(model
                                          .getSeasonIcon(SeasonType.March)),
                                      color:
                                          model.seasonType == SeasonType.March
                                              ? kselectionColor
                                              : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(SeasonType.March);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      tooltip: 'Winter',
                                      icon: Icon(model
                                          .getSeasonIcon(SeasonType.Winter)),
                                      color:
                                          model.seasonType == SeasonType.Winter
                                              ? kselectionColor
                                              : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(SeasonType.Winter);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                  ),
                  //spacing
                  SizedBox(
                    width: 50,
                  ),
                  //paper type
                  IconButton(
                    icon: Icon(model.paperTypeIcon),
                    color: kWhiteColor,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0)),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter setModelState) {
                              return Container(
                                height: 75.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(model
                                          .getPaperTypeIcon(PaperType.All)),
                                      color: model.paperType == PaperType.All
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperType.All);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(model.getPaperTypeIcon(
                                          PaperType.QuestionPaper)),
                                      color: model.paperType ==
                                              PaperType.QuestionPaper
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperType.QuestionPaper);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        model.getPaperTypeIcon(
                                            PaperType.MarkingScheme),
                                      ),
                                      color: model.paperType ==
                                              PaperType.MarkingScheme
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperType.MarkingScheme);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(model.getPaperTypeIcon(
                                          PaperType.GradeThreshold)),
                                      color: model.paperType ==
                                              PaperType.GradeThreshold
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model
                                              .filter(PaperType.GradeThreshold);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(model.getPaperTypeIcon(
                                          PaperType.ExaminorReport)),
                                      color: model.paperType ==
                                              PaperType.ExaminorReport
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model
                                              .filter(PaperType.ExaminorReport);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                  ),
                  //paper number
                  IconButton(
                    icon: Icon(model.paperNumberTypeIcon),
                    color: kWhiteColor,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0)),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context,
                                    StateSetter setModelState) {
                              return Container(
                                height: 75.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(model.getPaperNumberIcon(
                                          PaperNumberType.All)),
                                      color: model.paperNumberType ==
                                              PaperNumberType.All
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperNumberType.All);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(model.getPaperNumberIcon(
                                          PaperNumberType.One)),
                                      color: model.paperNumberType ==
                                              PaperNumberType.One
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperNumberType.One);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(model.getPaperNumberIcon(
                                          PaperNumberType.Two)),
                                      color: model.paperNumberType ==
                                              PaperNumberType.Two
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperNumberType.Two);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(model.getPaperNumberIcon(
                                          PaperNumberType.Three)),
                                      color: model.paperNumberType ==
                                              PaperNumberType.Three
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperNumberType.Three);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(model.getPaperNumberIcon(
                                          PaperNumberType.Four)),
                                      color: model.paperNumberType ==
                                              PaperNumberType.Four
                                          ? kselectionColor
                                          : kBlackColor,
                                      onPressed: () {
                                        setModelState(() {
                                          model.filter(PaperNumberType.Four);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                  )
                ],
              ),
            ));
  }
}
