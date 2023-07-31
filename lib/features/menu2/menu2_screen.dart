import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:awasind/features/menu2/menu2_binding.dart';
import 'package:awasind/features/menu2/menu2_controller.dart';
import 'package:awasind/features/preview_screen.dart';

import '../header.dart';

class Menu2Screen extends GetView<Menu2Controller> {
  const Menu2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();

    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              'QnA Pengadaan Barang dan Jasa di Desa',
              textAlign: TextAlign.center,
              style: CustomTextStyle.black24w400(),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomElevatedButton(
              text: 'Preview',
              onPressed: () => Get.to(() => const PreviewScreen(),
                  arguments: controller.pdfPath.value),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomElevatedButton(
              text: 'Download',
              onPressed: () => controller.downloadFile(),
            ),
          ),
        ],
      ),
    );
  }
}
