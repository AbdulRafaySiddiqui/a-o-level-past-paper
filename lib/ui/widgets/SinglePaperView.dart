import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/view_models/PaperViewerViewModel.dart';
import 'package:past_papers/ui/widgets/AddMcq.dart';
import 'package:past_papers/ui/widgets/McqSolver.dart';
import 'package:provider/provider.dart';

class SinglePaperView extends StatelessWidget {
  SinglePaperView();
  @override
  Widget build(BuildContext context) {
    return Consumer<PaperViewerViewModel>(
      builder:
          (BuildContext context, PaperViewerViewModel model, Widget child) =>
              Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Switch(
                    value: model.launchMcqSolver,
                    onChanged: (bool value) => model.changeLaunchSolver(value),
                  ),
                  Text('MCQ Solver'),
                  IconButton(
                    color: Colors.blue,
                    icon: Icon(FontAwesomeIcons.redoAlt),
                    onPressed: () => model.redownloadPdf(),
                  ),
                  Text('Live Check'),
                  Switch(
                    value: model.liveCheck,
                    onChanged: model.launchMcqSolver
                        ? (bool value) => model.changeLiveCheck(value)
                        : null,
                  ),
                ],
              ),
            ),
            if (!isUserVersion) ...{
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Edit MCQ'),
                    Switch(
                      value: model.edit,
                      onChanged: (bool value) => model.changeEdit(value),
                    ),
                  ],
                ),
              )
            },
            Expanded(
              child: PDFView(
                key: UniqueKey(),
                pageFling: false,
                filePath: model.papers[0].filePath,
                autoSpacing: true,
                enableSwipe: true,
                pageSnap: true,
                swipeHorizontal: false,
                onViewCreated: (PDFViewController controller) {},
              ),
            ),
            if (model.launchMcqSolver || model.edit) ...{
              Container(
                color: Colors.blue,
                height: 10,
              ),
              model.edit
                  ? Expanded(
                      child: AddMcq(paperId: model.papers[0].paperId),
                    )
                  : model.mcqAnswers[0] == null
                      ? Expanded(
                          child: Center(
                            child: Text('No MCQ Found!'),
                          ),
                        )
                      : Expanded(
                          child: McqSolver(
                            liveCheck: model.liveCheck,
                            mcqList: model.mcqAnswers[0].mcqAns,
                          ),
                        ),
            }
          ],
        ),
      ),
    );
  }
}
