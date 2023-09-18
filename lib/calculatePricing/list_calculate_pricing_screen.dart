// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/calculatePricing/add_calculate_pricing.dart';
import 'package:form_designer/global/currency_format.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../model/estimasi_pricing_model.dart';

class ListCalculatePricingScreen extends StatefulWidget {
  const ListCalculatePricingScreen({super.key});
  @override
  State<ListCalculatePricingScreen> createState() =>
      _ListCalculatePricingScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListCalculatePricingScreenState
    extends State<ListCalculatePricingScreen> {
  List<dynamic> filteredData = [];
  TextEditingController controller = TextEditingController();
  bool sort = true;
  int _currentSortColumn = 0;
  List<EstimasiPricingModel>? filterCrm;
  List<EstimasiPricingModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;

  // onsortColum(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     if (ascending) {
  //       filterCrm!.sort((a, b) => a.kodeDesignMdbc!
  //           .toLowerCase()
  //           .compareTo(b.kodeDesignMdbc!.toLowerCase()));
  //     } else {
  //       filterCrm!.sort((a, b) => b.kodeDesignMdbc!
  //           .toLowerCase()
  //           .compareTo(a.kodeDesignMdbc!.toLowerCase()));
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  Future<List<EstimasiPricingModel>> _getData() async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListEstimasiHarga));
    // final response = sharedPreferences!.getString('level') == '1'
    //     ? await http.get(
    //         Uri.parse(ApiConstants.baseUrl + ApiConstants.getListEstimasiHarga))
    //     : await http.get(Uri.parse(
    //         '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerByName}?nama=${sharedPreferences!.getString('nama')!}'));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g = jsonResponse
          .map((data) => EstimasiPricingModel.fromJson(data))
          .toList();
      setState(() {
        filterCrm = g;
        myCrm = g;
        print(myCrm!.length);
        isLoading = true;
      });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
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
              // drawer: Drawer1(),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.blue,
                flexibleSpace: Container(
                  color: Colors.blue,
                ),
                title: const Text(
                  "LIST CALCULATE PRICING",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _getData();
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  )
                ],
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
                                decoration: const InputDecoration(
                                    hintText: "Search Anything ..."),
                                onChanged: (value) {
                                  //fungsi search anyting
                                  myCrm = filterCrm!
                                      .where((element) =>
                                          element.id!
                                              .toString()
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          element.namaDesigner!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          element.brand!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          element.beratEmas!
                                              .toString()
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
                                        rowsPerPage: 10,
                                        columnSpacing: 0,
                                        columns: [
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "ID",
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
                                                    filterCrm!.sort((a, b) =>
                                                        a.id!.compareTo(b.id!));
                                                  } else {
                                                    sort = true;
                                                    filterCrm!.sort((a, b) =>
                                                        b.id!.compareTo(a.id!));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    "NAMA DESIGNER",
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
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "BRAND",
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
                                                        .brand!
                                                        .toLowerCase()
                                                        .compareTo(b.brand!
                                                            .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterCrm!.sort((a, b) => b
                                                        .brand!
                                                        .toLowerCase()
                                                        .compareTo(a.brand!
                                                            .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "BERAT EMAS",
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
                                                    filterCrm!.sort((a, b) =>
                                                        a.beratEmas!.compareTo(
                                                            b.beratEmas!));
                                                  } else {
                                                    sort = true;
                                                    filterCrm!.sort((a, b) =>
                                                        b.beratEmas!.compareTo(
                                                            a.beratEmas!));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "JENIS BARANG",
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
                                                        .compareTo(b
                                                            .jenisBarang!
                                                            .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterCrm!.sort((a, b) => b
                                                        .jenisBarang!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .jenisBarang!
                                                            .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 130,
                                                  child: Text(
                                                    "ESTIMASI HARGA",
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
                                        ],
                                        source:
                                            // UserDataTableSource(userData: filterCrm!)),
                                            RowSource(
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
              floatingActionButton: Stack(children: [
                Positioned(
                  left: 40,
                  bottom: 5,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>
                                  const AddCalculatePricingScreen()));
                    },
                    label: const Text(
                      "Tambah Estimasi Harga",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                )
              ]))),
    );
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  RowSource({
    required this.myData,
    required this.count,
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
    return DataRow(cells: [
      //id
      DataCell(Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text(data.id.toString())),
            IconButton(
                onPressed: () {
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
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 200,
                                            child: Text(
                                              'Labour',
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            'Rp.${CurrencyFormat.convertToDollar(int.parse(data.labour), 0)}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 200,
                                            child: Text(
                                              'Emas',
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            'Rp.${CurrencyFormat.convertToDollar(int.parse(data.emas), 0)}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 200,
                                            child: Text(
                                              'Diamond',
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            'Rp.${CurrencyFormat.convertToDollar(int.parse(data.diamond), 0)}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 3,
                                      color: Colors.black,
                                    ),
                                    //? batu1
                                    data.qtyBatu1 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu1}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu1} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu1),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu1 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu2
                                    data.qtyBatu2 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu2}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu2} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu2),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu2 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu3
                                    data.qtyBatu3 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu3}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu3} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu3),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu3 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu4
                                    data.qtyBatu4 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu4}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu4} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu4),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),

                                    data.qtyBatu4 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu5
                                    data.qtyBatu5 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu5}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu5} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu5),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu5 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu6
                                    data.qtyBatu6 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu6}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu6} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu6),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu6 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu7
                                    data.qtyBatu7 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu7}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu7} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu7),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu7 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu8
                                    data.qtyBatu8 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu8}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu8} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu8),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu8 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu9
                                    data.qtyBatu9 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu9}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu9} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu9),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu9 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu10
                                    data.qtyBatu10 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu10}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu10} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu10),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu10 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu11
                                    data.qtyBatu11 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu11}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu11} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu11),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu11 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu12
                                    data.qtyBatu12 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu12}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu12} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu12),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu12 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu13

                                    data.qtyBatu13 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu13}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu13} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu13),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu13 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu14
                                    data.qtyBatu14 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu14}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu14} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu14),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),

                                    data.qtyBatu14 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu15
                                    data.qtyBatu15 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu15}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu15} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu15),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu15 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu16
                                    data.qtyBatu16 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu16}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu16} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu16),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu16 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu17
                                    data.qtyBatu17 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu17}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu17} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu17),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu17 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu18
                                    data.qtyBatu18 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu18}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu18} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu18),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu18 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu19
                                    data.qtyBatu19 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu19}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu19} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu19),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu19 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu20
                                    data.qtyBatu20 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu20}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu20} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu20),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu20 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu21
                                    data.qtyBatu21 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu21}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu21} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu21),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu21 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu22
                                    data.qtyBatu22 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu22}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu22} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu22),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu22 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu23
                                    data.qtyBatu23 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu23}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu23} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu23),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu23 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu24
                                    data.qtyBatu24 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu24}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu24} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu24),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),

                                    data.qtyBatu24 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu25
                                    data.qtyBatu25 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu25}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu25} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu25),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu25 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu26
                                    data.qtyBatu26 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu26}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu26} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu26),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu26 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu27
                                    data.qtyBatu27 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu27}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu27} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu27),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu27 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu28
                                    data.qtyBatu28 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu28}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu28} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu28),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu28 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu29
                                    data.qtyBatu29 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu29}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu29} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu29),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu29 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),

                                    //? batu30
                                    data.qtyBatu30 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu30}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu30} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu30),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu30 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu31
                                    data.qtyBatu31 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu31}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu31} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu31),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu31 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu32
                                    data.qtyBatu32 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu32}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu32} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu32),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu32 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu33
                                    data.qtyBatu33 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu33}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu33} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu33),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu33 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu34
                                    data.qtyBatu34 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu34}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu34} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu34),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu34 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                    //? batu35
                                    data.qtyBatu35 <= 0
                                        ? const SizedBox()
                                        : Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    '${data.batu35}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  '(${data.qtyBatu35} Pcs)',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: FutureBuilder(
                                                      future: _getDataMdbc(
                                                          data.batu35),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            '(${snapshot.data!} Crt/Pcs)',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.qtyBatu35 <= 0
                                        ? const SizedBox()
                                        : const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.blue,
                ))
          ],
        );
      })),
      DataCell(_verticalDivider),
      //Nama Designer
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.namaDesigner)),
      ),
      DataCell(_verticalDivider),

      //Brand
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.brand)),
      ),
      DataCell(_verticalDivider),

      //Berat Emas
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.beratEmas.toString())),
      ),
      DataCell(_verticalDivider),

      //jenisBarang
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.jenisBarang.toString())),
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
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;

  _getDataMdbc(size) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$size"'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var sum = data[0]['idStone'] ?? 0;
        var result;
        try {
          final response = await http.get(
            Uri.parse(
                '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone="$sum"'),
          );
          final data = jsonDecode(response.body);
          result = data[0]['caratPcs'] ?? 0;
        } catch (c) {
          print(c);
        }
        return result;
      }
    } catch (e) {
      print(e);
    }
  }
}

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    required List<EstimasiPricingModel> userData,
  }) : _userData = userData;
  final List<EstimasiPricingModel> _userData;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
    final _user = _userData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        // DataCell(Text('${_user.kodeDesignMdbc}')),
        // DataCell(Text('${_user.kodeMarketing}')),
        // DataCell(Text('${_user.kodeDesign}')),
        // DataCell(Text('${_user.tema}')),
        // DataCell(Text('${_user.jenisBarang}')),
        // DataCell(Text('${_user.estimasiHarga}')),
        // DataCell(Text('${_user.imageUrl}')),
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
      Comparable<T> Function(EstimasiPricingModel d) getField, bool ascending) {
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
