// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/calculatePricing/list_calculate_pricing_screen.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/view_photo_mps.dart';
import 'package:form_designer/model/list_mps_model.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class OrulScreen extends StatefulWidget {
  const OrulScreen({super.key});
  @override
  State<OrulScreen> createState() => _OrulScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _OrulScreenState extends State<OrulScreen> {
  var nowSiklus = '';
  var nowBulan = '';
  final int _currentSortColumn = 0;

  List<ListMpsModel>? filterDataOrul;
  List<ListMpsModel>? listDataOrul;

  int _rowsPerPage = 10;
  bool sort = true;
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    // nowSiklus = sharedPreferences!.getString('siklus')!;
    nowSiklus = month;
    _get(nowSiklus);
  }

  _getData(chooseSiklus) async {
    // ignore: avoid_print
    print('getdata orul $chooseSiklus');
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getListMpsBySiklus}?siklus=$chooseSiklus'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var alldata =
          jsonResponse.map((data) => ListMpsModel.fromJson(data)).toList();

      var filterByOrul = alldata.where((element) =>
          element.statusBackPosisi.toString().toLowerCase() == 'orul');

      alldata = filterByOrul.toList();
      setState(() {
        listDataOrul = alldata.toList();
        filterDataOrul = alldata.toList();
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _get(chooseSiklus) async {
    setState(() {
      isLoading == true;
    });
    await _getData(chooseSiklus);
    setState(() {
      isLoading == false;
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
              backgroundColor: colorBG,
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
                        "Bulan saat ini : $nowSiklus",
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade700),
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
                      // myDataProduksi = filterDataProduksi!
                      //     .where((element) =>
                      //         element.kodeDesignMdbc!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.posisi!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.brand!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.statusForm!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.kodeMarketing!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.tema!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.jenisBarang!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.keteranganBatu!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.keteranganStatusBatu!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.artist!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.keteranganStatusAcc!
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()) ||
                      //         element.estimasiHarga!
                      //             .toString()
                      //             .contains(value.toLowerCase()))
                      //     .toList();

                      setState(() {});
                    },
                  ),
                ),
                centerTitle: true,
              ),
              body: listOrul())),
    );
  }

  listOrul() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 26, left: 20),
            child: const Text(
              'List Orul',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 350,
                  child: DropdownSearch<String>(
                    items: namaBulan,
                    onChanged: (item) async {
                      setState(() {
                        isLoading = true;
                      });
                      nowBulan = item!;
                      // print(siklusDesigner);
                      // await _getDataBySiklusProduksi(
                      //     siklusDesigner, pilihWeek, pilihJenisBarang);
                      // await _getListSubDivisi();
                      setState(() {
                        isLoading = false;
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
                          labelText: "Pilih Bulan",
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          nowBulan.isEmpty
              ? Center(
                  child: Column(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 210,
                      child: Lottie.asset("loadingJSON/selectDate.json"),
                    ),
                    const Text(
                      'Pilih bulan terlebih dahulu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Acne',
                          letterSpacing: 1.5),
                    ),
                  ],
                ))
              : isLoading == true
                  ? Expanded(
                      child: Center(
                          child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 90,
                      height: 90,
                      child: Lottie.asset("loadingJSON/loadingV1.json"),
                    )))
                  : Expanded(
                      child: ListView(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Theme(
                          data: ThemeData.light().copyWith(
                              // cardColor: Theme.of(context).canvasColor),
                              cardColor: Colors.white,
                              hoverColor: Colors.grey.shade400,
                              dividerColor: Colors.grey),
                          child: PaginatedDataTable(
                            showCheckboxColumn: false,
                            availableRowsPerPage: const [10, 50, 100],
                            rowsPerPage: _rowsPerPage,
                            dataRowMaxHeight: 150,
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                isLoading == false;
                              });
                              _rowsPerPage = value!;
                              setState(() {
                                isLoading == true;
                              });
                            },
                            sortColumnIndex: _currentSortColumn,
                            sortAscending: sort,
                            // rowsPerPage: 25,
                            columnSpacing: 0,
                            columns: [
                              // no
                              const DataColumn(
                                label: SizedBox(
                                    child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              DataColumn(label: _verticalDivider),
                              // gambar
                              const DataColumn(
                                label: SizedBox(
                                    child: Text(
                                  "Gambar",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              DataColumn(label: _verticalDivider),
                              // kode MDBC
                              const DataColumn(
                                label: SizedBox(
                                    child: Text(
                                  "Kode\nMDBC",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              DataColumn(label: _verticalDivider),
                              // kode Marketing
                              const DataColumn(
                                label: SizedBox(
                                    child: Text(
                                  "Kode Marketing",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              DataColumn(label: _verticalDivider),
                              // keterangan
                              const DataColumn(
                                label: SizedBox(
                                    child: Text(
                                  "Keterangan",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                            source: RowSourceOrul(
                                listOrul: listDataOrul,
                                countOrul: listDataOrul!.length),
                          ),
                        ),
                      )
                    ]))
        ]);
  }
}

class RowSourceOrul extends DataTableSource {
  var listOrul;
  final countOrul;

  RowSourceOrul({
    required this.listOrul,
    required this.countOrul,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(listOrul![index], index);
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
      //gambar
      DataCell(Builder(builder: (context) {
        return Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: 100,
              height: 140,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => ViewPhotoMpsScreen(
                                modelMps: ListMpsModel(
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
      //keterangan
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.keteranganBackPosisi),
                ],
              ));
        }),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => countOrul;

  @override
  int get selectedRowCount => 0;
}
