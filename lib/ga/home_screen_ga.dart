// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/ga/list_kurir.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/pembelian/add_form_pr.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/pembelian/save_pdf_pembelian.dart';
import 'package:form_designer/widgets/loading_widget.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeScreenGa extends StatefulWidget {
  const HomeScreenGa({super.key});

  @override
  State<HomeScreenGa> createState() => _HomeScreenGaState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _HomeScreenGaState extends State<HomeScreenGa> {
  TextEditingController controller = TextEditingController();
  bool isForm = false;
  int indexDataPr = 0;

  List<FormPrModel>? filterFormPR;
  List<FormPrModel>? dataFormPR;
  bool isLoading = false;
  bool sort = true;
  int _currentSortColumn = 0;
  int _rowsPerPage = 10;
  List<ListItemPRModel>? _listItemPR;
  var dataListPR;
  String? nomorPr;
  String? mode = 'new';
  @override
  initState() {
    super.initState();
    _getData();
  }

  changeWithData() async {
    setState(() {
      isForm = !isForm;
      _getData();
    });
  }

  change() async {
    setState(() {
      isForm = !isForm;
    });
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
                onChanged: (value) {
                  dataFormPR = filterFormPR!
                      .where((element) =>
                          element.noPr!
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
              ? AddFormPr(
                  onCloseForm: () {
                    setState(() {
                      change();
                    });
                  },
                  onCloseFormLoadData: () {
                    setState(() {
                      changeWithData();
                    });
                  },
                  listItemPR: _listItemPR,
                  dataFormPR: dataFormPR,
                  nomorPr: nomorPr,
                  mode: mode)
              : Container(
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
                                        availableRowsPerPage: const [
                                          10,
                                          50,
                                          100
                                        ],
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
                                          //Tanggal Kirim
                                          DataColumn(
                                            label: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: const Text(
                                                  "Tgl.Kirim",
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterFormPR!.sort((a, b) =>
                                                        a.noPr!
                                                            .toLowerCase()
                                                            .compareTo(b.noPr!
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterFormPR!.sort((a, b) =>
                                                        b.noPr!
                                                            .toLowerCase()
                                                            .compareTo(a.noPr!
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterFormPR!.sort((a, b) =>
                                                        a.vendor!
                                                            .toLowerCase()
                                                            .compareTo(b.vendor!
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterFormPR!.sort((a, b) =>
                                                        b.vendor!
                                                            .toLowerCase()
                                                            .compareTo(a.vendor!
                                                                .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          // lokasi
                                          const DataColumn(
                                            label: SizedBox(
                                                child: Text(
                                              "Lokasi",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),

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
                                          // kurir
                                          const DataColumn(
                                            label: SizedBox(
                                                child: Text(
                                              "Kurir",
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
                                                onRowChange:
                                                    (int i, String dumNomorPr) {
                                                  setState(() {
                                                    indexDataPr = i;
                                                    nomorPr = dumNomorPr;
                                                    mode = 'edit';
                                                  });
                                                  print(
                                                      'select $indexDataPr => $dumNomorPr');
                                                  change();
                                                },
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
}

class RowSource extends DataTableSource {
  BuildContext context;
  var myData;
  List<ListItemPRModel>? listDataPR;
  String? _selectedTime;
  final count;
  final VoidCallback onRowPressed; //* menerima data untuk me refresh screen
  final void Function(int, String)
      onRowChange; //* menerima data untuk me refresh screen

  double totalBeratReceive = 0.0;
  int? totalQtyReceive;

  double? totalBeratDatang;
  int? totalQtyDatang;
  String screenSizeText = "";

  RoundedLoadingButtonController btnControllerSimpan =
      RoundedLoadingButtonController();

  RowSource({
    required this.myData,
    required this.count,
    required this.context,
    required this.listDataPR,
    required this.onRowPressed,
    required this.onRowChange,
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
      List<ListItemPRModel>? listDataPR, int index) {
    return DataRow(cells: [
      //Aksi
      DataCell(Builder(builder: (context) {
        print(data.tanggalInQc);
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: IconButton(
                onPressed: () {
                  data.kurir == ''
                      ? showCustomDialog(
                          context: context,
                          dialogType: DialogType.info,
                          title: 'INFO',
                          description: 'Isi kurir terlebih dahulu',
                        )
                      : openForm(data, listDataPR);

                  // html.window.print();
                  // showCustomDialog(
                  //     context: context,
                  //     dialogType: DialogType.success,
                  //     title: 'SUCCESS',
                  //     description: 'This is a success message!',
                  //   );
                  // var filterBynoPR = listDataPR!
                  //     .where((element) =>
                  //         element.noPr.toString().toLowerCase() ==
                  //         data.noPr.toString().toLowerCase())
                  //     .toList();
                },
                icon: const Icon(
                  Icons.print,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      })),
      DataCell(_verticalDivider),
      //Tanggal Kirim
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(DateFormat('dd/MMMM/yyyy hh:mm')
                .format(DateTime.parse(data.tanggalKirim)))),
      ),
      DataCell(_verticalDivider),
      //no PR
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.noPr)),
      ),
      DataCell(_verticalDivider),
      //vendor
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.vendor)),
      ),
      DataCell(_verticalDivider),
      //lokasi
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.lokasi)),
      ),
      DataCell(_verticalDivider),
      //notes
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.notes)),
      ),
      DataCell(_verticalDivider),
      //kurir
      DataCell(Builder(builder: (context) {
        return data.kurir != ''
            ? Row(
                children: [
                  Text(data.kurir),
                  IconButton(
                      onPressed: () {
                        addKurirForm(data.id);
                      },
                      icon: const Icon(Icons.edit))
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 0),
                child: ElevatedButton(
                  onPressed: () {
                    addKurirForm(data.id);
                  },
                  child: const Text('Pilih kurir'),
                ),
              );
      })),
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
        Padding(
          padding: const EdgeInsets.all(0),
          child: FutureBuilder<String>(
            future: getSumBerat(data.noPr),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                    ''); // Tampilkan indikator loading jika sedang menunggu hasil
                // return const CircularProgressIndicator(); // Tampilkan indikator loading jika sedang menunggu hasil
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                    snapshot.data ?? ''); // Tampilkan hasil jika tersedia
              }
            },
          ),
        ),
      ),
    ]);
  }

  void setFullScreen(bool isFullScreen) {
    FullScreenWindow.setFullScreen(isFullScreen);
  }

  void showScreenSize() async {
    Size logicalSize = await FullScreenWindow.getScreenSize(context);
    Size physicalSize = await FullScreenWindow.getScreenSize(null);
    screenSizeText =
        "Screen size (logical pixel): ${logicalSize.width} x ${logicalSize.height}\n";
    screenSizeText +=
        "Screen size (physical pixel): ${physicalSize.width} x ${physicalSize.height}\n";
  }

  openForm(var data, List<ListItemPRModel>? listDataPR) {
    setFullScreen(true);

    var filterBynoPR = listDataPR!
        .where((element) =>
            element.noPr.toString().toLowerCase() ==
            data.noPr.toString().toLowerCase())
        .toList();
    return showGeneralDialog(
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
                      content:
                          Stack(clipBehavior: Clip.none, children: <Widget>[
                    SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                                Text(
                                  'No. ${data.noPr}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            data.jenisForm.toString().toLowerCase() == 'retur'
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
                              'Sudah Diterima dalam keadaan baik dan tersegel sbb',
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
                              Text(
                                'Tanggal : ${DateFormat('dd-MMMM-yyyy').format(DateTime.parse(data.created_at))}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lokasi  : ${data.lokasi}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              Text(
                                'Jam : ${DateFormat('H.mm').format(DateTime.parse(data.created_at))}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height *
                                    0.4 // Sesuaikan dengan tinggi maksimum yang diinginkan
                                ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child:
                                  dataTableForm(filterBynoPR, data.jenisItem),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Diserahkan oleh,',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 40),
                                    data.jenisForm.toString().toLowerCase() ==
                                            'retur'
                                        ? const Text('Warehouse')
                                        : Text('${data.vendor}')
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Dibawa oleh,',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(
                                        height: 40,
                                        child: Icon(Icons.verified_outlined)),
                                    Text(data.kurir)
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Diterima oleh,',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                      child: Icon(Icons.verified_outlined),
                                    ),
                                    data.jenisForm.toString().toLowerCase() ==
                                            'retur'
                                        ? Text('${data.vendor}')
                                        : const Text('Warehouse')
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      'Diketahui oleh,',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    SizedBox(height: 40),
                                    Text('....')
                                  ],
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setFullScreen(false);
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .red, // Mengatur warna latar belakang tombol
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Memberikan radius 10
                                    ),
                                  ),
                                  child: const Text(
                                    "Batal",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setFullScreen(false);

                                    Navigator.pop(context);
                                    savePdf(data.noPr);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .yellow, // Mengatur warna latar belakang tombol
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Memberikan radius 10
                                    ),
                                  ),
                                  child: const Text(
                                    "Save PDF",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]))));
        });
  }

  savePdf(noPr) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal on tap outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Loading, please wait...',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );

    await SavePdfPembelian().generatePDFKurir(noPr);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  addKurirForm(id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController kurir = TextEditingController();

          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                      content:
                          Stack(clipBehavior: Clip.none, children: <Widget>[
                    SizedBox(
                        height: 65,
                        width: 200,
                        child: DropdownSearch<ListKurir>(
                          asyncItems: (String? filter) => getDataKurir(filter),
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            searchFieldProps: TextFieldProps(
                                controller: kurir,
                                decoration: InputDecoration(
                                  labelText: "Search..",
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);

                                        simpanKurir('yes', id, kurir.text);
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text('Success'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      )),
                                  //! end fungsi
                                )),
                            showSelectedItems: true,
                            itemBuilder: _listKurir,
                            showSearchBox: true,
                          ),
                          compareFn: (item, sItem) => item.id == sItem.id,
                          onChanged: (item) {
                            Navigator.pop(context);
                            simpanKurir('', id, item);
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        )),
                  ])));
        });
  }

  simpanKurir(String modeAdd, id, kurir) async {
    if (modeAdd == 'yes') {
      await addKurir(kurir);
    }
    await updateKurir(id, kurir);
    // ignore: use_build_context_synchronously
    onRowPressed();
    showSimpleNotification(
      const Text('Success'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  updateKurir(idUser, kurir) async {
    try {
      Map<String, String> body = {
        'type': 'updateKurir',
        'id': idUser.toString(),
        'kurir': kurir.toString(),
      };

      print(body);
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.restFullApi}'),
          body: jsonEncode(body));
      print(response.body);
    } catch (e) {
      print(e);
      // ignore: use_build_context_synchronously
      showDialogError(
        context: context,
        dialogType: DialogType.error,
        title: 'update kurir',
        description: 'Hubungi admin => $e',
      );
    }
  }

  addKurir(kurir) async {
    try {
      Map<String, String> body = {
        'type': 'addKurir',
        'kurir': kurir.toString(),
      };
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.restFullApi}'),
          body: jsonEncode(body));
      print(response.body);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialogError(
        context: context,
        dialogType: DialogType.error,
        title: 'add kurir',
        description: 'Hubungi admin => $e',
      );
    }
  }

  Future<List<ListKurir>> getDataKurir(filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListKurir,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return ListKurir.fromJsonList(data);
    }
    return [];
  }

  Future<String> getSumBerat(String noPr) async {
    double sumTotalBerat = 0.0;

    // Pastikan listDataPR tidak null
    if (listDataPR != null) {
      // Filter listDataPR berdasarkan noPr
      var filteredList = listDataPR!
          .where((element) =>
              element.noPr.toString().toLowerCase() ==
              noPr.toString().toLowerCase())
          .toList();

      // Iterasi melalui data yang difilter
      for (var item in filteredList) {
        // Periksa jika nilai berat valid
        if (item.berat != null) {
          sumTotalBerat += double.parse(item.berat!);
        }
      }
    }

    // Kembalikan hasil dengan format string yang diinginkan
    return sumTotalBerat.toStringAsFixed(3);
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
              child: Center(
                  child:
                      Text(double.parse(data[i].berat).toStringAsFixed(3))))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: Text(
                      double.parse(data[i].fixBerat).toStringAsFixed(3))))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: Text(
                      double.parse(data[i].receiveBerat).toStringAsFixed(3))))),
          DataCell(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: Text(((double.parse(data[i].fixBerat)) -
                          (double.parse(data[i].receiveBerat)))
                      .toStringAsFixed(3))))),
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

  // ignore: unused_element
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

Widget _listKurir(
  BuildContext context,
  ListKurir? item,
  bool isSelected,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(50),
          ),
    child: ListTile(
      selected: isSelected,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item?.nama ?? '',
          ),
        ],
      ),
    ),
  );
}
