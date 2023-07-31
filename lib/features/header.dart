import 'package:awasind/core_imports.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade300,
      child: Image.asset(
        'assets/logo.png',
        width: Get.width,
        fit: BoxFit.cover,
      ),
    );
  }
}