// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/qc/modelQc/itemQcModel.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages

class ExcelPembelian {
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
      var filterByNoQc = data.where((element) => element.noQc == qc).toList();

      data = filterByNoQc;

      return data.first.item.toString();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  //*HINTS get data dari tabel lain
  Future<String?> getItemHarga(String qc) async {
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

      return data.first.harga.toString();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> exportExcel(noQc) async {
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
      print(response.body);
      throw Exception('Unexpected error occured!');
    }

    var excel = Excel.createExcel();
    CellStyle headStyle = CellStyle(
      bold: true,
      italic: true,
      textWrapping: TextWrapping.WrapText,
      rotation: 0,
    );

    var sheet = excel['mySheet'];

    var no = sheet.cell(CellIndex.indexByString("A1"));
    no.value = "No";
    no.cellStyle = headStyle;
    var kodeMdbc = sheet.cell(CellIndex.indexByString("B1"));
    kodeMdbc.value = "Kode MDBC";
    kodeMdbc.cellStyle = headStyle;
    var qty = sheet.cell(CellIndex.indexByString("C1"));
    qty.value = "Qty";
    qty.cellStyle = headStyle;
    var berat = sheet.cell(CellIndex.indexByString("D1"));
    berat.value = "Berat";
    berat.cellStyle = headStyle;
    var noQcLOT = sheet.cell(CellIndex.indexByString("E1"));
    noQcLOT.value = "No Qc";
    noQcLOT.cellStyle = headStyle;
    var harga = sheet.cell(CellIndex.indexByString("F1"));
    harga.value = "Harga";
    harga.cellStyle = headStyle;

    for (int row = 0; row < dataItemQc!.length; row++) {
      //belum bisa image  Image.network( ApiConstants.baseUrlImage + myData![row].imageUrl!,);
      var data = dataItemQc![row];

      //? listn o
      var listNo = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1));
      listNo.value = (row + 1);

      //? list kodeMdbc
      var listKodeMdbc = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1));
      listKodeMdbc.value = data.kodeMdbc;
      //? list qty
      var listQty = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1));
      listQty.value = data.qty;
      //? list berat
      var listBerat = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1));
      listBerat.value = data.berat;
      //? noQc
      var listNoQc = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1));
      String? itemName = await getItemName(data.noQc.toString());
      listNoQc.value = '${data.noQc} / $itemName';
      //* HINTS noQc
      var listHarga = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1));
      String? itemHarga = await getItemHarga(data.noQc.toString());
      listHarga.value = '$itemHarga';
    }

    excel.rename("mySheet", "RESULT");
    excel.delete('Sheet1');

    /// appending rows and checking the time complexity of it
    Stopwatch stopwatch = Stopwatch()..start();
    stopwatch.reset();
    // Saving the file
    // Simpan file
    String outputFileName = "$noQc.xlsx";
    //stopwatch.reset();
    List<int>? fileBytes = excel.save();
    //print('saving executed in ${stopwatch.elapsed}');
    // if (fileBytes != null) {
    try {
      File(join(outputFileName))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
    } catch (c) {
      print('err get excel $c');
    }

    // }
  }
}
