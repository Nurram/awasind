import 'package:awasind/features/header.dart';
import 'package:awasind/features/urugan/urugan_result_screen.dart';

import '../../core_imports.dart';
import '../guide_screen.dart';

class UruganScreen extends StatefulWidget {
  const UruganScreen({super.key});

  @override
  State<UruganScreen> createState() => _UruganScreenState();
}

class _UruganScreenState extends State<UruganScreen> {
  final pCtr = TextEditingController();
  final aCtr = TextEditingController();
  final bCtr = TextEditingController();
  final tCtr = TextEditingController();

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
                  Get.to(() => GuideScreen(type: 'urugan'));
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
                    textEditingController: pCtr,
                    labelText: 'p',
                  ),
                  CustomTextFormField(
                    textEditingController: aCtr,
                    labelText: 'a',
                  ),
                  CustomTextFormField(
                    textEditingController: bCtr,
                    labelText: 'b',
                  ),
                  CustomTextFormField(
                    textEditingController: tCtr,
                    labelText: 't',
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'HITUNG',
                    onPressed: () {
                      if (pCtr.text.isNotEmpty &&
                          aCtr.text.isNotEmpty &&
                          bCtr.text.isNotEmpty &&
                          tCtr.text.isNotEmpty) {
                        Get.to(() => const UruganResultScreen(), arguments: {
                          'p': pCtr.text,
                          'a': aCtr.text,
                          'b': bCtr.text,
                          't': tCtr.text,
                        });
                      }
                    },
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
