import 'package:awasind/core_imports.dart';
import 'package:awasind/features/header.dart';
import 'package:awasind/features/paving/paving_controller.dart';

import '../guide_screen.dart';

class PavingScreen extends StatelessWidget {
  PavingScreen({super.key});

  final controller = PavingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CustomElevatedButton(
                text: 'Panduan',
                onPressed: () {
                  Get.to(() => GuideScreen(type: 'paving'));
                },
                width: 120,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.white,
                    child: const Text('Isikan dalam satuan Meter (M)'),
                  ),
                  CustomTextFormField(
                    textEditingController: controller.pCtr,
                    labelText: 'p',
                  ),
                  CustomTextFormField(
                    textEditingController: controller.aCtr,
                    labelText: 'a',
                  ),
                  CustomTextFormField(
                    textEditingController: controller.bCtr,
                    labelText: 'b',
                  ),
                  CustomTextFormField(
                    textEditingController: controller.kCtr,
                    labelText: 'K',
                  ),
                  CustomTextFormField(
                    textEditingController: controller.uCtr,
                    labelText: 'U',
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'HITUNG',
                    onPressed: controller.moveScreen,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
