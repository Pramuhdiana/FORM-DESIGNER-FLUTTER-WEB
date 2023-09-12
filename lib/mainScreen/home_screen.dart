// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'dart:convert';

// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/mainScreen/form_view_screen.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController siklus = TextEditingController();
  String siklusDesigner = '';
  List<FormDesignerModel>? listJenisBarang;
  List<String> listKelasHarga = [];
  TextEditingController controller = TextEditingController();
  bool sort = true;
  int _currentSortColumn = 0;
  List<FormDesignerModel>? filterCrm;
  List<FormDesignerModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    print(month);
    siklusDesigner = month;
    _getAllData("all", sharedPreferences!.getString('nama')!);
  }

  Future<List<FormDesignerModel>> _getAllData(month, name) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      if (sharedPreferences!.getString('level') != '1') {
        if (month.toString().toLowerCase() == "all") {
          var filterByName = allData.where((element) =>
              element.namaDesigner.toString().toLowerCase() ==
              name.toString().toLowerCase());
          allData = filterByName.toList();
        } else {
          var filterBySiklus = allData.where((element) =>
              element.siklus.toString().toLowerCase() ==
              month.toString().toLowerCase());
          var filterByName = filterBySiklus.where((element) =>
              element.namaDesigner.toString().toLowerCase() ==
              name.toString().toLowerCase());
          allData = filterByName.toList();
        }
      } else {
        if (month.toString().toLowerCase() == "all") {
        } else {
          var filterBySiklus = allData.where((element) =>
              element.siklus.toString().toLowerCase() ==
              month.toString().toLowerCase());
          allData = filterBySiklus.toList();
        }
      }

      setState(() {
        filterCrm = allData;
        myCrm = allData;
        isLoading = true;
      });
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<FormDesignerModel>> _getData(chooseSiklus, nama) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      if (sharedPreferences!.getString('level') != '1') {
        if (chooseSiklus.toString().toLowerCase() == "all") {
          var filterByName = g.where((element) =>
              element.namaDesigner.toString().toLowerCase() ==
              nama.toString().toLowerCase());

          listJenisBarang = filterByName.toList();
        } else {
          var filterBySiklus = g.where((element) =>
              element.siklus.toString().toLowerCase() ==
              chooseSiklus.toString().toLowerCase());
          var filterByName = filterBySiklus.where((element) =>
              element.namaDesigner.toString().toLowerCase() ==
              nama.toString().toLowerCase());

          listJenisBarang = filterByName.toList();
        }
      } else {
        if (chooseSiklus.toString().toLowerCase() == "all") {
          listJenisBarang = g;
        } else {
          var filterBySiklus = g.where((element) =>
              element.siklus.toString().toLowerCase() ==
              chooseSiklus.toString().toLowerCase());

          filterBySiklus.toList();
          listJenisBarang = filterBySiklus.toList();
        }
      }

      g = removeDuplicates(listJenisBarang!);
      // g = filterBySiklus.toList();
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<FormDesignerModel>> _getKelasHarga(chooseSiklus, nama) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      if (sharedPreferences!.getString('level') != '1') {
//! kondisi designer
        if (chooseSiklus.toString().toLowerCase() == "all") {
          var filterByName = g.where((element) =>
              element.namaDesigner.toString().toLowerCase() ==
              nama.toString().toLowerCase());
          g = filterByName.toList();
        } else {
          var filterBySiklus = g.where((element) =>
              element.siklus.toString().toLowerCase() ==
              chooseSiklus.toString().toLowerCase());
          var filterByName = filterBySiklus.where((element) =>
              element.namaDesigner.toString().toLowerCase() ==
              nama.toString().toLowerCase());
          g = filterByName.toList();
        }
      } else {
        //! kondisi scm
        if (chooseSiklus.toString().toLowerCase() == "all") {
        } else {
          var filterBySiklus = g.where((element) =>
              element.siklus.toString().toLowerCase() ==
              chooseSiklus.toString().toLowerCase());
          g = filterBySiklus.toList();
        }
      }

      print(g.length);
      //* fungsi looping untuk menambahakn beberapa item kje dalam list kosong
      listKelasHarga.clear();

      for (var i = 0; i < g.length; i++) {
        print(g[i].estimasiHarga!);

        if (((g[i].estimasiHarga! * 0.37) * 11500) <= 5000000) {
          listKelasHarga.add(
              'XS'); //!menambahakn item baru ke dalam list yang sudah dibuatkan
        } else if (((g[i].estimasiHarga! * 0.37) * 11500) <= 10000000) {
          listKelasHarga.add('S');
        } else if (((g[i].estimasiHarga! * 0.37) * 11500) <= 20000000) {
          listKelasHarga.add('M');
        } else if (((g[i].estimasiHarga! * 0.37) * 11500) <= 35000000) {
          listKelasHarga.add('L');
        } else {
          listKelasHarga.add('XL');
        }
      }
      print(listKelasHarga);

      // print(listKelasHarga.where((e) => e == "XS").length); //! mencari kalimat tertentu di dalam list yang menampilkan count dalam list
      // print(listKelasHarga.toSet().toList()); //! menghapus item duplikat di dalam 1 list
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  // fungsi remove duplicate object
  List<FormDesignerModel> removeDuplicates(List<FormDesignerModel> items) {
    List<FormDesignerModel> uniqueItems = []; // uniqueList
    var uniqueNames = items
        .map((e) => e.jenisBarang)
        .toSet(); //list if UniqueID to remove duplicates
    for (var e in uniqueNames) {
      uniqueItems.add(items.firstWhere((i) => i.jenisBarang == e));
    }
    return uniqueItems; //send back the unique items list
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Pagi';
      }
      if (hour < 15) {
        return 'Siang';
      }
      if (hour < 17) {
        return 'Sore';
      }
      return 'Malam';
    }

    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: Scaffold(

            // drawer: Drawer1(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              centerTitle: true,
              actions: const [
                Text(
                  "v(1.2.0)",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            body: sharedPreferences!.getString('level') != '1'
                ?
                //dashboard designer
                // Center(
                //     child: Text(
                //       'Selamat ${greeting()},\n\n ${sharedPreferences!.getString('nama')!}',
                //       textAlign: TextAlign.center,
                //       style: const TextStyle(
                //           fontSize: 26,
                //           color: Colors.blueGrey,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'Acne',
                //           letterSpacing: 1.5),
                //     ),
                //   )
                dashboardDesigner()
                :
                //dashboard scm
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: 25),
                              width: MediaQuery.of(context).size.width * 0.3,
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
                                onChanged: (item) {
                                  setState(() {
                                    listKelasHarga.clear();

                                    isLoading = false;
                                    siklus.text = item!;
                                    siklusDesigner = siklus.text.toString();
                                    _getData(siklusDesigner,
                                        sharedPreferences!.getString('nama')!);
                                    _getAllData(siklusDesigner,
                                        sharedPreferences!.getString('nama')!);
                                  });
                                  Future.delayed(
                                          const Duration(milliseconds: 500))
                                      .then((value) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  textAlign: TextAlign.center,
                                  baseStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "Pilih Siklus",
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.center,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)))),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                        padding: const EdgeInsets.all(12),
                                        width: 300,
                                        height: 300,
                                        child: Card(
                                            color: Colors.grey.shade200,
                                            child: FutureBuilder(
                                                future: siklus.text.isEmpty
                                                    ? _getData(
                                                        "all",
                                                        sharedPreferences!
                                                            .getString('nama')!)
                                                    : _getData(
                                                        siklusDesigner,
                                                        sharedPreferences!
                                                            .getString(
                                                                'nama')!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Column(children: [
                                                      const Text('Jenis Barang',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                          )),
                                                      const Divider(
                                                          thickness: 5),
                                                      Center(
                                                          child: SizedBox(
                                                        width: 250,
                                                        height: 210,
                                                        child: Lottie.asset(
                                                            "loadingJSON/somethingwentwrong.json"),
                                                      ))
                                                    ]);
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Column(children: [
                                                      const Text('Jenis Barang',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                          )),
                                                      const Divider(
                                                          thickness: 5),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        width: 90,
                                                        height: 90,
                                                        child: Lottie.asset(
                                                            "loadingJSON/loadingV1.json"),
                                                      )
                                                    ]);
                                                  }
                                                  if (snapshot.data!.isEmpty) {
                                                    return const Column(
                                                        children: [
                                                          Text('Jenis Barang',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 24,
                                                              )),
                                                          Divider(thickness: 5),
                                                          Center(
                                                            child: Text(
                                                              'Tidak ada data',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 26,
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Acne',
                                                                  letterSpacing:
                                                                      1.5),
                                                            ),
                                                          )
                                                        ]);
                                                  }
                                                  if (snapshot.hasData) {
                                                    return Column(children: [
                                                      const Text('Jenis Barang',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                          )),
                                                      const Divider(
                                                          thickness: 5),
                                                      Expanded(
                                                        child:
                                                            isLoading == false
                                                                ? Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    width: 90,
                                                                    height: 90,
                                                                    child: Lottie
                                                                        .asset(
                                                                            "loadingJSON/loadingV1.json"),
                                                                  )
                                                                : ListView
                                                                    .builder(
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      var data =
                                                                          snapshot
                                                                              .data![index];
                                                                      return Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              data.jenisBarang.toString(),
                                                                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              listJenisBarang!.where((element) => element.jenisBarang.toString().toLowerCase() == data.jenisBarang.toString().toLowerCase()).toList().length.toString(),
                                                                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                      ),
                                                    ]);
                                                  }
                                                  return Column(children: [
                                                    const Text('Jenis Barang',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24,
                                                        )),
                                                    const Divider(thickness: 5),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      width: 90,
                                                      height: 90,
                                                      child: Lottie.asset(
                                                          "loadingJSON/loadingV1.json"),
                                                    )
                                                  ]);
                                                })))),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                        padding: const EdgeInsets.all(12),
                                        width: 300,
                                        height: 300,
                                        child: Card(
                                            color: Colors.grey.shade200,
                                            child: FutureBuilder(
                                                future: siklus.text.isEmpty
                                                    ? _getKelasHarga(
                                                        "all",
                                                        sharedPreferences!
                                                            .getString('nama')!)
                                                    : _getKelasHarga(
                                                        siklusDesigner,
                                                        sharedPreferences!
                                                            .getString(
                                                                'nama')!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Column(children: [
                                                      const Text('Kelas Harga',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                          )),
                                                      const Divider(
                                                          thickness: 5),
                                                      Center(
                                                          child: SizedBox(
                                                        height: 210,
                                                        child: Lottie.asset(
                                                            "loadingJSON/somethingwentwrong.json"),
                                                      ))
                                                    ]);
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Column(children: [
                                                      const Text('Kelas Harga',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                          )),
                                                      const Divider(
                                                          thickness: 5),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        width: 90,
                                                        height: 90,
                                                        child: Lottie.asset(
                                                            "loadingJSON/loadingV1.json"),
                                                      )
                                                    ]);
                                                  }
                                                  if (snapshot.data!.isEmpty) {
                                                    return const Column(
                                                        children: [
                                                          Text('Kelas Harga',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 24,
                                                              )),
                                                          Divider(thickness: 5),
                                                          Center(
                                                            child: Text(
                                                              'Tidak ada data',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 26,
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Acne',
                                                                  letterSpacing:
                                                                      1.5),
                                                            ),
                                                          )
                                                        ]);
                                                  }
                                                  if (snapshot.hasData) {
                                                    return Column(children: [
                                                      const Text('Kelas Harga',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                          )),
                                                      const Divider(
                                                          thickness: 5),
                                                      Expanded(
                                                        child:
                                                            isLoading == false
                                                                ? Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    width: 90,
                                                                    height: 90,
                                                                    child: Lottie
                                                                        .asset(
                                                                            "loadingJSON/loadingV1.json"),
                                                                  )
                                                                : ListView
                                                                    .builder(
                                                                    itemCount: listKelasHarga
                                                                        .toSet()
                                                                        .toList()
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      // ignore: unused_local_variable
                                                                      var data =
                                                                          snapshot
                                                                              .data![index];
                                                                      return Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            // menampilkan list kelas harga di list dan menghilangkan duplikatnya
                                                                            Text(
                                                                              listKelasHarga.toSet().toList()[index].toString(),
                                                                              maxLines: 2,
                                                                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            //fungsi menampilkan jumlah kelas harga di list
                                                                            Text(
                                                                              listKelasHarga.where((element) => element == listKelasHarga.toSet().toList()[index].toString()).length.toString(),
                                                                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                      ),
                                                    ]);
                                                  }
                                                  return Column(children: [
                                                    const Text('Kelas Harga',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24,
                                                        )),
                                                    const Divider(thickness: 5),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      width: 90,
                                                      height: 90,
                                                      child: Lottie.asset(
                                                          "loadingJSON/loadingV1.json"),
                                                    )
                                                  ]);
                                                })))),
                              ],
                            ),
                          ),
                          //? search anything
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
                                          element.kodeDesignMdbc!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          element.namaDesigner!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          element.kodeDesign!
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
                          //? table list
                          isLoading == false
                              ? Center(
                                  child: SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Lottie.asset(
                                      "loadingJSON/loadingV2.json"),
                                ))
                              : Container(
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
                                          // ignore: deprecated_member_use
                                          dataRowHeight: 200,
                                          sortColumnIndex: _currentSortColumn,
                                          sortAscending: sort,
                                          rowsPerPage: 10,
                                          columnSpacing: 0,
                                          columns: [
                                            DataColumn(
                                                label: const SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      "Kode MDBC",
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
                                                            "Kode Design",
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
                                                            .getString(
                                                                'level') ==
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
                                                            .kodeDesign!
                                                            .toLowerCase()
                                                            .compareTo(b
                                                                .kodeDesign!
                                                                .toLowerCase()));
                                                      } else {
                                                        sort = true;
                                                        filterCrm!.sort((a, b) => b
                                                            .kodeDesign!
                                                            .toLowerCase()
                                                            .compareTo(a
                                                                .kodeDesign!
                                                                .toLowerCase()));
                                                      }
                                                    }
                                                  });
                                                }),
                                            DataColumn(label: _verticalDivider),
                                            DataColumn(
                                                label: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 35),
                                                    width: 120,
                                                    child: const Text(
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
                                                          .compareTo(b
                                                              .estimasiHarga!));
                                                      // onsortColum(columnIndex, ascending);
                                                    } else {
                                                      sort = true;
                                                      filterCrm!.sort((a, b) => b
                                                          .estimasiHarga!
                                                          .compareTo(a
                                                              .estimasiHarga!));
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30),
                                                  width: 120,
                                                  child: const Text(
                                                    "Gambar",
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
                                                  myData: myCrm,
                                                  count: myCrm!.length)),
                                    ),
                                  ),
                                ),
                        ]),
                  )));
  }

  dashboardDesigner() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width * 0.3,
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
              onChanged: (item) {
                setState(() {
                  listKelasHarga.clear();

                  isLoading = false;
                  siklus.text = item!;
                  siklusDesigner = siklus.text.toString();
                  _getData(
                      siklusDesigner, sharedPreferences!.getString('nama')!);
                  _getAllData(
                      siklusDesigner, sharedPreferences!.getString('nama')!);
                });
                Future.delayed(const Duration(milliseconds: 500)).then((value) {
                  setState(() {
                    isLoading = true;
                  });
                });
              },
              popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                showSelectedItems: true,
                showSearchBox: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                textAlign: TextAlign.center,
                baseStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                dropdownSearchDecoration: InputDecoration(
                    labelText: "Pilih Siklus",
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 300,
                      height: 300,
                      child: Card(
                          color: Colors.grey.shade200,
                          child: FutureBuilder(
                              future: siklus.text.isEmpty
                                  ? _getData("all",
                                      sharedPreferences!.getString('nama')!)
                                  : _getData(siklusDesigner,
                                      sharedPreferences!.getString('nama')!),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Column(children: [
                                    const Text('Jenis Barang',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    const Divider(thickness: 5),
                                    Center(
                                        child: SizedBox(
                                      width: 250,
                                      height: 210,
                                      child: Lottie.asset(
                                          "loadingJSON/somethingwentwrong.json"),
                                    ))
                                  ]);
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Column(children: [
                                    const Text('Jenis Barang',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    const Divider(thickness: 5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 90,
                                      height: 90,
                                      child: Lottie.asset(
                                          "loadingJSON/loadingV1.json"),
                                    )
                                  ]);
                                }
                                if (snapshot.data!.isEmpty) {
                                  return const Column(children: [
                                    Text('Jenis Barang',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    Divider(thickness: 5),
                                    Center(
                                      child: Text(
                                        'Tidak ada data',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 26,
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Acne',
                                            letterSpacing: 1.5),
                                      ),
                                    )
                                  ]);
                                }
                                if (snapshot.hasData) {
                                  return Column(children: [
                                    const Text('Jenis Barang',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    const Divider(thickness: 5),
                                    Expanded(
                                      child: isLoading == false
                                          ? Container(
                                              padding: const EdgeInsets.all(5),
                                              width: 90,
                                              height: 90,
                                              child: Lottie.asset(
                                                  "loadingJSON/loadingV1.json"),
                                            )
                                          : ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var data =
                                                    snapshot.data![index];
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        data.jenisBarang
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        listJenisBarang!
                                                            .where((element) =>
                                                                element
                                                                    .jenisBarang
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                data.jenisBarang
                                                                    .toString()
                                                                    .toLowerCase())
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ]);
                                }
                                return Column(children: [
                                  const Text('Jenis Barang',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                  const Divider(thickness: 5),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 90,
                                    height: 90,
                                    child: Lottie.asset(
                                        "loadingJSON/loadingV1.json"),
                                  )
                                ]);
                              })))),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 300,
                      height: 300,
                      child: Card(
                          color: Colors.grey.shade200,
                          child: FutureBuilder(
                              future: siklus.text.isEmpty
                                  ? _getKelasHarga("all",
                                      sharedPreferences!.getString('nama')!)
                                  : _getKelasHarga(siklusDesigner,
                                      sharedPreferences!.getString('nama')!),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Column(children: [
                                    const Text('Kelas Harga',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    const Divider(thickness: 5),
                                    Center(
                                        child: SizedBox(
                                      height: 210,
                                      child: Lottie.asset(
                                          "loadingJSON/somethingwentwrong.json"),
                                    ))
                                  ]);
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Column(children: [
                                    const Text('Kelas Harga',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    const Divider(thickness: 5),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 90,
                                      height: 90,
                                      child: Lottie.asset(
                                          "loadingJSON/loadingV1.json"),
                                    )
                                  ]);
                                }
                                if (snapshot.data!.isEmpty) {
                                  return const Column(children: [
                                    Text('Kelas Harga',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    Divider(thickness: 5),
                                    Center(
                                      child: Text(
                                        'Tidak ada data',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 26,
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Acne',
                                            letterSpacing: 1.5),
                                      ),
                                    )
                                  ]);
                                }
                                if (snapshot.hasData) {
                                  return Column(children: [
                                    const Text('Kelas Harga',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    const Divider(thickness: 5),
                                    Expanded(
                                      child: isLoading == false
                                          ? Container(
                                              padding: const EdgeInsets.all(5),
                                              width: 90,
                                              height: 90,
                                              child: Lottie.asset(
                                                  "loadingJSON/loadingV1.json"),
                                            )
                                          : ListView.builder(
                                              itemCount: listKelasHarga
                                                  .toSet()
                                                  .toList()
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                // ignore: unused_local_variable
                                                var data =
                                                    snapshot.data![index];
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // menampilkan list kelas harga di list dan menghilangkan duplikatnya
                                                      Text(
                                                        listKelasHarga
                                                            .toSet()
                                                            .toList()[index]
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah kelas harga di list
                                                      Text(
                                                        listKelasHarga
                                                            .where((element) =>
                                                                element ==
                                                                listKelasHarga
                                                                    .toSet()
                                                                    .toList()[
                                                                        index]
                                                                    .toString())
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ]);
                                }
                                return Column(children: [
                                  const Text('Kelas Harga',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                  const Divider(thickness: 5),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 90,
                                    height: 90,
                                    child: Lottie.asset(
                                        "loadingJSON/loadingV1.json"),
                                  )
                                ]);
                              })))),
            ],
          ),
        ),
        //? search anything
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
                  const InputDecoration(hintText: "Search Anything ..."),
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
                        element.kodeDesign!
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
        //? table list
        isLoading == false
            ? Center(
                child: SizedBox(
                width: 150,
                height: 150,
                child: Lottie.asset("loadingJSON/loadingV2.json"),
              ))
            : Container(
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
                        // ignore: deprecated_member_use
                        dataRowHeight: 200,
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: sort,
                        rowsPerPage: 10,
                        columnSpacing: 0,
                        columns: [
                          DataColumn(
                              label: const SizedBox(
                                  width: 120,
                                  child: Text(
                                    "Kode MDBC",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.kodeDesignMdbc!
                                        .toLowerCase()
                                        .compareTo(
                                            b.kodeDesignMdbc!.toLowerCase()));
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.kodeDesignMdbc!
                                        .toLowerCase()
                                        .compareTo(
                                            a.kodeDesignMdbc!.toLowerCase()));
                                  }
                                });
                              }),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: SizedBox(
                                  width: 120,
                                  child:
                                      sharedPreferences!.getString('level') !=
                                              '1'
                                          ? const Text(
                                              "Kode Design",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const Text(
                                              "Nama Designer",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sharedPreferences!.getString('level') ==
                                      '1') {
                                    if (sort == true) {
                                      sort = false;
                                      filterCrm!.sort((a, b) => a.namaDesigner!
                                          .toLowerCase()
                                          .compareTo(
                                              b.namaDesigner!.toLowerCase()));
                                    } else {
                                      sort = true;
                                      filterCrm!.sort((a, b) => b.namaDesigner!
                                          .toLowerCase()
                                          .compareTo(
                                              a.namaDesigner!.toLowerCase()));
                                    }
                                  } else {
                                    if (sort == true) {
                                      sort = false;
                                      filterCrm!.sort((a, b) => a.kodeDesign!
                                          .toLowerCase()
                                          .compareTo(
                                              b.kodeDesign!.toLowerCase()));
                                    } else {
                                      sort = true;
                                      filterCrm!.sort((a, b) => b.kodeDesign!
                                          .toLowerCase()
                                          .compareTo(
                                              a.kodeDesign!.toLowerCase()));
                                    }
                                  }
                                });
                              }),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: Container(
                                  padding: const EdgeInsets.only(left: 35),
                                  width: 120,
                                  child: const Text(
                                    "Tema",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.tema!
                                        .toLowerCase()
                                        .compareTo(b.tema!.toLowerCase()));
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.tema!
                                        .toLowerCase()
                                        .compareTo(a.tema!.toLowerCase()));
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
                                        fontWeight: FontWeight.bold),
                                  )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.jenisBarang!
                                        .toLowerCase()
                                        .compareTo(
                                            b.jenisBarang!.toLowerCase()));
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.jenisBarang!
                                        .toLowerCase()
                                        .compareTo(
                                            a.jenisBarang!.toLowerCase()));
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
                                        fontWeight: FontWeight.bold),
                                  )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    // myCrm.sort((a, b) => a['estimasiHarga'].)
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.estimasiHarga!
                                        .compareTo(b.estimasiHarga!));
                                    // onsortColum(columnIndex, ascending);
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.estimasiHarga!
                                        .compareTo(a.estimasiHarga!));
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
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                            label: Container(
                                padding: const EdgeInsets.only(left: 30),
                                width: 120,
                                child: const Text(
                                  "Gambar",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                        source:
                            // UserDataTableSource(userData: filterCrm!)),
                            RowSource(myData: myCrm, count: myCrm!.length)),
                  ),
                ),
              ),
      ]),
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
    // ignore: prefer_interpolation_to_compose_strings
    return DataRow(cells: [
      //kodeDesignMdbc
      DataCell(Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sharedPreferences!.getString('level') != '1'
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      final dropdownFormKey = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              // title: const Text('Pilih Siklus'),
                              content: SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    Form(
                                        key: dropdownFormKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DropdownSearch<String>(
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
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintText: 'Pilih Siklus',
                                                  filled: true,
                                                  fillColor:
                                                      Colors.grey.shade200,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              validator: (value) => value ==
                                                      null
                                                  ? "Siklus tidak boleh kosong"
                                                  : null,
                                              onChanged: (String? newValue) {},
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (dropdownFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      print("siklus terisiisi");
                                                      //? method untuk mengganti siklus
                                                      Navigator.pop(context);
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const AlertDialog(
                                                                title: Text(
                                                                  'Design Berhasil Dipindahkan',
                                                                ),
                                                              ));
                                                    }
                                                    print(
                                                        "siklus tidak di isi");

                                                    // showDialog<String>(
                                                    //     context:
                                                    //         context,
                                                    //     builder: (BuildContext
                                                    //             context) =>
                                                    //         const AlertDialog(
                                                    //           title:
                                                    //               Text(
                                                    //             'Design Berhasil Dipindahkan',
                                                    //           ),
                                                    //         ));
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
                    icon: const Icon(Icons.rotate_90_degrees_ccw)),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: Text(
                  data.kodeDesignMdbc,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                )),
            IconButton(
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
                                  imageUrl: data.imageUrl),
                            )));
              },
              icon: const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.blue,
              ),
            )
          ],
        );
      })),
      DataCell(_verticalDivider),
      //namaDesigner
      DataCell(
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: sharedPreferences!.getString('level') != '1'
                ? Text(
                    data.kodeDesign,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  )
                : Text(
                    data.namaDesigner,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  )),
      ),
      DataCell(_verticalDivider),
      //tema
      DataCell(
        Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Text(
              data.tema,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
      ),
      DataCell(_verticalDivider),

      //jenisBarang
      DataCell(
        Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Text(
              data.jenisBarang,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
      ),
      DataCell(_verticalDivider),

      //estimasiHarga
      DataCell(
        Container(
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0),
          child: Text(
            data.brand == "BELI BERLIAN"
                ? 'Rp. ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}'
                : data.brand == "METIER"
                    ? 'Rp. ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}'
                    : '\$ ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      DataCell(_verticalDivider),

      //kelas harga
      DataCell(
        Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: ((data.estimasiHarga * 0.37) * 11500) <= 5000000
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
                            style: TextStyle(fontSize: 20, color: Colors.black),
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
                              )),
      ),
      DataCell(_verticalDivider),
      //gambar
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: 150,
              height: 190,
              child: Image.network(
                ApiConstants.baseUrlImage + data.imageUrl!,
                fit: BoxFit.cover,
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

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
