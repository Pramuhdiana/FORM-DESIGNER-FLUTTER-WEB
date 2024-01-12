// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_addPR.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

class ListFormPr extends StatefulWidget {
  const ListFormPr({super.key});

  @override
  State<ListFormPr> createState() => _ListFormPrState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListFormPrState extends State<ListFormPr> {
  TextEditingController controller = TextEditingController();

  List<FormPrModel>? filterFormPR;
  List<FormPrModel>? dataFormPR;
  bool isLoading = false;
  bool sort = true;
  int _currentSortColumn = 0;
  int _rowsPerPage = 10;

  List<ListItemPRModel>? _listItemPR;
  var dataListPR;

  @override
  initState() {
    super.initState();
    _getData();
    print('init on');
  }

  _getData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getFormPR}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var data =
          jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();

      setState(() {
        filterFormPR = data;
        dataFormPR = data;
      });
    } else {
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
    //get listnya
     final responseList = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));

    if (responseList.statusCode == 200) {
      List jsonResponse = json.decode(responseList.body);

      var dataList =
          jsonResponse.map((dataList) => ListItemPRModel.fromJson(dataList)).toList();

      setState(() {
        _listItemPR = dataList;
        isLoading = false;
      });
    } else {
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
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
          backgroundColor: colorBG,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leadingWidth: 320,
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
                onChanged: (value) {},
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 26),
                    child: const Text(
                      'List PR',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    ),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      // Navigasi ke ScreenB dan tunggu hingga layar tersebut ditutup
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainViewAddPr(
                                col: 1,
                                onBackPressed: () {
                                  // Callback yang akan dijalankan saat Navigator.pop dari ScreenB
                                  // _getData();
                                  print('call back oke');
                                })),
                      );
                    },
                    label: const Text(
                      "Tambah Form PR",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  isLoading == true
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
                          Container(
                            padding: const EdgeInsets.all(15),
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
                                  onRowsPerPageChanged: (value) {
                                    setState(() {
                                      _rowsPerPage = value!;
                                    });
                                  },
                                  sortColumnIndex: _currentSortColumn,
                                  sortAscending: sort,
                                  // rowsPerPage: 25,
                                  columnSpacing: 0,
                                  columns: [
                                    //AKSI
                                    DataColumn(
                                      label: Container(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: const Text(
                                            "AKSI",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    DataColumn(label: _verticalDivider),

                                    // No PR
                                    DataColumn(
                                        label: const SizedBox(
                                            child: Text(
                                          "Nomor PR",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterFormPR!.sort((a, b) => a
                                                  .noPR!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.noPR!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterFormPR!.sort((a, b) => b
                                                  .noPR!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.noPR!.toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    // vendor
                                    DataColumn(
                                        label: const SizedBox(
                                            child: Text(
                                          "Vendor",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterFormPR!.sort((a, b) => a
                                                  .vendor!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.vendor!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterFormPR!.sort((a, b) => b
                                                  .vendor!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.vendor!.toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    // notes
                                    const DataColumn(
                                      label: SizedBox(
                                          child: Text(
                                        "Notes",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),

                                    DataColumn(label: _verticalDivider),
                                    // total Item
                                    const DataColumn(
                                      label: SizedBox(
                                          child: Text(
                                        "Total Item",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),

                                    DataColumn(label: _verticalDivider),

                                    // Total QTY
                                    const DataColumn(
                                      label: SizedBox(
                                          child: Text(
                                        "Total Qty",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    DataColumn(label: _verticalDivider),

                                    // Total Berat
                                    const DataColumn(
                                      label: SizedBox(
                                          child: Text(
                                        "Total Berat",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ],
                                  source:
                                      // UserDataTableSource(userData: filterCrm!)),
                                      RowSource(
                                        listDataPR: _listItemPR,
                                          context: context,
                                          myData: dataFormPR,
                                          count: dataFormPR!.length)),
                            ),
                          ),
                        ]))
                ]),
          )),
    );
  }

  tableFormPR() {
    ListView(children: [
      Container(
        padding: const EdgeInsets.all(15),
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
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value!;
                });
              },
              sortColumnIndex: _currentSortColumn,
              sortAscending: sort,
              // rowsPerPage: 25,
              columnSpacing: 0,
              columns: [
                //AKSI
                DataColumn(
                  label: Container(
                      padding: const EdgeInsets.only(left: 0),
                      child: const Text(
                        "AKSI",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                ),
                DataColumn(label: _verticalDivider),

                // No PR
                DataColumn(
                    label: const SizedBox(
                        child: Text(
                      "Nomor PR",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (sort == true) {
                          sort = false;
                          filterFormPR!.sort((a, b) => a.noPR!
                              .toLowerCase()
                              .compareTo(b.noPR!.toLowerCase()));
                        } else {
                          sort = true;
                          filterFormPR!.sort((a, b) => b.noPR!
                              .toLowerCase()
                              .compareTo(a.noPR!.toLowerCase()));
                        }
                      });
                    }),
                DataColumn(label: _verticalDivider),
                // vendor
                DataColumn(
                    label: const SizedBox(
                        child: Text(
                      "Vendor",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (sort == true) {
                          sort = false;
                          filterFormPR!.sort((a, b) => a.vendor!
                              .toLowerCase()
                              .compareTo(b.vendor!.toLowerCase()));
                        } else {
                          sort = true;
                          filterFormPR!.sort((a, b) => b.vendor!
                              .toLowerCase()
                              .compareTo(a.vendor!.toLowerCase()));
                        }
                      });
                    }),
                DataColumn(label: _verticalDivider),
                // notes
                const DataColumn(
                  label: SizedBox(
                      child: Text(
                    "Notes",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                ),

                DataColumn(label: _verticalDivider),
                // total Item
                const DataColumn(
                  label: SizedBox(
                      child: Text(
                    "Total Item",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                ),

                DataColumn(label: _verticalDivider),

                // Total QTY
                const DataColumn(
                  label: SizedBox(
                      child: Text(
                    "Total Qty",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                ),
                DataColumn(label: _verticalDivider),

                // Total Berat
                const DataColumn(
                  label: SizedBox(
                      child: Text(
                    "Total Berat",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                ),
              ],
              source:
                  // UserDataTableSource(userData: filterCrm!)),
                  RowSource(
                    listDataPR: _listItemPR,
                      context: context,
                      myData: dataFormPR,
                      count: dataFormPR!.length)),
        ),
      ),
    ]);
  }
}

class RowSource extends DataTableSource {
  BuildContext context;
  var myData;
  List<ListItemPRModel>? listDataPR;
  final count;
  RowSource({
    required this.myData,
    required this.count,
    required this.context,
    required this.listDataPR,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context,listDataPR!);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data, BuildContext context,List<ListItemPRModel>? listDataPR) {
    return DataRow(cells: [
      //Aksi
      DataCell(Builder(builder: (context) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: IconButton(
                onPressed: () {
                  var filterBynoPR = listDataPR!.where((element) => element.noPr.toString().toLowerCase() == data.noPR.toString().toLowerCase()).toList();
                  showGeneralDialog(
              transitionDuration: const Duration(milliseconds: 200),
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
                        child:   AlertDialog(
                            content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                              SizedBox(
                                child: Column(
                                mainAxisSize: MainAxisSize.min,

                                  children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                            'Jl. Raya Daan Mogot\nKM 21 Pergudangan Eraprima\nBlok I No.2 Batu Ceper, Tanggerang,\nBanten 15122, Tangerang',
                                            style: TextStyle(
                                                color: Colors.black,
                                               
                                                fontSize: 12),
                                                                            ),
                                                                              Text(
                                          'NO PR-0011',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                    ),
                                          ],
                                        ),
                                      ),
                                    const Text(
                                      'TANDA TERIMA',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                     const Align(
                                      alignment: Alignment.topLeft,
                                       child: Text(
                                        'Sudah Diterima dengan rincian sbb',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                                                         ),
                                     ),
                                      Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(
                                          'Vendor : ${data.vendor}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                    ),
                                       const Text(
                                          'Tanggal : 12 - Januari - 2023',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                    ),
                                       ],
                                     ),
                                       const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(
                                          'Lokasi  : CSV',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                    ),
                                       Text(
                                          'Jam : 16.00',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                    ),
                                       ],
                                     ),
                                 dataTableForm(filterBynoPR),
                                  ],
                                ),
                              )
                            ]))));
              });
                },
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: IconButton(
                onPressed: () {
                   showSimpleNotification(
            const Text(
              'Form Terkirim',
            ),
            background: Colors.green,
            duration: const Duration(seconds: 1),
          );
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      })),

      DataCell(_verticalDivider),
      //no PR
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.noPR)),
      ),
      DataCell(_verticalDivider),
      //vendor
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.vendor)),
      ),
      DataCell(_verticalDivider),
      //notes
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.notes)),
      ),
      DataCell(_verticalDivider),
      //totalItem
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.totalItem)),
      ),
      DataCell(_verticalDivider),
      //totalQty
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.totalQty)),
      ),
      DataCell(_verticalDivider),
      //totalBerat
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.totalBerat)),
      ),
    ]);
  }

 dataTableForm(List<ListItemPRModel>? listData) {
    return DataTable(
        headingTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.black54),
        dataRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.white),
        columnSpacing: 0,
        headingRowHeight: 50,
        // dataRowMaxHeight: 50,
        columns: columnsData(),
        border: TableBorder.all(),
        rows: rowsData(listData,listData!.length));
  }
  List<DataColumn> columnsData() {
    return [
       const DataColumn(
          label: Center(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('No'),
          ))),
      const DataColumn(
          label: Center(child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Nama Barang / Dokumen'),
          ))),
              const DataColumn(
          label: Center(child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Qty'),
          ))),
              const DataColumn(
          label: Center(child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Berat'),
          ))),
          const DataColumn(
          label: Center(child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Kadar'),
          ))),
          const DataColumn(
          label: Center(child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Color'),
          ))),
    ];
  }
  List<DataRow> rowsData(var data, int count) {
    return [
      for (var i = 0; i < count; i++)
        DataRow(cells: [
            DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text('$i')))),
               DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].item)))),
          DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].qty)))),
               DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
              child:  Center(child: Text(data[i].berat)))),
                DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
              child:  Center(child: Text(data[i].kadar)))),
                DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
              child:  Center(child: Text(data[i].color)))),
        ]),
    ];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
