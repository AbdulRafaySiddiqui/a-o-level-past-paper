import 'package:past_papers/core/Base/BaseViewModel.dart';

class McqViewModel extends BaseViewModel {
  McqViewModel(
      {this.correctAns, this.index, this.liveCheck = false, this.edit = false});
  List<bool> isSelected;
  int correctAns;
  bool isCorrect = true;
  bool liveCheck;
  int index = 0;
  bool edit;

  setup() {
    if (edit)
      isSelected = List.generate(4, (f) => f == correctAns);
    else
      isSelected = List.generate(4, (f) => false);
  }

  select(int index) {
    for (var i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    isCorrect = index == correctAns;
    notifyListeners();
  }
}
