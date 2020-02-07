import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Helper {
  static String getPaperTitle(int paperType) {
    switch (paperType) {
      case 0:
        return 'All';
        break;
      case 1:
        return 'Question Paper';
        break;
      case 2:
        return 'Marking Scheme';
        break;
      case 3:
        return 'Examinor Report';
        break;
      case 4:
        return 'Grade Threshold';
        break;
    }
    return '';
  }

  static String getsubtitle(int paperNumberType, int paperVariantType) {
    String _paperNumber;
    String _paperVariant;

    switch (paperNumberType) {
      case 0:
        _paperNumber = 'All Papers';
        break;
      case 1:
        _paperNumber = 'Paper 1';
        break;
      case 2:
        _paperNumber = 'Paper 2';
        break;
      case 3:
        _paperNumber = 'Paper 3';
        break;
      case 4:
        _paperNumber = 'Paper 4';
        break;
    }

    switch (paperVariantType) {
      case 0:
        _paperVariant = 'All Variants';
        break;
      case 1:
        _paperVariant = 'Variant 1';
        break;
      case 2:
        _paperVariant = 'Variant 2';
        break;
      case 3:
        _paperVariant = 'Variant 3';
        break;
      case 4:
        _paperVariant = 'Variant 4';
        break;
    }

    return '$_paperNumber $_paperVariant';
  }

  ///0 => All,
  ///1 => Question paper (QP),
  ///2 => Marking Scheme (MS),
  ///3 => Examinor Report (ER),
  ///4 => Grade Threshold (GT),
  static IconData getPaperTypeIcon(int paperType) {
    IconData icon;
    switch (paperType) {
      case 0:
        icon = IconData(0xe900, fontFamily: 'icomoon');
        break;
      case 1:
        icon = IconData(0xe907, fontFamily: 'icomoon');
        break;
      case 2:
        icon = IconData(0xe905, fontFamily: 'icomoon');
        break;
      case 3:
        icon = IconData(0xe902, fontFamily: 'icomoon');
        break;
      case 4:
        icon = IconData(0xe904, fontFamily: 'icomoon');
        break;
    }

    return icon;
  }

  ///0 => All Papers,
  ///1 => Paper 1,
  ///2 => Paper 2,
  ///3 => Paper 3,
  ///4 => Paper 4,
  static IconData getPaperNumberIcon(int paperNumberType) {
    IconData icon;
    switch (paperNumberType) {
      case 0:
        icon = IconData(0xe901, fontFamily: 'icomoon');
        break;
      case 1:
        icon = IconData(0xe906, fontFamily: 'icomoon');
        break;
      case 2:
        icon = IconData(0xe909, fontFamily: 'icomoon');
        break;
      case 3:
        icon = IconData(0xe908, fontFamily: 'icomoon');
        break;
      case 4:
        icon = IconData(0xe903, fontFamily: 'icomoon');
        break;
    }
    return icon;
  }

  ///0 => All Seasons,
  ///1 => Summer,
  ///2 => March,
  ///3 => Winter,
  static IconData getSeasonIcon(int seasonType) {
    IconData icon;
    switch (seasonType) {
      case 0:
        icon = IconData(0xe90b, fontFamily: 'icomoon');
        break;
      case 1:
        icon = FontAwesomeIcons.solidSun;
        break;
      case 2:
        icon = FontAwesomeIcons.cloudSun;
        break;
      case 3:
        icon = IconData(0xe90a, fontFamily: 'icomoon');
        break;
    }
    return icon;
  }

  ///0 => All Variants,
  ///1 => Variant 1,
  ///2 => Variant 2,
  ///3 => Variant 3
  ///3 => Variant 4,
  static IconData getVariantIcon(int value) {
    IconData icon;
    switch (value) {
      case 0:
        icon = FontAwesomeIcons.vuejs;
        break;
      case 1:
        icon = FontAwesomeIcons.vuejs;
        break;
      case 2:
        icon = FontAwesomeIcons.vuejs;
        break;
      case 3:
        icon = FontAwesomeIcons.vuejs;
        break;
      case 4:
        icon = FontAwesomeIcons.vuejs;
        break;
    }
    return icon;
  }

  ///0 => All Variants,
  ///1 => Variant 1,
  ///2 => Variant 2,
  ///3 => Variant 3
  ///3 => Variant 4,
  static String getVariantText(int value) {
    String text;
    switch (value) {
      case 0:
        text = 'All Variants';
        break;
      case 1:
        text = 'Variant 1';
        break;
      case 2:
        text = 'Variant 2';
        break;
      case 3:
        text = 'Variant 3';
        break;
      case 4:
        text = 'Variant 4';
        break;
    }
    return text;
  }

  static Future<File> getFile(String fileName) async {
    try {
      var data = await rootBundle.load(fileName);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      var path = "${dir.path}/$fileName";
      File file = File(path);

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  static Future<String> getFilePath(String fileName) async {
    var path = await getApplicationDocumentsDirectory();
    return '${path.path}/$fileName';
  }

  static Future<bool> doesfileExists(String fileName) async {
    var path = await getApplicationDocumentsDirectory();
    return await File('${path.path}/$fileName').exists();
  }

  static Future<void> deleteFile(String fileName) async {
    var path = await getApplicationDocumentsDirectory();
    return await File('${path.path}/$fileName').delete();
  }
}


