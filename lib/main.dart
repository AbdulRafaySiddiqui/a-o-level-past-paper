import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/Router.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: kPrimaryColor),

      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Router.generateRoute,
      initialRoute: 'course',
      // //startup page
      // initialRoute: PaperViewer.id,

      // //Define routes
      // routes: {
      //   CourseSelector.id : (context)=> CourseSelector(),
      //   CourseListView.id : (context)=> CourseListView(),
      //   PaperSelector.id : (context)=> PaperSelector(),
      //   PaperViewer.id : (context)=> PaperViewer(),
      // },
    ));
