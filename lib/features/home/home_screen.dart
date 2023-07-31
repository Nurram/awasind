import 'package:awasind/core_imports.dart';
import 'package:awasind/features/header.dart';
import 'package:awasind/features/menu1/menu1_screen.dart';
import 'package:awasind/features/menu2/menu2_binding.dart';
import 'package:awasind/features/menu2/menu2_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../menu3/menu3_binding.dart';
import '../menu3/menu3_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                CustomElevatedButton(
                    text: 'Perhitungan Volume Pekerjaan dan Kebutuhan Pekerja',
                    onPressed: () {
                      Get.to(() => const Menu1Screen());
                    }),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  text: 'QnA Pengadaan Barang Dan Jasa Di Desa',
                  onPressed: () async {
                    if (await Permission.storage.request().isGranted) {
                      Get.to(() => const Menu2Screen(),
                          binding: Menu2Binding());
                    } else {
                      Get.back();
                      Utils.showGetSnackbar(
                          'Permission harus disetujui!', false);
                    }
                  },
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                    text:
                        'Kumpulan Peraturan Terkait Pengadaan Barang dan Jasa di Desa',
                    onPressed: () async {
                      if (await Permission.storage.request().isGranted) {
                        Get.to(() => const Menu3Screen(),
                            binding: Menu3Binding());
                      } else {
                        Get.back();
                        Utils.showGetSnackbar(
                            'Permission harus disetujui!', false);
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
