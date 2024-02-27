// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_addPR.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/widgets/loading_widget.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
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
  }

  refresh() async {
    print('refresh state');
    setState(() {
      isLoading = true;
    });
    await _getData();
    setState(() {
      isLoading = false;
    });
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
      data.sort((a, b) => b.created_at!.compareTo(a.created_at!));

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

      var dataList = jsonResponse
          .map((dataList) => ListItemPRModel.fromJson(dataList))
          .toList();

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
                                          onRowPressed: () {
                                            refresh();
                                          }, //! mengirim data untuk me refresh state

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

  // tableFormPR() {
  //   ListView(children: [
  //     Container(
  //       padding: const EdgeInsets.all(15),
  //       width: MediaQuery.of(context).size.width * 0.8,
  //       child: Theme(
  //         data: ThemeData.light().copyWith(
  //             // cardColor: Theme.of(context).canvasColor),
  //             cardColor: Colors.white,
  //             hoverColor: Colors.grey.shade400,
  //             dividerColor: Colors.grey),
  //         child: PaginatedDataTable(
  //             showCheckboxColumn: false,
  //             availableRowsPerPage: const [10, 50, 100],
  //             rowsPerPage: _rowsPerPage,
  //             onRowsPerPageChanged: (value) {
  //               setState(() {
  //                 _rowsPerPage = value!;
  //               });
  //             },
  //             sortColumnIndex: _currentSortColumn,
  //             sortAscending: sort,
  //             // rowsPerPage: 25,
  //             columnSpacing: 0,
  //             columns: [
  //               //AKSI
  //               DataColumn(
  //                 label: Container(
  //                     padding: const EdgeInsets.only(left: 0),
  //                     child: const Text(
  //                       "AKSI",
  //                       style: TextStyle(
  //                           fontSize: 15, fontWeight: FontWeight.bold),
  //                     )),
  //               ),
  //               DataColumn(label: _verticalDivider),

  //               // No PR
  //               DataColumn(
  //                   label: const SizedBox(
  //                       child: Text(
  //                     "Nomor PR",
  //                     style:
  //                         TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                   )),
  //                   onSort: (columnIndex, _) {
  //                     setState(() {
  //                       _currentSortColumn = columnIndex;
  //                       if (sort == true) {
  //                         sort = false;
  //                         filterFormPR!.sort((a, b) => a.noPR!
  //                             .toLowerCase()
  //                             .compareTo(b.noPR!.toLowerCase()));
  //                       } else {
  //                         sort = true;
  //                         filterFormPR!.sort((a, b) => b.noPR!
  //                             .toLowerCase()
  //                             .compareTo(a.noPR!.toLowerCase()));
  //                       }
  //                     });
  //                   }),
  //               DataColumn(label: _verticalDivider),
  //               // vendor
  //               DataColumn(
  //                   label: const SizedBox(
  //                       child: Text(
  //                     "Vendor",
  //                     style:
  //                         TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                   )),
  //                   onSort: (columnIndex, _) {
  //                     setState(() {
  //                       _currentSortColumn = columnIndex;
  //                       if (sort == true) {
  //                         sort = false;
  //                         filterFormPR!.sort((a, b) => a.vendor!
  //                             .toLowerCase()
  //                             .compareTo(b.vendor!.toLowerCase()));
  //                       } else {
  //                         sort = true;
  //                         filterFormPR!.sort((a, b) => b.vendor!
  //                             .toLowerCase()
  //                             .compareTo(a.vendor!.toLowerCase()));
  //                       }
  //                     });
  //                   }),
  //               DataColumn(label: _verticalDivider),
  //               // notes
  //               const DataColumn(
  //                 label: SizedBox(
  //                     child: Text(
  //                   "Notes",
  //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                 )),
  //               ),

  //               DataColumn(label: _verticalDivider),
  //               // total Item
  //               const DataColumn(
  //                 label: SizedBox(
  //                     child: Text(
  //                   "Total Item",
  //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                 )),
  //               ),

  //               DataColumn(label: _verticalDivider),

  //               // Total QTY
  //               const DataColumn(
  //                 label: SizedBox(
  //                     child: Text(
  //                   "Total Qty",
  //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                 )),
  //               ),
  //               DataColumn(label: _verticalDivider),

  //               // Total Berat
  //               const DataColumn(
  //                 label: SizedBox(
  //                     child: Text(
  //                   "Total Berat",
  //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                 )),
  //               ),
  //             ],
  //             source:
  //                 // UserDataTableSource(userData: filterCrm!)),
  //                 RowSource(
  //                     onRowPressed: () {
  //                       refresh();
  //                     }, //! mengirim data untuk me refresh state
  //                     listDataPR: _listItemPR,
  //                     context: context,
  //                     myData: dataFormPR,
  //                     count: dataFormPR!.length)),
  //       ),
  //     ),
  //   ]);
  // }
}

class RowSource extends DataTableSource {
  BuildContext context;
  var myData;
  List<ListItemPRModel>? listDataPR;
  String? _selectedTime;
  final count;
  final VoidCallback onRowPressed; //* menerima data untuk me refresh screen

  double totalBeratReceive = 0.0;
  int? totalQtyReceive;

  double? totalBeratDatang;
  int? totalQtyDatang;
  RowSource({
    required this.myData,
    required this.count,
    required this.context,
    required this.listDataPR,
    required this.onRowPressed,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context, listDataPR!);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(
      var data, BuildContext context, List<ListItemPRModel>? listDataPR) {
    return DataRow(cells: [
      //Aksi
      DataCell(Builder(builder: (context) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: IconButton(
                onPressed: () {
                  totalBeratReceive = 0.0;
                  totalQtyReceive = 0;
                  var filterBynoPR = listDataPR!
                      .where((element) =>
                          element.noPr.toString().toLowerCase() ==
                          data.noPR.toString().toLowerCase())
                      .toList();
                  // for(var i=0; i< filterBynoPR.length; i++){
                  // totalBeratReceive +=  double.tryParse(filterBynoPR[i].receiveBerat!) ?? 0;
                  // }
                  showGeneralDialog(
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: false,
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
                                    content: Stack(
                                        clipBehavior: Clip.none,
                                        children: <Widget>[
                                      SizedBox(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 100,
                                                        height: 50,
                                                        child: Image.network(
                                                          '${ApiConstants.baseUrlImage}csv.png',
                                                          fit: BoxFit.scaleDown,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        'Jl. Raya Daan Mogot\nKM 21 Pergudangan Eraprima\nBlok I No.2 Batu Ceper, Tanggerang,\nBanten 15122, Tangerang',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'No. ${data.noPR}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              data.jenisForm
                                                          .toString()
                                                          .toLowerCase() ==
                                                      'retur'
                                                  ? 'TANDA TERIMA RETUR'
                                                  : 'TANDA TERIMA PEMBELIAN',
                                              style: const TextStyle(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Vendor : ${data.vendor}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  'Tanggal : ${DateFormat('dd-MMMM-yyyy').format(DateTime.parse(data.created_at))}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Lokasi  : CSV',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  'Jam : ${DateFormat('H.mm').format(DateTime.parse(data.created_at))}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxHeight: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .height *
                                                      0.4 // Sesuaikan dengan tinggi maksimum yang diinginkan
                                                  ),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: dataTableForm(
                                                    filterBynoPR,
                                                    data.jenisItem),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Diserahkan oleh,',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(height: 40),
                                                      Text('....')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Dibawa oleh,',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(height: 40),
                                                      Text('....')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Diterima oleh,',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(height: 40),
                                                      Text('....')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Diketahui oleh,',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(height: 40),
                                                      Text('....')
                                                    ],
                                                  ),
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                data.status
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'waiting'
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                data.status
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'waiting'
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color:
                                                                Colors.yellow,
                                                          ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                data.status
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'waiting'
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: IconButton(
                                                          onPressed: () async {
                                                            await _showDatePicker(
                                                                context,
                                                                data.id);
                                                            onRowPressed();
                                                          },
                                                          icon: const Icon(
                                                            Icons.send,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))));
                      });
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: data.status.toString().toLowerCase() == 'waiting'
                      ? Colors.green
                      : Colors.blue,
                ),
              ),
            ),
            data.status.toString().toLowerCase() == 'waiting'
                ? const SizedBox()
                : const Icon(
                    Icons.done,
                    color: Colors.green,
                  )
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

  dataTableForm(List<ListItemPRModel>? listData, jenisItem) {
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
        columns: columnsData(jenisItem),
        border: TableBorder.all(),
        rows: rowsData(listData, listData!.length));
  }

  List<DataColumn> columnsData(jenisItem) {
    return [
      const DataColumn(
          label: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('No'),
      ))),
      const DataColumn(
          label: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('Nama Barang / Dokumen'),
      ))),
      const DataColumn(
          label: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('Qty'),
      ))),
      const DataColumn(
          label: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('Berat\nPengajuan'),
      ))),
      const DataColumn(
          label: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('Berat\nKedatangan'),
      ))),
      const DataColumn(
          label: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('Berat\nDiterima'),
      ))),
      const DataColumn(
          label: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('Berat\nDikembalikan'),
      ))),
      jenisItem.toString().toLowerCase() == 'diamond'
          ? const DataColumn(
              label: Center(
                  child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Clarity'),
            )))
          : const DataColumn(
              label: Center(
                  child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Kadar'),
            ))),
      const DataColumn(
          label: Center(
              child: Padding(
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
              child: Center(child: Text('${i + 1}')))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].item)))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].qty)))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].berat)))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].fixBerat)))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].receiveBerat)))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: Text(
                      '${double.parse(data[i].fixBerat) - double.parse(data[i].receiveBerat)}')))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].kadar)))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(data[i].color)))),
        ]),
    ];
  }

  DateTime currentDate = DateTime.now();

  Future<void> _showDatePicker(BuildContext context, id) async {
    try {
      final pickedDate = await Future.wait([
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        ),
        Future.delayed(const Duration(
            milliseconds:
                200)), // Tambahan future untuk memberikan sedikit jeda
      ]);

      if (pickedDate.first != null) {
        print(pickedDate
            .first); // Format output pickedDate => 2021-03-10 00:00:00.000
        String formattedDate =
            DateFormat('MM/dd/yyyy').format(pickedDate.first);
        print(
            formattedDate); // Format tanggal yang diformat menggunakan paket intl => 2021-03-16
        await _showTime(formattedDate, id);
      } else {
        print("Tanggal tidak dipilih");
      }
    } catch (e) {
      print("Dialog dibatalkan");
    }
  }

  Future<void> _showTime(String tanggal, id) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // <-- SEE HERE
              onPrimary: Colors.grey, // <-- SEE HERE
              onSurface: Colors.blue, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (result != null) {
      // ignore: use_build_context_synchronously
      _selectedTime = result.format(context);
      print(_selectedTime);
      String resultDate = '$tanggal $_selectedTime';
      DateTime dateTime = DateFormat("MM/dd/yyyy hh:mm a").parse(resultDate);
      print(dateTime);
      print('tanggal kirim $dateTime');
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (c) {
            return const LoadingDialogWidget(
              message: "Please Wait...",
            );
          });
      await postStatusPR(id, dateTime);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showSimpleNotification(
        const Text(
          'Form Terkirim',
        ),
        background: Colors.green,
        duration: const Duration(seconds: 1),
      );
    } else {}
  }

  postStatusPR(id, tanggalKirim) async {
    Map<String, String> body = {
      'id': id.toString(),
      'status': 'terkirim',
      'tanggal_kirim': tanggalKirim.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateStatusPR}'),
        body: body);
    print(response.body);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
