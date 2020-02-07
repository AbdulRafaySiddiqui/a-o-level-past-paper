import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/NavigationService.dart';

class SideMenuViewModel extends BaseViewModel {
  var _navigation = locator<NavigationService>();
  var _api = locator<Api>();
  bool isSyncing = false;
  bool isDeletingDb = false;
  bool isDownloadingDb = false;
  String downloadProgress = '0';
  String syncProgress = '0';

  navigate(String routeName) {
    _navigation.navigateTo(routeName);
  }

  deleteDatabase() async {
    isDeletingDb = true;
    notifyListeners();
    await _api.deleteDatabase();
    isDeletingDb = false;
    notifyListeners();
  }

  downloadDatabase() async {
    isDownloadingDb = true;
    notifyListeners();
    await _api.setupApi(function: (received, total) {
      downloadProgress = ((received / total) * 100).toStringAsFixed(0);
      notifyListeners();
    });
    isDownloadingDb = false;
    notifyListeners();
  }

  syncDatabase() async {
    isSyncing = true;
    notifyListeners();
    await _api.syncDatabase(onProgress: (received, total) {
      syncProgress = ((received / total) * 100).toStringAsFixed(0);
      notifyListeners();
    });
    isSyncing = false;
    notifyListeners();
  }

  changeAdminMode(bool value) {
    isUserVersion = !value;
  }
}
