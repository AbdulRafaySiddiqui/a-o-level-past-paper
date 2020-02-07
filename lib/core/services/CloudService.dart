import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum FileType { Pdf, Database }
enum CloudResponse { Success, Error, Timeout, BadConnection }

class CloudService {
  Future<CloudResponse> uploadFile(String filePath, String filename,
      {FileType fileType = FileType.Pdf}) async {
    try {
      String path;
      if (fileType == FileType.Pdf) {
        path = 'pdf/$filename';
      } else if (fileType == FileType.Database) {
        path = 'database/database';
      }
      StorageReference storageReference;
      File file = File(filePath);
      storageReference = FirebaseStorage.instance.ref().child(path);

      final StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      return CloudResponse.Success;
    } catch (exception) {
      return CloudResponse.Error;
    }
  }

  Future<void> downloadFile(
      String filename, String savePath, Function(int, int) onProgress,
      {FileType fileType = FileType.Pdf}) async {
    // StorageReference ref =
    //     FirebaseStorage.instance.ref().child("pdf/$filename");
    // final File tempFile = File(path);
    // if (tempFile.existsSync()) {
    //   await tempFile.delete();
    // }
    // await tempFile.create();
    // var tast = ref.writeToFile(tempFile);
    // await tast.future.whenComplete(() {});

    String cloudFilePath;
    if (fileType == FileType.Pdf) {
      cloudFilePath = "pdf/$filename";
    } else if (fileType == FileType.Database) {
      cloudFilePath = "database/$filename";
    }
    Dio dio = Dio();
    var url = await FirebaseStorage.instance
        .ref()
        .child(cloudFilePath)
        .getDownloadURL();
    await dio.download(url, savePath, onReceiveProgress: onProgress);
  }

  Future<bool> exists(String filename) async {
    StorageReference storageRef = FirebaseStorage.instance.ref();
    try {
      await storageRef.child(filename).getDownloadURL();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<CloudResponse> deleteFile(String filepath) async {
    try {
      var result = await exists(filepath);
      if (result) await FirebaseStorage.instance.ref().child(filepath).delete();
      return CloudResponse.Success;
    } catch (ex) {
      return CloudResponse.Success;
    }
  }
}
