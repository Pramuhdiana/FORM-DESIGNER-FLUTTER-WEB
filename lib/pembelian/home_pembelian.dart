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
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/qc/modelQc/itemQcModel.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
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
  List<ListItemPRModel>? filterFormPR;
  List<FormPrModel>? dataFormPR;
  List<ListItemPRModel>? listItemQc;
  List<ItemQcModel>? listDetailItemQc;
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
  String screenSizeText = "";
  List<bool> selectedList = List.generate(
      100, (index) => false); // List untuk menyimpan status pilihan
  @override
  initState() {
    super.initState();
    print('masuk');
    _getData();
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
              element.status.toString().toLowerCase() == 'selesai' ||
              element.jenisItem.toString().toLowerCase() == 'diamond')
          .toList();
      data = filterByStatus;
      //* hints Urutkan data berdasarkan tanggal terlama
      // data.sort((a, b) => a.tanggalSelesai!.compareTo(b.tanggalSelesai!));
      //? Sekarang, data sudah diurutkan berdasarkan tanggal terlama

      dataFormPR = data;
    } else {
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
    //get listnya QC
    final responseListItem = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));

    if (responseListItem.statusCode == 200) {
      List jsonResponse = json.decode(responseListItem.body);

      var dataListItem = jsonResponse
          .map((dataListItem) => ListItemPRModel.fromJson(dataListItem))
          .toList();
      var filterByNoQc =
          dataListItem.where((element) => element.noQc != '').toList();

      listItemQc = filterByNoQc;
      filterFormPR = filterByNoQc;

      print(listItemQc);
    } else {
      print(response.body);
      throw Exception('Unexpected error occured!');
    }

    //get detail listnya QC
    final responseList = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getItemQc}'));

    if (responseList.statusCode == 200) {
      List jsonResponse = json.decode(responseList.body);

      var dataList = jsonResponse
          .map((dataList) => ItemQcModel.fromJson(dataList))
          .toList();

      listDetailItemQc = dataList;
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
    double sumBerat = 0.0;
    double sumQty = 0.0;
    for (var i = 0; i < count; i++) {
      sumBerat += double.parse(data[i]
          .berat); // Menambahkan nilai dari indeks kedua (indeks kolom ke-1)
      sumQty += int.parse(data[i]
          .qty); // Menambahkan nilai dari indeks kedua (indeks kolom ke-1)
    }

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
            DataRow(cells: [
              DataCell(
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(
                        child: Text(
                      'Total',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),

              DataCell(
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(
                        child: Text(
                      '',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),
              //? qty round
              DataCell(
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                        child: Text(
                      '$sumQty',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),

              //? berat round
              DataCell(
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                        child: Text(
                      sumBerat.toStringAsFixed(3),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),

              DataCell(
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(
                        child: Text(
                      '',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),
              DataCell(
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(
                        child: Text(
                      '',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),
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
                    listItemQc = filterFormPR!
                        .where((element) =>
                            element.noPr!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.noQc!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                    setState(() {});
                  },
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _getData();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            body: isLoading == true
                ? Center(
                    child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 90,
                    height: 90,
                    child: Lottie.asset("loadingJSON/loadingV1.json"),
                  ))
                : listItemQc!.isEmpty
                    ? const Center(
                        child: Text('Tidak ada data'),
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        return StaggeredGridView.countBuilder(
                          crossAxisCount: constraints.maxWidth < 900
                              ? 1
                              : 2, // dua item per baris
                          itemCount: listItemQc!.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setFullScreen(true);
                              // showScreenSize();

                              selectListItemRound.clear();
                              var filterBynoPR = listDetailItemQc!
                                  .where((element) =>
                                      element.noPr.toString().toLowerCase() ==
                                      listItemQc![index]
                                          .noPr
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
                                                      content: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              'TANDA TERIMA QUALITY CONTROL ${listItemQc![index].item}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 22),
                                                            ),
                                                            Text(
                                                              'No. ${listItemQc![index].noQc}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                            Container(
                                                              constraints: BoxConstraints(
                                                                  maxHeight: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.70 // Sesuaikan dengan tinggi maksimum yang diinginkan
                                                                  ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                child: dataTableForm(
                                                                    listDetailItemQc!
                                                                        .where((element) =>
                                                                            element.noQc.toString().toLowerCase() ==
                                                                            listItemQc![index]
                                                                                .noQc
                                                                                .toString()
                                                                                .toLowerCase())
                                                                        .toList(),
                                                                    'read',
                                                                    listDetailItemQc![
                                                                            index]
                                                                        .jenisBatu!),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 200,
                                                                    height: 50,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        selectedList = List.generate(
                                                                            listItemQc!
                                                                                .length,
                                                                            (index) =>
                                                                                false);

                                                                        setFullScreen(
                                                                            false);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.red, // Mengatur warna latar belakang tombol
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10), // Memberikan radius 10
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        "Batal",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 18),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 200,
                                                                    height: 50,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        // setFullScreen(
                                                                        //     false);
                                                                        // exportData(
                                                                        //     '${listItemQc![index].noQc}');
                                                                        showGeneralDialog(
                                                                          transitionDuration:
                                                                              const Duration(milliseconds: 200),
                                                                          barrierDismissible:
                                                                              true,
                                                                          barrierLabel:
                                                                              '',
                                                                          context:
                                                                              context,
                                                                          pageBuilder: (context,
                                                                              animation1,
                                                                              animation2) {
                                                                            return const Text('');
                                                                          },
                                                                          barrierColor: Colors
                                                                              .black
                                                                              .withOpacity(0.75),
                                                                          transitionBuilder: (context,
                                                                              a1,
                                                                              a2,
                                                                              widget) {
                                                                            return Transform.scale(
                                                                              scale: a1.value,
                                                                              child: Opacity(
                                                                                opacity: a1.value,
                                                                                child: StatefulBuilder(
                                                                                  builder: (context, setState) => AlertDialog(
                                                                                    content: SizedBox(
                                                                                      width: 500,
                                                                                      height: 500,
                                                                                      child: SingleChildScrollView(
                                                                                        scrollDirection: Axis.vertical,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            // List of checkboxes and names
                                                                                            ListView.builder(
                                                                                              shrinkWrap: true,
                                                                                              itemCount: listItemQc!.length,
                                                                                              itemBuilder: (context, index) {
                                                                                                // Membuat selectedList dengan panjang yang sesuai

                                                                                                return CheckboxListTile(
                                                                                                  title: Text('No QC = ${listItemQc![index].noQc}'),
                                                                                                  value: selectedList[index],
                                                                                                  onChanged: (isSelected) {
                                                                                                    setState(() {
                                                                                                      selectedList[index] = isSelected ?? false;
                                                                                                    });
                                                                                                  },
                                                                                                );
                                                                                              },
                                                                                            ),
                                                                                            // Display button to submit selected items
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                setFullScreen(false);

                                                                                                // Print selected items
                                                                                                List<String> selectedNoQc = [];
                                                                                                for (int i = 0; i < selectedList.length; i++) {
                                                                                                  if (selectedList[i]) {
                                                                                                    selectedNoQc.add('${listItemQc![i].noQc}');
                                                                                                  }
                                                                                                }
                                                                                                print('Selected No Qc : $selectedNoQc');
                                                                                                Navigator.pop(context);
                                                                                                Navigator.pop(context);
                                                                                                exportData(selectedNoQc);
                                                                                              },
                                                                                              child: const Row(
                                                                                                children: [
                                                                                                  Icon(Icons.download), // Menambahkan ikon Download
                                                                                                  SizedBox(width: 8), // Menambahkan jarak antara ikon dan teks
                                                                                                  Text('Download'),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.blue, // Mengatur warna latar belakang tombol
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10), // Memberikan radius 10
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        "Export data",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 18),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                              )),
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
                                      Text(
                                        'TANDA TERIMA QUALITY CONTROL ${listItemQc![index].item}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      Text(
                                        'No. ${listItemQc![index].noQc}',
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
                                          const Text(
                                            'Vendor : value',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            'Tanggal : ${DateFormat('dd-MMMM-yyyy').format(DateTime.parse(listItemQc![index].updateAt!))}',
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
                                            'Jam : ${DateFormat('H.mm').format(DateTime.parse(listItemQc![index].updateAt!))}',
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
                                              listDetailItemQc!
                                                  .where((element) =>
                                                      element.noQc
                                                          .toString()
                                                          .toLowerCase() ==
                                                      listItemQc![index]
                                                          .noQc
                                                          .toString()
                                                          .toLowerCase())
                                                  .toList(),
                                              'read',
                                              listDetailItemQc![index]
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

    // // ignore: use_build_context_synchronously
    Future.delayed(const Duration(seconds: 1)).then((value) {
      //   //! lalu eksekusi fungsi ini
      Navigator.pop(context);
      //   Navigator.pop(context);
    });
    selectListItemRound.clear();
    selectedList = List.generate(listItemQc!.length, (index) => false);
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
