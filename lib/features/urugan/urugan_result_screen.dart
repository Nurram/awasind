import 'dart:developer';
import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:awasind/features/header.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class UruganResultScreen extends StatefulWidget {
  const UruganResultScreen({super.key});

  @override
  State<UruganResultScreen> createState() => _UruganResultScreenState();
}

class _UruganResultScreenState extends State<UruganResultScreen> {
  num volume = 0;
  num price = 0;

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
                  _buildTableItem(value: 'Pasir Urug'),
                  _buildTableItem(value: 'm3'),
                  _buildTableItem(value: volume.toStringAsFixed(2)),
                  _buildTableItem(value: 'Rp${Utils.numberFormat(price)}'),
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
                  _buildTableItem(value: '2 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '8 hari'),
                  _buildTableItem(value: '2 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '6 hari'),
                  _buildTableItem(value: '3 pekerja'),
                  _buildTableItem(value: '1 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '2 hari'),
                  _buildTableItem(value: '8 pekerja'),
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

  _calculate() {
    final args = Get.arguments;

    volume = (((double.parse(args['a']) + double.parse(args['b'])) *
            .5 *
            double.parse(args['p']) *
            double.parse(args['t'])) *
        1.2);
    price = volume * 132900;

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
                _buildPdfTableItem(value: 'Pasir Urug'),
                _buildPdfTableItem(value: 'm3'),
                _buildPdfTableItem(value: volume.toStringAsFixed(2)),
                _buildPdfTableItem(value: 'Rp${Utils.numberFormat(price)}'),
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
                _buildPdfTableItem(value: '2 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '8 hari'),
                _buildPdfTableItem(value: '2 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '6 hari'),
                _buildPdfTableItem(value: '3 pekerja'),
                _buildPdfTableItem(value: '1 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '2 hari'),
                _buildPdfTableItem(value: '8 pekerja'),
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
