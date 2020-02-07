import 'dart:async';
import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/NavigationService.dart';

class StartupViewModel extends BaseViewModel {
  StartupViewModel() {
    setup();
  }
  var _api = locator<Api>();
  var _navigation = locator<NavigationService>();
  bool isLoading = true;
  bool isDownloading = false;
  String downloadProgress = '0';

  setup() async {
    var watch = Stopwatch();
    watch.start();
    var isCourseSelected = await _api.setupApi(function: (received, total) {
      isDownloading = true;
      downloadProgress = ((received / total) * 100).toStringAsFixed(0);
      notifyListeners();
    });
    isDownloading = false;
    notifyListeners();
    downloadProgress = '0';
    watch.stop();
    if (watch.elapsed.inSeconds < 5) {
      await new Future.delayed(Duration(seconds: 1 - watch.elapsed.inSeconds));
    }
    isLoading = false;
    notifyListeners();
    if (isCourseSelected) {
      _navigation.navigateTo('paper_video_selection');
    } else {
      _navigation.navigateTo('course');
    }
  }
}
