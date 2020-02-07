import 'package:flutter/material.dart';
import 'package:past_papers/ui/views/AboutView.dart';
import 'package:past_papers/ui/views/CoursesView.dart';
import 'package:past_papers/ui/views/PaperViewerView.dart';
import 'package:past_papers/ui/views/PapersView.dart';
import 'package:past_papers/ui/views/StartupView.dart';
import 'package:past_papers/ui/views/SubjectsView.dart';
import 'package:past_papers/ui/views/SubjectVideoSelectionView.dart';
import 'package:past_papers/ui/views/VidoesView.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'startup':
        return MaterialPageRoute(builder: (_) => StartupView());
      case 'course':
        return MaterialPageRoute(builder: (_) => CourseView());
      case 'subject':
        return MaterialPageRoute(builder: (_) => SubjectsView());
      case 'about':
        return MaterialPageRoute(builder: (_) => AboutView());
      case 'paper_video_selection':
        return MaterialPageRoute(builder: (_) => SubjectVideoSelectionView());
      case 'paper':
        return MaterialPageRoute(
            builder: (_) => PapersView(
                  subject: settings.arguments,
                ));
      case 'video':
        return MaterialPageRoute(builder: (_) => VideoView());
      case 'paperViewer':
        return MaterialPageRoute(
            builder: (_) => PaperViewerView(
                  papers: settings.arguments,
                ));
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
