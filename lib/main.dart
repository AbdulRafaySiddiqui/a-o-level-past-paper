import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/Router.dart';

void main() {
  setupLocator();
  runApp(MaterialApp(
    theme: ThemeData.light().copyWith(primaryColor: kPrimaryColor),
    navigatorKey: locator<NavigationService>().navigatorKey,
    onGenerateRoute: Router.generateRoute,
    initialRoute: 'startup',
  ));
}
