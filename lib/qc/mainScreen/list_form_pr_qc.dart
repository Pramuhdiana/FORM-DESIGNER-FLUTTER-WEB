// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/qc/mainScreen/add_form_detail_batu_qy.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
// ignore: unused_import
import 'package:intl/intl.dart';

class ListFormPrQc extends StatefulWidget {
  const ListFormPrQc({super.key});

  @override
  State<ListFormPrQc> createState() => _ListFormPrQcState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListFormPrQcState extends State<ListFormPrQc> {
  int indexDataPr = 0;
  TextEditingController controller = TextEditingController();

  List<FormPrModel>? filterFormPR;
  List<FormPrModel>? dataFormPR;
  bool isLoading = false;
  bool sort = true;
  int _currentSortColumn = 0;
  int _rowsPerPage = 10;
  bool isForm = false;

  //? variable yang di kirim

  List<ListItemPRModel>? _listItemPR;
  var dataListPR;
  String screenSizeText = "";

  @override
  initState() {
    super.initState();
    _getData();
    setFullScreen(true);
    showScreenSize();
  }

  void setFullScreen(bool isFullScreen) {
    FullScreenWindow.setFullScreen(isFullScreen);
  }

  void showScreenSize() async {
    Size logicalSize = await FullScreenWindow.getScreenSize(context);
    Size physicalSize = await FullScreenWindow.getScreenSize(null);
    setState(() {
      screenSizeText =
          "Screen size (logical pixel): ${logicalSize.width} x ${logicalSize.height}\n";
      screenSizeText +=
          "Screen size (physical pixel): ${physicalSize.width} x ${physicalSize.height}\n";
    });
  }

  refresh() async {
    setState(() {
      isForm = !isForm;
      _getData();
    });
  }

  _getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http
          .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getFormPR}'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        var data =
            jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();
        var filterByStatus = data
            .where((element) =>
                element.status == 'qc' || element.status == 'qc review')
            .toList();
        // data.where((element) => element.status == 'qc' || element.status == 'selesai' ).toList();
        data = filterByStatus;
        setState(() {
          filterFormPR = data;
          dataFormPR = data;
        });
        print('form pr oke');
      } else {
        print(response.body);
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get form PR $c');
    }
    //get listnya
    try {
      final responseList = await http.get(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));

      if (responseList.statusCode == 200) {
        List jsonResponse = json.decode(responseList.body);

        var dataList = jsonResponse
            .map((dataList) => ListItemPRModel.fromJson(dataList))
            .toList();
        setState(() {
          _listItemPR = dataList;
        });

        print('list item pr oke');
      } else {
        print(responseList.body);
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get form list item pr $c');
    }
    setState(() {
      isLoading = false;
    });
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
                onChanged: (value) {
                  dataFormPR = filterFormPR!
                      .where((element) =>
                          element.noPR!
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element.vendor!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                  setState(() {});
                },
              ),
            ),
          ),
          body: isForm == true
              ? FormDetailBatuQc(
                  dataFormPr: FormPrModel(
                    noPR: dataFormPR![indexDataPr].noPR,
                    id: dataFormPR![indexDataPr].id,
                    vendor: dataFormPR![indexDataPr].vendor,
                    created_at: dataFormPR![indexDataPr].created_at,
                    tanggalInQc: dataFormPR![indexDataPr].tanggalInQc,
                    fixTotalQty: dataFormPR![indexDataPr].fixTotalQty,
                    fixTotalBerat: dataFormPR![indexDataPr].fixTotalBerat,
                  ),
                  //* hints untuk menerima isform close jika ada yang panggil oncloseform
                  onCloseForm: () {
                    setState(() {
                      refresh();
                    });
                  },
                )
              : Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 26),
                          child: const Text(
                            'List Qc',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                        ),
                        isLoading == true
                            ? Expanded(
                                child: Center(
                                    child: Container(
                                padding: const EdgeInsets.all(5),
                                width: 90,
                                height: 90,
                                child:
                                    Lottie.asset("loadingJSON/loadingV1.json"),
                              )))
                            : Expanded(
                                child: ListView(children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: const Text(
                                                "AKSI",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                _currentSortColumn =
                                                    columnIndex;
                                                if (sort == true) {
                                                  sort = false;
                                                  filterFormPR!.sort((a, b) => a
                                                      .noPR!
                                                      .toLowerCase()
                                                      .compareTo(b.noPR!
                                                          .toLowerCase()));
                                                } else {
                                                  sort = true;
                                                  filterFormPR!.sort((a, b) => b
                                                      .noPR!
                                                      .toLowerCase()
                                                      .compareTo(a.noPR!
                                                          .toLowerCase()));
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
                                                _currentSortColumn =
                                                    columnIndex;
                                                if (sort == true) {
                                                  sort = false;
                                                  filterFormPR!.sort((a, b) => a
                                                      .vendor!
                                                      .toLowerCase()
                                                      .compareTo(b.vendor!
                                                          .toLowerCase()));
                                                } else {
                                                  sort = true;
                                                  filterFormPR!.sort((a, b) => b
                                                      .vendor!
                                                      .toLowerCase()
                                                      .compareTo(a.vendor!
                                                          .toLowerCase()));
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
                                        // Total qty diterima
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              child: Text(
                                            "Total Qty Diterima",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        // Total Berat diterima
                                        DataColumn(label: _verticalDivider),
                                        const DataColumn(
                                          label: SizedBox(
                                              child: Text(
                                            "Total Berat Diterima",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ],

                                      source:
                                          // UserDataTableSource(userData: filterCrm!)),
                                          RowSource(
                                              onRowPressed: (int i) {
                                                setState(() {
                                                  indexDataPr = i;
                                                });
                                                print('select $indexDataPr');
                                                refresh();
                                              }, //! mengirim data untuk me refresh state
                                              indexDataPr: indexDataPr,
                                              listDataPR: _listItemPR,
                                              context: context,
                                              myData: dataFormPR,
                                              count: dataFormPR!.length),
                                    ),
                                  ),
                                )
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
                      onRowPressed: (int i) {
                        setState(() {
                          indexDataPr = i;
                        });
                        print('select $indexDataPr');
                        refresh();
                      },
                      indexDataPr: indexDataPr,
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
  final void Function(int)
      onRowPressed; //* menerima data untuk me refresh screen
  BuildContext context;
  var myData;
  List<ListItemPRModel>? listDataPR;
  final count;
  int indexDataPr; // Variabel untuk menyimpan indeks baris yang dipilih
  RowSource({
    required this.myData,
    required this.count,
    required this.context,
    required this.listDataPR,
    required this.onRowPressed,
    required this.indexDataPr,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context, listDataPR!, index);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data, BuildContext context,
      List<ListItemPRModel>? listDataPR, index) {
    return DataRow(cells: [
      //Aksi
      DataCell(Builder(builder: (context) {
        return Row(
          children: [
            data.status.toString().toLowerCase() == 'selesai'
                ? Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: IconButton(
                      onPressed: () {
                        onRowPressed(index);
                      },
                      icon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.green,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: IconButton(
                      onPressed: () {
                        onRowPressed(index);
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
      DataCell(_verticalDivider),
      //fixTotalQty
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.fixTotalQty)),
      ),
      DataCell(_verticalDivider),
      //fixTotalBerat
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.fixTotalBerat)),
      ),
    ]);
  }

  // dataTableForm(List<ListItemPRModel>? listData) {
  //   return DataTable(
  //       headingTextStyle:
  //           const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  //       headingRowColor:
  //           MaterialStateProperty.resolveWith((states) => Colors.black54),
  //       dataRowColor:
  //           MaterialStateProperty.resolveWith((states) => Colors.white),
  //       columnSpacing: 0,
  //       headingRowHeight: 50,
  //       // dataRowMaxHeight: 50,
  //       columns: columnsData(),
  //       border: TableBorder.all(),
  //       rows: rowsData(listData, listData!.length));
  // }

  // List<DataColumn> columnsData() {
  //   return [
  //     const DataColumn(
  //         label: Center(
  //             child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Text('No'),
  //     ))),
  //     const DataColumn(
  //         label: Center(
  //             child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Text('Nama Barang / Dokumen'),
  //     ))),
  //     const DataColumn(
  //         label: Center(
  //             child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Text('Qty'),
  //     ))),
  //     const DataColumn(
  //         label: Center(
  //             child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Text('Berat'),
  //     ))),
  //     const DataColumn(
  //         label: Center(
  //             child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Text('Kadar'),
  //     ))),
  //     const DataColumn(
  //         label: Center(
  //             child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Text('Color'),
  //     ))),
  //   ];
  // }

  // List<DataRow> rowsData(var data, int count) {
  //   return [
  //     for (var i = 0; i < count; i++)
  //       DataRow(cells: [
  //         DataCell(Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Center(child: Text('${i + 1}')))),
  //         DataCell(Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Center(child: Text(data[i].item)))),
  //         DataCell(Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Center(child: Text(data[i].qty)))),
  //         DataCell(Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Center(child: Text(data[i].berat)))),
  //         DataCell(Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Center(child: Text(data[i].kadar)))),
  //         DataCell(Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Center(child: Text(data[i].color)))),
  //       ]),
  //   ];
  // }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
