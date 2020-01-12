import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:past_papers/components/Splitter.dart';
import 'package:past_papers/constants/constants.dart';
import 'package:path_provider/path_provider.dart';

class PaperViewer extends StatefulWidget {
  static String id = 'PaperViewer';
  final String courseName;
  PaperViewer({this.courseName = 'Acounting (9706)'});
  @override
  _PaperViewerState createState() => _PaperViewerState();
}

class _PaperViewerState extends State<PaperViewer> {
  String assetPDFPath = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();

    getFileFromAsset("assets/samplePdf.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.courseName,
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.courseName,
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  FlatButton(
                    child: Text('Reload'),
                    onPressed: () {
                      getFileFromAsset("assets/samplePdf.pdf").then((f) {
                        setState(() {
                          assetPDFPath = f.path;
                          loading = false;
                        });
                      });
                    },
                  ),
                  Expanded(
                    child: Splitter(
                      top: PDFView(
                        pageFling: false,
                        filePath: assetPDFPath,
                        autoSpacing: true,
                        enableSwipe: true,
                        pageSnap: true,
                        swipeHorizontal: false,
                      ),
                      bottom: PDFView(
                        pageFling: true,
                        filePath: assetPDFPath,
                        autoSpacing: true,
                        enableSwipe: true,
                        pageSnap: true,
                        swipeHorizontal: false,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}



Future<File> getFileFromAsset(String asset) async {
  try {
    var data = await rootBundle.load(asset);
    var bytes = data.buffer.asUint8List();
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/samplePdf.pdf");

    File assetFile = await file.writeAsBytes(bytes);
    return assetFile;
  } catch (e) {
    throw Exception("Error opening asset file");
  }
}
