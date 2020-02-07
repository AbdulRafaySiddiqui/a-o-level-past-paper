import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:past_papers/core/Base/BaseViewModel.dart';
import 'package:past_papers/core/Base/locator.dart';
import 'package:past_papers/core/models/PaperModel.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/DatabaseService.dart';
import 'package:past_papers/core/services/Helper.dart';
import 'package:past_papers/core/services/NavigationService.dart';

class AddPaperViewModel extends BaseViewModel {
  AddPaperViewModel({@required this.subjectId, this.paper}) {
    if (subjectId == null) {
      edit = true;
    }
    seasons = List.generate(3, (index) => false);
    paperTypes = List.generate(4, (index) => false);
    paperNumberTypes = List.generate(5, (index) => false);
    paperVariantTypes = List.generate(5, (index) => false);

    if (edit) {
      seasons[paper.seasonType - 1] = true;
      paperTypes[paper.paperType - 1] = true;
      paperNumberTypes[paper.paperNumberType] = true;
      paperVariantTypes[paper.paperVariantType] = true;
      year = paper.year;
      notifyListeners();
    } else {
      seasons[0] = true;
      paperTypes[0] = true;
      paperNumberTypes[0] = true;
      paperVariantTypes[0] = true;
    }
  }

  var api = locator<Api>();
  var navigation = locator<NavigationService>();
  String subjectId;
  Paper paper;
  int year = 2020;
  String fileName = '';
  String filepath = '';
  List<int> getYears() => List<int>.generate(26, (index) => 2000 + index);
  List<bool> seasons;
  List<bool> paperTypes;
  List<bool> paperNumberTypes;
  List<bool> paperVariantTypes;
  bool attachingFile = false;
  bool uploading = false;
  bool showError = false;
  bool edit = false;
  File pdf;

  IconData getPaperTypeIcon(int value) => Helper.getPaperTypeIcon(value);

  IconData getPaperNumberIcon(int value) => Helper.getPaperNumberIcon(value);

  IconData getSeasonIcon(int value) => Helper.getSeasonIcon(value);

  IconData getVariantIcon(int value) => Helper.getVariantIcon(value);

  selectSeason(int value) {
    for (var i = 0; i < seasons.length; i++) {
      seasons[i] = value == i;
    }
    notifyListeners();
  }

  selectPaperType(int value) {
    for (var i = 0; i < paperTypes.length; i++) {
      paperTypes[i] = value == i;
    }
    notifyListeners();
  }

  selectPaperNumber(int value) {
    for (var i = 0; i < paperNumberTypes.length; i++) {
      paperNumberTypes[i] = value == i;
    }
    notifyListeners();
  }

  selectPaperVariant(int value) {
    for (var i = 0; i < paperVariantTypes.length; i++) {
      paperVariantTypes[i] = value == i;
    }
    notifyListeners();
  }

  selectYear(int value) {
    year = value;
    notifyListeners();
  }

  attachPdf() async {
    attachingFile = true;
    notifyListeners();

    var file =
        await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'pdf');
    if (file != null) {
      pdf = file;
      fileName = pdf.path?.split("/")?.last;
      filepath = pdf.path;
    }
    attachingFile = false;
    notifyListeners();
  }

  add() async {
    uploading = true;
    notifyListeners();
    //adding 1 becuase the paper model has also index for [ALL] while this [AddPaper] doesn't

    if (edit) {
      await api.updatePaper(Paper(
          paperId: paper.paperId,
          paperNumberType: paperNumberTypes.indexWhere((item) => item == true),
          paperType: paperTypes.indexWhere((item) => item == true) + 1,
          paperVariantType:
              paperVariantTypes.indexWhere((item) => item == true),
          seasonType: seasons.indexWhere((item) => item == true) + 1,
          subjectId: paper.subjectId,
          year: year,
          filePath: filepath,
          update: filepath.isNotEmpty));
    } else {
      showError = (await api.addPaper(Paper(
              paperId: getGuid(),
              paperNumberType:
                  paperNumberTypes.indexWhere((item) => item == true),
              paperType: paperTypes.indexWhere((item) => item == true) + 1,
              paperVariantType:
                  paperVariantTypes.indexWhere((item) => item == true),
              seasonType: seasons.indexWhere((item) => item == true) + 1,
              subjectId: subjectId,
              year: year,
              filePath: filepath,
              update: filepath.isNotEmpty))) ==
          DatabaseRespone.DuplicatePaper;
    }
    uploading = false;
    if (showError) {
      notifyListeners();
      return;
    }
    navigation.goBack();
  }
}
