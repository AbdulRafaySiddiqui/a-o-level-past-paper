import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/SubjectModel.dart';
import 'package:past_papers/core/services/NavigationService.dart';

class SubjectVideoSelectionViewModel extends BaseViewModel {
  SubjectVideoSelectionViewModel();
  var _navigation = locator<NavigationService>();
  Subject subject;
  navigate(String routeName) {
    _navigation.navigateTo(routeName);
  }
}
