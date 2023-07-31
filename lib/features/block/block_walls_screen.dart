import 'package:awasind/features/block/block_walls_result_screen.dart';
import 'package:awasind/features/header.dart';
import 'package:awasind/features/urugan/urugan_result_screen.dart';
import 'package:awasind/features/walls/new_walls_result_screen.dart';

import '../../core_imports.dart';
import '../guide_screen.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  final pCtr = TextEditingController();
  final tCtr = TextEditingController();
  final wideCtr = TextEditingController();

  final mixes = <String>['1:4', '1:3'];
  String selectedMix = '1:4';

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
                  Get.to(() => GuideScreen(type: 'dinding'));
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
                  CustomLabeledDropdown(
                      label: 'Pilih Campuran',
                      bgColor: Colors.white,
                      items: mixes,
                      onSelect: (value) {
                        setState(() {
                          selectedMix = value;
                        });
                      },
                      selectedValue: selectedMix),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'HITUNG',
                    onPressed: () {
                      if (wideCtr.text.isNotEmpty) {
                        Get.to(() => const BlockWallsResultScreen(),
                            arguments: {
                              'wide': wideCtr.text,
                              'mix': selectedMix,
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
