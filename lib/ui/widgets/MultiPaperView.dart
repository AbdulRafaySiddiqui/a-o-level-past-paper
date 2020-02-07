import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:past_papers/core/view_models/PaperViewerViewModel.dart';
import 'package:provider/provider.dart';

class MultiPaperView extends StatelessWidget {
  MultiPaperView();
  @override
  Widget build(BuildContext context) {
    return Consumer<PaperViewerViewModel>(
      builder:
          (BuildContext context, PaperViewerViewModel model, Widget child) =>
              Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PDFView(
                filePath: model.papers[0].filePath,
                enableSwipe: true,
                swipeHorizontal: false,
              ),
            ),
            Container(
              color: Colors.blue,
              height: 10,
            ),
            Expanded(
              child: PDFView(
                filePath: model.papers[1].filePath,
                enableSwipe: true,
                swipeHorizontal: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
