import 'package:awasind/features/header.dart';
import 'package:awasind/features/urugan/urugan_result_screen.dart';
import 'package:awasind/features/walls/new_walls_result_screen.dart';

import '../../core_imports.dart';
import '../guide_screen.dart';
import 'ceramics_result_screen.dart';

class CeramicsScreen extends StatefulWidget {
  const CeramicsScreen({super.key});

  @override
  State<CeramicsScreen> createState() => _CeramicsScreenState();
}

class _CeramicsScreenState extends State<CeramicsScreen> {
  final pCtr = TextEditingController();
  final lCtr = TextEditingController();
  final wideCtr = TextEditingController();

  final types = <String>[
    'Lantai keramik uk 30sd<40',
    'Lantai Keramik Uk 20sd<30',
    'Tealux Marmer uk 60x60',
    'Teralux Marmer uk 40x40',
    'Granit Uk 30x30',
    'Teralux 30x30',
    'Lantai Teraso 40x40',
  ];
  String selectedType = 'Lantai keramik uk 30sd<40';

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
                  Get.to(() => GuideScreen(type: 'keramik'));
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
                    textEditingController: lCtr,
                    labelText: 'l',
                  ),
                  CustomLabeledDropdown(
                    bgColor: Colors.white,
                    label: 'Bahan',
                    items: types,
                    onSelect: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                    selectedValue: selectedType,
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'Cek',
                    onPressed: () {
                      if (pCtr.text.isNotEmpty && lCtr.text.isNotEmpty) {
                        wideCtr.text =
                            (double.parse(pCtr.text) * double.parse(lCtr.text))
                                .toString();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    textEditingController: wideCtr,
                    labelText: 'Luas lantai (m2)',
                    readOnly: true,
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'HITUNG',
                    onPressed: () {
                      if (wideCtr.text.isNotEmpty) {
                        Get.to(() => const CeramicsResultScreen(), arguments: {
                          'wide': wideCtr.text,
                          'type': selectedType,
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
