// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages, unrelated_type_equality_checks

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/SCM/model/kebutuhan_batu_model.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/side_screen_kebutuhan_batu.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

class ListKebutuhanBatuScreen extends StatefulWidget {
  const ListKebutuhanBatuScreen({super.key});
  @override
  State<ListKebutuhanBatuScreen> createState() =>
      _ListKebutuhanBatuScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListKebutuhanBatuScreenState extends State<ListKebutuhanBatuScreen> {
  List<KebutuhanBatuModel>? filterListBatu;
  List<String> listAllBatu = [];
  List<String> listUniqBatu = [];
  List<int> listAllQtyBatu = [];
  List<int> listUniqQtyBatu = [];
  List<String> listUniqResultBatu = [];
  List<String> listResultBatu = [];
  Map<String, int> mylist = {};
  TextEditingController siklus = TextEditingController();

  TextEditingController controller = TextEditingController();
  bool sort = true;
  bool isLoading = false;
  int? page;
  int? limit;
  int _currentSortColumn = 0;
  String siklusDesigner = '';
  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    print(month);
    _getData("all");
  }

  // ignore: unused_element
  Future<List<KebutuhanBatuModel>> _getDataByPagenLimit() async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerBySiklus}?siklus=${siklus.text}'));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g = jsonResponse
          .map((data) => KebutuhanBatuModel.fromJson(data))
          .toList();
      // setState(() {
      //   isLoading = true;
      // });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<KebutuhanBatuModel>> _getData(siklus) async {
    listAllBatu.clear();
    listAllQtyBatu.clear();
    listUniqQtyBatu.clear();
    listUniqBatu.clear();
    mylist.clear();

    final response;

    if (siklus.toString().toLowerCase() == "all") {
      response = await http.get(Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.getListFormDesigner}'));
    } else {
      response = await http.get(Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerBySiklus}?siklus=$siklus'));
    }

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      final data = jsonDecode(response.body);

      //! remove batu1
      List<String> listBatu1 = [];
      List<int> listQtyBatu1 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu1'].toString() != '0') {
          listQtyBatu1.add(data[i]['qtyBatu1']);
          listBatu1.add(data[i]['batu1']);
        }
      }

      //! remove batu2
      List<String> listBatu2 = [];
      List<int> listQtyBatu2 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu2'].toString() != '0') {
          listQtyBatu2.add(data[i]['qtyBatu2']);
          listBatu2.add(data[i]['batu2']);
        }
      }

      //! remove batu3
      List<String> listBatu3 = [];
      List<int> listQtyBatu3 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu3'].toString() != '0') {
          listQtyBatu3.add(data[i]['qtyBatu3']);
          listBatu3.add(data[i]['batu3']);
        }
      }

      //! remove batu4
      List<String> listBatu4 = [];
      List<int> listQtyBatu4 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu4'].toString() != '0') {
          listQtyBatu4.add(data[i]['qtyBatu4']);
          listBatu4.add(data[i]['batu4']);
        }
      }

      //! remove batu5
      List<String> listBatu5 = [];
      List<int> listQtyBatu5 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu5'].toString() != '0') {
          listQtyBatu5.add(data[i]['qtyBatu5']);
          listBatu5.add(data[i]['batu5']);
        }
      }

      //! remove batu6
      List<String> listBatu6 = [];
      List<int> listQtyBatu6 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu6'].toString() != '0') {
          listQtyBatu6.add(data[i]['qtyBatu6']);
          listBatu6.add(data[i]['batu6']);
        }
      }

      //! remove batu7
      List<String> listBatu7 = [];
      List<int> listQtyBatu7 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu7'].toString() != '0') {
          listQtyBatu7.add(data[i]['qtyBatu7']);
          listBatu7.add(data[i]['batu7']);
        }
      }

      //! remove batu8
      List<String> listBatu8 = [];
      List<int> listQtyBatu8 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu8'].toString() != '0') {
          listQtyBatu8.add(data[i]['qtyBatu8']);
          listBatu8.add(data[i]['batu8']);
        }
      }

      //! remove batu9
      List<String> listBatu9 = [];
      List<int> listQtyBatu9 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu9'].toString() != '0') {
          listQtyBatu9.add(data[i]['qtyBatu9']);
          listBatu9.add(data[i]['batu9']);
        }
      }

      //! remove batu10
      List<String> listBatu10 = [];
      List<int> listQtyBatu10 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu10'].toString() != '0') {
          listQtyBatu10.add(data[i]['qtyBatu10']);
          listBatu10.add(data[i]['batu10']);
        }
      }

      //! remove batu11
      List<String> listBatu11 = [];
      List<int> listQtyBatu11 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu11'].toString() != '0') {
          listBatu11.add(data[i]['batu11']);
          listQtyBatu11.add(data[i]['qtyBatu11']);
        }
      }

      //! remove batu12
      List<String> listBatu12 = [];
      List<int> listQtyBatu12 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu12'].toString() != '0') {
          listBatu12.add(data[i]['batu12']);
          listQtyBatu12.add(data[i]['qtyBatu12']);
        }
      }

      //! remove batu13
      List<String> listBatu13 = [];
      List<int> listQtyBatu13 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu13'].toString() != '0') {
          listBatu13.add(data[i]['batu13']);
          listQtyBatu13.add(data[i]['qtyBatu13']);
        }
      }

      //! remove batu14
      List<String> listBatu14 = [];
      List<int> listQtyBatu14 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu14'].toString() != '0') {
          listBatu14.add(data[i]['batu14']);
          listQtyBatu14.add(data[i]['qtyBatu14']);
        }
      }

      //! remove batu15
      List<String> listBatu15 = [];
      List<int> listQtyBatu15 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu15'].toString() != '0') {
          listBatu15.add(data[i]['batu15']);
          listQtyBatu15.add(data[i]['qtyBatu15']);
        }
      }

      //! remove batu16
      List<String> listBatu16 = [];
      List<int> listQtyBatu16 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu16'].toString() != '0') {
          listQtyBatu16.add(data[i]['qtyBatu16']);
          listBatu16.add(data[i]['batu16']);
        }
      }

      //! remove batu17
      List<String> listBatu17 = [];
      List<int> listQtyBatu17 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu17'].toString() != '0') {
          listQtyBatu17.add(data[i]['qtyBatu17']);
          listBatu17.add(data[i]['batu17']);
        }
      }

      //! remove batu18
      List<String> listBatu18 = [];
      List<int> listQtyBatu18 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu18'].toString() != '0') {
          listQtyBatu18.add(data[i]['qtyBatu18']);
          listBatu18.add(data[i]['batu18']);
        }
      }

      //! remove batu19
      List<String> listBatu19 = [];
      List<int> listQtyBatu19 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu19'].toString() != '0') {
          listQtyBatu19.add(data[i]['qtyBatu19']);
          listBatu19.add(data[i]['batu19']);
        }
      }

      //! remove batu20
      List<String> listBatu20 = [];
      List<int> listQtyBatu20 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu20'].toString() != '0') {
          listQtyBatu20.add(data[i]['qtyBatu20']);
          listBatu20.add(data[i]['batu20']);
        }
      }

      //! remove batu21
      List<String> listBatu21 = [];
      List<int> listQtyBatu21 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu21'].toString() != '0') {
          listQtyBatu21.add(data[i]['qtyBatu21']);
          listBatu21.add(data[i]['batu21']);
        }
      }

      //! remove batu22
      List<String> listBatu22 = [];
      List<int> listQtyBatu22 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu22'].toString() != '0') {
          listQtyBatu22.add(data[i]['qtyBatu22']);
          listBatu22.add(data[i]['batu22']);
        }
      }

      //! remove batu23
      List<String> listBatu23 = [];
      List<int> listQtyBatu23 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu23'].toString() != '0') {
          listQtyBatu23.add(data[i]['qtyBatu23']);
          listBatu23.add(data[i]['batu23']);
        }
      }

      //! remove batu24
      List<String> listBatu24 = [];
      List<int> listQtyBatu24 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu24'].toString() != '0') {
          listQtyBatu24.add(data[i]['qtyBatu24']);
          listBatu24.add(data[i]['batu24']);
        }
      }

      //! remove batu25
      List<String> listBatu25 = [];
      List<int> listQtyBatu25 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu25'].toString() != '0') {
          listQtyBatu25.add(data[i]['qtyBatu25']);
          listBatu25.add(data[i]['batu25']);
        }
      }

      //! remove batu26
      List<String> listBatu26 = [];
      List<int> listQtyBatu26 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu26'].toString() != '0') {
          listQtyBatu26.add(data[i]['qtyBatu26']);
          listBatu26.add(data[i]['batu26']);
        }
      }

      //! remove batu27
      List<String> listBatu27 = [];
      List<int> listQtyBatu27 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu27'].toString() != '0') {
          listQtyBatu27.add(data[i]['qtyBatu27']);
          listBatu27.add(data[i]['batu27']);
        }
      }

      //! remove batu28
      List<String> listBatu28 = [];
      List<int> listQtyBatu28 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu28'].toString() != '0') {
          listQtyBatu28.add(data[i]['qtyBatu28']);
          listBatu28.add(data[i]['batu28']);
        }
      }

      //! remove batu29
      List<String> listBatu29 = [];
      List<int> listQtyBatu29 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu29'].toString() != '0') {
          listQtyBatu29.add(data[i]['qtyBatu29']);
          listBatu29.add(data[i]['batu29']);
        }
      }

      //! remove batu30
      List<String> listBatu30 = [];
      List<int> listQtyBatu30 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu30'].toString() != '0') {
          listQtyBatu30.add(data[i]['qtyBatu30']);
          listBatu30.add(data[i]['batu30']);
        }
      }

      //! remove batu31
      List<String> listBatu31 = [];
      List<int> listQtyBatu31 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu31'].toString() != '0') {
          listQtyBatu31.add(data[i]['qtyBatu31']);
          listBatu31.add(data[i]['batu31']);
        }
      }

      //! remove batu32
      List<String> listBatu32 = [];
      List<int> listQtyBatu32 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu32'].toString() != '0') {
          listQtyBatu32.add(data[i]['qtyBatu32']);
          listBatu32.add(data[i]['batu32']);
        }
      }

      //! remove batu33
      List<String> listBatu33 = [];
      List<int> listQtyBatu33 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu33'].toString() != '0') {
          listQtyBatu33.add(data[i]['qtyBatu33']);
          listBatu33.add(data[i]['batu33']);
        }
      }

      //! remove batu34
      List<String> listBatu34 = [];
      List<int> listQtyBatu34 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu34'].toString() != '0') {
          listQtyBatu34.add(data[i]['qtyBatu34']);
          listBatu34.add(data[i]['batu34']);
        }
      }

      //! remove batu35
      List<String> listBatu35 = [];
      List<int> listQtyBatu35 = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]['qtyBatu35'].toString() != '0') {
          listQtyBatu35.add(data[i]['qtyBatu35']);
          listBatu35.add(data[i]['batu35']);
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
      print(listAllBatu.length);

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
      print(listAllQtyBatu.length);

      listUniqBatu = listAllBatu.toSet().toList();
      // print(listUniqBatu);

      var sum = 0;
      //looping menyatukan size dan qty
      for (var i = 0; i < listUniqBatu.length; i++) {
        sum = 0;

        for (var j = 0; j < listAllBatu.length; j++) {
          mylist[listUniqBatu[i]] = sum;

          if (mylist[listUniqBatu[i]] != mylist[listAllBatu[j]]) {
          } else {
            sum = sum + listAllQtyBatu[j];
            mylist.update(listUniqBatu[i], (value) => sum);
          }
        }
      }

      Iterable<int> values = mylist.values;
      for (final value in values) {
        listUniqQtyBatu.add(value);
      }

      // print(listUniqBatu);
      // print(listUniqQtyBatu);
      var g = jsonResponse
          .map((data) => KebutuhanBatuModel.fromJson(data))
          .toList();
      filterListBatu = g;
      // setState(() {
      //   isLoading = true;
      // });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

// fungsi remove duplicate object
  List<KebutuhanBatuModel> removeDuplicates(List<KebutuhanBatuModel> items) {
    List<KebutuhanBatuModel> uniqueItems = []; // uniqueList
    var uniqueNames = items
        .map((e) => e.batu1)
        .toSet(); //list if UniqueID to remove duplicates
    for (var e in uniqueNames) {
      uniqueItems.add(items.firstWhere((i) => i.batu1 == e));
    } // populate uniqueItems with equivalent original Batch items
    return uniqueItems; //send back the unique items list
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: null_check_always_fails
      onWillPop: () async => null!,
      child: Scaffold(
        // drawer: Drawer1(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.blue,
          flexibleSpace: Container(
            color: Colors.blue,
          ),
          title: const Text(
            "LIST KEBUTUHAN BATU",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownSearch<String>(
                  items: const [
                    "JANUARI",
                    "FEBRUARI",
                    "MARET",
                    "APRIL",
                    "MEI",
                    "JUNI",
                    "JULI",
                    "AGUSTUS",
                    "SEPTEMBER",
                    "OKTOBER",
                    "NOVEMBER",
                    "DESEMBER"
                  ],
                  onChanged: (item) async {
                    setState(() {
                      isLoading = false;
                    });
                    siklus.text = item!;
                    siklusDesigner = siklus.text.toString();
                    _getData(siklus.text);

                    //? tunggu 2 detik
                    Future.delayed(const Duration(seconds: 2)).then((value) {
                      //! lalu eksekusi fungsi ini
                      setState(() {
                        isLoading = true;
                      });
                    });
                  },
                  popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                  ),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Pilih Siklus",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              siklusDesigner.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        SizedBox(
                          width: 250,
                          height: 210,
                          child: Lottie.asset("loadingJSON/selectDate.json"),
                        ),
                        const Text(
                          'Pilih siklus terlebih dahulu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Acne',
                              letterSpacing: 1.5),
                        ),
                      ],
                    ))
                  : isLoading == false
                      ? Expanded(
                          child: Center(
                              child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 90,
                          height: 90,
                          child: Lottie.asset("loadingJSON/loadingV1.json"),
                        )))
                      : Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * 1,
                              child: SizedBox(
                                width: double.infinity,
                                child: Theme(
                                  data: ThemeData.light().copyWith(
                                      // cardColor: Theme.of(context).canvasColor),
                                      cardColor: Colors.white,
                                      hoverColor: Colors.grey.shade400,
                                      dividerColor: Colors.grey),
                                  child: PaginatedDataTable(
                                      sortColumnIndex: _currentSortColumn,
                                      sortAscending: sort,
                                      rowsPerPage: 25,
                                      columnSpacing: 0,
                                      columns: [
                                        // LOT
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 120,
                                              child: Text(
                                                "LOT",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        //UKURAN
                                        DataColumn(
                                            label: const SizedBox(
                                                width: 120,
                                                child: Text(
                                                  "UKURAN",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            onSort: (columnIndex, _) {
                                              setState(() {
                                                _currentSortColumn =
                                                    columnIndex;
                                                if (sort == true) {
                                                  sort = false;
                                                  listUniqBatu.sort((a, b) => a
                                                      .toLowerCase()
                                                      .compareTo(
                                                          b.toLowerCase()));
                                                } else {
                                                  sort = true;
                                                  listUniqBatu.sort((a, b) => b
                                                      .toLowerCase()
                                                      .compareTo(
                                                          a.toLowerCase()));
                                                }
                                              });
                                            }),
                                        DataColumn(label: _verticalDivider),

                                        //QTY
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 120,
                                              child: Text(
                                                "QTY AWAL",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        //? penyesuaian
                                        DataColumn(
                                          label: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              width: 120,
                                              child: const Text(
                                                "Penyesuaian",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataColumn(label: _verticalDivider),

                                        //stok
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 120,
                                              child: Text(
                                                "STOK",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataColumn(label: _verticalDivider),

                                        //total penyesuaian
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 120,
                                              child: Text(
                                                "ADJUSMENT",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataColumn(label: _verticalDivider),

                                        //hasil penyesuaian
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 120,
                                              child: Text(
                                                "QTY AKHIR",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ],
                                      source: RowSource(
                                          size: listUniqBatu,
                                          qty: listUniqQtyBatu,
                                          count: listUniqBatu.length,
                                          mylist: mylist,
                                          siklus: siklusDesigner)),
                                ),
                              ),
                            ),
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  var size;
  var qty;
  final count;
  var mylist;
  var siklus;

  RowSource({
    required this.size,
    required this.qty,
    required this.count,
    required this.mylist,
    required this.siklus,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(size![index], mylist, qty![index], siklus);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var size, var mylist, var qty, var siklus) {
    print(mylist);
    _getSum(size, siklus);

    return DataRow(cells: [
      //lot
      DataCell(FutureBuilder(
          future: _getLotBySize(size),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('CUSTOM');
            }
            if (snapshot.hasData) {
              return Text(snapshot.data!.toString());
            } else {
              return const CircularProgressIndicator();
            }
          })),
      DataCell(_verticalDivider),
      //ukuran
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(size)),
      ),
      DataCell(_verticalDivider),

      //qty AWAL
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(mylist[size].toString())),
      ),

      DataCell(_verticalDivider),
      //? penyesuaian Qty
      DataCell(Builder(builder: (context) {
        TextEditingController penyesuaianQty = TextEditingController();

        return Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 15),
              width: 100,
              height: 30,
              child: TextFormField(
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textInputAction: TextInputAction.next,
                controller: penyesuaianQty,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            siklus.toString().isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      final _formKey = GlobalKey<FormState>();
                      // ignore: unused_local_variable
                      bool isKodeAkses = false;
                      TextEditingController kodeAkses = TextEditingController();
                      penyesuaianQty.text.isEmpty
                          ? null
                          :
                          //beri kode akses
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Positioned(
                                        right: -47.0,
                                        top: -47.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 190,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5, bottom: 10),
                                                child:
                                                    Text('Masukan Kode Akses'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  autofocus: true,
                                                  obscureText: true,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller: kodeAkses,
                                                  validator: (value) {
                                                    if (value! != aksesKode) {
                                                      return 'Kode akses salah';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) {
                                                    isKodeAkses = true;
                                                    kodeAkses.text == aksesKode
                                                        ? isKodeAkses = true
                                                        : isKodeAkses = false;
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: "Kode Akses",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                height: 50,
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: ElevatedButton(
                                                  child: const Text("Submit"),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                      Navigator.of(context)
                                                          .pop();

                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                            'Perhatian',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          content: Row(
                                                            children: [
                                                              const Text(
                                                                'Apakah anda yakin ingin menambahkan penggunaan batu ',
                                                              ),
                                                              Text(
                                                                '$size  ?',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                context,
                                                                'Batal',
                                                              ),
                                                              child: const Text(
                                                                'Batal',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .amber),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                final response =
                                                                    await http
                                                                        .get(
                                                                  Uri.parse(
                                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$size"'),
                                                                );
                                                                if (response
                                                                        .statusCode ==
                                                                    200) {
                                                                  final data =
                                                                      jsonDecode(
                                                                          response
                                                                              .body);

                                                                  var stok = data[
                                                                              0]
                                                                          [
                                                                          'qty'] -
                                                                      int.parse(
                                                                          penyesuaianQty
                                                                              .text);
                                                                  await postUpdateQtyBatuBySize(
                                                                      size,
                                                                      stok,
                                                                      siklus);
                                                                } else {
                                                                  throw Exception(
                                                                      'Unexpected error occured!');
                                                                }

                                                                await postPenyesuaianBatu(
                                                                    size,
                                                                    penyesuaianQty
                                                                        .text);
                                                                showDialog<
                                                                        String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        const AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            'Penyesuaian Batu Berhasil',
                                                                          ),
                                                                        ));

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (c) =>
                                                                                const MainViewKebutuhanBatu()));
                                                                showDialog<
                                                                        String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        const AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            'Penyesuaian Batu Berhasil',
                                                                          ),
                                                                        ));
                                                              },
                                                              child: const Text(
                                                                'Tambah',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else {}
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    )),
            siklus.toString().isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      final _formKey = GlobalKey<FormState>();
                      // ignore: unused_local_variable
                      bool isKodeAkses = false;
                      TextEditingController kodeAkses = TextEditingController();
                      penyesuaianQty.text.isEmpty
                          ? null
                          :
                          //beri kode akses
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Positioned(
                                        right: -47.0,
                                        top: -47.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 190,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5, bottom: 10),
                                                child:
                                                    Text('Masukan Kode Akses'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  autofocus: true,
                                                  obscureText: true,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller: kodeAkses,
                                                  validator: (value) {
                                                    if (value! != aksesKode) {
                                                      return 'Kode akses salah';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) {
                                                    isKodeAkses = true;
                                                    kodeAkses.text == aksesKode
                                                        ? isKodeAkses = true
                                                        : isKodeAkses = false;
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: "Kode Akses",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                height: 50,
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: ElevatedButton(
                                                  child: const Text("Submit"),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                            'Perhatian',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          content: Row(
                                                            children: [
                                                              const Text(
                                                                'Apakah anda yakin ingin mengurangi penggunaan batu ',
                                                              ),
                                                              Text(
                                                                '$size  ?',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                context,
                                                                'Batal',
                                                              ),
                                                              child: const Text(
                                                                'Batal',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .amber),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                final response =
                                                                    await http
                                                                        .get(
                                                                  Uri.parse(
                                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$size"'),
                                                                );
                                                                if (response
                                                                        .statusCode ==
                                                                    200) {
                                                                  final data =
                                                                      jsonDecode(
                                                                          response
                                                                              .body);

                                                                  var stok = data[
                                                                              0]
                                                                          [
                                                                          'qty'] +
                                                                      int.parse(
                                                                          penyesuaianQty
                                                                              .text);
                                                                  await postUpdateQtyBatuBySize(
                                                                      size,
                                                                      stok,
                                                                      siklus);
                                                                } else {
                                                                  throw Exception(
                                                                      'Unexpected error occured!');
                                                                }

                                                                await postPenyesuaianBatu(
                                                                    size,
                                                                    (int.parse(penyesuaianQty
                                                                            .text) *
                                                                        -1));
                                                                showDialog<
                                                                        String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        const AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            'Penyesuaian Batu Berhasil',
                                                                          ),
                                                                        ));

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (c) =>
                                                                                const MainViewKebutuhanBatu()));
                                                                showDialog<
                                                                        String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        const AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            'Penyesuaian Batu Berhasil',
                                                                          ),
                                                                        ));
                                                              },
                                                              child: const Text(
                                                                'Kurangi',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else {}
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ))
          ],
        );
      })),
      DataCell(_verticalDivider),

      //STOK
      DataCell(FutureBuilder(
          future: _getStokBySize(size),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('0');
            }
            if (snapshot.hasData) {
              return Text(snapshot.data!.toString());
            } else {
              return const CircularProgressIndicator();
            }
          })),

      DataCell(_verticalDivider),

      //ADJUSMENT
      DataCell(FutureBuilder(
          future: _getSum(size, siklus),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.toString());
            } else {
              return const CircularProgressIndicator();
            }
          })),
      DataCell(_verticalDivider),

      //qty setelah di kurangi penyesuaian
      DataCell(FutureBuilder(
          future: _getSum(size, siklus),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var resultSum = int.parse(mylist[size].toString()) +
                  int.parse(snapshot.data!.toString());

              return Text(
                '$resultSum',
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              );
            } else {
              return const CircularProgressIndicator();
            }
          })),
    ]);
  }

  _getSum(size, siklus) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getSumPenyesuaian}?size="$size"&siklus="$siklus"'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        var sum = data[0]['SUM(qty)'] ?? 0;
        return sum;
      }
    } catch (e) {
      print(e);
    }
  }

  _getStokBySize(size) async {
    var lot;
    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$size"'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      lot = data[0]['qty'];
      return lot;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  postUpdateQtyBatuBySize(size, qty, siklus) async {
    print('ini qty update $qty');
    print('ini siklus update $siklus');
    try {
      Map<String, String> body = {
        'size': size.toString(),
        'qty': qty.toString(),
        'siklus': siklus.toString()
      };
      final response = await http.post(
          Uri.parse(
              ApiConstants.baseUrl + ApiConstants.postUpdateDataBatuBySize),
          body: body);
      print(response.body);
    } catch (c) {
      print(c);
    }
  }

  postPenyesuaianBatu(size, qty) async {
    try {
      Map<String, String> body = {
        'size': size.toString(),
        'qty': qty.toString(),
      };
      final response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.postBatuPenyesuaian),
          body: body);
      print(response.body);
    } catch (c) {
      print(c);
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;

  _getLotBySize(size) async {
    var lot;
    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$size"'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      lot = data[0]['lot'];
      return lot;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
