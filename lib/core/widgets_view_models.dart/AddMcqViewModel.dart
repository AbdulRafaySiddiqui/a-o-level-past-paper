import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/McqModel.dart';
import 'package:past_papers/core/services/Api.dart';

class AddMcqViewModel extends BaseViewModel {
  AddMcqViewModel(String paperId) {
    mcq = api.getMcq(paperId);
    if (mcq != null) {
      edit = true;
    } else {
      mcq = Mcq(paperId: paperId, mcqAns: []);
    }
  }
  var api = locator<Api>();
  Mcq mcq;
  String paperId;
  bool uploading = false;
  bool edit = false;

  addMcq() {
    mcq.mcqAns.add(null);
    notifyListeners();
  }

  removeMcq() {
    if (mcq.mcqAns.isNotEmpty) {
      mcq.mcqAns.removeLast();
      notifyListeners();
    }
  }

  select(int index, int value) {
    mcq.mcqAns[index] = value;
  }

  save() async {
    uploading = true;
    notifyListeners();
    if (edit) {
      await api.updateMcq(mcq);
    } else {
      await api.addMcq(mcq);
    }

    uploading = false;
    notifyListeners();
  }
}
