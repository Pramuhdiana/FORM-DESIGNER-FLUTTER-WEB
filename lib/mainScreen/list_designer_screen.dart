// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/mainScreen/form_screen.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/mainScreen/form_view_screen.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

import '../api/api_constant.dart';
import '../global/global.dart';

class ListDesignerScreen extends StatefulWidget {
  const ListDesignerScreen({super.key});
  @override
  State<ListDesignerScreen> createState() => _ListDesignerScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListDesignerScreenState extends State<ListDesignerScreen> {
  List<dynamic> filteredData = [];
  TextEditingController controller = TextEditingController();
  bool sort = true;
  int _currentSortColumn = 0;
  List<FormDesignerModel>? filterCrm;
  List<FormDesignerModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;

  String siklusDesigner = '';
  TextEditingController siklus = TextEditingController();

  int? idBatu1 = 0;
  int? stokBatu1 = 0;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterCrm!.sort((a, b) => a.kodeDesignMdbc!
            .toLowerCase()
            .compareTo(b.kodeDesignMdbc!.toLowerCase()));
      } else {
        filterCrm!.sort((a, b) => b.kodeDesignMdbc!
            .toLowerCase()
            .compareTo(a.kodeDesignMdbc!.toLowerCase()));
      }
    }
  }

  var nowSiklus = '';
  TextEditingController addSiklus = TextEditingController();

  @override
  void initState() {
    super.initState();
    nowSiklus = sharedPreferences!.getString('siklus')!;

    _getData();
  }

  refresh() async {
    print('refresh state');
    // setState(() {
    //   isLoading = false;
    // });
    await _getData();
    setState(() {
      // isLoading = true;
    });
  }

  Future<List<FormDesignerModel>> _getData() async {
    final response = sharedPreferences!.getString('level') != '2'
        ? await http.get(
            Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner))
        : await http.get(Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerByName}?nama=${sharedPreferences!.getString('nama')!}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      if (sharedPreferences!.getString('level') == '3') {
        var nama = sharedPreferences!.getString('nama');
        print(nama);
        var filterByModeller = g.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            nama.toString().toLowerCase());
        g = filterByModeller.toList();
        setState(() {
          filterCrm = g;
          myCrm = g;
          isLoading = true;
        });
      } else {
        setState(() {
          filterCrm = g;
          myCrm = g;
          isLoading = true;
        });
      }

      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<FormDesignerModel>> _getDataBySiklus(chooseSiklus) async {
    final response = sharedPreferences!.getString('level') == '1'
        ? await http.get(
            Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner))
        : await http.get(Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerByName}?nama=${sharedPreferences!.getString('nama')!}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      var filterBySiklus = g.where((element) =>
          element.siklus.toString().toLowerCase() ==
          chooseSiklus.toString().toLowerCase());
      filterBySiklus.toList();
      setState(() {
        filterCrm = filterBySiklus.toList();
        myCrm = filterBySiklus.toList();
        isLoading = true;
      });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  postSiklus() async {
    Map<String, String> body = {
      'id': '1',
      'siklus': addSiklus.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addSiklus}'),
        body: body);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: null_check_always_fails
      onWillPop: () async => null!,
      child: MaterialApp(
          scrollBehavior: CustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: colorBG,
            // drawer: Drawer1(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              leadingWidth: 320,
              //change siklus
              leading: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        "Siklus Saat Ini : $nowSiklus",
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade700),
                      ),
                      sharedPreferences!.getString('level') != '1'
                          ? const SizedBox()
                          : IconButton(
                              color: Colors.grey.shade700,
                              onPressed: () {
                                final dropdownFormKey = GlobalKey<FormState>();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        // title: const Text('Pilih Siklus'),
                                        content: SizedBox(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              Form(
                                                  key: dropdownFormKey,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      DropdownSearch<String>(
                                                        items: namaBulan,
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Pilih Siklus',
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                        ),
                                                        validator: (value) =>
                                                            value == null
                                                                ? "Siklus tidak boleh kosong"
                                                                : null,
                                                        onChanged:
                                                            (String? newValue) {
                                                          addSiklus.text =
                                                              newValue!;
                                                        },
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 20),
                                                        child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              if (dropdownFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                //? method untuk mengganti siklus
                                                                await postSiklus();
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (c) =>
                                                                                MainViewScm(col: 2)));

                                                                showDialog<
                                                                        String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        const AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            'Siklus Berhasil Diterapkan',
                                                                          ),
                                                                        ));
                                                                setState(() {
                                                                  nowSiklus =
                                                                      addSiklus
                                                                          .text;
                                                                  sharedPreferences!.setString(
                                                                      'siklus',
                                                                      addSiklus
                                                                          .text);
                                                                });
                                                              }
                                                            },
                                                            child: const Text(
                                                              "Submit",
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.change_circle,
                              ))
                    ],
                  ),
                ),
              ),
              // ignore: avoid_unnecessary_containers
              title: Container(
                // width: MediaQuery.of(context).size.width * 0.3,
                child: CupertinoSearchTextField(
                  placeholder: 'Search Anything...',
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  itemColor: Colors.black,
                  // autofocus: false,
                  controller: controller,
                  backgroundColor: Colors.black12,
                  // keyboardType: TextInputType.number,
                  // focusNode: numberFocusNode,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    //fungsi search anyting
                    myCrm = filterCrm!
                        .where((element) =>
                            element.kodeDesignMdbc!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.namaDesigner!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.kodeMarketing!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.kodeDesign!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.tema!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.jenisBarang!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.estimasiHarga!
                                .toString()
                                .contains(value.toLowerCase()))
                        .toList();

                    setState(() {});
                  },
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 26, left: 5),
                    child: const Text(
                      'List Designer',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(),
                          width: 350,
                          child: DropdownSearch<String>(
                            items: namaBulan,
                            onChanged: (item) {
                              setState(() {
                                siklus.text = item!;
                                siklusDesigner = siklus.text.toString();
                                _getDataBySiklus(siklus.text);
                              });
                            },
                            popupProps:
                                const PopupPropsMultiSelection.modalBottomSheet(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              textAlign: TextAlign.center,
                              baseStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: "Pilih Siklus",
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.center,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)))),
                            ),
                          ),
                        ),
                        sharedPreferences!.getString('level') == '3' ||
                                sharedPreferences!.getString('divisi') == 'scm'
                            ? const SizedBox()
                            : Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: FloatingActionButton.extended(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                const FormScreen()));
                                  },
                                  label: const Text(
                                    "Tambah Form Designer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                              )
                      ],
                    ),
                  ),
                  isLoading == false
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
                                      rowsPerPage: 10,
                                      columnSpacing: 0,
                                      columns: [
                                        DataColumn(
                                            label: const SizedBox(
                                                width: 120,
                                                child: Text(
                                                  "      Kode MDBC",
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
                                                  filterCrm!.sort((a, b) => a
                                                      .kodeDesignMdbc!
                                                      .toLowerCase()
                                                      .compareTo(b
                                                          .kodeDesignMdbc!
                                                          .toLowerCase()));
                                                } else {
                                                  sort = true;
                                                  filterCrm!.sort((a, b) => b
                                                      .kodeDesignMdbc!
                                                      .toLowerCase()
                                                      .compareTo(a
                                                          .kodeDesignMdbc!
                                                          .toLowerCase()));
                                                }
                                              });
                                            }),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                            label: SizedBox(
                                                width: 120,
                                                child: sharedPreferences!
                                                            .getString(
                                                                'level') !=
                                                        '1'
                                                    ? const Text(
                                                        "Kode Marketing",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : const Text(
                                                        "Nama Designer",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                            onSort: (columnIndex, _) {
                                              setState(() {
                                                _currentSortColumn =
                                                    columnIndex;
                                                if (sharedPreferences!
                                                        .getString('level') ==
                                                    '1') {
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterCrm!.sort((a, b) => a
                                                        .namaDesigner!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .namaDesigner!
                                                            .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterCrm!.sort((a, b) => b
                                                        .namaDesigner!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .namaDesigner!
                                                            .toLowerCase()));
                                                  }
                                                } else {
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterCrm!.sort((a, b) => a
                                                        .kodeMarketing!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .kodeMarketing!
                                                            .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterCrm!.sort((a, b) => b
                                                        .kodeMarketing!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .kodeMarketing!
                                                            .toLowerCase()));
                                                  }
                                                }
                                              });
                                            }),
                                        DataColumn(label: _verticalDivider),
                                        // DataColumn(
                                        //     label: const SizedBox(
                                        //         width: 120,
                                        //         child: Text(
                                        //           "Kode Design",
                                        //           style: TextStyle(
                                        //               fontSize: 15,
                                        //               fontWeight:
                                        //                   FontWeight.bold),
                                        //         )),
                                        //     onSort: (columnIndex, _) {
                                        //       setState(() {
                                        //         _currentSortColumn =
                                        //             columnIndex;
                                        //         if (sort == true) {
                                        //           sort = false;
                                        //           filterCrm!.sort((a, b) => a
                                        //               .kodeDesign!
                                        //               .toLowerCase()
                                        //               .compareTo(b.kodeDesign!
                                        //                   .toLowerCase()));
                                        //         } else {
                                        //           sort = true;
                                        //           filterCrm!.sort((a, b) => b
                                        //               .kodeDesign!
                                        //               .toLowerCase()
                                        //               .compareTo(a.kodeDesign!
                                        //                   .toLowerCase()));
                                        //         }
                                        //       });
                                        //     }),
                                        // DataColumn(label: _verticalDivider),
                                        DataColumn(
                                            label: const SizedBox(
                                                width: 120,
                                                child: Text(
                                                  "Tema",
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
                                                  filterCrm!.sort((a, b) => a
                                                      .tema!
                                                      .toLowerCase()
                                                      .compareTo(b.tema!
                                                          .toLowerCase()));
                                                } else {
                                                  sort = true;
                                                  filterCrm!.sort((a, b) => b
                                                      .tema!
                                                      .toLowerCase()
                                                      .compareTo(a.tema!
                                                          .toLowerCase()));
                                                }
                                              });
                                            }),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                            label: const SizedBox(
                                                width: 120,
                                                child: Text(
                                                  "Jenis Barang",
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
                                                  filterCrm!.sort((a, b) => a
                                                      .jenisBarang!
                                                      .toLowerCase()
                                                      .compareTo(b.jenisBarang!
                                                          .toLowerCase()));
                                                } else {
                                                  sort = true;
                                                  filterCrm!.sort((a, b) => b
                                                      .jenisBarang!
                                                      .toLowerCase()
                                                      .compareTo(a.jenisBarang!
                                                          .toLowerCase()));
                                                }
                                              });
                                            }),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                            label: const SizedBox(
                                                width: 50,
                                                child: Text(
                                                  "Harga",
                                                  maxLines: 2,
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
                                                  // myCrm.sort((a, b) => a['estimasiHarga'].)
                                                  sort = false;
                                                  filterCrm!.sort((a, b) => a
                                                      .estimasiHarga!
                                                      .compareTo(
                                                          b.estimasiHarga!));
                                                  // onsortColum(columnIndex, ascending);
                                                } else {
                                                  sort = true;
                                                  filterCrm!.sort((a, b) => b
                                                      .estimasiHarga!
                                                      .compareTo(
                                                          a.estimasiHarga!));
                                                }
                                              });
                                            }),
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 120,
                                              child: Text(
                                                "Kelas Harga",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              width: 120,
                                              child: const Text(
                                                "Aksi",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ],
                                      source:
                                          // UserDataTableSource(userData: filterCrm!)),
                                          RowSource(
                                              onRowPressed: () {
                                                refresh();
                                              },
                                              myData: myCrm,
                                              count: myCrm!.length)),
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
            // floatingActionButton: sharedPreferences!.getString('level') == '3'
            //     ? null
            //     : Stack(children: [
            //         Positioned(
            //           left: 40,
            //           bottom: 5,
            //           child: FloatingActionButton.extended(
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (c) => const FormScreen()));
            //             },
            //             label: const Text(
            //               "Tambah Form Designer",
            //               style: TextStyle(color: Colors.white),
            //             ),
            //             icon: const Icon(
            //               Icons.add_circle_outline_sharp,
            //               color: Colors.white,
            //             ),
            //             backgroundColor: Colors.blue,
            //           ),
            //         )
            //       ])
          )),
    );
  }
}

class RowSource extends DataTableSource {
  var myData;
  final VoidCallback onRowPressed; //* menerima data untuk me refresh screen
  final count;
  RowSource({
    required this.myData,
    required this.count,
    required this.onRowPressed,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index]);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data) {
    // ignore: prefer_interpolation_to_compose_strings
    return DataRow(cells: [
      //kodeDesignMdbc
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: sharedPreferences!.getString('level') != '1'
                  ? Text(data.kodeDesignMdbc)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data.kodeDesignMdbc),
                      ],
                    ));
        }),
      ),
      DataCell(_verticalDivider),
      //namaDesigner
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: sharedPreferences!.getString('level') != '1'
                ? Text(data.kodeMarketing)
                : Text(data.namaDesigner)),
      ),
      DataCell(_verticalDivider),

      // //kodeDesign
      // DataCell(
      //   Padding(padding: const EdgeInsets.all(0), child: Text(data.kodeDesign)),
      // ),
      // DataCell(_verticalDivider),

      //tema
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.tema)),
      ),
      DataCell(_verticalDivider),

      //jenisBarang
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.jenisBarang)),
      ),
      DataCell(_verticalDivider),

      //estimasiHarga
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.brand == "BELI BERLIAN"
                    ? 'Rp. ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}'
                    : data.brand == "METIER"
                        ? 'Rp. ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}'
                        : '\$ ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}',
                textAlign: TextAlign.center,
              ),
            )),
      ),
      DataCell(_verticalDivider),

      //kelas harga
      DataCell(
        Container(
            width: 100,
            padding: const EdgeInsets.all(0),
            child: (data.brand.toString().toLowerCase() == "parva" ||
                    data.brand.toString().toLowerCase() == "fine")
                ? ((data.estimasiHarga * 0.37) * 11500) <= 5000000
                    ? const Text(
                        "XS",
                        maxLines: 2,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                        ? const Text(
                            "S",
                            maxLines: 2,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
                            ? const Text(
                                "M",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )
                            : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
                                ? const Text(
                                    "L",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                : const Text(
                                    "XL",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                : (data.estimasiHarga) <= 5000000
                    ? const Text(
                        "XS",
                        maxLines: 2,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    : (data.estimasiHarga) <= 10000000
                        ? const Text(
                            "S",
                            maxLines: 2,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        : (data.estimasiHarga) <= 20000000
                            ? const Text(
                                "M",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )
                            : (data.estimasiHarga) <= 35000000
                                ? const Text(
                                    "L",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                : const Text(
                                    "XL",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )),
      ),
      DataCell(_verticalDivider),

      //Aksi
      // DataCell(Builder(builder: (context) {
      //   return IconButton(
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (c) => const FormScreenById()));
      //     },
      //     icon: const Icon(
      //       Icons.remove_red_eye,
      //       color: Colors.green,
      //     ),
      //   );
      // }
      DataCell(Builder(builder: (context) {
        return Row(
          children: [
            sharedPreferences!.getString('level') == '3'
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => FormViewScreen(
                                    modelDesigner: FormDesignerModel(
                                      id: data.id,
                                      kodeDesignMdbc: data.kodeDesignMdbc,
                                      kodeMarketing: data.kodeMarketing,
                                      kodeProduksi: data.kodeProduksi,
                                      namaDesigner: data.namaDesigner,
                                      namaModeller: data.namaModeller,
                                      kodeDesign: data.kodeDesign,
                                      siklus: data.siklus,
                                      tema: data.tema,
                                      rantai: data.rantai,
                                      qtyRantai: data.qtyRantai,
                                      lain2: data.lain2,
                                      qtyLain2: data.qtyLain2,
                                      earnut: data.earnut,
                                      qtyEarnut: data.qtyEarnut,
                                      panjangRantai: data.panjangRantai,
                                      customKomponen: data.customKomponen,
                                      qtyCustomKomponen: data.qtyCustomKomponen,
                                      jenisBarang: data.jenisBarang,
                                      kategoriBarang: data.kategoriBarang,
                                      brand: data.brand,
                                      photoShoot: data.photoShoot,
                                      color: data.color,
                                      beratEmas: data.beratEmas,
                                      estimasiHarga: data.estimasiHarga,
                                      ringSize: data.ringSize,
                                      created_at: data.created_at,
                                      batu1: data.batu1,
                                      qtyBatu1: data.qtyBatu1,
                                      batu2: data.batu2,
                                      qtyBatu2: data.qtyBatu2,
                                      batu3: data.batu3,
                                      qtyBatu3: data.qtyBatu3,
                                      batu4: data.batu4,
                                      qtyBatu4: data.qtyBatu4,
                                      batu5: data.batu5,
                                      qtyBatu5: data.qtyBatu5,
                                      batu6: data.batu6,
                                      qtyBatu6: data.qtyBatu6,
                                      batu7: data.batu7,
                                      qtyBatu7: data.qtyBatu7,
                                      batu8: data.batu8,
                                      qtyBatu8: data.qtyBatu8,
                                      batu9: data.batu9,
                                      qtyBatu9: data.qtyBatu9,
                                      batu10: data.batu10,
                                      qtyBatu10: data.qtyBatu10,
                                      batu11: data.batu11,
                                      qtyBatu11: data.qtyBatu11,
                                      batu12: data.batu12,
                                      qtyBatu12: data.qtyBatu12,
                                      batu13: data.batu13,
                                      qtyBatu13: data.qtyBatu13,
                                      batu14: data.batu14,
                                      qtyBatu14: data.qtyBatu14,
                                      batu15: data.batu15,
                                      qtyBatu15: data.qtyBatu15,
                                      batu16: data.batu16,
                                      qtyBatu16: data.qtyBatu16,
                                      batu17: data.batu17,
                                      qtyBatu17: data.qtyBatu17,
                                      batu18: data.batu18,
                                      qtyBatu18: data.qtyBatu18,
                                      batu19: data.batu19,
                                      qtyBatu19: data.qtyBatu19,
                                      batu20: data.batu20,
                                      qtyBatu20: data.qtyBatu20,
                                      batu21: data.batu21,
                                      qtyBatu21: data.qtyBatu21,
                                      batu22: data.batu22,
                                      qtyBatu22: data.qtyBatu22,
                                      batu23: data.batu23,
                                      qtyBatu23: data.qtyBatu23,
                                      batu24: data.batu24,
                                      qtyBatu24: data.qtyBatu24,
                                      batu25: data.batu25,
                                      qtyBatu25: data.qtyBatu25,
                                      batu26: data.batu26,
                                      qtyBatu26: data.qtyBatu26,
                                      batu27: data.batu27,
                                      qtyBatu27: data.qtyBatu27,
                                      batu28: data.batu28,
                                      qtyBatu28: data.qtyBatu28,
                                      batu29: data.batu29,
                                      qtyBatu29: data.qtyBatu29,
                                      batu30: data.batu30,
                                      qtyBatu30: data.qtyBatu30,
                                      batu31: data.batu31,
                                      qtyBatu31: data.qtyBatu31,
                                      batu32: data.batu32,
                                      qtyBatu32: data.qtyBatu32,
                                      batu33: data.batu33,
                                      qtyBatu33: data.qtyBatu33,
                                      batu34: data.batu34,
                                      qtyBatu34: data.qtyBatu34,
                                      batu35: data.batu35,
                                      qtyBatu35: data.qtyBatu35,
                                      imageUrl: data.imageUrl,
                                      keteranganStatusBatu:
                                          data.keteranganStatusBatu,
                                      pointModeller: data.pointModeller,
                                      tanggalInModeller: data.tanggalInModeller,
                                      tanggalOutModeller:
                                          data.tanggalOutModeller,
                                      tanggalInProduksi: data.tanggalInProduksi,
                                      beratModeller: data.beratModeller,
                                      statusForm: data.statusForm,
                                      jo: data.jo,
                                    ),
                                  )));
                    },
                    icon: data.pointModeller != '0'
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: Colors.blue,
                          )
                        : Stack(
                            clipBehavior:
                                Clip.none, //agar tidak menghalangi object

                            children: [
                              //tambahan icon ADD
                              Positioned(
                                right: -10.0,
                                top: -13.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.green,
                              ),
                            ],
                          ))
                : data.bulan != ''
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'Perhatian',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Row(
                                children: [
                                  const Text(
                                    'Apakah anda yakin ingin menghapus data ',
                                  ),
                                  Text(
                                    '${data.kodeDesignMdbc}  ?',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                    context,
                                    'Batal',
                                  ),
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await postApiQtyBatu1(
                                      data.batu1,
                                      data.qtyBatu1,
                                    );
                                    await postApiQtyBatu2(
                                      data.batu2,
                                      data.qtyBatu2,
                                    );
                                    await postApiQtyBatu3(
                                      data.batu3,
                                      data.qtyBatu3,
                                    );
                                    await postApiQtyBatu4(
                                      data.batu4,
                                      data.qtyBatu4,
                                    );
                                    await postApiQtyBatu5(
                                      data.batu5,
                                      data.qtyBatu5,
                                    );
                                    await postApiQtyBatu6(
                                      data.batu6,
                                      data.qtyBatu6,
                                    );
                                    await postApiQtyBatu7(
                                      data.batu7,
                                      data.qtyBatu7,
                                    );
                                    await postApiQtyBatu8(
                                      data.batu8,
                                      data.qtyBatu8,
                                    );
                                    await postApiQtyBatu9(
                                      data.batu9,
                                      data.qtyBatu9,
                                    );
                                    await postApiQtyBatu10(
                                      data.batu10,
                                      data.qtyBatu10,
                                    );
                                    await postApiQtyBatu11(
                                      data.batu11,
                                      data.qtyBatu11,
                                    );
                                    await postApiQtyBatu12(
                                      data.batu12,
                                      data.qtyBatu12,
                                    );
                                    await postApiQtyBatu13(
                                      data.batu13,
                                      data.qtyBatu13,
                                    );
                                    await postApiQtyBatu14(
                                      data.batu14,
                                      data.qtyBatu14,
                                    );
                                    await postApiQtyBatu15(
                                      data.batu15,
                                      data.qtyBatu15,
                                    );
                                    await postApiQtyBatu16(
                                      data.batu16,
                                      data.qtyBatu16,
                                    );
                                    await postApiQtyBatu17(
                                      data.batu17,
                                      data.qtyBatu17,
                                    );
                                    await postApiQtyBatu18(
                                      data.batu18,
                                      data.qtyBatu18,
                                    );
                                    await postApiQtyBatu19(
                                      data.batu19,
                                      data.qtyBatu19,
                                    );
                                    await postApiQtyBatu20(
                                      data.batu20,
                                      data.qtyBatu20,
                                    );
                                    await postApiQtyBatu21(
                                      data.batu21,
                                      data.qtyBatu21,
                                    );
                                    await postApiQtyBatu22(
                                      data.batu22,
                                      data.qtyBatu22,
                                    );
                                    await postApiQtyBatu23(
                                      data.batu23,
                                      data.qtyBatu23,
                                    );
                                    await postApiQtyBatu24(
                                      data.batu24,
                                      data.qtyBatu24,
                                    );
                                    await postApiQtyBatu25(
                                      data.batu25,
                                      data.qtyBatu25,
                                    );
                                    await postApiQtyBatu26(
                                      data.batu26,
                                      data.qtyBatu26,
                                    );
                                    await postApiQtyBatu27(
                                      data.batu27,
                                      data.qtyBatu27,
                                    );
                                    await postApiQtyBatu28(
                                      data.batu28,
                                      data.qtyBatu28,
                                    );
                                    await postApiQtyBatu29(
                                      data.batu29,
                                      data.qtyBatu29,
                                    );
                                    await postApiQtyBatu30(
                                      data.batu30,
                                      data.qtyBatu30,
                                    );
                                    await postApiQtyBatu31(
                                      data.batu31,
                                      data.qtyBatu31,
                                    );
                                    await postApiQtyBatu32(
                                      data.batu32,
                                      data.qtyBatu32,
                                    );
                                    await postApiQtyBatu33(
                                      data.batu33,
                                      data.qtyBatu33,
                                    );
                                    await postApiQtyBatu34(
                                      data.batu34,
                                      data.qtyBatu34,
                                    );
                                    await postApiQtyBatu35(
                                      data.batu35,
                                      data.qtyBatu35,
                                    );
                                    var id = data.id.toString();
                                    Map<String, String> body = {'id': id};
                                    final response = await http.post(
                                        Uri.parse(ApiConstants.baseUrl +
                                            ApiConstants
                                                .postDeleteFormDesignerById),
                                        body: body);
                                    print(response.body);
                                    onRowPressed(); //! function merefresh state

                                    Navigator.pop(context);
                                    showSimpleNotification(
                                      const Text(
                                        'Design Terhapus',
                                      ),
                                      background: Colors.green,
                                      duration: const Duration(seconds: 1),
                                    );
                                  },
                                  child: const Text(
                                    'Hapus',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
            sharedPreferences!.getString('level') == '3'
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: IconButton(
                      onPressed: () {
                        data.edit! == 0
                            ? showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AlertDialog(
                                      title: Text(
                                        'Form terkunci',
                                      ),
                                    ))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => FormScreenById(
                                          modelDesigner: FormDesignerModel(
                                              id: data.id,
                                              kodeDesignMdbc:
                                                  data.kodeDesignMdbc,
                                              kodeMarketing: data.kodeMarketing,
                                              kodeProduksi: data.kodeProduksi,
                                              namaDesigner: data.namaDesigner,
                                              namaModeller: data.namaModeller,
                                              kodeDesign: data.kodeDesign,
                                              siklus: data.siklus,
                                              tema: data.tema,
                                              rantai: data.rantai,
                                              qtyRantai: data.qtyRantai,
                                              lain2: data.lain2,
                                              qtyLain2: data.qtyLain2,
                                              earnut: data.earnut,
                                              qtyEarnut: data.qtyEarnut,
                                              panjangRantai: data.panjangRantai,
                                              customKomponen:
                                                  data.customKomponen,
                                              qtyCustomKomponen:
                                                  data.qtyCustomKomponen,
                                              jenisBarang: data.jenisBarang,
                                              kategoriBarang:
                                                  data.kategoriBarang,
                                              brand: data.brand,
                                              photoShoot: data.photoShoot,
                                              color: data.color,
                                              beratEmas: data.beratEmas,
                                              estimasiHarga: data.estimasiHarga,
                                              ringSize: data.ringSize,
                                              created_at: data.created_at,
                                              batu1: data.batu1,
                                              qtyBatu1: data.qtyBatu1,
                                              batu2: data.batu2,
                                              qtyBatu2: data.qtyBatu2,
                                              batu3: data.batu3,
                                              qtyBatu3: data.qtyBatu3,
                                              batu4: data.batu4,
                                              qtyBatu4: data.qtyBatu4,
                                              batu5: data.batu5,
                                              qtyBatu5: data.qtyBatu5,
                                              batu6: data.batu6,
                                              qtyBatu6: data.qtyBatu6,
                                              batu7: data.batu7,
                                              qtyBatu7: data.qtyBatu7,
                                              batu8: data.batu8,
                                              qtyBatu8: data.qtyBatu8,
                                              batu9: data.batu9,
                                              qtyBatu9: data.qtyBatu9,
                                              batu10: data.batu10,
                                              qtyBatu10: data.qtyBatu10,
                                              batu11: data.batu11,
                                              qtyBatu11: data.qtyBatu11,
                                              batu12: data.batu12,
                                              qtyBatu12: data.qtyBatu12,
                                              batu13: data.batu13,
                                              qtyBatu13: data.qtyBatu13,
                                              batu14: data.batu14,
                                              qtyBatu14: data.qtyBatu14,
                                              batu15: data.batu15,
                                              qtyBatu15: data.qtyBatu15,
                                              batu16: data.batu16,
                                              qtyBatu16: data.qtyBatu16,
                                              batu17: data.batu17,
                                              qtyBatu17: data.qtyBatu17,
                                              batu18: data.batu18,
                                              qtyBatu18: data.qtyBatu18,
                                              batu19: data.batu19,
                                              qtyBatu19: data.qtyBatu19,
                                              batu20: data.batu20,
                                              qtyBatu20: data.qtyBatu20,
                                              batu21: data.batu21,
                                              qtyBatu21: data.qtyBatu21,
                                              batu22: data.batu22,
                                              qtyBatu22: data.qtyBatu22,
                                              batu23: data.batu23,
                                              qtyBatu23: data.qtyBatu23,
                                              batu24: data.batu24,
                                              qtyBatu24: data.qtyBatu24,
                                              batu25: data.batu25,
                                              qtyBatu25: data.qtyBatu25,
                                              batu26: data.batu26,
                                              qtyBatu26: data.qtyBatu26,
                                              batu27: data.batu27,
                                              qtyBatu27: data.qtyBatu27,
                                              batu28: data.batu28,
                                              qtyBatu28: data.qtyBatu28,
                                              batu29: data.batu29,
                                              qtyBatu29: data.qtyBatu29,
                                              batu30: data.batu30,
                                              qtyBatu30: data.qtyBatu30,
                                              batu31: data.batu31,
                                              qtyBatu31: data.qtyBatu31,
                                              batu32: data.batu32,
                                              qtyBatu32: data.qtyBatu32,
                                              batu33: data.batu33,
                                              qtyBatu33: data.qtyBatu33,
                                              batu34: data.batu34,
                                              qtyBatu34: data.qtyBatu34,
                                              batu35: data.batu35,
                                              qtyBatu35: data.qtyBatu35,
                                              imageUrl: data.imageUrl,
                                              keteranganStatusBatu:
                                                  data.keteranganStatusBatu,
                                              pointModeller: data.pointModeller,
                                              tanggalInModeller:
                                                  data.tanggalInModeller,
                                              tanggalOutModeller:
                                                  data.tanggalOutModeller,
                                              tanggalInProduksi:
                                                  data.tanggalInProduksi,
                                              beratModeller: data.beratModeller,
                                              statusForm: data.statusForm,
                                              jo: data.jo),
                                        )));
                      },
                      icon: data.edit! == 0
                          ? const Icon(
                              Icons.lock,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                    ),
                  ),
            sharedPreferences!.getString('level') != '1'
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              'Perhatian',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Row(
                              children: [
                                data.edit! == 0
                                    ? const Text(
                                        'Apakah anda yakin ingin membuka kunci ',
                                      )
                                    : const Text(
                                        'Apakah anda yakin ingin kunci ',
                                      ),
                                Text(
                                  '${data.kodeDesignMdbc}  ?',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(
                                  context,
                                  'Batal',
                                ),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  var id = data.id.toString();
                                  var edit = data.edit! == 0 ? 1 : 0;
                                  Map<String, String> body = {
                                    'id': id,
                                    'edit': edit.toString()
                                  };
                                  final response = await http.post(
                                      Uri.parse(ApiConstants.baseUrl +
                                          ApiConstants.keyById),
                                      body: body);
                                  print(response.body);
                                  onRowPressed(); //! function merefresh state

                                  Navigator.pop(context);
                                  showSimpleNotification(
                                    edit == 0
                                        ? const Text(
                                            'Design Berhasil Dibuka',
                                          )
                                        : const Text(
                                            'Design Berhasil Dikunci',
                                          ),
                                    background: Colors.green,
                                    duration: const Duration(seconds: 1),
                                  );
                                  // sharedPreferences!.getString('divisi') ==
                                  //         'designer'
                                  //     ? Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (c) =>
                                  //                 MainViewDesigner(col: 1)))
                                  //     : Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (c) =>
                                  //                 MainViewScm(col: 2))

                                  // );
                                },
                                child: data.edit! == 0
                                    ? const Text('Buka kunci',
                                        style: TextStyle(color: Colors.red))
                                    : const Text(
                                        'Kunci',
                                        style: TextStyle(color: Colors.red),
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: data.edit! == 0
                          ? const Icon(
                              Icons.key,
                              color: Colors.blue,
                            )
                          : Icon(
                              Icons.key_off,
                              color: Colors.yellow.shade900,
                            ),
                    ),
                  ),
            // sharedPreferences!.getString('level') != '1'
            //     ? const SizedBox()
            //     : Padding(
            //         padding: const EdgeInsets.only(left: 5),
            //         child: IconButton(
            //             onPressed: () {},
            //             icon: const Icon(
            //               Icons.print,
            //               color: Colors.blue,
            //             )))
          ],
        );
      }))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;

  postApiQtyBatu1(batu1, qtyBatu1) async {
    if (qtyBatu1 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu1"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu1 += data[0]['qty'];
          print(qtyBatu1);
          try {
            Map<String, String> body = {
              'size': batu1.toString(),
              'qty': qtyBatu1.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu2(batu2, qtyBatu2) async {
    if (qtyBatu2 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu2"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu2 += data[0]['qty'];
          print(qtyBatu2);
          try {
            Map<String, String> body = {
              'size': batu2.toString(),
              'qty': qtyBatu2.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu3(batu3, qtyBatu3) async {
    if (qtyBatu3 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu3"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu3 += data[0]['qty'];
          print(qtyBatu3);
          try {
            Map<String, String> body = {
              'size': batu3.toString(),
              'qty': qtyBatu3.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu4(batu4, qtyBatu4) async {
    if (qtyBatu4 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu4"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu4 += data[0]['qty'];
          print(qtyBatu4);
          try {
            Map<String, String> body = {
              'size': batu4.toString(),
              'qty': qtyBatu4.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu5(batu5, qtyBatu5) async {
    if (qtyBatu5 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu5"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu5 += data[0]['qty'];
          print(qtyBatu5);
          try {
            Map<String, String> body = {
              'size': batu5.toString(),
              'qty': qtyBatu5.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu6(batu6, qtyBatu6) async {
    if (qtyBatu6 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu6"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu6 += data[0]['qty'];
          print(qtyBatu6);
          try {
            Map<String, String> body = {
              'size': batu6.toString(),
              'qty': qtyBatu6.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu7(batu7, qtyBatu7) async {
    if (qtyBatu7 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu7"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu7 += data[0]['qty'];
          print(qtyBatu7);
          try {
            Map<String, String> body = {
              'size': batu7.toString(),
              'qty': qtyBatu7.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu8(batu8, qtyBatu8) async {
    if (qtyBatu8 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu8"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu8 += data[0]['qty'];
          print(qtyBatu8);
          try {
            Map<String, String> body = {
              'size': batu8.toString(),
              'qty': qtyBatu8.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu9(batu9, qtyBatu9) async {
    if (qtyBatu9 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu9"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu9 += data[0]['qty'];
          print(qtyBatu9);
          try {
            Map<String, String> body = {
              'size': batu9.toString(),
              'qty': qtyBatu9.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu10(batu10, qtyBatu10) async {
    if (qtyBatu10 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu10"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu10 += data[0]['qty'];
          print(qtyBatu10);
          try {
            Map<String, String> body = {
              'size': batu10.toString(),
              'qty': qtyBatu10.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu11(batu11, qtyBatu11) async {
    if (qtyBatu11 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu11"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu11 += data[0]['qty'];
          print(qtyBatu11);
          try {
            Map<String, String> body = {
              'size': batu11.toString(),
              'qty': qtyBatu11.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu12(batu12, qtyBatu12) async {
    if (qtyBatu12 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu12"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu12 += data[0]['qty'];
          print(qtyBatu12);
          try {
            Map<String, String> body = {
              'size': batu12.toString(),
              'qty': qtyBatu12.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu13(batu13, qtyBatu13) async {
    if (qtyBatu13 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu13"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu13 += data[0]['qty'];
          print(qtyBatu13);
          try {
            Map<String, String> body = {
              'size': batu13.toString(),
              'qty': qtyBatu13.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu14(batu14, qtyBatu14) async {
    if (qtyBatu14 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu14"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu14 += data[0]['qty'];
          print(qtyBatu14);
          try {
            Map<String, String> body = {
              'size': batu14.toString(),
              'qty': qtyBatu14.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu15(batu15, qtyBatu15) async {
    if (qtyBatu15 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu15"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu15 += data[0]['qty'];
          print(qtyBatu15);
          try {
            Map<String, String> body = {
              'size': batu15.toString(),
              'qty': qtyBatu15.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu16(batu16, qtyBatu16) async {
    if (qtyBatu16 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu16"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu16 += data[0]['qty'];
          print(qtyBatu16);
          try {
            Map<String, String> body = {
              'size': batu16.toString(),
              'qty': qtyBatu16.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu17(batu17, qtyBatu17) async {
    if (qtyBatu17 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu17"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu17 += data[0]['qty'];
          print(qtyBatu17);
          try {
            Map<String, String> body = {
              'size': batu17.toString(),
              'qty': qtyBatu17.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu18(batu18, qtyBatu18) async {
    if (qtyBatu18 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu18"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu18 += data[0]['qty'];
          print(qtyBatu18);
          try {
            Map<String, String> body = {
              'size': batu18.toString(),
              'qty': qtyBatu18.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu19(batu19, qtyBatu19) async {
    if (qtyBatu19 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu19"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu19 += data[0]['qty'];
          print(qtyBatu19);
          try {
            Map<String, String> body = {
              'size': batu19.toString(),
              'qty': qtyBatu19.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu20(batu20, qtyBatu20) async {
    if (qtyBatu20 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu20"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu20 += data[0]['qty'];
          print(qtyBatu20);
          try {
            Map<String, String> body = {
              'size': batu20.toString(),
              'qty': qtyBatu20.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu21(batu21, qtyBatu21) async {
    if (qtyBatu21 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu21"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu21 += data[0]['qty'];
          print(qtyBatu21);
          try {
            Map<String, String> body = {
              'size': batu21.toString(),
              'qty': qtyBatu21.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu22(batu22, qtyBatu22) async {
    if (qtyBatu22 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu22"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu22 += data[0]['qty'];
          print(qtyBatu22);
          try {
            Map<String, String> body = {
              'size': batu22.toString(),
              'qty': qtyBatu22.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu23(batu23, qtyBatu23) async {
    if (qtyBatu23 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu23"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu23 += data[0]['qty'];
          print(qtyBatu23);
          try {
            Map<String, String> body = {
              'size': batu23.toString(),
              'qty': qtyBatu23.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu24(batu24, qtyBatu24) async {
    if (qtyBatu24 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu24"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu24 += data[0]['qty'];
          print(qtyBatu24);
          try {
            Map<String, String> body = {
              'size': batu24.toString(),
              'qty': qtyBatu24.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu25(batu25, qtyBatu25) async {
    if (qtyBatu25 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu25"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu25 += data[0]['qty'];
          print(qtyBatu25);
          try {
            Map<String, String> body = {
              'size': batu25.toString(),
              'qty': qtyBatu25.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu26(batu26, qtyBatu26) async {
    if (qtyBatu26 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu26"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu26 += data[0]['qty'];
          print(qtyBatu26);
          try {
            Map<String, String> body = {
              'size': batu26.toString(),
              'qty': qtyBatu26.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu27(batu27, qtyBatu27) async {
    if (qtyBatu27 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu27"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu27 += data[0]['qty'];
          print(qtyBatu27);
          try {
            Map<String, String> body = {
              'size': batu27.toString(),
              'qty': qtyBatu27.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu28(batu28, qtyBatu28) async {
    if (qtyBatu28 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu28"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu28 += data[0]['qty'];
          print(qtyBatu28);
          try {
            Map<String, String> body = {
              'size': batu28.toString(),
              'qty': qtyBatu28.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu29(batu29, qtyBatu29) async {
    if (qtyBatu29 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu29"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu29 += data[0]['qty'];
          print(qtyBatu29);
          try {
            Map<String, String> body = {
              'size': batu29.toString(),
              'qty': qtyBatu29.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu30(batu30, qtyBatu30) async {
    if (qtyBatu30 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu30"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu30 += data[0]['qty'];
          print(qtyBatu30);
          try {
            Map<String, String> body = {
              'size': batu30.toString(),
              'qty': qtyBatu30.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu31(batu31, qtyBatu31) async {
    if (qtyBatu31 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu31"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu31 += data[0]['qty'];
          print(qtyBatu31);
          try {
            Map<String, String> body = {
              'size': batu31.toString(),
              'qty': qtyBatu31.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu32(batu32, qtyBatu32) async {
    if (qtyBatu32 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu32"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu32 += data[0]['qty'];
          print(qtyBatu32);
          try {
            Map<String, String> body = {
              'size': batu32.toString(),
              'qty': qtyBatu32.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu33(batu33, qtyBatu33) async {
    if (qtyBatu33 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu33"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu33 += data[0]['qty'];
          print(qtyBatu33);
          try {
            Map<String, String> body = {
              'size': batu33.toString(),
              'qty': qtyBatu33.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu34(batu34, qtyBatu34) async {
    if (qtyBatu34 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu34"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu34 += data[0]['qty'];
          print(qtyBatu34);
          try {
            Map<String, String> body = {
              'size': batu34.toString(),
              'qty': qtyBatu34.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  postApiQtyBatu35(batu35, qtyBatu35) async {
    if (qtyBatu35 > 0) {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu35"'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print(data[0]['qty']);
          qtyBatu35 += data[0]['qty'];
          print(qtyBatu35);
          try {
            Map<String, String> body = {
              'size': batu35.toString(),
              'qty': qtyBatu35.toString(),
            };
            final response = await http.post(
                Uri.parse(ApiConstants.baseUrl +
                    ApiConstants.postUpdateDataBatuBySize),
                body: body);
            print(response.body);
          } catch (c) {
            print(c);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }
}

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    required List<FormDesignerModel> userData,
  }) : _userData = userData;
  final List<FormDesignerModel> _userData;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    // ignore: no_leading_underscores_for_local_identifiers
    final _user = _userData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${_user.kodeDesignMdbc}')),
        DataCell(Text('${_user.namaDesigner}')),
        DataCell(Text('${_user.kodeDesign}')),
        DataCell(Text('${_user.tema}')),
        DataCell(Text('${_user.jenisBarang}')),
        DataCell(Text('${_user.estimasiHarga}')),
        DataCell(Text('${_user.imageUrl}')),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                // Text('${_user.id}');
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.green,
              ),
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(FormDesignerModel d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
