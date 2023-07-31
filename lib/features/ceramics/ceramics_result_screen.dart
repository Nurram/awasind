import 'dart:developer';
import 'dart:io';

import 'package:awasind/core_imports.dart';
import 'package:awasind/features/header.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CeramicsResultScreen extends StatefulWidget {
  const CeramicsResultScreen({super.key});

  @override
  State<CeramicsResultScreen> createState() => _CeramicsResultScreenState();
}

class _CeramicsResultScreenState extends State<CeramicsResultScreen> {
  num tileVolume = 0;
  num tilePrice = 0;
  num cementVolume = 0;
  num cementPrice = 0;
  num pasirVolume = 0;
  num pasirPrice = 0;
  num coloredCementVolume = 0;
  num coloredCementPrice = 0;

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
                  _buildTableItem(value: 'Ubin'),
                  _buildTableItem(value: 'Dus'),
                  _buildTableItem(value: tileVolume.toStringAsFixed(2)),
                  _buildTableItem(value: 'Rp${Utils.numberFormat(tilePrice)}'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Semen Portland'),
                  _buildTableItem(value: 'kg'),
                  _buildTableItem(value: cementVolume.toStringAsFixed(2)),
                  _buildTableItem(
                      value:
                          'Rp${Utils.numberFormat(cementPrice)}\n(${cementVolume / 40} Sak)'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Pasir Pasang'),
                  _buildTableItem(value: 'm3'),
                  _buildTableItem(value: pasirVolume.toStringAsFixed(2)),
                  _buildTableItem(value: 'Rp${Utils.numberFormat(pasirPrice)}'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: 'Semen Warna'),
                  _buildTableItem(value: 'kg'),
                  _buildTableItem(
                      value: coloredCementVolume.toStringAsFixed(2)),
                  _buildTableItem(
                      value: 'Rp${Utils.numberFormat(coloredCementPrice)}'),
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
                  _buildTableItem(value: '3 pekerja'),
                  _buildTableItem(value: '2 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '6 hari'),
                  _buildTableItem(value: '3 pekerja'),
                  _buildTableItem(value: '2 tukang'),
                ]),
                TableRow(children: [
                  _buildTableItem(value: '2 hari'),
                  _buildTableItem(value: '9 pekerja'),
                  _buildTableItem(value: '4 tukang'),
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
    final wide = double.parse(Get.arguments['wide']);
    final type = Get.arguments['type'];

    double tKoef = 1.05;
    double tPrice = 498200;

    double cKoef = 10;
    double cPrice = 26000;

    double pKoef = .045;
    double pPrice = 11263.5;

    double scKoef = .5;
    double scPrice = 7750;

    if (type == 'Lantai Keramik Uk 20sd<30') {
      tKoef = 1.05;
      tPrice = 310200;

      cKoef = 10.4;
      cPrice = 26000;

      pKoef = .045;
      pPrice = 11263.5;

      scKoef = .5;
      scPrice = 7750;
    } else if (type == 'Tealux Marmer uk 60x60') {
      tKoef = 3.1;
      tPrice = 556200;

      cKoef = 9.6;
      cPrice = 26000;

      pKoef = .045;
      pPrice = 11263.5;

      scKoef = 1.5;
      scPrice = 7750;
    } else if (type == 'Tealux Marmer uk 40x40') {
      tKoef = 6.63;
      tPrice = 257500;

      cKoef = 9.8;
      cPrice = 26000;

      pKoef = .045;
      pPrice = 11263.5;

      scKoef = 1.3;
      scPrice = 7750;
    } else if (type == 'Granit Uk 30x30') {
      tKoef = 11.87;
      tPrice = 6400;

      cKoef = 10;
      cPrice = 26000;

      pKoef = .045;
      pPrice = 11263.5;

      scKoef = 1.5;
      scPrice = 7750;
    } else if (type == 'Teralux 30x30') {
      tKoef = 11.87;
      tPrice = 250300;

      cKoef = 10;
      cPrice = 26000;

      pKoef = .045;
      pPrice = 11263.5;

      scKoef = 1.5;
      scPrice = 7750;
    } else if (type == 'Lantai Teraso 40x40') {
      tKoef = 6.63;
      tPrice = 6400;

      cKoef = 9.8;
      cPrice = 26000;

      pKoef = .045;
      pPrice = 11263.5;

      scKoef = 1.3;
      scPrice = 7750;
    }

    tileVolume = wide * tKoef;
    tilePrice = tileVolume * tPrice;

    cementVolume = wide * cKoef;
    cementPrice = cementVolume * cPrice;

    pasirVolume = wide * pKoef;
    pasirPrice = pasirVolume * pPrice;

    coloredCementVolume = wide * scKoef;
    coloredCementPrice = coloredCementVolume * scPrice;

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
                _buildPdfTableItem(value: 'Ubin'),
                _buildPdfTableItem(value: 'Dus'),
                _buildPdfTableItem(value: tileVolume.toStringAsFixed(2)),
                _buildPdfTableItem(value: 'Rp${Utils.numberFormat(tilePrice)}'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Semen Portland'),
                _buildPdfTableItem(value: 'kg'),
                _buildPdfTableItem(value: cementVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value:
                        'Rp${Utils.numberFormat(cementPrice)}\n${cementVolume / 40} Sak'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Pasir Pasang'),
                _buildPdfTableItem(value: 'm3'),
                _buildPdfTableItem(value: pasirVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(pasirPrice)}'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: 'Semen Warna'),
                _buildPdfTableItem(value: 'kg'),
                _buildPdfTableItem(
                    value: coloredCementVolume.toStringAsFixed(2)),
                _buildPdfTableItem(
                    value: 'Rp${Utils.numberFormat(coloredCementPrice)}'),
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
                _buildPdfTableItem(value: '3 pekerja'),
                _buildPdfTableItem(value: '2 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '6 hari'),
                _buildPdfTableItem(value: '3 pekerja'),
                _buildPdfTableItem(value: '2 tukang'),
              ]),
              pw.TableRow(children: [
                _buildPdfTableItem(value: '2 hari'),
                _buildPdfTableItem(value: '9 pekerja'),
                _buildPdfTableItem(value: '4 tukang'),
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
