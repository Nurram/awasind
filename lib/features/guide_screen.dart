import 'package:awasind/core_imports.dart';
import 'package:awasind/features/header.dart';

class GuideScreen extends StatelessWidget {
  final String type;
  GuideScreen({super.key, required this.type});

  final datas = <String, dynamic>{
    'paving': {
      'path': 'assets/paving.png',
      'desc': 'a = lebar sisi kiri paving (diukur dari ujung paving/uskup jika ada)'
          'b = lebar sisi kanan paving (diukur dari ujung paving/ uskup jika ada)'
          'p = panjang paving'
          'K= Total panjang kanstin (satuan m1)'
          'U= Total panjang uskup (satuan m1)'
    },
    'dinding': {
      'path': 'assets/dinding.png',
      'desc': 'p = Panjang dinding (m) '
          't = Tinggi dinding (m)'
    },
    'urugan': {
      'path': 'assets/urugan.png',
      'desc': 'a = lebar urugan sisi kiri '
          'b = lebar urugan sisi kanan'
          'p = panjang urugan'
          't = rata-rata tinggi urugan '
    },
    'keramik': {
      'path': 'assets/keramik.png',
      'desc': ' P = Panjang Total Ruangan yang dipasang Ubim/Keramik'
          'L = Lebar Ruangan yang dipasang Ubin/Keramik'
          'Luas Lantai = Luas 1 + Luas 2 + ................'
    },
    'pengecatan': {
      'path': 'assets/pengecatan.png',
      'desc': 'P = Panjang bidang Tembok yang di cat'
          'T = Tinggi bidang tembok yang di cat'
          'Luas Bidang = Luas 1(P1xL1) + Luas 2(P2xL2) + ................'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(),
          Image.asset(
            datas[type]['path'],
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(), color: Colors.grey.shade300),
            child: Text(
              datas[type]['desc'],
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomElevatedButton(text: 'Back', onPressed: Get.back),
          )
        ],
      ),
    );
  }
}
