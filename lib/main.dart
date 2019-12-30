import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/screens/course_list.dart';
import 'package:past_papers/screens/course_selector.dart';
import 'package:past_papers/screens/paper_selector.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: kPrimaryColor),

      //startup page
      initialRoute: PaperSelector.id,

      //Define routes
      routes: {
        CourseSelector.id : (context)=> CourseSelector(),
        CourseListView.id : (context)=> CourseListView(),
        PaperSelector.id : (context)=> PaperSelector(),
      },
    ));
