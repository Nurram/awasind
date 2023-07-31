import 'dart:developer';

import 'package:awasind/core_imports.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        filePath: Get.arguments,
        onError: (error) {
          log(error.toString());
        },
      ),
    );
  }
}
