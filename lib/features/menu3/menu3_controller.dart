import 'dart:developer';
import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Menu3Controller extends GetxController {
  final pdfPath = ''.obs;
  final files = <String, dynamic>{
    '1': {
      'name':
          'Peraturan Bupati Nomor 11 Tahun 2021 TATA CARA PENGANGGARAN, PELAKSANAAN DAN PENATAUSAHAAN',
      'path': 'assets/rule1.pdf',
    },
    '2': {
      'name':
          'Peraturan Bupati Nomor 102 Tahun 2022 tentang petunjuk teknis penyusunan rencana pembangunan jangka menengah desa dan rencana kerja pemerintah desa, serta pelaksanaan kegiatan pembangunan desa',
      'path': 'assets/rule2.pdf',
    },
    '3': {
      'name':
          'Peraturan Lembaga Nomor 11 Tahun 2021 tentang pengadaan barang dan jasa pemerintah',
      'path': 'assets/rule3.pdf',
    },
    '4': {
      'name':
          'Peraturan LKPP Nomor 12 Tahun 2019 tentang pengadaan barang atau jasa di desa',
      'path': 'assets/rule4.pdf',
    },
  };

  @override
  void onInit() async {
    files.forEach((key, value) {
      fromAsset(value['path'], '${value['path']}'.replaceAll('assets/', ''))
          .then((f) {
        files[key]['realPath'] = f.path;
      });
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
