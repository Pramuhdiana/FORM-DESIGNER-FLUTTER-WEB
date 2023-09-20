// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/global/currency_format.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../api/api_constant.dart';
import '../model/estimasi_pricing_model.dart';

class ListStatusApprovalScreen extends StatefulWidget {
  const ListStatusApprovalScreen({super.key});
  @override
  State<ListStatusApprovalScreen> createState() =>
      _ListStatusApprovalScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListStatusApprovalScreenState extends State<ListStatusApprovalScreen> {
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

      var filterBySiklus = g.where(
          (element) => element.statusApproval.toString().toLowerCase() != '0');

      g = filterBySiklus.toList();
      setState(() {
        filterCrm = g;
        myCrm = g;
        myCrm!.sort((a, b) => a.statusApproval!
            .compareTo(b.statusApproval!)); //!fungsi untuk sort data
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
                "LIST STATUS APPROVAL",
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
            body: Container(
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
                                  element.diambilId!
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  element.namaSales!
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
                                                width: 80,
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
                                                  filterCrm!.sort((a, b) => a
                                                      .diambilId!
                                                      .compareTo(b.diambilId!));
                                                } else {
                                                  sort = true;
                                                  filterCrm!.sort((a, b) => b
                                                      .diambilId!
                                                      .compareTo(a.diambilId!));
                                                }
                                              });
                                            }),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                            label: const SizedBox(
                                                width: 150,
                                                child: Text(
                                                  "NAMA PEMOHON",
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
                                                      .namaSales!
                                                      .toLowerCase()
                                                      .compareTo(b.namaSales!
                                                          .toLowerCase()));
                                                } else {
                                                  sort = true;
                                                  filterCrm!.sort((a, b) => b
                                                      .namaSales!
                                                      .toLowerCase()
                                                      .compareTo(a.namaSales!
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
                                                  "STATUS",
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
                                                      .statusApproval!
                                                      .compareTo(
                                                          b.statusApproval!));
                                                } else {
                                                  sort = true;
                                                  filterCrm!.sort((a, b) => b
                                                      .statusApproval!
                                                      .compareTo(
                                                          a.statusApproval!));
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
                                        //approval harga
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 130,
                                              child: Text(
                                                "HARGA APPROVE",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        //note approve
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              width: 130,
                                              child: Text(
                                                "NOTE APPROVE",
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
                          ),
                        )
                ],
              ),
            ),
          )),
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
      //diambil id
      DataCell(
        Container(
            width: 50,
            padding: const EdgeInsets.all(0),
            child: Text(data.diambilId.toString())),
      ),
      DataCell(_verticalDivider),
      //Nama sales
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.namaSales)),
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
            child: data.statusApproval == '1'
                ? Text("Waiting - ${data.jenisPengajuan}")
                : const Text("Approved")),
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
      DataCell(_verticalDivider),
      //approval harga
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.approvalHarga == '0'
                    ? "0"
                    : data.brand == "BELI BERLIAN"
                        ? 'Rp. ${CurrencyFormat.convertToDollar(int.parse(data.approvalHarga), 0)}'
                        : data.brand == "METIER"
                            ? 'Rp. ${CurrencyFormat.convertToDollar(int.parse(data.approvalHarga), 0)}'
                            : '\$ ${CurrencyFormat.convertToDollar(int.parse(data.approvalHarga), 0)}',
                textAlign: TextAlign.center,
              ),
            )),
      ),
      //note
      DataCell(_verticalDivider),
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.noteApprove.toString())),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
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
