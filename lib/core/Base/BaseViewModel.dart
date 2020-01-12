import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/BusyState.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/services/NavigationService.dart';

class BaseViewModel extends ChangeNotifier {
  final navigation = locator<NavigationService>();
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}