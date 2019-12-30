import 'package:past_papers/enums/CourseType.dart';
import 'package:past_papers/components/ToggleButton.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/screens/course_list.dart';
import 'package:flutter/material.dart';

class CourseSelector extends StatefulWidget {
  static String id = 'courseSelector';

  @override
  _CourseSelectorState createState() => _CourseSelectorState();
}

class _CourseSelectorState extends State<CourseSelector> {
  CourseType selectedCourse;
  void changeSelectedCourse(CourseType course) {
    setState(() {
      selectedCourse = course;
    });
  }

  Color color = kPrimaryColor;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: ToggleButton(
                  text: 'O Level',
                  isSelected: selectedCourse == CourseType.OLevel,
                  onPressed: () {
                    setState(() {
                      selectedCourse = CourseType.OLevel;
                       Navigator.pushNamed(context, CourseListView.id);
                    });
                  },
                ),
              ),
              Expanded(
                child: ToggleButton(
                  text: 'A Level',
                  isSelected: selectedCourse == CourseType.ALevel,
                  onPressed: () {
                    setState(() {
                      selectedCourse = CourseType.ALevel;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
