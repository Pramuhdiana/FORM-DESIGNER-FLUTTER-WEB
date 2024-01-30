// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/form_screen.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

class ListScmScreen extends StatefulWidget {
  const ListScmScreen({super.key});
  @override
  State<ListScmScreen> createState() => _ListScmState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListScmState extends State<ListScmScreen> {
  List<String> listBulan = [
    'CANCEL',
    'JANUARI',
    'FEBRUARI',
    'MARET',
    'APRIL',
    'MEI',
    'JUNI',
    'JULI',
    'AGUSTUS',
    'SEPTEMBER',
    'OKTOBER',
    'NOVEMBER',
    'DESEMBER'
  ];
  int _rowsPerPage = 50;
  List<bool> selectedRows = [];
  List<dynamic> filteredData = [];
  TextEditingController controller = TextEditingController();
  bool sort = true;
  final int _currentSortColumn = 0;
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
                            element.bulan!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.bulan!
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
                      'List Scm',
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
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const FormScreen()));
                            },
                            label: const Text(
                              "Tambah Form List SCM",
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
                                      onRowsPerPageChanged: (value) {
                                        setState(() {
                                          _rowsPerPage = value!;
                                        });
                                      },
                                      sortAscending: sort,
                                      rowsPerPage: _rowsPerPage,
                                      columnSpacing: 0,
                                      columns: [
                                        DataColumn(
                                          label: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: const Text(
                                                "Select",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              child: Text(
                                            "Kode MDBC",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        DataColumn(label: _verticalDivider),
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
                                        const DataColumn(
                                          label: SizedBox(
                                              child: Text(
                                            "Tema",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              child: Text(
                                            "Jenis Barang",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              child: Text(
                                            "Harga",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
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
                                              padding: const EdgeInsets.only(
                                                  left: 30),
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
                                        selectedRows: selectedRows,
                                        myData: myCrm,
                                        count: myCrm!.length,
                                        listBulan: listBulan,
                                        // onSelectChanged:(bool value, int index){
                                        //   setState(() {
                                        //     selectedRows[index] = value;
                                        //   });
                                        // }
                                      )),
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
  final List<bool> selectedRows;
  var listBulan;

  RowSource({
    required this.myData,
    required this.count,
    required this.onRowPressed,
    required this.selectedRows,
    required this.listBulan,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      final data = myData[index];
      return DataRow(
          // index: index,
          // selected: selectedRows[index],
          // onSelectChanged: (value) {},
          cells: [
            //! selceted rows
            DataCell(Checkbox(value: false, onChanged: (value) {})),
            DataCell(_verticalDivider),

            //kodeDesignMdbc

            DataCell(
              Builder(builder: (context) {
                return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(data.kodeDesignMdbc));
              }),
            ),
            DataCell(_verticalDivider),
            // kodeMarketing
            DataCell(data.kodeMarketing != ''
                ? Builder(builder: (context) {
                    return Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(data.kodeMarketing));
                  })
                : FutureBuilder(
                    future: _getKodeMarketingBykodeDesign(data.kodeDesignMdbc),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('');
                      }
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.toString());
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })),
            // DataCell(
            //   Padding(
            //       padding: const EdgeInsets.all(0),
            //       child: Text(data.kodeMarketing)),
            // ),
            DataCell(_verticalDivider),

            //tema
            DataCell(
              Padding(padding: const EdgeInsets.all(0), child: Text(data.tema)),
            ),
            DataCell(_verticalDivider),

            //jenisBarang
            DataCell(
              Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(data.jenisBarang)),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )
                          : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                              ? const Text(
                                  "S",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                )
                              : ((data.estimasiHarga * 0.37) * 11500) <=
                                      20000000
                                  ? const Text(
                                      "M",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    )
                                  : ((data.estimasiHarga * 0.37) * 11500) <=
                                          35000000
                                      ? const Text(
                                          "L",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        )
                                      : const Text(
                                          "XL",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        )
                      : (data.estimasiHarga) <= 5000000
                          ? const Text(
                              "XS",
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )
                          : (data.estimasiHarga) <= 10000000
                              ? const Text(
                                  "S",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
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
                                              fontSize: 20,
                                              color: Colors.black),
                                        )
                                      : const Text(
                                          "XL",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
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
                  Text(data.bulan),
                  IconButton(
                      onPressed: () {
                        showGeneralDialog(
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            barrierDismissible: true,
                            barrierLabel: '',
                            context: context,
                            pageBuilder: (context, animation1, animation2) {
                              return const Text('');
                            },
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              return Transform.scale(
                                  scale: a1.value,
                                  child: Opacity(
                                      opacity: a1.value,
                                      child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          content: SizedBox(
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(children: [
                                                    const Text(
                                                      'Pilih bulan release',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    for (var j = 0;
                                                        j < listBulan.length;
                                                        j++)
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor: listBulan[j]
                                                                              .toString()
                                                                              .toLowerCase() ==
                                                                          'cancel'
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .blue,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50.0))),
                                                              onPressed:
                                                                  () async {
                                                                await postTanggalProduksi(
                                                                    data.id,
                                                                    listBulan[
                                                                        j]);
                                                                data.bulan == ''
                                                                    ? await postDataMps(
                                                                        myData,
                                                                        index,
                                                                        listBulan[
                                                                            j],
                                                                        context,
                                                                        'false')
                                                                    : await postDataMps(
                                                                        myData,
                                                                        index,
                                                                        listBulan[
                                                                            j],
                                                                        context,
                                                                        'true');
                                                                onRowPressed();
                                                              },
                                                              child: Text(
                                                                "${listBulan[j]}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              )))
                                                  ]))))));
                            });
                      },
                      icon: Stack(
                        clipBehavior: Clip.none, //agar tidak menghalangi object
                        children: [
                          //tambahan icon ADD
                          data.bulan == ''
                              ? Positioned(
                                  right: -10.0,
                                  top: -13.0,
                                  child: InkResponse(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          data.bulan == ''
                              ? const Icon(
                                  Icons.send,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.swap_horiz,
                                  color: Colors.blue,
                                ),
                        ],
                      ))
                ],
              );
            }))
          ]);
    } else {
      return null;
    }
  }

  postTanggalProduksi(id, release) async {
    Map<String, String> body = {
      'id': id.toString(),
      'bulan': release.toString()
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addTanggalProduksi}'),
        body: body);
    print(response.body);
  }

  postDataMps(var dumData, index, bulan, context, isUpdate) async {
    var data = dumData[index];
    print(bulan);
    print(data.imageUrl);
    Map<String, String> body = {
      'isUpdate': isUpdate,
      'id': data.id.toString(),
      'kodeDesignMdbc': data.kodeDesignMdbc.toString(),
      'kodeMarketing': data.kodeMarketing.toString(),
      'posisi': 'release',
      'tema': data.tema.toString(),
      'jenisBarang': data.jenisBarang.toString(),
      'brand': data.brand.toString(),
      'color': data.color.toString(),
      'beratEmas': data.beratEmas.toString(),
      'estimasiHarga': data.estimasiHarga.toString(),
      'ringSize': data.ringSize.toString(),
      'statusForm': data.statusForm.toString(),
      'keteranganMinggu': data.keteranganMinggu.toString(),
      'keteranganBatu': data.keteranganBatu.toString(),
      'keteranganStatusBatu': data.keteranganStatusBatu.toString(),
      'imageUrl': data.imageUrl.toString(),
      'artist': data.artist.toString(),
      'keteranganStatusAcc': 'BELUM KOMPLIT ACC',
      'rantai': data.rantai.toString(),
      'qtyRantai': data.qtyRantai.toString(),
      'lain2': data.lain2.toString(),
      'qtyLain2': data.qtyLain2.toString(),
      'earnut': data.earnut.toString(),
      'qtyEarnut': data.qtyEarnut.toString(),
      'panjangRantai': data.panjangRantai.toString(),
      'customKomponen': data.customKomponen.toString(),
      'qtyCustomKomponen': data.qtyCustomKomponen.toString(),
      'siklus': data.siklus.toString(),
      'bulan': bulan.toString(),
    };
    try {
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postDataMps}'),
          body: body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showSimpleNotification(
          const Text('Data berhasil di release'),
          background: Colors.green,
          duration: const Duration(seconds: 1),
        );
        print(response.body);
      } else {
        print('err : ${response.body}');
        Navigator.pop(context);
        showSimpleNotification(
          const Text('Error Data ()'),
          background: Colors.red,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (c) {
      print('err : $c');
      Navigator.pop(context);
      showSimpleNotification(
        Text('Error Data ($c)'),
        background: Colors.red,
        duration: const Duration(seconds: 2),
      );
    }
  }

  _getKodeMarketingBykodeDesign(kodeDesign) async {
    var kodeMarketing;
    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.getDataModellerBykodeDesign}?kodeDesign="$kodeDesign"'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      kodeMarketing = data[0]['kodeMarketing'];
      return kodeMarketing;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  // int get selectedRowCount => selectedRows.where((element) => element).length;
  int get selectedRowCount => 0;
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
