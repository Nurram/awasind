import 'package:awasind/features/header.dart';
import 'package:awasind/features/urugan/urugan_result_screen.dart';
import 'package:awasind/features/walls/new_walls_result_screen.dart';
import 'package:awasind/features/walls/old_walls_result_screen.dart';

import '../../core_imports.dart';
import '../guide_screen.dart';

class OldWallsScreen extends StatefulWidget {
  const OldWallsScreen({super.key});

  @override
  State<OldWallsScreen> createState() => _OldWallsScreenState();
}

class _OldWallsScreenState extends State<OldWallsScreen> {
  final pCtr = TextEditingController();
  final tCtr = TextEditingController();
  final wideCtr = TextEditingController();

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
                  Get.to(() => GuideScreen(type: 'pengecatan'));
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
                    textEditingController: tCtr,
                    labelText: 't',
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'Cek',
                    onPressed: () {
                      if (pCtr.text.isNotEmpty && tCtr.text.isNotEmpty) {
                        wideCtr.text =
                            (double.parse(pCtr.text) * double.parse(tCtr.text))
                                .toString();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    textEditingController: wideCtr,
                    labelText: 'Luas bidang (m2)',
                    readOnly: true,
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'HITUNG',
                    onPressed: () {
                      if (wideCtr.text.isNotEmpty) {
                        Get.to(() => const OldWallsResultScreen(), arguments: {
                          'wide': wideCtr.text,
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
