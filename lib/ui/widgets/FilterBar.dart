import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/view_models/PapersViewModel.dart';
import 'package:past_papers/ui/widgets/FilterToggleButton.dart';
import 'package:provider/provider.dart';

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PapersViewModel>(
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
                            return StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  Container(
                                height: 75.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('From'),
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
                                        setState(() {
                                          model.startYear = value;
                                          model.filter();
                                        });
                                      },
                                    ),
                                    Text('To'),
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
                                        model.endYear = value;
                                        model.filter();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  //seasons
                  FilterButton(
                    children: <IconModel>[
                      IconModel(icon: model.getSeasonIcon(0), title: 'All'),
                      IconModel(icon: model.getSeasonIcon(1), title: 'Summer'),
                      IconModel(icon: model.getSeasonIcon(2), title: 'March'),
                      IconModel(icon: model.getSeasonIcon(3), title: 'Winter'),
                    ],
                    isSelected: model.seasons,
                    addTitle: true,
                    onPressed: (int value) => model.selectSeason(value),
                  ),
                  //spacing
                  SizedBox(
                    width: 50,
                  ),
                  //paper type
                  FilterButton(
                    children: <IconModel>[
                      IconModel(
                        icon: model.getPaperTypeIcon(0),
                      ),
                      IconModel(icon: model.getPaperTypeIcon(1)),
                      IconModel(icon: model.getPaperTypeIcon(2)),
                      IconModel(icon: model.getPaperTypeIcon(3)),
                      IconModel(icon: model.getPaperTypeIcon(4)),
                    ],
                    isSelected: model.paperTypes,
                    onPressed: (int value) => model.selectPaperType(value),
                  ),
                  //paper number
                  FilterButton(
                    children: <IconModel>[
                      IconModel(icon: model.getPaperNumberIcon(0)),
                      IconModel(icon: model.getPaperNumberIcon(1)),
                      IconModel(icon: model.getPaperNumberIcon(2)),
                      IconModel(icon: model.getPaperNumberIcon(3)),
                      IconModel(icon: model.getPaperNumberIcon(4)),
                    ],
                    isSelected: model.paperNumberTypes,
                    onPressed: (int value) => model.selectPaperNumber(value),
                  ),
                ],
              ),
            ));
  }
}
