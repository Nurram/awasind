import 'dart:developer';
import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:awasind/features/header.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BlockWallsResultScreen extends StatefulWidget {
  const BlockWallsResultScreen({super.key});

  @override
  State<BlockWallsResultScreen> createState() => _BlockWallsResultScreenState();
}

class _BlockWallsResultScreenState extends State<BlockWallsResultScreen> {
  num blockVolume = 0;
  num blockPrice = 0;
  num portlandVolume = 0;
  num protlandPrice = 0;
  num pasirVolume = 0;
  num pasirPrice = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Get.arguments['mix'] == '1:3' ? _calculate1and3() : _calculate1and4();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: Colors.orange,
            child: Text(
              'Material yang dibutuhkan',
              style: CustomTextStyle.white(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  _buildTableItem(value: 'Kebutuhan bahan / material'),
                  _buildTableItem(value: 'Satuan'),
                  _buildTableItem(value: 'Volume / Jumlah'),
                  _buildTableItem(value: 'SSH (Rp)'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Bata Merah'),
                  _buildTableItem(value: 'bh'),
                  _buildTableItem(value: blockVolume.toStringAsFixed(2)),
                  _buildTableItem(value: 'Rp${Utils.numberFormat(blockPrice)}'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Semen Portland'),
                  _buildTableItem(value: 'kg'),
                  _buildTableItem(value: portlandVolume.toStringAsFixed(2)),
                  _buildTableItem(
                      value:
                          'Rp${Utils.numberFormat(protlandPrice)}\n(${(portlandVolume / 40).toStringAsFixed(0)} Sak)'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Pasir Pasang'),
                  _buildTableItem(value: 'm3'),
                  _buildTableItem(value: pasirVolume.toStringAsFixed(2)),
                  _buildTableItem(value: 'Rp${Utils.numberFormat(pasirPrice)}'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: Colors.orange,
            child: Text(
              'Perkiraan Waktu Pengerjaan',
              style: CustomTextStyle.white(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  _buildTableItem(value: '30 hari'),
                  _buildTableItem(value: '1 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '21 hari'),
                  _buildTableItem(value: '1 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '14 hari'),
                  _buildTableItem(value: '1 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '8 hari'),
                  _buildTableItem(value: '1 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '6 hari'),
                  _buildTableItem(value: '1 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '2 hari'),
                  _buildTableItem(value: '3 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomElevatedButton(text: 'Download', onPressed: _buildPdf),
          )
        ],
      ),
    );
  }

  Widget _buildTableItem({required String value}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value),
      ),
    );
  }

  _calculate1and3() {
    final wide = double.parse(Get.arguments['wide']);

    blockVolume = wide * 70;
    blockPrice = blockVolume * 800;
    portlandVolume = wide * 14.37;
    protlandPrice = portlandVolume * 2500;
    pasirVolume = wide * 0.04;
    pasirPrice = pasirVolume * 250300;

    setState(() {});
  }

  _calculate1and4() {
    final wide = double.parse(Get.arguments['wide']);

    blockVolume = wide * 70;
    blockPrice = blockVolume * 800;
    portlandVolume = wide * 11.5;
    protlandPrice = portlandVolume * 2500;
    pasirVolume = wide * 0.043;
    pasirPrice = pasirVolume * 250300;

    setState(() {});
  }

  _buildPdf() async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => _buildPdfPage(image)),
    );

    try {
      File file = File("/storage/emulated/0/Download/bata_merah.pdf");
      await file.writeAsBytes(await pdf.save(), flush: true);

      Utils.showGetSnackbar(
          'File disimpan di: /storage/emulated/0/Download/bata_merah.pdf',
          true);
    } catch (e) {
      log(e.toString());
    }
  }

  pw.Widget _buildPdfPage(pw.MemoryImage image) {
    return pw.ListView(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          color: PdfColor.fromHex('#E0E0E0'),
          child: pw.Image(
            image,
            width: Get.width,
            fit: pw.BoxFit.cover,
          ),
        ),
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(16),
          margin: const pw.EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          color: PdfColor.fromHex('#FF9800'),
          child: pw.Text(
            'Material yang dibutuhkan',
            style: pw.TextStyle(color: PdfColor.fromHex('#fff')),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 16),
          child: pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: const {
              0: pw.FlexColumnWidth(3),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(3),
              3: pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Kebutuhan bahan / material'),
                _buildPdfTableItem(value: 'Satuan'),
                _buildPdfTableItem(value: 'Volume / Jumlah'),
                _buildPdfTableItem(value: 'SSH (Rp)'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Bata Merah'),
                _buildPdfTableItem(value: 'bh'),
                _buildPdfTableItem(value: blockVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(blockPrice)}'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Semen Portland'),
                _buildPdfTableItem(value: 'kg'),
                _buildPdfTableItem(value: portlandVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value:
                        'Rp${Utils.numberFormat(protlandPrice)}\n(${(portlandVolume / 40).toStringAsFixed(0)} Sak)'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Pasir Pasang'),
                _buildPdfTableItem(value: 'm3'),
                _buildPdfTableItem(value: pasirVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(pasirPrice)}'),
              ]),
            ],
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(16),
          margin: const pw.EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          color: PdfColor.fromHex('#FF9800'),
          child: pw.Text(
            'Perkiraan Waktu Pengerjaan',
            style: pw.TextStyle(color: PdfColor.fromHex('#fff')),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 16),
          child: pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(children: [
                _buildPdfTableItem(value: '30 hari'),
                _buildPdfTableItem(value: '1 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '21 hari'),
                _buildPdfTableItem(value: '1 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '14 hari'),
                _buildPdfTableItem(value: '1 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '8 hari'),
                _buildPdfTableItem(value: '1 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '6 hari'),
                _buildPdfTableItem(value: '1 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '2 hari'),
                _buildPdfTableItem(value: '3 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
            ],
          ),
        )
      ],
    );
  }

  pw.Widget _buildPdfTableItem({required String value}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Text(value),
    );
  }
}
