// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/pembelian/export_pembelian.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/qc/modelQc/itemQcModel.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeScreenPembelian extends StatefulWidget {
  const HomeScreenPembelian({super.key});

  @override
  State<HomeScreenPembelian> createState() => _HomeScreenPembelianState();
}

TextEditingController controller = TextEditingController();

class _HomeScreenPembelianState extends State<HomeScreenPembelian> {
  bool isLoading = false;

  RoundedLoadingButtonController btnControllerBatal =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerSimpan =
      RoundedLoadingButtonController();
  List<FormPrModel>? filterFormPR;
  List<FormPrModel>? dataFormPR;
  List<ItemQcModel>? _listDetailItemQc;
  List<List<String>> selectListItemRound = [];
  List<List<String>> selectListItemFancy = [];
  String? dumItem = '';
  String? dumQty = '';
  String? dumBerat = '';
  String? dumKadar = '';
  String? dumColor = '';
  String? dumDiterima = '';
  double totalBerat = 0.0;
  int totalQty = 0;

  @override
  initState() {
    super.initState();
    _getData();
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
      var filterByStatus = data
          .where((element) =>
              element.status == 'selesai' || element.jenisItem == 'diamond')
          .toList();
      data = filterByStatus;
      //* hints Urutkan data berdasarkan tanggal terlama
      // data.sort((a, b) => a.tanggalSelesai!.compareTo(b.tanggalSelesai!));
      //? Sekarang, data sudah diurutkan berdasarkan tanggal terlama

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
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getItemQc}'));

    if (responseList.statusCode == 200) {
      List jsonResponse = json.decode(responseList.body);

      var dataList = jsonResponse
          .map((dataList) => ItemQcModel.fromJson(dataList))
          .toList();

      setState(() {
        _listDetailItemQc = dataList;
        isLoading = false;
      });
    } else {
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
    setState(() {
      isLoading = false;
    });
  }

  final List<String> items = List.generate(20, (index) => "Item $index");

  dataTableForm(List<ItemQcModel>? listData, String status, String jenisItem) {
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
        columns: columnsData(jenisItem, status),
        border: TableBorder.all(),
        rows: rowsData(listData, listData!.length, () {
          setState(() {});
        }, jenisItem));
  }

  List<DataColumn> columnsData(jenisItem, status) {
    return jenisItem.toString().toLowerCase() == 'round'
        ? [
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
              child: Text('Ukuran Batu Round'),
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
              child: Text('Berat'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Jenis Batu'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Kualitas Batu'),
            ))),
          ]
        : [
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
              child: Text('Kode Mdbc'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Ukuran'),
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
              child: Text('Berat'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Jenis Batu'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Kualitas Batu'),
            ))),
          ];
  }

  List<DataRow> rowsData(
      var data, int count, Function() onChangedCallback, jenisItem) {
    return jenisItem.toString().toLowerCase() == 'round'
        ? [
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
                    child: Center(child: Text(data[i].jenisBatu)))),
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(data[i].kualitasBatu)))),
              ]),
          ]
        : [
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
                    child: Center(
                        child:
                            Text('${data[i].panjang} x ${data[i].lebar} ')))),
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(data[i].qty)))),
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(data[i].berat)))),
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(data[i].jenisBatu)))),
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(data[i].kualitasBatu)))),
              ]),
          ];
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
            body: isLoading == true
                ? Center(
                    child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 90,
                    height: 90,
                    child: Lottie.asset("loadingJSON/loadingV1.json"),
                  ))
                : dataFormPR!.isEmpty
                    ? const Center(
                        child: Text('Tidak ada data'),
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        return StaggeredGridView.countBuilder(
                          crossAxisCount: constraints.maxWidth < 900
                              ? 1
                              : 2, // dua item per baris
                          itemCount: dataFormPR!.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              selectListItemRound.clear();
                              var filterBynoPR = _listDetailItemQc!
                                  .where((element) =>
                                      element.noQc.toString().toLowerCase() ==
                                      dataFormPR![index]
                                          .noQc
                                          .toString()
                                          .toLowerCase())
                                  .toList();

                              for (var i = 0; i < filterBynoPR.length; i++) {
                                selectListItemRound.add([
                                  filterBynoPR[i].id.toString(),
                                  filterBynoPR[i].item!,
                                  filterBynoPR[i].qty!,
                                  filterBynoPR[i].berat!,
                                  filterBynoPR[i].panjang!,
                                  filterBynoPR[i].lebar!,
                                  filterBynoPR[i].jenisBatu!,
                                  filterBynoPR[i].kualitasBatu!,
                                ]);
                              }
                              print(selectListItemRound);
                              showGeneralDialog(
                                  transitionDuration:
                                      const Duration(milliseconds: 200),
                                  barrierDismissible: false,
                                  barrierLabel: '',
                                  context: context,
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return const Text('');
                                  },
                                  barrierColor: Colors.black.withOpacity(0.75),
                                  transitionBuilder: (context, a1, a2, widget) {
                                    return Transform.scale(
                                        scale: a1.value,
                                        child: Opacity(
                                            opacity: a1.value,
                                            child: StatefulBuilder(
                                              builder: (context, setState) =>
                                                  AlertDialog(
                                                      content: Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: <Widget>[
                                                    SizedBox(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          50,
                                                                      child: Image
                                                                          .network(
                                                                        '${ApiConstants.baseUrlImage}csv.png',
                                                                        fit: BoxFit
                                                                            .scaleDown,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    const Text(
                                                                      'Jl. Raya Daan Mogot\nKM 21 Pergudangan Eraprima\nBlok I No.2 Batu Ceper, Tanggerang,\nBanten 15122, Tangerang',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Text(
                                                            'TANDA TERIMA QUALITY CONTROL',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22),
                                                          ),
                                                          Text(
                                                            'No. ${dataFormPR![index].noQc}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                          const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Sudah Diterima dengan rincian sbb',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Vendor : ${dataFormPR![index].vendor}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                'Tanggal selesai : ${DateFormat('dd-MMMM-yyyy').format(DateTime.parse(dataFormPR![index].tanggalSelesai!))}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
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
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                'Jam : ${DateFormat('H.mm').format(DateTime.parse(dataFormPR![index].tanggalSelesai!))}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
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
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: dataTableForm(
                                                                  filterBynoPR,
                                                                  'edit',
                                                                  _listDetailItemQc![
                                                                          index]
                                                                      .jenisBatu!),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
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
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            40),
                                                                    Text(
                                                                        'Sri Sumiati')
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      'Dibawa oleh,',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            40),
                                                                    Text('....')
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      'Diterima oleh,',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            40),
                                                                    Text('....')
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      'Diketahui oleh,',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            40),
                                                                    Text('....')
                                                                  ],
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                SizedBox(
                                                                  width: 200,
                                                                  child:
                                                                      CustomLoadingButton(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    controller:
                                                                        btnControllerBatal,
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Batal",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 200,
                                                                  child:
                                                                      CustomLoadingButton(
                                                                    controller:
                                                                        btnControllerSimpan,
                                                                    onPressed:
                                                                        () {
                                                                      exportData(
                                                                          '${dataFormPR![index].noQc}');
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Export Data",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ],
                                                      ),
                                                    ),
                                                  ])),
                                            )));
                                  });
                            },
                            child: Card(
                              child: Container(
                                // height: 50, // Atur tinggi yang diinginkan di sini
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                    child: SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        'TANDA TERIMA QUALITY CONTROL',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      Text(
                                        'No. ${dataFormPR![index].noQc}',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Vendor : ${dataFormPR![index].vendor}',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            'Tanggal : ${DateFormat('dd-MMMM-yyyy').format(DateTime.parse(dataFormPR![index].tanggalSelesai!))}',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Lokasi  : CSV',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            'Jam : ${DateFormat('H.mm').format(DateTime.parse(dataFormPR![index].tanggalSelesai!))}',
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
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.4 // Sesuaikan dengan tinggi maksimum yang diinginkan
                                            ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: dataTableForm(
                                              _listDetailItemQc!
                                                  .where((element) =>
                                                      element.noQc
                                                          .toString()
                                                          .toLowerCase() ==
                                                      dataFormPR![index]
                                                          .noQc
                                                          .toString()
                                                          .toLowerCase())
                                                  .toList(),
                                              'read',
                                              _listDetailItemQc![index]
                                                  .jenisBatu!),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Diserahkan oleh,',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(height: 40),
                                                Text('Sri Sumiati')
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Dibawa oleh,',
                                                  textAlign: TextAlign.start,
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
                                                  textAlign: TextAlign.start,
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
                                                  textAlign: TextAlign.start,
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
                                    ],
                                  ),
                                )),
                              ),
                            ),
                          ),
                          staggeredTileBuilder: (int index) =>
                              const StaggeredTile.fit(1), // Satu item per baris
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        );
                      })));
  }

  exportData(noQc) async {
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
    ExcelPembelian().exportExcel(noQc);

    // ignore: use_build_context_synchronously
    Future.delayed(const Duration(seconds: 1)).then((value) {
      //! lalu eksekusi fungsi ini
      Navigator.pop(context);
      Navigator.pop(context);
    });
    selectListItemRound.clear();
  }

  postStatusPR(id, fixTotalQty, fixTotalBerat) async {
    Map<String, String> body = {
      'id': id.toString(),
      'status': 'qc',
      'fix_total_qty': fixTotalQty.toString(),
      'fix_total_berat': fixTotalBerat.toString()
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateStatusPR}'),
        body: body);
    print(response.body);
  }

  postUpdateListFormPR(id, kadar, color, fixQty, fixBerat) async {
    Map<String, String> body = {
      'id': id,
      'kadar': kadar,
      'color': color,
      'fixQty': fixQty,
      'fixBerat': fixBerat
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateListFormPR}'),
        body: body);
    print(response.body);
  }
}
