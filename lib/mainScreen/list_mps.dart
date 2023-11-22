// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/view_photo_screen.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../api/api_constant.dart';
import '../global/global.dart';

class ListMpsScreen extends StatefulWidget {
  const ListMpsScreen({super.key});
  @override
  State<ListMpsScreen> createState() => _ListMpsScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListMpsScreenState extends State<ListMpsScreen> {
  List<dynamic> filteredData = [];
  TextEditingController controller = TextEditingController();
  bool sort = true;
  int _currentSortColumn = 0;
  List<FormDesignerModel>? filterCrm;
  List<FormDesignerModel>? myCrm;
  List<FormDesignerModel>? myDataProduksi;
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

  @override
  void initState() {
    super.initState();
    nowSiklus = sharedPreferences!.getString('siklus')!;

    // _getData();
  }

  // Future<List<FormDesignerModel>> _getData() async {
  //   final response = sharedPreferences!.getString('level') != '2'
  //       ? await http.get(
  //           Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner))
  //       : await http.get(Uri.parse(
  //           '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerByName}?nama=${sharedPreferences!.getString('nama')!}'));

  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);

  //     var g =
  //         jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

  //     if (sharedPreferences!.getString('level') == '3') {
  //       var nama = sharedPreferences!.getString('nama');
  //       print(nama);
  //       var filterByModeller = g.where((element) =>
  //           element.namaModeller.toString().toLowerCase() ==
  //           nama.toString().toLowerCase());

  //       g = filterByModeller.toList();
  //       setState(() {
  //         filterCrm = g;
  //         myCrm = g;
  //       });
  //     } else {
  //       var dataProduksi = g.where((element) =>
  //           element.tanggalInProduksi.toString().toLowerCase().isNotEmpty);

  //       setState(() {
  //         myDataProduksi = dataProduksi.toList();
  //         filterCrm = g;
  //         myCrm = g;
  //       });
  //     }

  //     return g;
  //   } else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }

  Future<List<FormDesignerModel>> _getDataBySiklus(chooseSiklus) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      var filterBySiklus = g.where((element) =>
          element.siklus.toString().toLowerCase() ==
          chooseSiklus.toString().toLowerCase());

      // ignore: unused_local_variable
      var dataProduksi = filterBySiklus.toList();
      // var dataProduksi = filterBySiklus.where((element) =>
      //     element.tanggalInProduksi.toString().toLowerCase().isNotEmpty);
      filterBySiklus.toList();

      setState(() {
        myDataProduksi = filterBySiklus.toList();
        filterCrm = filterBySiklus.toList();
        myCrm = filterBySiklus.toList();
      });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  refresh() {
    setState(() {
      isLoading = false;
    });
    _getDataBySiklus(siklus.text);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      //! lalu eksekusi fungsi ini
      setState(() {
        isLoading = true;
      });
    });
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
              backgroundColor: Colors.white,
              leadingWidth: 320,
              leading: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Siklus Saat Ini : $nowSiklus",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              elevation: 0,
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
                            element.kodeDesign!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.kodeMarketing!
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
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      refresh();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ))
              ],
            ),
            body: sharedPreferences!.getString('level') == '4'
                ? mpsProduksi()
                : mpsSCM(),

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
            //       ]
            //       )
          )),
    );
  }

  mpsSCM() {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
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
                        isLoading = false;
                      });
                      siklus.text = item!;
                      siklusDesigner = siklus.text.toString();
                      _getDataBySiklus(siklus.text);
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
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.2,
                //   padding: const EdgeInsets.all(0),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.grey,
                //       ),
                //       borderRadius: BorderRadius.circular(12)),
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: TextField(
                //       textAlign: TextAlign.center,
                //       controller: controller,
                //       decoration: const InputDecoration(
                //           hintText: "Search Anything ..."),
                //       onChanged: (value) {
                //         //fungsi search anyting
                //         myCrm = filterCrm!
                //             .where((element) =>
                //                 element.kodeDesignMdbc!
                //                     .toLowerCase()
                //                     .contains(value.toLowerCase()) ||
                //                 element.namaDesigner!
                //                     .toLowerCase()
                //                     .contains(value.toLowerCase()) ||
                //                 element.kodeMarketing!
                //                     .toLowerCase()
                //                     .contains(value.toLowerCase()) ||
                //                 element.kodeDesign!
                //                     .toLowerCase()
                //                     .contains(value.toLowerCase()) ||
                //                 element.tema!
                //                     .toLowerCase()
                //                     .contains(value.toLowerCase()) ||
                //                 element.jenisBarang!
                //                     .toLowerCase()
                //                     .contains(value.toLowerCase()) ||
                //                 element.estimasiHarga!
                //                     .toString()
                //                     .contains(value.toLowerCase()))
                //             .toList();

                //         setState(() {});
                //       },
                //     ),
                //   ),
                // ),
              ],
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
                                  rowsPerPage: 50,
                                  columnSpacing: 0,
                                  // ignore: deprecated_member_use
                                  columns: [
                                    // no
                                    const DataColumn(
                                      label: SizedBox(
                                          width: 25,
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    DataColumn(label: _verticalDivider),
                                    // kode design
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "      Kode Design",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .kodeDesign!
                                                  .toLowerCase()
                                                  .compareTo(b.kodeDesign!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .kodeDesign!
                                                  .toLowerCase()
                                                  .compareTo(a.kodeDesign!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    // kode mdbc
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "      Kode MDBC",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .kodeDesignMdbc!
                                                  .toLowerCase()
                                                  .compareTo(b.kodeDesignMdbc!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .kodeDesignMdbc!
                                                  .toLowerCase()
                                                  .compareTo(a.kodeDesignMdbc!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //kode marketing
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Kode Marketing",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;

                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .kodeMarketing!
                                                  .toLowerCase()
                                                  .compareTo(b.kodeMarketing!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .kodeMarketing!
                                                  .toLowerCase()
                                                  .compareTo(a.kodeMarketing!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //posisi
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 50,
                                            child: Text(
                                              "Posisi",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .photoShoot!
                                                  .compareTo(b.photoShoot!));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .photoShoot!
                                                  .compareTo(a.photoShoot!));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //status batu
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Status Batu",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;

                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .keteranganStatusBatu!
                                                  .toLowerCase()
                                                  .compareTo(b
                                                      .keteranganStatusBatu!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .keteranganStatusBatu!
                                                  .toLowerCase()
                                                  .compareTo(a
                                                      .keteranganStatusBatu!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //nama designer
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Nama Designer",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;

                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .namaDesigner!
                                                  .toLowerCase()
                                                  .compareTo(b.namaDesigner!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .namaDesigner!
                                                  .toLowerCase()
                                                  .compareTo(a.namaDesigner!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //tema
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
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
                                                  .compareTo(
                                                      b.tema!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b.tema!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.tema!.toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //jenis barang
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
                                    //brand
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 50,
                                            child: Text(
                                              "Brand",
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
                                              filterCrm!.sort((a, b) =>
                                                  a.brand!.compareTo(b.brand!));
                                              // onsortColum(columnIndex, ascending);
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) =>
                                                  b.brand!.compareTo(a.brand!));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //kelas harga
                                    const DataColumn(
                                      label: SizedBox(
                                          width: 50,
                                          child: Text(
                                            "Kelas\nHarga",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    DataColumn(label: _verticalDivider),

                                    //nama modeller
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Nama Modeller",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .namaModeller!
                                                  .toLowerCase()
                                                  .compareTo(b.namaModeller!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .namaModeller!
                                                  .toLowerCase()
                                                  .compareTo(a.namaModeller!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //tanggal out modeller
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Tanggal Out\nModeller",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .tanggalOutModeller!
                                                  .toLowerCase()
                                                  .compareTo(b
                                                      .tanggalOutModeller!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .tanggalOutModeller!
                                                  .toLowerCase()
                                                  .compareTo(a
                                                      .tanggalOutModeller!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    //tanggal in produksi
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Tanggal In\nProduksi",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .tanggalInProduksi!
                                                  .toLowerCase()
                                                  .compareTo(b
                                                      .tanggalInProduksi!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .tanggalInProduksi!
                                                  .toLowerCase()
                                                  .compareTo(a
                                                      .tanggalInProduksi!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                  ],
                                  source:
                                      // UserDataTableSource(userData: filterCrm!)),
                                      RowSource(
                                          myData: myCrm, count: myCrm!.length)),
                            ),
                          ),
                        ),
                      ),
                    )
        ],
      ),
    );
  }

  mpsProduksi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 26),
          child: const Text(
            'Master Planning Siklus',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 350,
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
                  isLoading = false;
                });
                siklus.text = item!;
                siklusDesigner = siklus.text.toString();
                _getDataBySiklus(siklus.text);
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
                textAlign: TextAlign.center,
                baseStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                dropdownSearchDecoration: InputDecoration(
                    labelText: "Pilih Siklus",
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
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
                                // ignore: deprecated_member_use
                                dataRowHeight: 200,
                                sortColumnIndex: _currentSortColumn,
                                sortAscending: sort,
                                rowsPerPage: 10,
                                columnSpacing: 0,
                                columns: [
                                  // no
                                  const DataColumn(
                                    label: SizedBox(
                                        width: 25,
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  //gambar
                                  DataColumn(
                                    label: Container(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        width: 150,
                                        child: const Text(
                                          "Gambar",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // kode mdbc
                                  DataColumn(
                                      label: const SizedBox(
                                          width: 120,
                                          child: Text(
                                            "      Kode MDBC",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      onSort: (columnIndex, _) {
                                        setState(() {
                                          _currentSortColumn = columnIndex;
                                          if (sort == true) {
                                            sort = false;
                                            filterCrm!.sort((a, b) => a
                                                .kodeDesignMdbc!
                                                .toLowerCase()
                                                .compareTo(b.kodeDesignMdbc!
                                                    .toLowerCase()));
                                          } else {
                                            sort = true;
                                            filterCrm!.sort((a, b) => b
                                                .kodeDesignMdbc!
                                                .toLowerCase()
                                                .compareTo(a.kodeDesignMdbc!
                                                    .toLowerCase()));
                                          }
                                        });
                                      }),
                                  DataColumn(label: _verticalDivider),
                                  //kode marketing
                                  DataColumn(
                                      label: const SizedBox(
                                          width: 120,
                                          child: Text(
                                            "Kode Marketing",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      onSort: (columnIndex, _) {
                                        setState(() {
                                          _currentSortColumn = columnIndex;

                                          if (sort == true) {
                                            sort = false;
                                            filterCrm!.sort((a, b) => a
                                                .kodeMarketing!
                                                .toLowerCase()
                                                .compareTo(b.kodeMarketing!
                                                    .toLowerCase()));
                                          } else {
                                            sort = true;
                                            filterCrm!.sort((a, b) => b
                                                .kodeMarketing!
                                                .toLowerCase()
                                                .compareTo(a.kodeMarketing!
                                                    .toLowerCase()));
                                          }
                                        });
                                      }),
                                  DataColumn(label: _verticalDivider),
                                  //posisi
                                  DataColumn(
                                      label: const SizedBox(
                                          width: 50,
                                          child: Text(
                                            "Posisi",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      onSort: (columnIndex, _) {
                                        setState(() {
                                          _currentSortColumn = columnIndex;
                                          if (sort == true) {
                                            sort = false;
                                            filterCrm!.sort((a, b) => a
                                                .photoShoot!
                                                .compareTo(b.photoShoot!));
                                          } else {
                                            sort = true;
                                            filterCrm!.sort((a, b) => b
                                                .photoShoot!
                                                .compareTo(a.photoShoot!));
                                          }
                                        });
                                      }),
                                  DataColumn(label: _verticalDivider),

                                  //status batu
                                  DataColumn(
                                      label: const SizedBox(
                                          width: 120,
                                          child: Text(
                                            "Status Batu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      onSort: (columnIndex, _) {
                                        setState(() {
                                          _currentSortColumn = columnIndex;

                                          if (sort == true) {
                                            sort = false;
                                            filterCrm!.sort((a, b) => a
                                                .keteranganStatusBatu!
                                                .toLowerCase()
                                                .compareTo(b
                                                    .keteranganStatusBatu!
                                                    .toLowerCase()));
                                          } else {
                                            sort = true;
                                            filterCrm!.sort((a, b) => b
                                                .keteranganStatusBatu!
                                                .toLowerCase()
                                                .compareTo(a
                                                    .keteranganStatusBatu!
                                                    .toLowerCase()));
                                          }
                                        });
                                      }),
                                  DataColumn(label: _verticalDivider),
                                  //ketrangan batu
                                  const DataColumn(
                                    label: SizedBox(
                                        width: 120,
                                        child: Text(
                                          "Keterangan Batu",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    // onSort: (columnIndex, _) {
                                    //   setState(() {
                                    //     _currentSortColumn = columnIndex;

                                    //     if (sort == true) {
                                    //       sort = false;
                                    //       filterCrm!.sort((a, b) => a
                                    //           .keteranganStatusBatu!
                                    //           .toLowerCase()
                                    //           .compareTo(b
                                    //               .keteranganStatusBatu!
                                    //               .toLowerCase()));
                                    //     } else {
                                    //       sort = true;
                                    //       filterCrm!.sort((a, b) => b
                                    //           .keteranganStatusBatu!
                                    //           .toLowerCase()
                                    //           .compareTo(a
                                    //               .keteranganStatusBatu!
                                    //               .toLowerCase()));
                                    //     }
                                    //   });
                                    // }
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  //tema
                                  DataColumn(
                                      label: const SizedBox(
                                          width: 120,
                                          child: Text(
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
                                                .compareTo(
                                                    b.tema!.toLowerCase()));
                                          } else {
                                            sort = true;
                                            filterCrm!.sort((a, b) => b.tema!
                                                .toLowerCase()
                                                .compareTo(
                                                    a.tema!.toLowerCase()));
                                          }
                                        });
                                      }),
                                  DataColumn(label: _verticalDivider),
                                  //jenis barang
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
                                  //brand
                                  DataColumn(
                                      label: const SizedBox(
                                          width: 50,
                                          child: Text(
                                            "Brand",
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
                                            filterCrm!.sort((a, b) =>
                                                a.brand!.compareTo(b.brand!));
                                            // onsortColum(columnIndex, ascending);
                                          } else {
                                            sort = true;
                                            filterCrm!.sort((a, b) =>
                                                b.brand!.compareTo(a.brand!));
                                          }
                                        });
                                      }),
                                  DataColumn(label: _verticalDivider),
                                  //kelas harga
                                  const DataColumn(
                                    label: SizedBox(
                                        width: 50,
                                        child: Text(
                                          "Kelas\nHarga",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  //tanggal in produksi
                                  DataColumn(
                                      label: const SizedBox(
                                          width: 120,
                                          child: Text(
                                            "Tanggal In\nProduksi",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      onSort: (columnIndex, _) {
                                        setState(() {
                                          _currentSortColumn = columnIndex;
                                          if (sort == true) {
                                            sort = false;
                                            filterCrm!.sort((a, b) => a
                                                .tanggalInProduksi!
                                                .toLowerCase()
                                                .compareTo(b.tanggalInProduksi!
                                                    .toLowerCase()));
                                          } else {
                                            sort = true;
                                            filterCrm!.sort((a, b) => b
                                                .tanggalInProduksi!
                                                .toLowerCase()
                                                .compareTo(a.tanggalInProduksi!
                                                    .toLowerCase()));
                                          }
                                        });
                                      }),
                                ],
                                source: RowSourceProduksi(
                                    myData: myDataProduksi,
                                    count: myDataProduksi!.length,
                                    siklus: siklusDesigner)),
                          ),
                        ),
                      ),
                    ),
                  )
      ],
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
      return recentFileDataRow(myData![index], index);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data, var i) {
    // ignore: prefer_interpolation_to_compose_strings
    return DataRow(cells: [
      //No
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((i + 1).toString()),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //kode design
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.kodeDesign),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //kode mdbc
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.kodeDesignMdbc),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //kode marketing
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.kodeMarketing),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //posisi
      DataCell(Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data.posisi),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            content: SizedBox(
                                height: 150,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(children: [
                                      const Text(
                                        'Pilih Posisi',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Casting");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Casting",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Casting",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(data.id, "BRJ");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "BRJ",
                                                  "Unknown");

                                              Navigator.pop(context);
                                              // Navigator.push(
                                              //           context,
                                              //           MaterialPageRoute(
                                              //               builder: (c) =>
                                              //                   const MainView()));
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate\n Tekan refresh di pojok kanan atas untuk update data',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "BRJ",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                    ]))));
                      });
                },
                icon: const Icon(
                  Icons.change_circle,
                  color: Colors.blue,
                )),
          ],
        );
      })),
      DataCell(_verticalDivider),
      //status batu
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.keteranganStatusBatu)),
      ),
      DataCell(_verticalDivider),
      //namaDesigner
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.namaDesigner)),
      ),
      DataCell(_verticalDivider),
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
      //brand
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.brand)),
      ),
      DataCell(_verticalDivider),
      //kelas harga
      DataCell(
        Container(
            width: 100,
            padding: const EdgeInsets.all(0),
            child: ((data.estimasiHarga * 0.37) * 11500) <= 5000000
                ? const Text(
                    "XS",
                    maxLines: 2,
                  )
                : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                    ? const Text(
                        "S",
                        maxLines: 2,
                      )
                    : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
                        ? const Text(
                            "M",
                            maxLines: 2,
                          )
                        : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
                            ? const Text(
                                "L",
                                maxLines: 2,
                              )
                            : const Text(
                                "XL",
                                maxLines: 2,
                              )),
      ),
      DataCell(_verticalDivider),

      //nama modeller
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.namaModeller)),
      ),
      DataCell(_verticalDivider),

      //tanggal out modeller
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.tanggalOutModeller)),
      ),
      DataCell(_verticalDivider),

      //tanggal in produksi
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.tanggalInProduksi)),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;

  postPosisi(id, posisi) async {
    Map<String, String> body = {
      'id': id.toString(),
      'posisi': posisi.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisi}'),
        body: body);
    print(response.body);
  }

  postHistory(kodeDesignMdbc, kodeMarketing, posisi, namaArtist) async {
    Map<String, String> body = {
      'kodeDesignMdbc': kodeDesignMdbc.toString(),
      'kodeMarketing': kodeMarketing.toString(),
      'posisi': posisi.toString(),
      'namaArtis': namaArtist.toString()
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addHistoryPosisi}'),
        body: body);
    print(response.body);
  }

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

class RowSourceProduksi extends DataTableSource {
  var myData;
  final count;
  var siklus;
  RowSourceProduksi({
    required this.myData,
    required this.count,
    required this.siklus,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], index, siklus);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data, var i, var siklus) {
    // ignore: prefer_interpolation_to_compose_strings
    return DataRow(cells: [
      //No
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((i + 1).toString()),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //gambar
      DataCell(Builder(builder: (context) {
        return Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: 150,
              height: 190,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => ViewPhotoScreen(
                                model: FormDesignerModel(
                                    kodeDesignMdbc: data.kodeDesignMdbc,
                                    imageUrl: data.imageUrl),
                              )));
                },
                child: Image.network(
                  ApiConstants.baseUrlImage + data.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ));
      })),

      DataCell(_verticalDivider),
      //kode mdbc
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.kodeDesignMdbc),
                  data.namaModeller.toString().isNotEmpty
                      ? const SizedBox()
                      : Stack(
                          clipBehavior:
                              Clip.none, //agar tidak menghalangi object
                          children: [
                            //tambahan icon ADD
                            Positioned(
                              right: -5.0,
                              top: -3.0,
                              child: InkResponse(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          content: SizedBox(
                                              height: 250,
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(children: [
                                                    const Text(
                                                      'Pilih Waktu',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0))),
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog<String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Waktu telah disimpan',
                                                                      ),
                                                                    ));
                                                          },
                                                          child: const Text(
                                                            "WEEK 1",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0))),
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog<String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Waktu telah disimpan',
                                                                      ),
                                                                    ));
                                                          },
                                                          child: const Text(
                                                            "WEEK 2",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0))),
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog<String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Waktu telah disimpan',
                                                                      ),
                                                                    ));
                                                          },
                                                          child: const Text(
                                                            "WEEK 3",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0))),
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            // Navigator.push(
                                                            //           context,
                                                            //           MaterialPageRoute(
                                                            //               builder: (c) =>
                                                            //                   const MainView()));
                                                            showDialog<String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Waktu telah disimpan',
                                                                      ),
                                                                    ));
                                                          },
                                                          child: const Text(
                                                            "WEEK 4",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          )),
                                                    ),
                                                  ]))));
                                    });
                              },
                              icon: const Icon(Icons.group_add_sharp),
                              color: Colors.green,
                            ),
                          ],
                        )
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //kode marketing
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.kodeMarketing),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //posisi
      DataCell(Builder(builder: (context) {
        // String? posisi = '';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data.posisi),
            sharedPreferences!.getString('level') != '4'
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      // final dropdownFormKey = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              content: SizedBox(
                                height: 500,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Pilih Posisi',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //printing resin
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              // await postPosisi(
                                              //     data.id, "Printing Resin");
                                              // await postHistory(
                                              //     data.kodeDesignMdbc,
                                              //     data.kodeMarketing,
                                              //     "Printing Resin");
                                              // Navigator.pop(context);
                                              // showDialog<String>(
                                              //     context: context,
                                              //     builder:
                                              //         (BuildContext context) =>
                                              //             const AlertDialog(
                                              //               title: Text(
                                              //                 'Posisi Berhasil Diupdate',
                                              //               ),
                                              //             ));
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      content: SizedBox(
                                                        height: 500,
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: Column(
                                                            children: [
                                                              const Text(
                                                                'Pilih Artis',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              //A
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            15),
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors
                                                                                .blue,
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(
                                                                                    50.0))),
                                                                        onPressed:
                                                                            () async {
                                                                          await postPosisi(
                                                                              data.id,
                                                                              "Printing Resin");
                                                                          await postHistory(
                                                                              data.kodeDesignMdbc,
                                                                              data.kodeMarketing,
                                                                              "Printing Resin",
                                                                              "Unknown A");
                                                                          Navigator.pop(
                                                                              context);
                                                                          showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => const AlertDialog(
                                                                                    title: Text(
                                                                                      'Posisi Berhasil Diupdate',
                                                                                    ),
                                                                                  ));
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "A",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        )),
                                                              ),
                                                              //B
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            15),
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors
                                                                                .blue,
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(
                                                                                    50.0))),
                                                                        onPressed:
                                                                            () async {
                                                                          await postPosisi(
                                                                              data.id,
                                                                              "Finishing Resin");
                                                                          await postHistory(
                                                                              data.kodeDesignMdbc,
                                                                              data.kodeMarketing,
                                                                              "Printing Resin",
                                                                              "Unknown B");
                                                                          Navigator.pop(
                                                                              context);
                                                                          showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => const AlertDialog(
                                                                                    title: Text(
                                                                                      'Posisi Berhasil Diupdate',
                                                                                    ),
                                                                                  ));
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "B",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: const Text(
                                              "Printing Resin",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Finishing resin
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Finishing Resin");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Finishing Resin",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Finishing Resin",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Casting
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Casting");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Casting",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Casting",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Finishing
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Finishing");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Finishing",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Finishing",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Poleshing 1
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Poleshing 1");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Poleshing 1",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Poleshing 1",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Stell 1
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Stell 1");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Stell 1",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Stell 1",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Stell 2
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Stell 2");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Stell 2",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Stell 2",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Poleshing 2
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Poleshing 2");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Poleshing 2",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Poleshing 2",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Pasang Batu
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Pasang Batu");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Pasang Batu",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Pasang Batu",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),
                                      //Chrome
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0))),
                                            onPressed: () async {
                                              await postPosisi(
                                                  data.id, "Chrome");
                                              await postHistory(
                                                  data.kodeDesignMdbc,
                                                  data.kodeMarketing,
                                                  "Chrome",
                                                  "Unknown");
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const AlertDialog(
                                                            title: Text(
                                                              'Posisi Berhasil Diupdate',
                                                            ),
                                                          ));
                                            },
                                            child: const Text(
                                              "Chrome",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                      ),

                                      // Form(
                                      //     key: dropdownFormKey,
                                      //     child: Column(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       children: [
                                      //         DropdownSearch<String>(
                                      //           items: const [
                                      //             "Printing Resin",
                                      //             "Finishing Resin",
                                      //             "Casting",
                                      //             "Finishing",
                                      //             "Poleshing 1",
                                      //             "Stell 1",
                                      //             "Stell 2",
                                      //             "Poleshing 2",
                                      //             "Chrome",
                                      //             "Pasang Batu",
                                      //           ],
                                      //           dropdownDecoratorProps:
                                      //               DropDownDecoratorProps(
                                      //             dropdownSearchDecoration:
                                      //                 InputDecoration(
                                      //               hintText: 'Pilih Posisi',
                                      //               filled: true,
                                      //               fillColor:
                                      //                   Colors.grey.shade200,
                                      //               enabledBorder:
                                      //                   OutlineInputBorder(
                                      //                 borderSide:
                                      //                     const BorderSide(
                                      //                         color: Colors.black,
                                      //                         width: 2),
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(
                                      //                         20),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           onChanged: (String? newValue) {
                                      //             posisi = newValue;
                                      //           },
                                      //         ),
                                      //         Container(
                                      //           padding: const EdgeInsets.only(
                                      //               top: 20),
                                      //           child: ElevatedButton(
                                      //               onPressed: () async {
                                      //                 if (dropdownFormKey
                                      //                     .currentState!
                                      //                     .validate()) {
                                      //                   // ? method untuk mengganti posisi
                                      //                   await postPosisi(
                                      //                       data.id, posisi);
                                      //                   await postHistory(
                                      //                       data.kodeDesignMdbc,
                                      //                       data.kodeMarketing,
                                      //                       posisi);
                                      //                   Navigator.pop(context);
                                      //                   showDialog<String>(
                                      //                       context: context,
                                      //                       builder: (BuildContext
                                      //                               context) =>
                                      //                           const AlertDialog(
                                      //                             title: Text(
                                      //                               'Posisi Berhasil Diupdate',
                                      //                             ),
                                      //                           ));
                                      //                 }
                                      //               },
                                      //               child: const Text(
                                      //                 "Submit",
                                      //                 style: TextStyle(
                                      //                   fontSize: 24,
                                      //                 ),
                                      //               )),
                                      //         )
                                      //       ],
                                      //     ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.change_circle,
                    )),
          ],
        );
      })),
      DataCell(_verticalDivider),
      //status batu
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.keteranganStatusBatu)),
      ),
      DataCell(_verticalDivider),
      //keterangan batu
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.keteranganStatusBatu)),
      ),
      DataCell(_verticalDivider),
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
      //brand
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.brand)),
      ),
      DataCell(_verticalDivider),
      //kelas harga
      DataCell(
        Container(
            width: 100,
            padding: const EdgeInsets.all(0),
            child: ((data.estimasiHarga * 0.37) * 11500) <= 5000000
                ? const Text(
                    "XS",
                    maxLines: 2,
                  )
                : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                    ? const Text(
                        "S",
                        maxLines: 2,
                      )
                    : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
                        ? const Text(
                            "M",
                            maxLines: 2,
                          )
                        : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
                            ? const Text(
                                "L",
                                maxLines: 2,
                              )
                            : const Text(
                                "XL",
                                maxLines: 2,
                              )),
      ),
      DataCell(_verticalDivider),
      //tanggal in produksi
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.tanggalInProduksi)),
      ),
    ]);
  }

  postPosisi(id, posisi) async {
    Map<String, String> body = {
      'id': id.toString(),
      'posisi': posisi.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisi}'),
        body: body);
    print(response.body);
  }

  postHistory(kodeDesignMdbc, kodeMarketing, posisi, namaArtist) async {
    Map<String, String> body = {
      'kodeDesignMdbc': kodeDesignMdbc.toString(),
      'kodeMarketing': kodeMarketing.toString(),
      'posisi': posisi.toString(),
      'namaArtis': namaArtist.toString()
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addHistoryPosisi}'),
        body: body);
    print(response.body);
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
