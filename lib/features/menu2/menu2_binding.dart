import 'package:awasind/core_imports.dart';
import 'package:awasind/features/menu2/menu2_controller.dart';

class Menu2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Menu2Controller());
  }
}
