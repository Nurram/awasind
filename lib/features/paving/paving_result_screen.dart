import 'dart:developer';
import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:awasind/features/header.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PavingResultScreen extends StatefulWidget {
  const PavingResultScreen({super.key});

  @override
  State<PavingResultScreen> createState() => _PavingResultScreenState();
}

class _PavingResultScreenState extends State<PavingResultScreen> {
  num pavingVolume = 0;
  num pavingPrice = 0;
  num uskupVolume = 0;
  num uskupPrice = 0;
  num semenVolume = 0;
  num semenPrice = 0;
  num betonVolume = 0;
  num betonPrice = 0;
  num kanstinVolume = 0;
  num kanstinPrice = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _calculate();
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
                  _buildTableItem(value: 'Paving'),
                  _buildTableItem(value: 'bj'),
                  _buildTableItem(value: pavingVolume.toStringAsFixed(2)),
                  _buildTableItem(
                      value: 'Rp${Utils.numberFormat(pavingPrice)}'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Uskup'),
                  _buildTableItem(value: 'bj'),
                  _buildTableItem(value: uskupVolume.toStringAsFixed(2)),
                  _buildTableItem(value: 'Rp${Utils.numberFormat(uskupPrice)}'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Semen'),
                  _buildTableItem(value: 'kg'),
                  _buildTableItem(value: semenVolume.toStringAsFixed(2)),
                  _buildTableItem(
                      value:
                          'Rp${Utils.numberFormat(semenPrice)}\n(${(semenVolume / 40).toStringAsFixed(0)} Sak)'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Pasir Beton'),
                  _buildTableItem(value: 'm3'),
                  _buildTableItem(value: betonVolume.toStringAsFixed(2)),
                  _buildTableItem(value: 'Rp${Utils.numberFormat(betonPrice)}'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Kanstin'),
                  _buildTableItem(value: 'bj'),
                  _buildTableItem(value: kanstinVolume.toStringAsFixed(2)),
                  _buildTableItem(
                      value: 'Rp${Utils.numberFormat(kanstinPrice)}'),
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
                  _buildTableItem(value: '18 hari'),
                  _buildTableItem(value: '6 pekerja'),
                  _buildTableItem(value: '13 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '14 hari'),
                  _buildTableItem(value: '8 pekerja'),
                  _buildTableItem(value: '16 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '10 hari'),
                  _buildTableItem(value: '11 pekerja'),
                  _buildTableItem(value: '23 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '8 hari'),
                  _buildTableItem(value: '14 pekerja'),
                  _buildTableItem(value: '28 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '6 hari'),
                  _buildTableItem(value: '19 pekerja'),
                  _buildTableItem(value: '38 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '4 hari'),
                  _buildTableItem(value: '28 pekerja'),
                  _buildTableItem(value: '56 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '3 hari'),
                  _buildTableItem(value: '38 pekerja'),
                  _buildTableItem(value: '75 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '2 hari'),
                  _buildTableItem(value: '56 pekerja'),
                  _buildTableItem(value: '113 tukang'),
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

  _calculate() {
    final args = Get.arguments;
    final p = double.parse(args['p']);
    final a = double.parse(args['a']);
    final b = double.parse(args['b']);
    final k = double.parse(args['k']);
    final u = double.parse(args['u']);

    pavingVolume = (((a + b) * .5 * p) - (u * 3.333 * .040035)) * 1.01;
    pavingPrice = pavingVolume * 3600;

    uskupVolume = u * 3.333;
    uskupPrice = uskupVolume * 3600;

    semenVolume = k * 1.2;
    semenPrice = semenVolume * 2500;

    betonVolume = (k * 0.05) + (((a + b) * .5 * p) * 0.05);
    betonPrice = betonVolume * 20800;

    kanstinVolume = k * 2.5;
    kanstinPrice = kanstinVolume * 20800;

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
      File file = File("/storage/emulated/0/Download/urugan.pdf");
      await file.writeAsBytes(await pdf.save(), flush: true);

      Utils.showGetSnackbar(
          'File disimpan di: /storage/emulated/0/Download/urugan.pdf', true);
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
                _buildPdfTableItem(value: 'Paving'),
                _buildPdfTableItem(value: 'bj'),
                _buildPdfTableItem(value: pavingVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(pavingPrice)}'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Uskup'),
                _buildPdfTableItem(value: 'bj'),
                _buildPdfTableItem(value: uskupVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(uskupPrice)}'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Semen'),
                _buildPdfTableItem(value: 'kg'),
                _buildPdfTableItem(value: semenVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(semenPrice)}'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Pasir Beton'),
                _buildPdfTableItem(value: 'm3'),
                _buildPdfTableItem(value: betonVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(betonPrice)}'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Kanstin'),
                _buildPdfTableItem(value: 'bj'),
                _buildPdfTableItem(value: kanstinVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(kanstinPrice)}'),
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
                _buildPdfTableItem(value: '18 hari'),
                _buildPdfTableItem(value: '6 pekerja'),
                _buildPdfTableItem(value: '13 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '14 hari'),
                _buildPdfTableItem(value: '8 pekerja'),
                _buildPdfTableItem(value: '16 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '10 hari'),
                _buildPdfTableItem(value: '11 pekerja'),
                _buildPdfTableItem(value: '23 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '8 hari'),
                _buildPdfTableItem(value: '14 pekerja'),
                _buildPdfTableItem(value: '28 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '6 hari'),
                _buildPdfTableItem(value: '19 pekerja'),
                _buildPdfTableItem(value: '38 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '4 hari'),
                _buildPdfTableItem(value: '28 pekerja'),
                _buildPdfTableItem(value: '56 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '3 hari'),
                _buildPdfTableItem(value: '38 pekerja'),
                _buildPdfTableItem(value: '75 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '2 hari'),
                _buildPdfTableItem(value: '56 pekerja'),
                _buildPdfTableItem(value: '113 tukang'),
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
