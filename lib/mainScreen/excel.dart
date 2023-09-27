import 'dart:convert';
import 'dart:io';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/model/form_designer_model.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;

class ExcelScreen {
  List<FormDesignerModel>? myData;

  Future<void> exportExcel() async {
//get data
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      myData = allData.toList();
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
    var head1 = sheet.cell(CellIndex.indexByString("B1"));
    head1.value = "Kode MDBC";
    head1.cellStyle = headStyle;
    var head2 = sheet.cell(CellIndex.indexByString("C1"));
    head2.value = "Nama Designer";
    head2.cellStyle = headStyle;
    var head3 = sheet.cell(CellIndex.indexByString("D1"));
    head3.value = "Tema";
    head3.cellStyle = headStyle;
    var head4 = sheet.cell(CellIndex.indexByString("E1"));
    head4.value = "Jenis Barang";
    head4.cellStyle = headStyle;
    var head5 = sheet.cell(CellIndex.indexByString("F1"));
    head5.value = "Harga";
    head5.cellStyle = headStyle;
    var head6 = sheet.cell(CellIndex.indexByString("G1"));
    head6.value = "Kelas Harga";
    head6.cellStyle = headStyle;
    var head7 = sheet.cell(CellIndex.indexByString("H1"));
    head7.value = "Emas";
    head7.cellStyle = headStyle;
    var head8 = sheet.cell(CellIndex.indexByString("I1"));
    head8.value = "Rantai";
    head8.cellStyle = headStyle;
    var head9 = sheet.cell(CellIndex.indexByString("J1"));
    head9.value = "Qty Rantai";
    head9.cellStyle = headStyle;
    var head10 = sheet.cell(CellIndex.indexByString("K1"));
    head10.value = "Lain-Lain";
    head10.cellStyle = headStyle;
    var head11 = sheet.cell(CellIndex.indexByString("L1"));
    head11.value = "Qty Lain-Lain";
    head11.cellStyle = headStyle;
    var head12 = sheet.cell(CellIndex.indexByString("M1"));
    head12.value = "Earnut";
    head12.cellStyle = headStyle;
    var head13 = sheet.cell(CellIndex.indexByString("N1"));
    head13.value = "Qty Earnut";
    head13.cellStyle = headStyle;
    //? batu 1 -35
    var batu1 = sheet.cell(CellIndex.indexByString("O1"));
    batu1.value = "Ukuran Batu1";
    batu1.cellStyle = headStyle;
    var qtyBatu1 = sheet.cell(CellIndex.indexByString("P1"));
    qtyBatu1.value = "Qty Batu1";
    qtyBatu1.cellStyle = headStyle;
    var batu2 = sheet.cell(CellIndex.indexByString("Q1"));
    batu2.value = "Ukuran Batu2";
    batu2.cellStyle = headStyle;
    var qtyBatu2 = sheet.cell(CellIndex.indexByString("R1"));
    qtyBatu2.value = "Qty Batu2";
    qtyBatu2.cellStyle = headStyle;
    var batu3 = sheet.cell(CellIndex.indexByString("S1"));
    batu3.value = "Ukuran Batu3";
    batu3.cellStyle = headStyle;
    var qtyBatu3 = sheet.cell(CellIndex.indexByString("T1"));
    qtyBatu3.value = "Qty Batu3";
    qtyBatu3.cellStyle = headStyle;
    var batu4 = sheet.cell(CellIndex.indexByString("U1"));
    batu4.value = "Ukuran Batu4";
    batu4.cellStyle = headStyle;
    var qtyBatu4 = sheet.cell(CellIndex.indexByString("V1"));
    qtyBatu4.value = "Qty Batu4";
    qtyBatu4.cellStyle = headStyle;
    var batu5 = sheet.cell(CellIndex.indexByString("W1"));
    batu5.value = "Ukuran Batu5";
    batu5.cellStyle = headStyle;
    var qtyBatu5 = sheet.cell(CellIndex.indexByString("X1"));
    qtyBatu5.value = "Qty Batu5";
    qtyBatu5.cellStyle = headStyle;
    var batu6 = sheet.cell(CellIndex.indexByString("Y1"));
    batu6.value = "Ukuran Batu6";
    batu6.cellStyle = headStyle;
    var qtyBatu6 = sheet.cell(CellIndex.indexByString("Z1"));
    qtyBatu6.value = "Qty Batu6";
    qtyBatu6.cellStyle = headStyle;
    var batu7 = sheet.cell(CellIndex.indexByString("AA1"));
    batu7.value = "Ukuran Batu7";
    batu7.cellStyle = headStyle;
    var qtyBatu7 = sheet.cell(CellIndex.indexByString("AB1"));
    qtyBatu7.value = "Qty Batu7";
    qtyBatu7.cellStyle = headStyle;
    var batu8 = sheet.cell(CellIndex.indexByString("AC1"));
    batu8.value = "Ukuran Batu8";
    batu8.cellStyle = headStyle;
    var qtyBatu8 = sheet.cell(CellIndex.indexByString("AD1"));
    qtyBatu8.value = "Qty Batu8";
    qtyBatu8.cellStyle = headStyle;
    var batu9 = sheet.cell(CellIndex.indexByString("AE1"));
    batu9.value = "Ukuran Batu9";
    batu9.cellStyle = headStyle;
    var qtyBatu9 = sheet.cell(CellIndex.indexByString("AF1"));
    qtyBatu9.value = "Qty Batu9";
    qtyBatu9.cellStyle = headStyle;
    var batu10 = sheet.cell(CellIndex.indexByString("AG1"));
    batu10.value = "Ukuran Batu10";
    batu10.cellStyle = headStyle;
    var qtyBatu10 = sheet.cell(CellIndex.indexByString("AH1"));
    qtyBatu10.value = "Qty Batu10";
    qtyBatu10.cellStyle = headStyle;
    var batu11 = sheet.cell(CellIndex.indexByString("AI1"));
    batu11.value = "Ukuran Batu11";
    batu11.cellStyle = headStyle;
    var qtyBatu11 = sheet.cell(CellIndex.indexByString("AJ1"));
    qtyBatu11.value = "Qty Batu11";
    qtyBatu11.cellStyle = headStyle;
    var batu12 = sheet.cell(CellIndex.indexByString("AK1"));
    batu12.value = "Ukuran Batu12";
    batu12.cellStyle = headStyle;
    var qtyBatu12 = sheet.cell(CellIndex.indexByString("AL1"));
    qtyBatu12.value = "Qty Batu12";
    qtyBatu12.cellStyle = headStyle;
    var batu13 = sheet.cell(CellIndex.indexByString("AM1"));
    batu13.value = "Ukuran Batu13";
    batu13.cellStyle = headStyle;
    var qtyBatu13 = sheet.cell(CellIndex.indexByString("AN1"));
    qtyBatu13.value = "Qty Batu13";
    qtyBatu13.cellStyle = headStyle;
    var batu14 = sheet.cell(CellIndex.indexByString("AO1"));
    batu14.value = "Ukuran Batu14";
    batu14.cellStyle = headStyle;
    var qtyBatu14 = sheet.cell(CellIndex.indexByString("AP1"));
    qtyBatu14.value = "Qty Batu14";
    qtyBatu14.cellStyle = headStyle;
    var batu15 = sheet.cell(CellIndex.indexByString("AQ1"));
    batu15.value = "Ukuran Batu15";
    batu15.cellStyle = headStyle;
    var qtyBatu15 = sheet.cell(CellIndex.indexByString("AR1"));
    qtyBatu15.value = "Qty Batu15";
    qtyBatu15.cellStyle = headStyle;
    var batu16 = sheet.cell(CellIndex.indexByString("AS1"));
    batu16.value = "Ukuran Batu16";
    batu16.cellStyle = headStyle;
    var qtyBatu16 = sheet.cell(CellIndex.indexByString("AT1"));
    qtyBatu16.value = "Qty Batu16";
    qtyBatu16.cellStyle = headStyle;
    var batu17 = sheet.cell(CellIndex.indexByString("AU1"));
    batu17.value = "Ukuran Batu17";
    batu17.cellStyle = headStyle;
    var qtyBatu17 = sheet.cell(CellIndex.indexByString("AV1"));
    qtyBatu17.value = "Qty Batu17";
    qtyBatu17.cellStyle = headStyle;
    var batu18 = sheet.cell(CellIndex.indexByString("AW1"));
    batu18.value = "Ukuran Batu18";
    batu18.cellStyle = headStyle;
    var qtyBatu18 = sheet.cell(CellIndex.indexByString("AX1"));
    qtyBatu18.value = "Qty Batu18";
    qtyBatu18.cellStyle = headStyle;
    var batu19 = sheet.cell(CellIndex.indexByString("AY1"));
    batu19.value = "Ukuran Batu19";
    batu19.cellStyle = headStyle;
    var qtyBatu19 = sheet.cell(CellIndex.indexByString("AZ1"));
    qtyBatu19.value = "Qty Batu19";
    qtyBatu19.cellStyle = headStyle;
    var batu20 = sheet.cell(CellIndex.indexByString("BA1"));
    batu20.value = "Ukuran Batu20";
    batu20.cellStyle = headStyle;
    var qtyBatu20 = sheet.cell(CellIndex.indexByString("BB1"));
    qtyBatu20.value = "Qty Batu20";
    qtyBatu20.cellStyle = headStyle;
    var batu21 = sheet.cell(CellIndex.indexByString("BC1"));
    batu21.value = "Ukuran Batu21";
    batu21.cellStyle = headStyle;
    var qtyBatu21 = sheet.cell(CellIndex.indexByString("BD1"));
    qtyBatu21.value = "Qty Batu21";
    qtyBatu21.cellStyle = headStyle;
    var batu22 = sheet.cell(CellIndex.indexByString("BE1"));
    batu22.value = "Ukuran Batu22";
    batu22.cellStyle = headStyle;
    var qtyBatu22 = sheet.cell(CellIndex.indexByString("BF1"));
    qtyBatu22.value = "Qty Batu22";
    qtyBatu22.cellStyle = headStyle;
    var batu23 = sheet.cell(CellIndex.indexByString("BG1"));
    batu23.value = "Ukuran Batu23";
    batu23.cellStyle = headStyle;
    var qtyBatu23 = sheet.cell(CellIndex.indexByString("BH1"));
    qtyBatu23.value = "Qty Batu23";
    qtyBatu23.cellStyle = headStyle;
    var batu24 = sheet.cell(CellIndex.indexByString("BI1"));
    batu24.value = "Ukuran Batu24";
    batu24.cellStyle = headStyle;
    var qtyBatu24 = sheet.cell(CellIndex.indexByString("BJ1"));
    qtyBatu24.value = "Qty Batu24";
    qtyBatu24.cellStyle = headStyle;
    var batu25 = sheet.cell(CellIndex.indexByString("BK1"));
    batu25.value = "Ukuran Batu25";
    batu25.cellStyle = headStyle;
    var qtyBatu25 = sheet.cell(CellIndex.indexByString("BL1"));
    qtyBatu25.value = "Qty Batu25";
    qtyBatu25.cellStyle = headStyle;
    var batu26 = sheet.cell(CellIndex.indexByString("BM1"));
    batu26.value = "Ukuran Batu26";
    batu26.cellStyle = headStyle;
    var qtyBatu26 = sheet.cell(CellIndex.indexByString("BN1"));
    qtyBatu26.value = "Qty Batu26";
    qtyBatu26.cellStyle = headStyle;
    var batu27 = sheet.cell(CellIndex.indexByString("BO1"));
    batu27.value = "Ukuran Batu27";
    batu27.cellStyle = headStyle;
    var qtyBatu27 = sheet.cell(CellIndex.indexByString("BP1"));
    qtyBatu27.value = "Qty Batu27";
    qtyBatu27.cellStyle = headStyle;
    var batu28 = sheet.cell(CellIndex.indexByString("BQ1"));
    batu28.value = "Ukuran Batu28";
    batu28.cellStyle = headStyle;
    var qtyBatu28 = sheet.cell(CellIndex.indexByString("BR1"));
    qtyBatu28.value = "Qty Batu28";
    qtyBatu28.cellStyle = headStyle;
    var batu29 = sheet.cell(CellIndex.indexByString("BS1"));
    batu29.value = "Ukuran Batu29";
    batu29.cellStyle = headStyle;
    var qtyBatu29 = sheet.cell(CellIndex.indexByString("BT1"));
    qtyBatu29.value = "Qty Batu29";
    qtyBatu29.cellStyle = headStyle;
    var batu30 = sheet.cell(CellIndex.indexByString("BU1"));
    batu30.value = "Ukuran Batu30";
    batu30.cellStyle = headStyle;
    var qtyBatu30 = sheet.cell(CellIndex.indexByString("BV1"));
    qtyBatu30.value = "Qty Batu30";
    qtyBatu30.cellStyle = headStyle;
    var batu31 = sheet.cell(CellIndex.indexByString("BW1"));
    batu31.value = "Ukuran Batu31";
    batu31.cellStyle = headStyle;
    var qtyBatu31 = sheet.cell(CellIndex.indexByString("BX1"));
    qtyBatu31.value = "Qty Batu31";
    qtyBatu31.cellStyle = headStyle;
    var batu32 = sheet.cell(CellIndex.indexByString("BY1"));
    batu32.value = "Ukuran Batu32";
    batu32.cellStyle = headStyle;
    var qtyBatu32 = sheet.cell(CellIndex.indexByString("BZ1"));
    qtyBatu32.value = "Qty Batu32";
    qtyBatu32.cellStyle = headStyle;
    var batu33 = sheet.cell(CellIndex.indexByString("CA1"));
    batu33.value = "Ukuran Batu33";
    batu33.cellStyle = headStyle;
    var qtyBatu33 = sheet.cell(CellIndex.indexByString("CB1"));
    qtyBatu33.value = "Qty Batu33";
    qtyBatu33.cellStyle = headStyle;
    var batu34 = sheet.cell(CellIndex.indexByString("CC1"));
    batu34.value = "Ukuran Batu34";
    batu34.cellStyle = headStyle;
    var qtyBatu34 = sheet.cell(CellIndex.indexByString("CD1"));
    qtyBatu34.value = "Qty Batu34";
    qtyBatu34.cellStyle = headStyle;
    var batu35 = sheet.cell(CellIndex.indexByString("CE1"));
    batu35.value = "Ukuran Batu35";
    batu35.cellStyle = headStyle;
    var qtyBatu35 = sheet.cell(CellIndex.indexByString("CF1"));
    qtyBatu35.value = "Qty Batu35";
    qtyBatu35.cellStyle = headStyle;

    for (int row = 0; row < myData!.length; row++) {
      //belum bisa image  Image.network( ApiConstants.baseUrlImage + myData![row].imageUrl!,);
      var data = myData![row];
      //? listn o
      var listNo = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1));
      listNo.value = (row + 1);

      //? list head1
      var listHeadi1 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1));
      listHeadi1.value = data.kodeDesignMdbc;

      //? list head2
      var listHeadi2 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1));
      listHeadi2.value = data.namaDesigner;
      //? list head3
      var listHeadi3 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1));
      listHeadi3.value = data.tema;
      //? list head4
      var listHeadi4 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1));
      listHeadi4.value = data.jenisBarang;
      //? list head5
      var listHeadi5 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1));
      listHeadi5.value = data.estimasiHarga;
      //? list head5
      var listHeadi6 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1));
      listHeadi6.value = ((data.estimasiHarga! * 0.37) * 11500) <= 5000000
          ? "XS"
          : ((data.estimasiHarga! * 0.37) * 11500) <= 10000000
              ? "S"
              : ((data.estimasiHarga! * 0.37) * 11500) <= 20000000
                  ? "M"
                  : ((data.estimasiHarga! * 0.37) * 11500) <= 35000000
                      ? "L"
                      : "XL";

      //? EMAS
      var emas = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row + 1));
      emas.value = data.beratEmas;
      //? rantai
      var rantai = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row + 1));
      rantai.value = data.rantai;
      //? qtyRantai
      var qtyRantai = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row + 1));
      qtyRantai.value = data.qtyRantai;
      //? lain2
      var lain2 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row + 1));
      lain2.value = data.lain2;
      //? qtyLain2
      var qtyLain2 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: row + 1));
      qtyLain2.value = data.qtyLain2;
      //? earnut
      var earnut = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: row + 1));
      earnut.value = data.earnut;
      //? qtyEarnut
      var qtyEarnut = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: row + 1));
      qtyEarnut.value = data.qtyEarnut;

      //* batu 1  - 35
      //? batu1
      var batu1 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: row + 1));
      batu1.value = data.batu1;
      //? qtyBatu1
      var qtyBatu1 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: row + 1));
      qtyBatu1.value = data.qtyBatu1;
      //? batu2
      var batu2 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: row + 1));
      batu2.value = data.batu2;
      //? qtyBatu2
      var qtyBatu2 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 17, rowIndex: row + 1));
      qtyBatu2.value = data.qtyBatu2;
      //? batu3
      var batu3 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 18, rowIndex: row + 1));
      batu3.value = data.batu3;
      //? qtyBatu3
      var qtyBatu3 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 19, rowIndex: row + 1));
      qtyBatu3.value = data.qtyBatu3;
      //? batu4
      var batu4 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 20, rowIndex: row + 1));
      batu4.value = data.batu4;
      //? qtyBatu4
      var qtyBatu4 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 21, rowIndex: row + 1));
      qtyBatu4.value = data.qtyBatu4;
      //? batu5
      var batu5 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 22, rowIndex: row + 1));
      batu5.value = data.batu5;
      //? qtyBatu5
      var qtyBatu5 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 23, rowIndex: row + 1));
      qtyBatu5.value = data.qtyBatu5;
      //? batu6
      var batu6 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 24, rowIndex: row + 1));
      batu6.value = data.batu6;
      //? qtyBatu6
      var qtyBatu6 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 25, rowIndex: row + 1));
      qtyBatu6.value = data.qtyBatu6;
      //? batu7
      var batu7 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 26, rowIndex: row + 1));
      batu7.value = data.batu7;
      //? qtyBatu7
      var qtyBatu7 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 27, rowIndex: row + 1));
      qtyBatu7.value = data.qtyBatu7;
      //? batu8
      var batu8 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 28, rowIndex: row + 1));
      batu8.value = data.batu8;
      //? qtyBatu8
      var qtyBatu8 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 29, rowIndex: row + 1));
      qtyBatu8.value = data.qtyBatu8;
      //? batu9
      var batu9 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 30, rowIndex: row + 1));
      batu9.value = data.batu9;
      //? qtyBatu9
      var qtyBatu9 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 31, rowIndex: row + 1));
      qtyBatu9.value = data.qtyBatu9;
      //? batu10
      var batu10 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 32, rowIndex: row + 1));
      batu10.value = data.batu10;
      //? qtyBatu10
      var qtyBatu10 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 33, rowIndex: row + 1));
      qtyBatu10.value = data.qtyBatu10;
      //? batu11
      var batu11 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 34, rowIndex: row + 1));
      batu11.value = data.batu11;
      //? qtyBatu11
      var qtyBatu11 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 35, rowIndex: row + 1));
      qtyBatu11.value = data.qtyBatu11;
      //? batu12
      var batu12 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 36, rowIndex: row + 1));
      batu12.value = data.batu12;
      //? qtyBatu12
      var qtyBatu12 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 37, rowIndex: row + 1));
      qtyBatu12.value = data.qtyBatu12;
      //? batu13
      var batu13 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 38, rowIndex: row + 1));
      batu13.value = data.batu13;
      //? qtyBatu13
      var qtyBatu13 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 39, rowIndex: row + 1));
      qtyBatu13.value = data.qtyBatu13;
      //? batu14
      var batu14 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 40, rowIndex: row + 1));
      batu14.value = data.batu14;
      //? qtyBatu14
      var qtyBatu14 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 41, rowIndex: row + 1));
      qtyBatu14.value = data.qtyBatu14;
      //? batu15
      var batu15 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 42, rowIndex: row + 1));
      batu15.value = data.batu15;
      //? qtyBatu15
      var qtyBatu15 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 43, rowIndex: row + 1));
      qtyBatu15.value = data.qtyBatu15;
      //? batu16
      var batu16 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 44, rowIndex: row + 1));
      batu16.value = data.batu16;
      //? qtyBatu16
      var qtyBatu16 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 45, rowIndex: row + 1));
      qtyBatu16.value = data.qtyBatu16;
      //? batu17
      var batu17 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 46, rowIndex: row + 1));
      batu17.value = data.batu17;
      //? qtyBatu17
      var qtyBatu17 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 47, rowIndex: row + 1));
      qtyBatu17.value = data.qtyBatu17;
      //? batu18
      var batu18 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 48, rowIndex: row + 1));
      batu18.value = data.batu18;
      //? qtyBatu18
      var qtyBatu18 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 49, rowIndex: row + 1));
      qtyBatu18.value = data.qtyBatu18;
      //? batu19
      var batu19 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 50, rowIndex: row + 1));
      batu19.value = data.batu19;
      //? qtyBatu19
      var qtyBatu19 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 51, rowIndex: row + 1));
      qtyBatu19.value = data.qtyBatu19;
      //? batu20
      var batu20 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 52, rowIndex: row + 1));
      batu20.value = data.batu20;
      //? qtyBatu20
      var qtyBatu20 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 53, rowIndex: row + 1));
      qtyBatu20.value = data.qtyBatu20;
      //? batu21
      var batu21 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 54, rowIndex: row + 1));
      batu21.value = data.batu21;
      //? qtyBatu21
      var qtyBatu21 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 55, rowIndex: row + 1));
      qtyBatu21.value = data.qtyBatu21;
      //? batu22
      var batu22 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 56, rowIndex: row + 1));
      batu22.value = data.batu22;
      //? qtyBatu22
      var qtyBatu22 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 57, rowIndex: row + 1));
      qtyBatu22.value = data.qtyBatu22;
      //? batu23
      var batu23 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 58, rowIndex: row + 1));
      batu23.value = data.batu23;
      //? qtyBatu23
      var qtyBatu23 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 59, rowIndex: row + 1));
      qtyBatu23.value = data.qtyBatu23;
      //? batu24
      var batu24 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 60, rowIndex: row + 1));
      batu24.value = data.batu24;
      //? qtyBatu24
      var qtyBatu24 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 61, rowIndex: row + 1));
      qtyBatu24.value = data.qtyBatu24;
      //? batu25
      var batu25 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 62, rowIndex: row + 1));
      batu25.value = data.batu25;
      //? qtyBatu25
      var qtyBatu25 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 63, rowIndex: row + 1));
      qtyBatu25.value = data.qtyBatu25;
      //? batu26
      var batu26 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 64, rowIndex: row + 1));
      batu26.value = data.batu26;
      //? qtyBatu26
      var qtyBatu26 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 65, rowIndex: row + 1));
      qtyBatu26.value = data.qtyBatu26;
      //? batu27
      var batu27 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 66, rowIndex: row + 1));
      batu27.value = data.batu27;
      //? qtyBatu27
      var qtyBatu27 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 67, rowIndex: row + 1));
      qtyBatu27.value = data.qtyBatu27;
      //? batu28
      var batu28 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 68, rowIndex: row + 1));
      batu28.value = data.batu28;
      //? qtyBatu28
      var qtyBatu28 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 69, rowIndex: row + 1));
      qtyBatu28.value = data.qtyBatu28;
      //? batu29
      var batu29 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 70, rowIndex: row + 1));
      batu29.value = data.batu29;
      //? qtyBatu29
      var qtyBatu29 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 71, rowIndex: row + 1));
      qtyBatu29.value = data.qtyBatu29;
      //? batu30
      var batu30 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 72, rowIndex: row + 1));
      batu30.value = data.batu30;
      //? qtyBatu30
      var qtyBatu30 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 73, rowIndex: row + 1));
      qtyBatu30.value = data.qtyBatu30;
      //? batu31
      var batu31 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 74, rowIndex: row + 1));
      batu31.value = data.batu31;
      //? qtyBatu31
      var qtyBatu31 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 75, rowIndex: row + 1));
      qtyBatu31.value = data.qtyBatu31;
      //? batu32
      var batu32 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 76, rowIndex: row + 1));
      batu32.value = data.batu32;
      //? qtyBatu32
      var qtyBatu32 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 77, rowIndex: row + 1));
      qtyBatu32.value = data.qtyBatu32;
      //? batu33
      var batu33 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 78, rowIndex: row + 1));
      batu33.value = data.batu33;
      //? qtyBatu33
      var qtyBatu33 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 79, rowIndex: row + 1));
      qtyBatu33.value = data.qtyBatu33;
      //? batu34
      var batu34 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 80, rowIndex: row + 1));
      batu34.value = data.batu34;
      //? qtyBatu34
      var qtyBatu34 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 81, rowIndex: row + 1));
      qtyBatu34.value = data.qtyBatu34;
      //? batu35
      var batu35 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 82, rowIndex: row + 1));
      batu35.value = data.batu35;
      //? qtyBatu35
      var qtyBatu35 = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 83, rowIndex: row + 1));
      qtyBatu35.value = data.qtyBatu35;
    }

    excel.rename("mySheet", "result");
    excel.delete('Sheet1');

    /// appending rows and checking the time complexity of it
    Stopwatch stopwatch = Stopwatch()..start();
    stopwatch.reset();
    // Saving the file
    String outputFile = "/Users/kawal/Desktop/git_projects/r.xlsx";
    //stopwatch.reset();
    List<int>? fileBytes = excel.save();
    //print('saving executed in ${stopwatch.elapsed}');
    if (fileBytes != null) {
      File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }
  }
}
