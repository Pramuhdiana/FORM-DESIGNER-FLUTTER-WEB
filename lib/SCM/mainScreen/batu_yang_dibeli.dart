// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_designer/SCM/model/kebutuhan_batu_model.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_batu.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BatuYangDibeliScreen extends StatefulWidget {
  const BatuYangDibeliScreen({super.key});
  @override
  State<BatuYangDibeliScreen> createState() => _BatuYangDibeliScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _BatuYangDibeliScreenState extends State<BatuYangDibeliScreen> {
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
    _getData(month);
  }

  Future<List<KebutuhanBatuModel>> _getData(siklus) async {
    listAllBatu.clear();
    listAllQtyBatu.clear();
    listUniqQtyBatu.clear();
    listUniqBatu.clear();
    mylist.clear();

    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerBySiklus}?siklus=$siklus'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      final data = jsonDecode(response.body);

      //! remove batu1
      List<String> listBatu1 = [];
      List<int> listQtyBatu1 = [];
      for (var i = 0; i < data.length; i++) {
        listBatu1.add(data[i]['batu1']);
        listQtyBatu1.add(data[i]['qtyBatu1']);
      }

      //! remove batu2
      List<String> listBatu2 = [];
      List<int> listQtyBatu2 = [];
      for (var i = 0; i < data.length; i++) {
        listBatu2.add(data[i]['batu2']);
        listQtyBatu2.add(data[i]['qtyBatu2']);
      }

      //! remove batu3
      List<String> listBatu3 = [];
      List<int> listQtyBatu3 = [];
      for (var i = 0; i < data.length; i++) {
        listBatu3.add(data[i]['batu3']);
        listQtyBatu3.add(data[i]['qtyBatu3']);
      }

      //! remove batu4
      List<String> listBatu4 = [];
      List<int> listQtyBatu4 = [];
      for (var i = 0; i < data.length; i++) {
        listBatu4.add(data[i]['batu4']);
        listQtyBatu4.add(data[i]['qtyBatu4']);
      }

      //! remove batu5
      List<String> listBatu5 = [];
      List<int> listQtyBatu5 = [];
      for (var i = 0; i < data.length; i++) {
        listBatu5.add(data[i]['batu5']);
        listQtyBatu5.add(data[i]['qtyBatu5']);
      }

      //! remove batu6
      List<String> listBatu6 = [];
      List<int> listQtyBatu6 = [];
      for (var i = 0; i < data.length; i++) {
        listBatu6.add(data[i]['batu6']);
        listQtyBatu6.add(data[i]['qtyBatu6']);
      }

      //?bawah belum
      //! remove batu7
      List<String> listBatu7 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu7.add(data[i]['batu7']);
        listBatu7 = listBatu7.toSet().toList();
      }
      //! remove batu8
      List<String> listBatu8 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu8.add(data[i]['batu8']);
        listBatu8 = listBatu8.toSet().toList();
      }
      //! remove batu9
      List<String> listBatu9 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu9.add(data[i]['batu9']);
        listBatu9 = listBatu9.toSet().toList();
      }
      //! remove batu10
      List<String> listBatu10 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu10.add(data[i]['batu10']);
        listBatu10 = listBatu10.toSet().toList();
      }
      //! remove batu11
      List<String> listBatu11 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu11.add(data[i]['batu11']);
        listBatu11 = listBatu11.toSet().toList();
      }
      //! remove batu12
      List<String> listBatu12 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu12.add(data[i]['batu12']);
        listBatu12 = listBatu12.toSet().toList();
      }
      //! remove batu13
      List<String> listBatu13 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu13.add(data[i]['batu13']);
        listBatu13 = listBatu13.toSet().toList();
      }
      //! remove batu14
      List<String> listBatu14 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu14.add(data[i]['batu14']);
        listBatu14 = listBatu14.toSet().toList();
      }
      //! remove batu15
      List<String> listBatu15 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu15.add(data[i]['batu15']);
        listBatu15 = listBatu15.toSet().toList();
      }
      //! remove batu16
      List<String> listBatu16 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu16.add(data[i]['batu16']);
        listBatu16 = listBatu16.toSet().toList();
      }
      //! remove batu17
      List<String> listBatu17 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu17.add(data[i]['batu17']);
        listBatu17 = listBatu17.toSet().toList();
      }
      //! remove batu18
      List<String> listBatu18 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu18.add(data[i]['batu18']);
        listBatu18 = listBatu18.toSet().toList();
      }
      //! remove batu19
      List<String> listBatu19 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu19.add(data[i]['batu19']);
        listBatu19 = listBatu19.toSet().toList();
      }
      //! remove batu20
      List<String> listBatu20 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu20.add(data[i]['batu20']);
        listBatu20 = listBatu20.toSet().toList();
      }
      //! remove batu21
      List<String> listBatu21 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu21.add(data[i]['batu21']);
        listBatu21 = listBatu21.toSet().toList();
      }
      //! remove batu22
      List<String> listBatu22 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu22.add(data[i]['batu22']);
        listBatu22 = listBatu22.toSet().toList();
      }
      //! remove batu23
      List<String> listBatu23 = [];
      for (var i = 1; i < data.length; i++) {
        listBatu23.add(data[i]['batu23']);
        listBatu23 = listBatu23.toSet().toList();
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
      // listAllBatu.addAll(listBatu24);
      // listAllBatu.addAll(listBatu25);
      // listAllBatu.addAll(listBatu26);
      // listAllBatu.addAll(listBatu27);
      // listAllBatu.addAll(listBatu28);
      // listAllBatu.addAll(listBatu29);
      // listAllBatu.addAll(listBatu30);
      // listAllBatu.addAll(listBatu31);
      // listAllBatu.addAll(listBatu32);
      // listAllBatu.addAll(listBatu33);
      // listAllBatu.addAll(listBatu34);
      // listAllBatu.addAll(listBatu35);
      listAllBatu.removeWhere((value) => value == '');
      print(listAllBatu);
      listAllQtyBatu.addAll(listQtyBatu1);
      listAllQtyBatu.addAll(listQtyBatu2);
      listAllQtyBatu.addAll(listQtyBatu3);
      listAllQtyBatu.addAll(listQtyBatu4);
      listAllQtyBatu.addAll(listQtyBatu5);
      listAllQtyBatu.addAll(listQtyBatu6);
      listAllQtyBatu.removeWhere((value) => value == 0);
      print(listAllQtyBatu);

      listUniqBatu = listAllBatu.toSet().toList();
      print(listUniqBatu);

      var sum = 0;
      for (var i = 0; i < listUniqBatu.length; i++) {
        sum = 0;
        //! ini 3
        for (var j = 0; j < listAllBatu.length; j++) {
          mylist[listUniqBatu[i]] = sum;
          //! ini 7
          if (mylist[listUniqBatu[i]] != mylist[listAllBatu[j]]) {
          } else {
            sum = sum + listAllQtyBatu[j];
            mylist.update(listUniqBatu[i], (value) => sum);
          }
        }
      }

      print(mylist);
      Iterable<int> values = mylist.values;
      for (final value in values) {
        listUniqQtyBatu.add(value);
      }
      print(listUniqBatu);
      print(listUniqQtyBatu);
      var g = jsonResponse
          .map((data) => KebutuhanBatuModel.fromJson(data))
          .toList();
      setState(() {
        filterListBatu = g;
        isLoading = true;
      });
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
            "BATU YANG HARUS DIBELI",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: isLoading == false
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 45,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller,
                          decoration:
                              const InputDecoration(hintText: "Search Anyting"),
                          onChanged: (value) {
                            //fungsi search anyting
                            // _listBatu = filterListBatu!
                            //     .where((element) =>
                            //         element.lot!
                            //             .toLowerCase()
                            //             .contains(value.toLowerCase()) ||
                            //         element.size
                            //             .toLowerCase()
                            //             .contains(value.toLowerCase()) ||
                            //         element.parcel!
                            //             .toLowerCase()
                            //             .contains(value.toLowerCase()) ||
                            //         element.qty!
                            //             .toString()
                            //             .contains(value.toLowerCase()))
                            //     .toList();

                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Expanded(
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
                                                fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              listUniqBatu.sort((a, b) => a
                                                  .toLowerCase()
                                                  .compareTo(b.toLowerCase()));
                                            } else {
                                              sort = true;
                                              listUniqBatu.sort((a, b) => b
                                                  .toLowerCase()
                                                  .compareTo(a.toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),

                                    //QTY
                                    const DataColumn(
                                      label: SizedBox(
                                          width: 120,
                                          child: Text(
                                            "QTY",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      // onSort: (columnIndex, _) {
                                      //   setState(() {
                                      //     _currentSortColumn = columnIndex;
                                      //     if (sort == true) {
                                      //       sort = false;
                                      //       listUniqQtyBatu.sort(
                                      //           (a, b) => b.compareTo(a));
                                      //     } else {
                                      //       sort = true;
                                      //       listUniqQtyBatu.sort(
                                      //           (a, b) => a.compareTo(b));
                                      //     }
                                      //   });
                                      // }
                                    ),
                                    DataColumn(label: _verticalDivider),

                                    // STOK
                                    const DataColumn(
                                      label: SizedBox(
                                          width: 120,
                                          child: Text(
                                            "STOK",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ],
                                  source:
                                      // UserDataTableSource(userData: filterCrm!)),
                                      RowSource(
                                          size: listUniqBatu,
                                          qty: listUniqQtyBatu,
                                          count: listUniqBatu.length,
                                          mylist: mylist)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        floatingActionButton: sharedPreferences!.getString('level') != '1'
            ? null
            : Stack(children: [
                Positioned(
                  left: 40,
                  bottom: 5,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final _formKey = GlobalKey<FormState>();
                            TextEditingController lot = TextEditingController();
                            TextEditingController size =
                                TextEditingController();
                            TextEditingController parcel =
                                TextEditingController();
                            TextEditingController qty = TextEditingController();
                            TextEditingController caratPcs =
                                TextEditingController();
                            TextEditingController keterangan =
                                TextEditingController();
                            RoundedLoadingButtonController btnController =
                                RoundedLoadingButtonController();
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
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        //lot
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: lot,
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              labelText: "Lot",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Wajib diisi *';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        //size
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: size,
                                            decoration: InputDecoration(
                                              labelText: "Ukuran",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Wajib diisi *';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: parcel,
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              labelText: "Parcel",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Wajib diisi *';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qty,
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              labelText: "Qty",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Wajib diisi *';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: caratPcs,
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              labelText: "Carat Pcs",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: keterangan,
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              labelText: "Keterangan",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 250,
                                            child: CustomLoadingButton(
                                                controller: btnController,
                                                child:
                                                    const Text("Simpan Batu"),
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();
                                                    Future.delayed(
                                                            const Duration(
                                                                seconds: 2))
                                                        .then((value) async {
                                                      btnController.success();
                                                      print(lot.text);
                                                      print(size.text);
                                                      print(parcel.text);
                                                      print(qty.text);
                                                      print(caratPcs.text);
                                                      print(keterangan.text);
                                                      Map<String, dynamic>
                                                          body = {
                                                        'lot': lot.text,
                                                        'size': size.text,
                                                        'parcel': parcel.text,
                                                        'qty': qty.text,
                                                        'caratPcs':
                                                            caratPcs.text,
                                                        'keterangan':
                                                            keterangan.text,
                                                      };
                                                      final response = await http.post(
                                                          Uri.parse(ApiConstants
                                                                  .baseUrl +
                                                              ApiConstants
                                                                  .postDataBatu),
                                                          body: body);
                                                      print(response.body);
                                                      Future.delayed(
                                                              const Duration(
                                                                  seconds: 1))
                                                          .then((value) {
                                                        btnController
                                                            .reset(); //reset
                                                        showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const AlertDialog(
                                                                  title: Text(
                                                                    'Tambah batu berhasil',
                                                                  ),
                                                                ));
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (c) =>
                                                                  const MainViewBatu()));
                                                    });
                                                  } else {
                                                    btnController.error();
                                                    Future.delayed(
                                                            const Duration(
                                                                seconds: 1))
                                                        .then((value) {
                                                      btnController
                                                          .reset(); //reset
                                                    });
                                                  }
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    label: const Text(
                      "Tambah Batu",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ]),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  var size;
  var qty;
  final count;
  var mylist;
  RowSource({
    required this.size,
    required this.qty,
    required this.count,
    required this.mylist,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(size![index], mylist, qty![index]);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var size, var mylist, var qty) {
    return DataRow(cells: [
      //lot
      DataCell(FutureBuilder(
          future: _getLotBySize(size),
          builder: (context, snapshot) {
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
      // //parcel
      // DataCell(
      //   Padding(padding: const EdgeInsets.all(0), child: Text(data.parcel)),
      // ),
      // DataCell(_verticalDivider),
      //qty
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(mylist[size].toString())),
      ),
      DataCell(_verticalDivider),
      //STOK
      DataCell(FutureBuilder(
          future: _getStokBySize(size),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.toString());
            } else {
              return const CircularProgressIndicator();
            }
          })),
      //Aksi
      // DataCell(Builder(builder: (context) {
      //   return sharedPreferences!.getString('level') != '1'
      //       ? const Row()
      //       : Row(
      //           children: [
      //             IconButton(
      //               onPressed: () {
      //                 showDialog<String>(
      //                   context: context,
      //                   builder: (BuildContext context) => AlertDialog(
      //                     title: const Text(
      //                       'Perhatian',
      //                       textAlign: TextAlign.center,
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                     content: Row(
      //                       children: [
      //                         const Text(
      //                           'Apakah anda yakin ingin menghapus data batu ',
      //                         ),
      //                         Text(
      //                           '${data.size}  ?',
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.black),
      //                         ),
      //                       ],
      //                     ),
      //                     actions: <Widget>[
      //                       TextButton(
      //                         onPressed: () => Navigator.pop(
      //                           context,
      //                           'Batal',
      //                         ),
      //                         child: const Text('Batal'),
      //                       ),
      //                       TextButton(
      //                         onPressed: () async {
      //                           var id = data.id.toString();
      //                           Map<String, String> body = {'id': id};
      //                           final response = await http.post(
      //                               Uri.parse(ApiConstants.baseUrl +
      //                                   ApiConstants.postDeleteBatuById),
      //                               body: body);
      //                           print(response.body);

      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (c) => const MainViewBatu()));
      //                           showDialog<String>(
      //                               context: context,
      //                               builder: (BuildContext context) =>
      //                                   const AlertDialog(
      //                                     title: Text(
      //                                       'Hapus Batu Berhasil',
      //                                     ),
      //                                   ));
      //                         },
      //                         child: const Text(
      //                           'Hapus',
      //                           style: TextStyle(color: Colors.red),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               },
      //               icon: const Icon(
      //                 Icons.delete,
      //                 color: Colors.red,
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(left: 25),
      //               child: IconButton(
      //                 onPressed: () {
      //                   showDialog(
      //                       context: context,
      //                       builder: (BuildContext context) {
      //                         final _formKey = GlobalKey<FormState>();
      //                         TextEditingController lot =
      //                             TextEditingController();
      //                         TextEditingController size =
      //                             TextEditingController();
      //                         TextEditingController parcel =
      //                             TextEditingController();
      //                         TextEditingController qty =
      //                             TextEditingController();
      //                         String id;

      //                         id = data.id.toString();
      //                         lot.text = data.lot;
      //                         size.text = data.size;
      //                         parcel.text = data.parcel;
      //                         qty.text = data.qty.toString();
      //                         RoundedLoadingButtonController btnController =
      //                             RoundedLoadingButtonController();
      //                         return AlertDialog(
      //                           content: Stack(
      //                             clipBehavior: Clip.none,
      //                             children: <Widget>[
      //                               Positioned(
      //                                 right: -47.0,
      //                                 top: -47.0,
      //                                 child: InkResponse(
      //                                   onTap: () {
      //                                     Navigator.of(context).pop();
      //                                   },
      //                                   child: const CircleAvatar(
      //                                     backgroundColor: Colors.red,
      //                                     child: Icon(Icons.close),
      //                                   ),
      //                                 ),
      //                               ),
      //                               Form(
      //                                 key: _formKey,
      //                                 child: Column(
      //                                   mainAxisSize: MainAxisSize.min,
      //                                   children: <Widget>[
      //                                     //lot
      //                                     Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: TextFormField(
      //                                         style: const TextStyle(
      //                                             fontSize: 14,
      //                                             color: Colors.black,
      //                                             fontWeight: FontWeight.bold),
      //                                         textInputAction:
      //                                             TextInputAction.next,
      //                                         controller: lot,
      //                                         decoration: InputDecoration(
      //                                           // hintText: "example: Cahaya Sanivokasi",
      //                                           labelText: "Lot",
      //                                           border: OutlineInputBorder(
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       5.0)),
      //                                         ),
      //                                         validator: (value) {
      //                                           if (value!.isEmpty) {
      //                                             return 'Wajib diisi *';
      //                                           }
      //                                           return null;
      //                                         },
      //                                       ),
      //                                     ),
      //                                     //size
      //                                     Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: TextFormField(
      //                                         style: const TextStyle(
      //                                             fontSize: 14,
      //                                             color: Colors.black,
      //                                             fontWeight: FontWeight.bold),
      //                                         textInputAction:
      //                                             TextInputAction.next,
      //                                         controller: size,
      //                                         decoration: InputDecoration(
      //                                           // hintText: "example: Cahaya Sanivokasi",
      //                                           labelText: "Ukuran",
      //                                           border: OutlineInputBorder(
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       5.0)),
      //                                         ),
      //                                         validator: (value) {
      //                                           if (value!.isEmpty) {
      //                                             return 'Wajib diisi *';
      //                                           }
      //                                           return null;
      //                                         },
      //                                       ),
      //                                     ),
      //                                     Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: TextFormField(
      //                                         style: const TextStyle(
      //                                             fontSize: 14,
      //                                             color: Colors.black,
      //                                             fontWeight: FontWeight.bold),
      //                                         textInputAction:
      //                                             TextInputAction.next,
      //                                         controller: parcel,
      //                                         decoration: InputDecoration(
      //                                           // hintText: "example: Cahaya Sanivokasi",
      //                                           labelText: "Parcel",
      //                                           border: OutlineInputBorder(
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       5.0)),
      //                                         ),
      //                                         validator: (value) {
      //                                           if (value!.isEmpty) {
      //                                             return 'Wajib diisi *';
      //                                           }
      //                                           return null;
      //                                         },
      //                                       ),
      //                                     ),
      //                                     Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: TextFormField(
      //                                         style: const TextStyle(
      //                                             fontSize: 14,
      //                                             color: Colors.black,
      //                                             fontWeight: FontWeight.bold),
      //                                         textInputAction:
      //                                             TextInputAction.next,
      //                                         controller: qty,
      //                                         decoration: InputDecoration(
      //                                           // hintText: "example: Cahaya Sanivokasi",
      //                                           labelText: "Qty",
      //                                           border: OutlineInputBorder(
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       5.0)),
      //                                         ),
      //                                         validator: (value) {
      //                                           if (value!.isEmpty) {
      //                                             return 'Wajib diisi *';
      //                                           }

      //                                           return null;
      //                                         },
      //                                       ),
      //                                     ),
      //                                     Padding(
      //                                       padding: const EdgeInsets.all(8.0),
      //                                       child: SizedBox(
      //                                         width: 250,
      //                                         child: CustomLoadingButton(
      //                                             controller: btnController,
      //                                             child: const Text("Update"),
      //                                             onPressed: () async {
      //                                               if (_formKey.currentState!
      //                                                   .validate()) {
      //                                                 _formKey.currentState!
      //                                                     .save();
      //                                                 Future.delayed(
      //                                                         const Duration(
      //                                                             seconds: 2))
      //                                                     .then((value) async {
      //                                                   btnController.success();
      //                                                   Map<String, dynamic>
      //                                                       body = {
      //                                                     'id': id,
      //                                                     'lot': lot.text,
      //                                                     'size': size.text,
      //                                                     'parcel': parcel.text,
      //                                                     'qty': qty.text,
      //                                                   };
      //                                                   final response = await http.post(
      //                                                       Uri.parse(ApiConstants
      //                                                               .baseUrl +
      //                                                           ApiConstants
      //                                                               .postUpdateListDataBatu),
      //                                                       body: body);
      //                                                   print(response.body);
      //                                                   Future.delayed(
      //                                                           const Duration(
      //                                                               seconds: 1))
      //                                                       .then((value) {
      //                                                     btnController
      //                                                         .reset(); //reset
      //                                                     showDialog<String>(
      //                                                         context: context,
      //                                                         builder: (BuildContext
      //                                                                 context) =>
      //                                                             const AlertDialog(
      //                                                               title: Text(
      //                                                                 'Update Berhasil',
      //                                                               ),
      //                                                             ));
      //                                                   });
      //                                                   Navigator.push(
      //                                                       context,
      //                                                       MaterialPageRoute(
      //                                                           builder: (c) =>
      //                                                               const MainViewBatu()));
      //                                                 });
      //                                               } else {
      //                                                 btnController.error();
      //                                                 Future.delayed(
      //                                                         const Duration(
      //                                                             seconds: 1))
      //                                                     .then((value) {
      //                                                   btnController
      //                                                       .reset(); //reset
      //                                                 });
      //                                               }
      //                                             }),
      //                                       ),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         );
      //                       });
      //                 },
      //                 icon: const Icon(
      //                   Icons.edit,
      //                   color: Colors.green,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         );
      // }))
    ]);
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
}
