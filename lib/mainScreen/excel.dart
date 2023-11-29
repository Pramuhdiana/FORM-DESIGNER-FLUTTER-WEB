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
  List<String> listAllBatu = [];
  List<int> listAllQtyBatu = [];
  List<int> listUniqQtyBatu = [];
  List<String> listUniqBatu = [];
  Map<String, int> mylist = {};

  Future<void> exportExcel(siklus) async {
    listAllBatu.clear();
    listAllQtyBatu.clear();
    listUniqQtyBatu.clear();
    listUniqBatu.clear();
    mylist.clear();

//get data
    // ignore: avoid_print
    print(siklus);
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      if (siklus != '') {
        var filterBySiklus = allData.where((element) =>
            element.siklus!.toLowerCase() == siklus.toString().toLowerCase());
        allData = filterBySiklus.toList();
        final data = allData;

        //funtion batu
        //! remove batu1
        List<String> listBatu1 = [];
        List<int> listQtyBatu1 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu1.toString() != '0') {
            listQtyBatu1.add(data[i].qtyBatu1!);
            listBatu1.add(data[i].batu1!);
          }
        }

        //! remove batu2
        List<String> listBatu2 = [];
        List<int> listQtyBatu2 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu2!.toString() != '0') {
            listQtyBatu2.add(data[i].qtyBatu2!);
            listBatu2.add(data[i].batu2!);
          }
        }

        //! remove batu3
        List<String> listBatu3 = [];
        List<int> listQtyBatu3 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu3!.toString() != '0') {
            listQtyBatu3.add(data[i].qtyBatu3!);
            listBatu3.add(data[i].batu3!);
          }
        }
        //! remove batu4
        List<String> listBatu4 = [];
        List<int> listQtyBatu4 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu4!.toString() != '0') {
            listQtyBatu4.add(data[i].qtyBatu4!);
            listBatu4.add(data[i].batu4!);
          }
        }

        //! remove batu5
        List<String> listBatu5 = [];
        List<int> listQtyBatu5 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu5!.toString() != '0') {
            listQtyBatu5.add(data[i].qtyBatu5!);
            listBatu5.add(data[i].batu5!);
          }
        }

        //! remove batu6
        List<String> listBatu6 = [];
        List<int> listQtyBatu6 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu6!.toString() != '0') {
            listQtyBatu6.add(data[i].qtyBatu6!);
            listBatu6.add(data[i].batu6!);
          }
        }

        //! remove batu7
        List<String> listBatu7 = [];
        List<int> listQtyBatu7 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu7!.toString() != '0') {
            listQtyBatu7.add(data[i].qtyBatu7!);
            listBatu7.add(data[i].batu7!);
          }
        }

        //! remove batu8
        List<String> listBatu8 = [];
        List<int> listQtyBatu8 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu8!.toString() != '0') {
            listQtyBatu8.add(data[i].qtyBatu8!);
            listBatu8.add(data[i].batu8!);
          }
        }

        //! remove batu9
        List<String> listBatu9 = [];
        List<int> listQtyBatu9 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu9!.toString() != '0') {
            listQtyBatu9.add(data[i].qtyBatu9!);
            listBatu9.add(data[i].batu9!);
          }
        }

        //! remove batu10
        List<String> listBatu10 = [];
        List<int> listQtyBatu10 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu10!.toString() != '0') {
            listQtyBatu10.add(data[i].qtyBatu10!);
            listBatu10.add(data[i].batu10!);
          }
        }

        //! remove batu11
        List<String> listBatu11 = [];
        List<int> listQtyBatu11 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu11!.toString() != '0') {
            listBatu11.add(data[i].batu11!);
            listQtyBatu11.add(data[i].qtyBatu11!);
          }
        }

        //! remove batu12
        List<String> listBatu12 = [];
        List<int> listQtyBatu12 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu12!.toString() != '0') {
            listBatu12.add(data[i].batu12!);
            listQtyBatu12.add(data[i].qtyBatu12!);
          }
        }

        //! remove batu13
        List<String> listBatu13 = [];
        List<int> listQtyBatu13 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu13!.toString() != '0') {
            listBatu13.add(data[i].batu13!);
            listQtyBatu13.add(data[i].qtyBatu13!);
          }
        }

        //! remove batu14
        List<String> listBatu14 = [];
        List<int> listQtyBatu14 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu14!.toString() != '0') {
            listBatu14.add(data[i].batu14!);
            listQtyBatu14.add(data[i].qtyBatu14!);
          }
        }

        //! remove batu15
        List<String> listBatu15 = [];
        List<int> listQtyBatu15 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu15!.toString() != '0') {
            listBatu15.add(data[i].batu15!);
            listQtyBatu15.add(data[i].qtyBatu15!);
          }
        }

        //! remove batu16
        List<String> listBatu16 = [];
        List<int> listQtyBatu16 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu16!.toString() != '0') {
            listQtyBatu16.add(data[i].qtyBatu16!);
            listBatu16.add(data[i].batu16!);
          }
        }

        //! remove batu17
        List<String> listBatu17 = [];
        List<int> listQtyBatu17 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu17!.toString() != '0') {
            listQtyBatu17.add(data[i].qtyBatu17!);
            listBatu17.add(data[i].batu17!);
          }
        }

        //! remove batu18
        List<String> listBatu18 = [];
        List<int> listQtyBatu18 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu18!.toString() != '0') {
            listQtyBatu18.add(data[i].qtyBatu18!);
            listBatu18.add(data[i].batu18!);
          }
        }

        //! remove batu19
        List<String> listBatu19 = [];
        List<int> listQtyBatu19 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu19!.toString() != '0') {
            listQtyBatu19.add(data[i].qtyBatu19!);
            listBatu19.add(data[i].batu19!);
          }
        }

        //! remove batu20
        List<String> listBatu20 = [];
        List<int> listQtyBatu20 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu20!.toString() != '0') {
            listQtyBatu20.add(data[i].qtyBatu20!);
            listBatu20.add(data[i].batu20!);
          }
        }

        //! remove batu21
        List<String> listBatu21 = [];
        List<int> listQtyBatu21 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu21!.toString() != '0') {
            listQtyBatu21.add(data[i].qtyBatu21!);
            listBatu21.add(data[i].batu21!);
          }
        }

        //! remove batu22
        List<String> listBatu22 = [];
        List<int> listQtyBatu22 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu22!.toString() != '0') {
            listQtyBatu22.add(data[i].qtyBatu22!);
            listBatu22.add(data[i].batu22!);
          }
        }

        //! remove batu23
        List<String> listBatu23 = [];
        List<int> listQtyBatu23 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu23!.toString() != '0') {
            listQtyBatu23.add(data[i].qtyBatu23!);
            listBatu23.add(data[i].batu23!);
          }
        }

        //! remove batu24
        List<String> listBatu24 = [];
        List<int> listQtyBatu24 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu24!.toString() != '0') {
            listQtyBatu24.add(data[i].qtyBatu24!);
            listBatu24.add(data[i].batu24!);
          }
        }

        //! remove batu25
        List<String> listBatu25 = [];
        List<int> listQtyBatu25 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu25!.toString() != '0') {
            listQtyBatu25.add(data[i].qtyBatu25!);
            listBatu25.add(data[i].batu25!);
          }
        }

        //! remove batu26
        List<String> listBatu26 = [];
        List<int> listQtyBatu26 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu26!.toString() != '0') {
            listQtyBatu26.add(data[i].qtyBatu26!);
            listBatu26.add(data[i].batu26!);
          }
        }

        //! remove batu27
        List<String> listBatu27 = [];
        List<int> listQtyBatu27 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu27!.toString() != '0') {
            listQtyBatu27.add(data[i].qtyBatu27!);
            listBatu27.add(data[i].batu27!);
          }
        }

        //! remove batu28
        List<String> listBatu28 = [];
        List<int> listQtyBatu28 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu28!.toString() != '0') {
            listQtyBatu28.add(data[i].qtyBatu28!);
            listBatu28.add(data[i].batu28!);
          }
        }

        //! remove batu29
        List<String> listBatu29 = [];
        List<int> listQtyBatu29 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu29!.toString() != '0') {
            listQtyBatu29.add(data[i].qtyBatu29!);
            listBatu29.add(data[i].batu29!);
          }
        }

        //! remove batu30
        List<String> listBatu30 = [];
        List<int> listQtyBatu30 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu30!.toString() != '0') {
            listQtyBatu30.add(data[i].qtyBatu30!);
            listBatu30.add(data[i].batu30!);
          }
        }

        //! remove batu31
        List<String> listBatu31 = [];
        List<int> listQtyBatu31 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu31!.toString() != '0') {
            listQtyBatu31.add(data[i].qtyBatu31!);
            listBatu31.add(data[i].batu31!);
          }
        }

        //! remove batu32
        List<String> listBatu32 = [];
        List<int> listQtyBatu32 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu32!.toString() != '0') {
            listQtyBatu32.add(data[i].qtyBatu32!);
            listBatu32.add(data[i].batu32!);
          }
        }

        //! remove batu33
        List<String> listBatu33 = [];
        List<int> listQtyBatu33 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu33!.toString() != '0') {
            listQtyBatu33.add(data[i].qtyBatu33!);
            listBatu33.add(data[i].batu33!);
          }
        }

        //! remove batu34
        List<String> listBatu34 = [];
        List<int> listQtyBatu34 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu34!.toString() != '0') {
            listQtyBatu34.add(data[i].qtyBatu34!);
            listBatu34.add(data[i].batu34!);
          }
        }

        //! remove batu35
        List<String> listBatu35 = [];
        List<int> listQtyBatu35 = [];
        for (var i = 0; i < data.length; i++) {
          if (data[i].qtyBatu35!.toString() != '0') {
            listQtyBatu35.add(data[i].qtyBatu35!);
            listBatu35.add(data[i].batu35!);
          }
        }
        listAllBatu.addAll(listBatu1);
        listAllBatu.addAll(listBatu2);
        listAllBatu.addAll(listBatu3);
        listAllBatu.addAll(listBatu4);
        listAllBatu.addAll(listBatu5);
        listAllBatu.addAll(listBatu6);
        listAllBatu.addAll(listBatu7);
        listAllBatu.addAll(listBatu8);
        listAllBatu.addAll(listBatu9);
        listAllBatu.addAll(listBatu10);
        listAllBatu.addAll(listBatu11);
        listAllBatu.addAll(listBatu12);
        listAllBatu.addAll(listBatu13);
        listAllBatu.addAll(listBatu14);
        listAllBatu.addAll(listBatu15);
        listAllBatu.addAll(listBatu16);
        listAllBatu.addAll(listBatu17);
        listAllBatu.addAll(listBatu18);
        listAllBatu.addAll(listBatu19);
        listAllBatu.addAll(listBatu20);
        listAllBatu.addAll(listBatu21);
        listAllBatu.addAll(listBatu22);
        listAllBatu.addAll(listBatu23);
        listAllBatu.addAll(listBatu24);
        listAllBatu.addAll(listBatu25);
        listAllBatu.addAll(listBatu26);
        listAllBatu.addAll(listBatu27);
        listAllBatu.addAll(listBatu28);
        listAllBatu.addAll(listBatu29);
        listAllBatu.addAll(listBatu30);
        listAllBatu.addAll(listBatu31);
        listAllBatu.addAll(listBatu32);
        listAllBatu.addAll(listBatu33);
        listAllBatu.addAll(listBatu34);
        listAllBatu.addAll(listBatu35);
        listAllBatu.removeWhere((value) => value == '');
        listAllQtyBatu.addAll(listQtyBatu1);
        listAllQtyBatu.addAll(listQtyBatu2);
        listAllQtyBatu.addAll(listQtyBatu3);
        listAllQtyBatu.addAll(listQtyBatu4);
        listAllQtyBatu.addAll(listQtyBatu5);
        listAllQtyBatu.addAll(listQtyBatu6);
        listAllQtyBatu.addAll(listQtyBatu7);
        listAllQtyBatu.addAll(listQtyBatu8);
        listAllQtyBatu.addAll(listQtyBatu9);
        listAllQtyBatu.addAll(listQtyBatu10);
        listAllQtyBatu.addAll(listQtyBatu11);
        listAllQtyBatu.addAll(listQtyBatu12);
        listAllQtyBatu.addAll(listQtyBatu13);
        listAllQtyBatu.addAll(listQtyBatu14);
        listAllQtyBatu.addAll(listQtyBatu15);
        listAllQtyBatu.addAll(listQtyBatu16);
        listAllQtyBatu.addAll(listQtyBatu17);
        listAllQtyBatu.addAll(listQtyBatu18);
        listAllQtyBatu.addAll(listQtyBatu19);
        listAllQtyBatu.addAll(listQtyBatu20);
        listAllQtyBatu.addAll(listQtyBatu21);
        listAllQtyBatu.addAll(listQtyBatu22);
        listAllQtyBatu.addAll(listQtyBatu23);
        listAllQtyBatu.addAll(listQtyBatu24);
        listAllQtyBatu.addAll(listQtyBatu25);
        listAllQtyBatu.addAll(listQtyBatu26);
        listAllQtyBatu.addAll(listQtyBatu27);
        listAllQtyBatu.addAll(listQtyBatu28);
        listAllQtyBatu.addAll(listQtyBatu29);
        listAllQtyBatu.addAll(listQtyBatu30);
        listAllQtyBatu.addAll(listQtyBatu31);
        listAllQtyBatu.addAll(listQtyBatu32);
        listAllQtyBatu.addAll(listQtyBatu33);
        listAllQtyBatu.addAll(listQtyBatu34);
        listAllQtyBatu.addAll(listQtyBatu35);
        listAllQtyBatu.removeWhere((value) => value == 0);
        listUniqBatu = listAllBatu.toSet().toList();
        var sum = 0;
        //looping menyatukan size dan qty
        // listUniqBatu.length
        for (var i = 0; i < listUniqBatu.length; i++) {
          sum = 0;

          for (var j = 0; j < listAllBatu.length; j++) {
            mylist[listUniqBatu[i]] = sum;

            if (listUniqBatu[i] == listAllBatu[j]) {
              sum = sum + listAllQtyBatu[j];
              // ignore: avoid_print
              print('true ${listUniqBatu[i]} == ${listAllBatu[j]}');
              mylist.update(listUniqBatu[i], (value) => sum);
            } else {}
          }
        }

        Iterable<int> values = mylist.values;
        for (final value in values) {
          listUniqQtyBatu.add(value);
        }
      } else {
        allData = allData;
      }

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
    var head36 = sheet.cell(CellIndex.indexByString("CG1"));
    head36.value = "Siklus";
    head36.cellStyle = headStyle;

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

      //? SIKLUS
      var siklus = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 84, rowIndex: row + 1));
      siklus.value = data.siklus;
    }

    excel.rename("mySheet", "result");

    //! sheet 2
    var sheet2 = excel['kebutuhan batu'];
    var noSheet2 = sheet2.cell(CellIndex.indexByString("A1"));
    noSheet2.value = "No";
    noSheet2.cellStyle = headStyle;
    var head1Sheet2 = sheet2.cell(CellIndex.indexByString("B1"));
    head1Sheet2.value = "Ukuran";
    head1Sheet2.cellStyle = headStyle;
    var head2Sheet2 = sheet2.cell(CellIndex.indexByString("C1"));
    head2Sheet2.value = "Kebutuhan";
    head2Sheet2.cellStyle = headStyle;

    for (int row = 0; row < listUniqBatu.length; row++) {
      // var dataSheet2 = myData![row];
      //? no
      var listNoSheet2 = sheet2
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1));
      listNoSheet2.value = (row + 1);
      //? list head1
      var listHead1Sheet2 = sheet2
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1));
      listHead1Sheet2.value = listUniqBatu[row];
      //? list head1
      var listHead2Sheet2 = sheet2
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1));
      listHead2Sheet2.value = listUniqQtyBatu[row];
    }
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
