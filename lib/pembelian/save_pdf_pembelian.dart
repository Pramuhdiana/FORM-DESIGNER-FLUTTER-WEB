import 'dart:convert';
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/qc/modelQc/itemQcModel.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class SavePdfPembelian {
  List<FormPrModel>? dataFormPR;
  List<ListItemPRModel>? dataItemPr;
  List<ItemQcModel>? dataItemQc;
  String jenisForm = '';

  Future<String?> getItemName(String qc) async {
    //get item pr
    final responseListItem = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));
    if (responseListItem.statusCode == 200) {
      List jsonResponse = json.decode(responseListItem.body);

      var data =
          jsonResponse.map((data) => ListItemPRModel.fromJson(data)).toList();
      //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
      // Filter data based on whether any of the conditions in noQc are met
      var filterByNoQc = data.where((element) => element.noQc == qc).toList();

      data = filterByNoQc;

      return data.first.item.toString();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> generatePDF(noQc) async {
    //init data
    //get data
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getFormPR}'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var data =
          jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();
      //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
      // Filter data based on whether any of the conditions in noQc are met
      var filterByNoQc = data
          .where((element) => noQc.any((qc) => element.noQc == qc))
          .toList();

      data = filterByNoQc;

      dataFormPR = data;
    } else {
      // ignore: avoid_print
      print(response.body);
      throw Exception('Unexpected error occured!');
    }

    //get listnya
    final responseList = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getItemQc}'));

    if (responseList.statusCode == 200) {
      List jsonResponse = json.decode(responseList.body);

      var dataList = jsonResponse
          .map((dataList) => ItemQcModel.fromJson(dataList))
          .toList();
      //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
      // Filter data berdasarkan nomor QC yang ada dalam list noQc
      // Filter data based on whether any of the conditions in noQc are met
      var filterByNoQc = dataList
          .where((element) => noQc.any((qc) => element.noQc == qc))
          .toList();

      dataList = filterByNoQc;
      dataItemQc = dataList;
    } else {
      // ignore: avoid_print
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
    //? end init
    // Create a PDF document.
    final pw.Document pdf = pw.Document();
    final headers = ['No', 'Kode MDBC', 'Qty', 'Berat', 'No QC'];
    final data = <List<String>>[];
    int index = 0;
    int totalQty = 0;
    double totalBerat = 0;
    await Future.forEach(dataItemQc!, (item) async {
      final itemName = await getItemName(item.noQc.toString());
      data.add([
        '${index += 1}',
        '${item.kodeMdbc}',
        '${item.qty}',
        '${item.berat}',
        '${item.noQc} / $itemName',
      ]);
      totalQty += int.parse(item.qty!);
      totalBerat += double.parse(item.berat!);
    });
// Add total quantity and total weight to the last row of the table
    data.add(
        ['', 'Total', totalQty.toString(), totalBerat.toStringAsFixed(3), '']);
// Function to split a list into smaller chunks
    // ignore: no_leading_underscores_for_local_identifiers
    List<List<T>> _splitList<T>(List<T> list, int chunkSize) {
      List<List<T>> chunks = [];
      for (int i = 0; i < list.length; i += chunkSize) {
        int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
        chunks.add(list.sublist(i, end));
      }
      return chunks;
    }

// Split data into chunks to fit on each page
    final List<List<List<String>>> chunkedData = _splitList(data, 27);

    // Add a page to the document.
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          // if (data.length <= 15) {
          return [
            pw.Column(children: [
              //? header
              pw.Row(children: [
                pw.Center(
                    child: pw.Text(
                  'TANDA TERIMA QUALITY CONTROL',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 22),
                )),
              ]),
              for (final chunk in chunkedData)
                //? body
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  headers: headers,
                  data: chunk,
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.blue,
                  ),
                  cellStyle: const pw.TextStyle(
                    color: PdfColors.black,
                  ),
                  cellAlignment: pw.Alignment.center,
                  cellDecoration: (rowIndex, _, rowNum) {
                    // Jika index baris genap, beri warna biru muda, jika tidak, beri warna putih
                    return rowNum % 2 == 0
                        ? const pw.BoxDecoration(color: PdfColors.white)
                        : const pw.BoxDecoration(color: PdfColors.blue100);
                  },
                ),

              //? footer
              pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 20, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Diserahkan oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 30, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Dibawa oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 30, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Diterima oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 30, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Diketahui oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                    ],
                  ),
                  pw.SizedBox(height: 18),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: pw.SizedBox(
                              child: pw.Text('..........',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('..........',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('..........',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('..........',
                                  style: const pw.TextStyle(fontSize: 10)))),
                    ],
                  ),
                ],
              )
            ])
          ];
          // } else {
          //   return [];
          // }
        },
      ),
    );
    // Save the document as bytes.
    final Uint8List bytes = await pdf.save();

    // Convert the bytes to blob.
    final blob = html.Blob([bytes], 'application/pdf');

    // Create a download link.
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create anchor element.
    // ignore: unused_local_variable
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'FormQc.pdf')
      ..click();

    // Revoke the object URL.
    html.Url.revokeObjectUrl(url);
  }

  Future<void> generatePDFKurir(nomorPr) async {
    //init data
    //get data
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getFormPR}'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var data =
          jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();
      //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
      // Filter data based on whether any of the conditions in noQc are met
      var filterByNoQc =
          data.where((element) => element.noPr == nomorPr).toList();

      data = filterByNoQc;
      jenisForm = data.first.jenisForm!.toLowerCase();
      dataFormPR = data;
    } else {
      // ignore: avoid_print
      print(response.body);
      throw Exception('Unexpected error occured!');
    }

    //get listnya
    final responseList = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));

    if (responseList.statusCode == 200) {
      List jsonResponse = json.decode(responseList.body);

      var dataList = jsonResponse
          .map((dataList) => ListItemPRModel.fromJson(dataList))
          .toList();
      //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
      // Filter data berdasarkan nomor QC yang ada dalam list noQc
      // Filter data based on whether any of the conditions in noQc are met
      var filterByNoPr =
          dataList.where((element) => element.noPr == nomorPr).toList();

      dataList = filterByNoPr;
      dataItemPr = dataList;
    } else {
      // ignore: avoid_print
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
    //? end init
    // Create a PDF document.
    final pw.Document pdf = pw.Document();
    final headers = ['No', 'Nama Barang', 'Qty', 'Berat', 'Clarity', 'Color'];
    final data = <List<String>>[];
    int index = 0;
    int totalQty = 0;
    double totalBerat = 0;

    await Future.forEach(dataItemPr!, (item) async {
      data.add([
        '${index += 1}',
        '${item.item}',
        '${item.qty}',
        '${item.berat}',
        '${item.kadar}',
        '${item.color}',
      ]);
      totalQty += int.parse(item.qty!);
      totalBerat += double.parse(item.berat!);
    });
// Add total quantity and total weight to the last row of the table
    data.add(
        ['', 'Total', totalQty.toString(), totalBerat.toStringAsFixed(3), '']);
// Function to split a list into smaller chunks
    // ignore: no_leading_underscores_for_local_identifiers
    List<List<T>> _splitList<T>(List<T> list, int chunkSize) {
      List<List<T>> chunks = [];
      for (int i = 0; i < list.length; i += chunkSize) {
        int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
        chunks.add(list.sublist(i, end));
      }
      return chunks;
    }

//* Split data into chunks to fit on each page (sesuaikan splitnya)
    final List<List<List<String>>> chunkedData = _splitList(data, 27);

    // Add a page to the document.
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          // if (data.length <= 15) {
          return [
            pw.Column(children: [
              //? header
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          width: 100,
                          height: 50,
                          // child: pw.Image(
                          //   PdfImage.file(
                          //     pdf.document,
                          //     bytes: imageData,
                          //   ) as pw.ImageProvider,
                          // ),
                        ),
                        pw.SizedBox(width: 10),
                        pw.Text(
                          'Jl. Raya Daan Mogot\nKM 21 Pergudangan Eraprima\nBlok I No.2 Batu Ceper, Tanggerang,\nBanten 15122, Tangerang',
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    pw.Text(
                      'No. ${dataFormPR!.first.noPr}',
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 18),
                    ),
                  ]),
              pw.Center(
                  child: pw.Text(
                jenisForm == 'retur'
                    ? 'TANDA TERIMA RETUR'
                    : 'TANDA TERIMA PEMBELIAN',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22),
              )),
              for (final chunk in chunkedData)
                //? body
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  headers: headers,
                  data: chunk,
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.blue,
                  ),
                  cellStyle: const pw.TextStyle(
                    color: PdfColors.black,
                  ),
                  cellAlignment: pw.Alignment.center,
                  cellDecoration: (rowIndex, _, rowNum) {
                    // Jika index baris genap, beri warna biru muda, jika tidak, beri warna putih
                    return rowNum % 2 == 0
                        ? const pw.BoxDecoration(color: PdfColors.white)
                        : const pw.BoxDecoration(color: PdfColors.blue100);
                  },
                ),

              //? footer
              pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 20, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Diserahkan oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 30, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Dibawa oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 30, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Diterima oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.only(left: 30, top: 20.0),
                          child: pw.SizedBox(
                              child: pw.Text('Diketahui oleh,',
                                  style: const pw.TextStyle(fontSize: 10)))),
                    ],
                  ),
                  pw.SizedBox(height: 18),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.SizedBox(
                        width: 60,
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: pw.SizedBox(
                              width: 60,
                              child: pw.Text(
                                  jenisForm == 'retur'
                                      ? 'Warehouse'
                                      : '${dataFormPR!.first.vendor}',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.SizedBox(
                        width: 60,
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 20.0),
                          child: pw.SizedBox(
                              width: 60,
                              child: pw.Text('${dataFormPR!.first.kurir}',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.SizedBox(
                        width: 60,
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 20.0),
                          child: pw.SizedBox(
                              width: 60,
                              child: pw.Text(
                                  jenisForm == 'retur'
                                      ? '${dataFormPR!.first.vendor}'
                                      : 'Warehouse',
                                  style: const pw.TextStyle(fontSize: 10)))),
                      pw.SizedBox(
                        width: 60,
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 20.0),
                          child: pw.SizedBox(
                              width: 60,
                              child: pw.Text('Procurement',
                                  style: const pw.TextStyle(fontSize: 10)))),
                    ],
                  ),
                ],
              )
            ])
          ];
          // } else {
          //   return [];
          // }
        },
      ),
    );
    // Save the document as bytes.
    final Uint8List bytes = await pdf.save();

    // Convert the bytes to blob.
    final blob = html.Blob([bytes], 'application/pdf');

    // Create a download link.
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create anchor element.
    // ignore: unused_local_variable
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'suratJalan${dataFormPR!.first.noPr}.pdf')
      ..click();

    // Revoke the object URL.
    html.Url.revokeObjectUrl(url);
  }

  Future<void> generatePDFInvoice(nomorPr, tanggalCetak) async {
    //get data pr
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getFormPR}'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var data =
          jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();
      //* hints Filter data berdasarkan nomo PR
      var filterByNoPr =
          data.where((element) => element.noPr == nomorPr).toList();

      data = filterByNoPr;
      jenisForm = data.first.jenisForm!.toLowerCase();
      dataFormPR = data;
    } else {
      // ignore: avoid_print
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
    //get listnya
    final responseList = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));

    if (responseList.statusCode == 200) {
      List jsonResponse = json.decode(responseList.body);

      var dataList = jsonResponse
          .map((dataList) => ListItemPRModel.fromJson(dataList))
          .toList();
      var filterByNoPr =
          dataList.where((element) => element.noPr == nomorPr).toList();

      dataList = filterByNoPr;
      dataItemPr = dataList;
    } else {
      // ignore: avoid_print
      print(response.body);
      throw Exception('Unexpected error occured!');
    }

    //? end init
    // Create a PDF document.
    final pw.Document pdf = pw.Document();
    final headers = [
      'No',
      'Berat Kedatangan',
      'Berat Diterima',
      'Nama Barang',
      'Harga (\$)',
      'Total Harga (\$)'
    ];
    final data = <List<String>>[];
    int index = 0;
    // int totalQty = 0;
    // double totalBerat = 0;
    List<double> totalHarga = [];
    double sumHargaBerat = 0.0;
    for (var i = 0; i < dataItemPr!.length; i++) {
      double sumTotal = double.parse(dataItemPr![i].harga!) *
          double.parse(dataItemPr![i].receiveBerat!);
      totalHarga.add(sumTotal);
      sumHargaBerat += sumTotal;
    }
    await Future.forEach(dataItemPr!, (item) async {
      data.add([
        '${index += 1}',
        '${item.fixBerat}',
        '${item.receiveBerat}',
        '${item.item}',
        '\$ ${item.harga}',
        '\$ ${totalHarga[index].toStringAsFixed(3)}',
      ]);
    });
// Add total quantity and total weight to the last row of the table
    data.add(['', '', '', '', 'Total', sumHargaBerat.toStringAsFixed(3)]);
// Function to split a list into smaller chunks
    // ignore: no_leading_underscores_for_local_identifiers
    List<List<T>> _splitList<T>(List<T> list, int chunkSize) {
      List<List<T>> chunks = [];
      for (int i = 0; i < list.length; i += chunkSize) {
        int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
        chunks.add(list.sublist(i, end));
      }
      return chunks;
    }

//* Split data into chunks to fit on each page (sesuaikan splitnya)
    final List<List<List<String>>> chunkedData = _splitList(data, 27);

    // Add a page to the document.
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          // if (data.length <= 15) {
          return [
            pw.Column(children: [
              //? header
              pw.Center(
                  child: pw.Text(
                'NOTA BISNIS / INVOICE ${dataFormPR!.first.noPr}',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22),
              )),
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: 100,
                    child: pw.Text(
                      'Nota titipan',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  pw.SizedBox(
                    width: 10,
                    child: pw.Text(
                      ':',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  pw.SizedBox(
                    child: pw.Text(
                      '${dataFormPR!.first.tanggalInQc}',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    children: [
                      pw.SizedBox(
                        child: pw.Text(
                          'Kpd Yth PT. Cahaya Sani Vokasi',
                          textAlign: pw.TextAlign.start,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  pw.Text(
                    'Tanggal : ${DateFormat('dd-MMMM-yyyy').format(DateTime.parse(tanggalCetak!))}',
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Bu Stephanie / Pak Vitalik',
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 14),
                  ),
                  pw.Text(
                    'Jam : ${DateFormat('H.mm').format(DateTime.parse(tanggalCetak))}',
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              for (final chunk in chunkedData)
                //? body
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  headers: headers,
                  data: chunk,
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.blue,
                  ),
                  cellStyle: const pw.TextStyle(
                    color: PdfColors.black,
                  ),
                  cellAlignment: pw.Alignment.center,
                  cellDecoration: (rowIndex, _, rowNum) {
                    // Jika index baris genap, beri warna biru muda, jika tidak, beri warna putih
                    return rowNum % 2 == 0
                        ? const pw.BoxDecoration(color: PdfColors.white)
                        : const pw.BoxDecoration(color: PdfColors.blue100);
                  },
                ),

              //? footer
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          'Pembelian,',
                          textAlign: pw.TextAlign.start,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 14),
                        ),
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                          height: 78,
                          width: 138,
                        ),
                        pw.Text('....')
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          'Finance,',
                          textAlign: pw.TextAlign.start,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 14),
                        ),
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                          height: 78,
                          width: 138,
                        ),
                        pw.Text('....')
                      ],
                    ),
                  ]),
            ])
          ];
          // } else {
          //   return [];
          // }
        },
      ),
    );
    // Save the document as bytes.
    final Uint8List bytes = await pdf.save();

    // Convert the bytes to blob.
    final blob = html.Blob([bytes], 'application/pdf');

    // Create a download link.
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create anchor element.
    // ignore: unused_local_variable
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'notaBisnis${dataFormPR!.first.noPr}.pdf')
      ..click();

    // Revoke the object URL.
    html.Url.revokeObjectUrl(url);
  }
}
