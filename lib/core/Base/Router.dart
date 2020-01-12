import 'package:flutter/material.dart';
import 'package:past_papers/ui/views/CoursesView.dart';
import 'package:past_papers/ui/views/PapersView.dart';
import 'package:past_papers/ui/views/SubjectsView.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'course':
        return MaterialPageRoute(builder: (_) => CourseView());
      case 'subject':
        return MaterialPageRoute(builder: (_) => SubjectsView());
      case 'paper':
        return MaterialPageRoute(builder: (_) => PapersView(subject: settings.arguments,));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}