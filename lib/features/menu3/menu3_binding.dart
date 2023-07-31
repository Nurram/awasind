import 'package:awasind/core_imports.dart';

import 'menu3_controller.dart';

class Menu3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Menu3Controller());
  }
}
