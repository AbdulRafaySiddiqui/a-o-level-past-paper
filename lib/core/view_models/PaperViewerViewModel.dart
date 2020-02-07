import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/McqModel.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/Helper.dart';

class PaperViewerViewModel extends BaseViewModel {
  var api = locator<Api>();
  PaperViewerViewModel(this.papers) {
    mcqAnswers = [];
    for (var paper in papers) {
      mcqAnswers.add(api.getMcq(paper.paperId));
    }
    loadPaths();
  }

  List<Paper> papers;
  List<Mcq> mcqAnswers;
  bool isLoading = true;
  bool isDownloading = false;
  bool isDownloadSuccess = true;
  String downloadProgress = '0';
  bool launchMcqSolver = false;
  bool liveCheck = false;
  bool edit = false;

  loadPaths() async {
    isLoading = true;
    notifyListeners();
    for (var paper in papers) {
      //check if file exist
      var fileExists = await Helper.doesfileExists('${paper.paperId}');
      if (fileExists) {
        //load file path
        paper.filePath = await Helper.getFilePath('${paper.paperId}');
      }
      //if file does not exists then download it
      else {
        isDownloading = true;
        notifyListeners();
        var isDownloaded =
            await api.downloadFile(paper.paperId, (received, total) {
          downloadProgress = ((received / total) * 100).toStringAsFixed(0);
          notifyListeners();
        });
        isDownloading = false;
        downloadProgress = '0';
        notifyListeners();
        //if download was success full load file path
        if (isDownloaded) {
          //check if file exist
          var fileExists = await Helper.doesfileExists('${paper.paperId}');
          if (fileExists) {
            //load file path
            paper.filePath = await Helper.getFilePath('${paper.paperId}');
          } else {
            isDownloadSuccess = false;
            notifyListeners();
          }
        }
        //if download failed show error
        else {
          isDownloadSuccess = false;
          notifyListeners();
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }

  changeLiveCheck(bool value) {
    liveCheck = value;
    notifyListeners();
  }

  changeLaunchSolver(bool value) {
    if (edit && value) {
      edit = false;
    }
    launchMcqSolver = value;
    notifyListeners();
  }

  changeEdit(bool value) {
    if (launchMcqSolver && value) {
      launchMcqSolver = false;
    }
    edit = value;
    notifyListeners();
  }

  redownloadPdf() async {
    try {
      var paper = papers[0];
      isLoading = true;
      isDownloading = true;
      notifyListeners();
      isDownloadSuccess =
          await api.redownloadPdf(paper.paperId, (received, total) {
        downloadProgress = ((received / total) * 100).toStringAsFixed(0);
        notifyListeners();
      });
      isDownloading = false;
      downloadProgress = '0';
      notifyListeners();
      //if download was success full load file path
      if (isDownloadSuccess) {
        //check if file exist
        var fileExists = await Helper.doesfileExists('${paper.paperId}');
        if (fileExists) {
          //load file path
          paper.filePath = await Helper.getFilePath('${paper.paperId}');
        } else {
          isDownloadSuccess = false;
          notifyListeners();
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isDownloadSuccess = false;
      isLoading = false;
      notifyListeners();
    }
  }
}
