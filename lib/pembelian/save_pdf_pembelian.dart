import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class SavePdfPembelian {
  Future<void> generatePDF() async {
    // final pdf = pw.Document();

    // Add content to the PDF
    // pdf.addPage(pw.Page(build: (pw.Context context) {
    //   return pw.Center(
    //     child: pw.Text('Hello, PDF!', style: pw.TextStyle(fontSize: 40)),
    //   );
    // }));

    // Get the document directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;

    // Define the file path
    final String filePath = '$appDocPath/example.pdf';
    final File file = File(filePath);

    // Save the PDF to the file
    // await file.writeAsBytes(await pdf.save());

    print('PDF saved to: $filePath');
  }
}
