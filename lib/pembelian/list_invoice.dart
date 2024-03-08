// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ui' as ui;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/pembelian/export_pembelian.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/pembelian/save_pdf_pembelian.dart';
import 'package:form_designer/qc/modelQc/itemQcModel.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:form_designer/widgets/web_image_converter.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class ListInvoice extends StatefulWidget {
  const ListInvoice({super.key});

  @override
  State<ListInvoice> createState() => _ListInvoiceState();
}

TextEditingController controller = TextEditingController();

class _ListInvoiceState extends State<ListInvoice> {
  bool isLoading = false;

  RoundedLoadingButtonController btnControllerBatal =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerSimpan =
      RoundedLoadingButtonController();
  List<ListItemPRModel>? filterFormPR;
  List<FormPrModel>? dataFormPR;
  List<FormPrModel>? filterDataFormPR;
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
  String? _selectedTime;

  bool _isSigned = false;
  final double _fontSize = 16;

  late Uint8List _signatureData;
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  Color? _backgroundColor;

  @override
  initState() {
    super.initState();
    print('masuk');
    _getData();
  }

  bool _handleOnDrawStart() {
    _isSigned = true;
    return false;
  }

  void _showPopup() {
    _isSigned = false;

    _backgroundColor = Colors.white;

    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            final Color? backgroundColor = _backgroundColor;
            const Color textColor = Colors.black87;

            return AlertDialog(
              insetPadding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
              backgroundColor: backgroundColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Draw your signature',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto-Medium')),
                  InkWell(
                    //ignore: sdk_version_set_literal
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.clear,
                        color: Color.fromRGBO(0, 0, 0, 0.54), size: 24.0),
                  )
                ],
              ),
              titlePadding: const EdgeInsets.all(16.0),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width < 306
                      ? MediaQuery.of(context).size.width
                      : 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width < 306
                            ? MediaQuery.of(context).size.width
                            : 450,
                        height: 172,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: SfSignaturePad(
                            minimumStrokeWidth: 2,
                            maximumStrokeWidth: 6,
                            backgroundColor: _backgroundColor,
                            onDrawStart: _handleOnDrawStart,
                            key: _signaturePadKey),
                      ),
                      const SizedBox(height: 24),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Pen Color',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              actionsPadding: const EdgeInsets.all(8.0),
              buttonPadding: EdgeInsets.zero,
              actions: <Widget>[
                TextButton(
                  onPressed: _handleClearButtonPressed,
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text(
                    'CLEAR',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto-Medium'),
                  ),
                ),
                const SizedBox(width: 8.0),
                TextButton(
                  onPressed: () {
                    _handleSaveButtonPressed();
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text('SAVE',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto-Medium')),
                )
              ],
            );
          },
        );
      },
    );
  }

  void _handleClearButtonPressed() {
    _signaturePadKey.currentState!.clear();
    _isSigned = false;
  }

  Future<void> _handleSaveButtonPressed() async {
    late Uint8List data;

    if (kIsWeb) {
      final RenderSignaturePad renderSignaturePad =
          _signaturePadKey.currentState!.context.findRenderObject()!
              as RenderSignaturePad;
      data =
          await ImageConverter.toImage(renderSignaturePad: renderSignaturePad);
    } else {
      final ui.Image imageData =
          await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
      final ByteData? bytes =
          await imageData.toByteData(format: ui.ImageByteFormat.png);
      if (bytes != null) {
        data = bytes.buffer.asUint8List();
      }
    }

    setState(
      () {
        _signatureData = data;
      },
    );
  }

  Future<void> _showDatePicker(BuildContext context, id, int index) async {
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
        await _showTime(formattedDate, id, index);
      } else {
        print("Tanggal tidak dipilih");
      }
    } catch (e) {
      print("Dialog dibatalkan");
    }
  }

  Future<void> _showTime(String tanggal, id, int index) async {
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
      setState(() {
        dataFormPR![index].tanggalCetak = dateTime.toString();
      });
    } else {}
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
              element.status.toString().toLowerCase() == 'selesai' &&
              element.jenisItem.toString().toLowerCase() == 'diamond')
          .toList();
      data = filterByStatus;
      //* hints Urutkan data berdasarkan tanggal terlama
      // data.sort((a, b) => a.tanggalSelesai!.compareTo(b.tanggalSelesai!));
      //? Sekarang, data sudah diurutkan berdasarkan tanggal terlama

      dataFormPR = data;
      filterDataFormPR = data;
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

  dataTableForm(
      List<ListItemPRModel>? listData, String status, String jenisItem) {
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
    return [
      const DataColumn(
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No'),
        ),
        numeric: true,
      ),
      const DataColumn(
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Berat Kedatangan'),
        ),
      ),
      const DataColumn(
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Berat Diterima'),
        ),
      ),
      const DataColumn(
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Nama Barang'),
        ),
      ),
      const DataColumn(
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Harga (\$)'),
        ),
      ),
      const DataColumn(
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Total Harga (\$)'),
        ),
        numeric: true,
      ),
    ];
  }

  List<DataRow> rowsData(
      var data, int count, Function() onChangedCallback, jenisItem) {
    List<double> totalHarga = [];
    double sumHargaBerat = 0.0;
    for (var i = 0; i < count; i++) {
      double sumTotal =
          double.parse(data[i].harga) * double.parse(data[i].receiveBerat);
      totalHarga.add(sumTotal);
      sumHargaBerat += sumTotal;
    }

    return [
      for (var i = 0; i < count; i++)
        DataRow(cells: [
          DataCell(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('${i + 1}'),
          )),
          DataCell(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(data[i].fixBerat),
          )),
          DataCell(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(data[i].receiveBerat.toString()),
          )),
          DataCell(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('${data[i].item} / ${getKualitas(data[i].kadar)}'),
          )),
          DataCell(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$ ${data[i].harga}', textAlign: TextAlign.left),
          )),
          DataCell(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$ ${totalHarga[i].toStringAsFixed(3)}',
                textAlign: TextAlign.left),
          )),
        ]),
      DataRow(cells: [
        DataCell(
          Container(
              color: Colors.white,
              child: const Text(
                '',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),

        DataCell(
          Container(
              color: Colors.white,
              child: const Text(
                '',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),

        DataCell(
          Container(
              color: Colors.white,
              child: const Text(
                '',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),

        DataCell(
          Container(
              color: Colors.white,
              child: const Text(
                '',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),

        DataCell(
          Container(
              color: Colors.black54,
              child: const Center(
                  child: Text(
                'Total',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        //? berat round
        DataCell(
          Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '\$ ${sumHargaBerat.toStringAsFixed(3)}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))),
        ),
      ]),
    ];
  }

  //* HINTS switch case mengembalikan hasil
  String getKualitas(String kualitas) {
    switch (kualitas) {
      case 'ZR / ZS':
        return 'VVS';
      case 'ZE':
        return 'VS';
      case 'ZT':
        return 'SI';
      default:
        return '';
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
                    dataFormPR = filterDataFormPR!
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
                : dataFormPR!.isEmpty
                    ? const Center(
                        child: Text('Tidak ada data'),
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        return StaggeredGridView.countBuilder(
                          crossAxisCount: 1,
                          // constraints.maxWidth < 850
                          //     ? 1
                          //     : 2, // dua item per baris
                          itemCount: dataFormPR!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Sesuaikan dengan nilai radius yang diinginkan
                              ),
                              elevation:
                                  4, // Atur ketinggian shadow card sesuai kebutuhan
                              child: Container(
                                // height: 50, // Atur tinggi yang diinginkan di sini
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                    child: SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'NOTA BISNIS / INVOICE ${dataFormPR![index].noPr}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                'Nota titipan',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _fontSize),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                              child: Text(
                                                ':',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _fontSize),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                '${dataFormPR![index].tanggalInQc}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _fontSize),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  'Kpd Yth PT. Cahaya Sani Vokasi',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _fontSize),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 10,
                                              //   child: Text(
                                              //     ':',
                                              //     textAlign: TextAlign.start,
                                              //     style: TextStyle(
                                              //         color: Colors.black,
                                              //         fontWeight:
                                              //             FontWeight.bold,
                                              //         fontSize: _fontSize),
                                              //   ),
                                              // ),
                                              // Text(
                                              //   'PT. Cahaya Sani Vokasi',
                                              //   textAlign: TextAlign.start,
                                              //   style: TextStyle(
                                              //       color: Colors.black,
                                              //       fontWeight: FontWeight.bold,
                                              //       fontSize: _fontSize),
                                              // ),
                                            ],
                                          ),
                                          dataFormPR![index].tanggalCetak == ''
                                              ? ElevatedButton(
                                                  onPressed: (() async {
                                                    await _showDatePicker(
                                                        context,
                                                        dataFormPR![index].noPr,
                                                        index);
                                                  }),
                                                  child: Text(
                                                    'Pilih tanggal cetak',
                                                    style: TextStyle(
                                                        fontSize: _fontSize),
                                                  ))
                                              : Text(
                                                  'Tanggal : ${DateFormat('dd-MMMM-yyyy').format(DateTime.parse(dataFormPR![index].tanggalCetak!))}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _fontSize),
                                                ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Bu Stephanie / Pak Vitalik',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: _fontSize),
                                          ),
                                          dataFormPR![index].tanggalCetak == ''
                                              ? Text(
                                                  'Jam : --:--',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _fontSize),
                                                )
                                              : Text(
                                                  'Jam : ${DateFormat('H.mm').format(DateTime.parse(listItemQc![index].updateAt!))}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _fontSize),
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
                                              listItemQc!
                                                  .where((element) =>
                                                      element.noPr
                                                          .toString()
                                                          .toLowerCase() ==
                                                      dataFormPR![index]
                                                          .noPr
                                                          .toString()
                                                          .toLowerCase())
                                                  .toList(),
                                              'read',
                                              dataFormPR![index].jenisBatu!),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Pembelian,',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _fontSize),
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  //ignore: sdk_version_set_literal
                                                  onTap: () {
                                                    _showPopup();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: _isSigned
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                    height: 78,
                                                    width: 138,
                                                    child: _isSigned
                                                        ? Image.memory(
                                                            _signatureData)
                                                        : Center(
                                                            child: Text(
                                                              'Tap here to sign',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      _fontSize,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                                // SizedBox(height: 40),
                                                const Text('....')
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Finance,',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _fontSize),
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  //ignore: sdk_version_set_literal
                                                  onTap: () {
                                                    // _showPopup();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black),
                                                    ),
                                                    height: 78,
                                                    width: 138,
                                                    // child: _isSigned
                                                    //     ? Image.memory(
                                                    //         _signatureData)
                                                    //     : const Center(
                                                    //         child: Text(
                                                    //           'Tap here to sign',
                                                    //           style: TextStyle(
                                                    //               fontSize: 12,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .bold,
                                                    //               color: Colors
                                                    //                   .black),
                                                    //         ),
                                                    //       ),
                                                  ),
                                                ),
                                                const Text('....')
                                              ],
                                            ),
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: 40,
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: CustomLoadingButton(
                                                controller: btnControllerSimpan,
                                                onPressed: () async {
                                                  if (_signatureData.isEmpty) {
                                                    showCustomDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.error,
                                                      title: 'GAGAL',
                                                      description:
                                                          'Tanda tangan wajib di isi',
                                                    );
                                                  } else {
                                                    await Future.delayed(
                                                            const Duration(
                                                                seconds: 2))
                                                        .then((value) async {
                                                      btnControllerSimpan
                                                          .success();
                                                    });
                                                    print(_signatureData);
                                                    Future.delayed(
                                                            const Duration(
                                                                seconds: 1))
                                                        .then((value) async {
                                                      btnControllerSimpan
                                                          .reset();
                                                    });
                                                    //*HINTS Panggil fungsi showCustomDialog
                                                    // ignore: use_build_context_synchronously
                                                    showCustomDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.success,
                                                      title: 'SUCCESS',
                                                      description:
                                                          'Nota tersimpan',
                                                    );
                                                  }
                                                },
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.download),
                                                    SizedBox(width: 15),
                                                    Text(
                                                      'Cetak Nota',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ))),
                                      ),
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

  savePdf(noQc) async {
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

    await SavePdfPembelian().generatePDF(noQc);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    selectListItemRound.clear();
    selectedList = List.generate(listItemQc!.length, (index) => false);
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

    await ExcelPembelian().exportExcel(noQc);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);

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
