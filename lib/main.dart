import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/Router.dart';

void main() {
  setupLocator();
  Admob.initialize(getAppId());
  runApp(MaterialApp(
    theme: ThemeData.light().copyWith(primaryColor: kPrimaryColor),
    navigatorKey: locator<NavigationService>().navigatorKey,
    onGenerateRoute: Router.generateRoute,
    initialRoute: 'startup',
  ));
}

String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544~1458002511';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544~3347511713';
  }
  return null;
}
