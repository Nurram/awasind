import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:awasind/features/menu2/menu2_binding.dart';
import 'package:awasind/features/menu2/menu2_controller.dart';
import 'package:awasind/features/preview_screen.dart';

import '../header.dart';
import 'menu3_controller.dart';

class Menu3Screen extends GetView<Menu3Controller> {
  const Menu3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();

    return Scaffold(
      body: Column(
        children: [
          const Header(),
          const SizedBox(height: 32),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final file = controller.files[(index + 1).toString()];

                  return InkWell(
                    onTap: () => Get.to(() => const PreviewScreen(),
                        arguments: file['realPath']),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(file['name']),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
