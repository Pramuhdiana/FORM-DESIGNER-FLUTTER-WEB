// import 'dart:convert';
// // ignore: unused_import
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:form_designer/api/api_constant.dart';
// import 'package:form_designer/pembelian/form_pr_model.dart';
// import 'package:form_designer/pembelian/list_form_pr_model.dart';
// import 'package:form_designer/qc/modelQc/itemQcModel.dart';
// import 'package:form_designer/widgets/save_file_web.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// class SavePdfPembelian {
//   List<FormPrModel>? dataFormPR;
//   List<ListItemPRModel>? dataItemPr;
//   List<ItemQcModel>? dataItemQc;
//   String vendor = 'A';
//   String alamatVendor = 'JAKARTA';
//   String contactVendor = '+62';
//   String numberQc = 'PR-0001/QC/Februari/2024/00003';

//   Future<String?> getItemName(String qc) async {
//     //get item pr
//     final responseListItem = await http
//         .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));
//     if (responseListItem.statusCode == 200) {
//       List jsonResponse = json.decode(responseListItem.body);

//       var data =
//           jsonResponse.map((data) => ListItemPRModel.fromJson(data)).toList();
//       //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
//       // Filter data based on whether any of the conditions in noQc are met
//       var filterByNoQc = data.where((element) => element.noQc == qc).toList();

//       data = filterByNoQc;

//       return data.first.item.toString();
//     } else {
//       throw Exception('Unexpected error occured!');
//     }
//   }

//   Future<void> generatePDF(noQc) async {
//     //init data
//     //get data
//     final response = await http
//         .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getFormPR}'));
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);

//       var data =
//           jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();
//       //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
//       // Filter data based on whether any of the conditions in noQc are met
//       var filterByNoQc = data
//           .where((element) => noQc.any((qc) => element.noQc == qc))
//           .toList();

//       data = filterByNoQc;

//       dataFormPR = data;
//     } else {
//       // ignore: avoid_print
//       print(response.body);
//       throw Exception('Unexpected error occured!');
//     }

//     //get listnya
//     final responseList = await http
//         .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getItemQc}'));

//     if (responseList.statusCode == 200) {
//       List jsonResponse = json.decode(responseList.body);

//       var dataList = jsonResponse
//           .map((dataList) => ItemQcModel.fromJson(dataList))
//           .toList();
//       //* hints Filter data berdasarkan nomor QC yang ada dalam list noQc
//       // Filter data berdasarkan nomor QC yang ada dalam list noQc
//       // Filter data based on whether any of the conditions in noQc are met
//       var filterByNoQc = dataList
//           .where((element) => noQc.any((qc) => element.noQc == qc))
//           .toList();

//       dataList = filterByNoQc;
//       dataItemQc = dataList;
//     } else {
//       // ignore: avoid_print
//       print(response.body);
//       throw Exception('Unexpected error occured!');
//     }
//     //? end init
//     //Create a PDF document.
//     final PdfDocument document = PdfDocument();
//     //Add page to the PDF
//     final PdfPage page = document.pages.add();
//     //Get page client size
//     final Size pageSize = page.getClientSize();

//     //Draw rectangle
//     page.graphics.drawRectangle(
//         bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
//         pen: PdfPen(PdfColor(142, 170, 219)));
//     //Generate PDF grid.
//     final PdfGrid grid = _getGrid();
//     //Draw the header section by creating text element
//     final PdfLayoutResult result = _drawHeader(page, pageSize, grid);
//     //Draw grid
//     _drawGrid(page, grid, result);
//     //Add invoice footer
//     _drawFooter(page, pageSize);
//     //Save and dispose the document.
//     final List<int> bytes = await document.save();
//     document.dispose();
//     //Launch file.
//     await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.pdf');
//   }

//   //Draws the invoice header
//   PdfLayoutResult _drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
//     //Draw rectangle
//     page.graphics.drawRectangle(
//         brush: PdfSolidBrush(PdfColor(91, 126, 215)),
//         bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
//     //Draw string
//     page.graphics.drawString(
//         'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
//         brush: PdfBrushes.white,
//         bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
//     page.graphics.drawRectangle(
//         bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
//         brush: PdfSolidBrush(PdfColor(65, 104, 205)));
//     page.graphics.drawString(_getTotalBerat(grid).toStringAsFixed(3),
//         PdfStandardFont(PdfFontFamily.helvetica, 18),
//         bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
//         brush: PdfBrushes.white,
//         format: PdfStringFormat(
//             alignment: PdfTextAlignment.center,
//             lineAlignment: PdfVerticalAlignment.middle));
//     final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
//     //Draw string
//     page.graphics.drawString('Total Berat', contentFont,
//         brush: PdfBrushes.white,
//         bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
//         format: PdfStringFormat(
//             alignment: PdfTextAlignment.center,
//             lineAlignment: PdfVerticalAlignment.bottom));
//     //Create data foramt and convert it to text.
//     final DateFormat format = DateFormat.yMMMMd('en_US');
//     final String invoiceNumber =
//         'Qc Number: $numberQc\r\n\r\nDate: ${format.format(DateTime.now())}';
//     final Size contentSize = contentFont.measureString(invoiceNumber);
//     String address =
//         'Nama vendor: $vendor, \r\n\r\nAlamat vendor:$alamatVendor\r\n\r\nContact vendor:$contactVendor';
//     PdfTextElement(text: invoiceNumber, font: contentFont).draw(
//         page: page,
//         bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
//             contentSize.width + 30, pageSize.height - 120));
//     return PdfTextElement(text: address, font: contentFont).draw(
//         page: page,
//         bounds: Rect.fromLTWH(30, 120,
//             pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
//   }

//   //Draws the grid
//   void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
//     Rect? totalPriceCellBounds;
//     Rect? quantityCellBounds;
//     //Invoke the beginCellLayout event.
//     grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
//       final PdfGrid grid = sender as PdfGrid;
//       if (args.cellIndex == grid.columns.count - 1) {
//         totalPriceCellBounds = args.bounds;
//       } else if (args.cellIndex == grid.columns.count - 2) {
//         quantityCellBounds = args.bounds;
//       }
//     };
//     // Draw the PDF grid and get the result.
//     result = grid.draw(
//         page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
//     // //Draw grand total.
//     page.graphics.drawString('Total Berat',
//         PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
//         bounds: Rect.fromLTWH(
//             quantityCellBounds!.left,
//             result.bounds.bottom + 10,
//             quantityCellBounds!.width,
//             quantityCellBounds!.height));
//     page.graphics.drawString(_getTotalBerat(grid).toStringAsFixed(3),
//         PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
//         bounds: Rect.fromLTWH(
//             totalPriceCellBounds!.left,
//             result.bounds.bottom + 10,
//             totalPriceCellBounds!.width,
//             totalPriceCellBounds!.height));
//   }

//   //Draw the invoice footer data.
//   void _drawFooter(PdfPage page, Size pageSize) {
//     final PdfPen linePen =
//         PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
//     linePen.dashPattern = <double>[3, 3];
//     //Draw line
//     page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
//         Offset(pageSize.width, pageSize.height - 100));
//     const String footerContent =
//         '800 Interchange Blvd.\r\n\r\nSuite 2501, Austin, TX 78721\r\n\r\nAny Questions? support@adventure-works.com';
//     //Added 30 as a margin for the layout
//     page.graphics.drawString(
//         footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
//         format: PdfStringFormat(alignment: PdfTextAlignment.right),
//         bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
//   }

//   //Create PDF grid and return
//   PdfGrid _getGrid() {
//     //Create a PDF grid
//     final PdfGrid grid = PdfGrid();
//     //Secify the columns count to the grid.
//     grid.columns.add(count: 5);
//     //Create the header row of the grid.
//     final PdfGridRow headerRow = grid.headers.add(1)[0];
//     //Set style
//     headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
//     headerRow.style.textBrush = PdfBrushes.white;
//     headerRow.cells[0].value = 'No';
//     headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
//     headerRow.cells[1].value = 'Kode MDBC';
//     headerRow.cells[2].value = 'Qty';
//     headerRow.cells[3].value = 'Berat';
//     headerRow.cells[4].value = 'No Qc ';
//     for (var i = 0; i < dataItemQc!.length; i++) {
//       var data = dataItemQc![i];
//       _addProducts('${i + 1}', '${data.kodeMdbc}', data.qty!, data.berat!,
//           '${data.noQc}', grid);
//     }
//     // _addProducts('', 'Total', _getTotalQty(grid).toString(),
//     //     _getTotalBerat(grid).toStringAsFixed(3), '', grid);

//     grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
//     grid.columns[1].width = 100;
//     grid.columns[4].width = 200;
//     for (int i = 0; i < headerRow.cells.count; i++) {
//       headerRow.cells[i].style.cellPadding =
//           PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
//     }
//     for (int i = 0; i < grid.rows.count; i++) {
//       final PdfGridRow row = grid.rows[i];
//       for (int j = 0; j < row.cells.count; j++) {
//         final PdfGridCell cell = row.cells[j];
//         if (j == 0) {
//           cell.stringFormat.alignment = PdfTextAlignment.center;
//         }
//         cell.style.cellPadding =
//             PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
//       }
//     }
//     return grid;
//   }

//   //Create and row for the grid.
//   void _addProducts(String no, String ukuran, String qty, String berat,
//       String numberQc, PdfGrid grid) {
//     final PdfGridRow row = grid.rows.add();
//     row.cells[0].value = no;
//     row.cells[1].value = ukuran;
//     row.cells[2].value = qty.toString();
//     row.cells[3].value = berat.toString();
//     row.cells[4].value = numberQc;
//   }

//   //Get the total amount.
//   double _getTotalBerat(PdfGrid grid) {
//     double total = 0;
//     for (int i = 0; i < dataItemQc!.length; i++) {
//       final String? value = dataItemQc![i].berat;
//       total += double.parse(value!);
//     }
//     return total;
//   }

//   //Get the total amount.
//   int _getTotalQty(PdfGrid grid) {
//     int total = 0;
//     for (int i = 0; i < dataItemQc!.length; i++) {
//       final String? value = dataItemQc![i].qty;
//       total += int.parse(value!);
//     }
//     return total;
//   }
// }

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

class SavePdfPembelian {
  List<FormPrModel>? dataFormPR;
  List<ListItemPRModel>? dataItemPr;
  List<ItemQcModel>? dataItemQc;

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
        ['', '', totalQty.toString(), totalBerat.toStringAsFixed(3), 'Total']);
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
}
