import 'package:awasind/core_imports.dart';
import 'package:awasind/features/block/block_walls_screen.dart';
import 'package:awasind/features/walls/new_walls_screen.dart';

import '../ceramics/ceramics_screen.dart';
import '../header.dart';
import '../hebel/hebel_walls_screen.dart';
import '../paving/paving_screen.dart';
import '../urugan/urugan_screen.dart';
import '../walls/old_walls_screen.dart';

class Menu1Screen extends StatelessWidget {
  const Menu1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          const SizedBox(height: 32),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView(
                children: [
                  CustomElevatedButton(
                    text: 'Paving',
                    onPressed: () => Get.to(
                      () => PavingScreen(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                      text: 'Urugan',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UruganScreen(),
                          ),
                        );
                      }),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                      text: 'Pengecatan Tembok Baru',
                      onPressed: () {
                        Get.to(() => const NewsWallsScreen());
                      }),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                      text: 'Pengecatan Tembok Lama',
                      onPressed: () {
                        Get.to(() => const OldWallsScreen());
                      }),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                      text: 'Pemasangan Keramik',
                      onPressed: () {
                        Get.to(() => const CeramicsScreen());
                      }),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                      text: 'Pemasangan Dinding Bata Merah',
                      onPressed: () {
                        Get.to(() => const BlockScreen());
                      }),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                      text: 'Pemasangan Dinding Bata Ringan',
                      onPressed: () {
                        Get.to(() => const HebelScreen());
                      }),
                  const SizedBox(height: 24),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.home,
                      size: 48,
                    ),
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
