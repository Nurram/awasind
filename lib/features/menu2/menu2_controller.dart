import 'dart:developer';
import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Menu2Controller extends GetxController {
  final pdfPath = ''.obs;

  @override
  void onInit() async {
    fromAsset('assets/qna.pdf', 'qna.pdf').then((f) {
      pdfPath(f.path);
    });

    super.onInit();
  }

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();

    try {
      var dir = await getTemporaryDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      log(e.toString());
    }

    return completer.future;
  }

  downloadFile() async {
    try {
      var dir = await getExternalStorageDirectory();
      File file = File("/storage/emulated/0/Download/qna.pdf");
      var data = await rootBundle.load('assets/qna.pdf');
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);

      Utils.showGetSnackbar(
          'File disimpan di: /storage/emulated/0/Download/qna.pdf', true);
    } catch (e) {
      log(e.toString());
    }
  }
}
