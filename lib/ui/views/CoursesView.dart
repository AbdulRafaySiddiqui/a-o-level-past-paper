import 'package:flutter/material.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';
import 'package:past_papers/ui/widgets/CourseButton.dart';

class CourseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>.withConsumer(
      viewModel: CourseViewModel(),
      builder: (BuildContext context, CourseViewModel model, Widget child) =>
      SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Select Course',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: CourseButton(
                  text: 'O Level',
                  isSelected: model.course == Course.OLevel,
                  onPressed: () {
                    model.course = Course.OLevel;
                  }
                ),
              ),
              Expanded(
                child: CourseButton(
                  text: 'A Level',
                  isSelected: model.course == Course.ALevel,
                  onPressed: () {
                    model.course = Course.ALevel;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    )
    );
  }
}
