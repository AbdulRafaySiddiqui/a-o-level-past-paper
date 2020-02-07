import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/core/Base/BaseView.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/view_models/PaperViewerViewModel.dart';
import 'package:past_papers/ui/widgets/MultiPaperView.dart';
import 'package:past_papers/ui/widgets/SinglePaperView.dart';

class PaperViewerView extends StatelessWidget {
  PaperViewerView({this.papers});
  final List<Paper> papers;
  @override
  Widget build(BuildContext context) {
    return BaseView<PaperViewerViewModel>.withConsumer(
      viewModel: PaperViewerViewModel(papers),
      builder:
          (BuildContext context, PaperViewerViewModel model, Widget child) =>
              SafeArea(
        child: Scaffold(
          body: model.isLoading
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      if (model.isDownloading)
                        Text('Downloading: ${model.downloadProgress} %'),
                    ],
                  ),
                )
              : !model.isDownloadSuccess
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Error while downloading.'),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.redoAlt),
                            onPressed: () => model.redownloadPdf(),
                          ),
                        ],
                      ),
                    )
                  : papers.length == 1 ? SinglePaperView() : MultiPaperView(),
        ),
      ),
    );
  }
}
