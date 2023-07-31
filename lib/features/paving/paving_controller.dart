import 'package:awasind/core_imports.dart';
import 'package:awasind/features/paving/paving_result_screen.dart';

class PavingController extends GetxController {
  final pCtr = TextEditingController();
  final aCtr = TextEditingController();
  final bCtr = TextEditingController();
  final kCtr = TextEditingController();
  final uCtr = TextEditingController();

  moveScreen() {
    final p = pCtr.text;
    final a = aCtr.text;
    final b = bCtr.text;
    final k = kCtr.text;
    final u = uCtr.text;

    if (p.isEmpty && a.isEmpty && b.isEmpty && k.isEmpty && u.isEmpty) return;

    Get.to(() => const PavingResultScreen(),
        arguments: {'p': p, 'a': a, 'b': b, 'k': k, 'u': u});
  }
}
