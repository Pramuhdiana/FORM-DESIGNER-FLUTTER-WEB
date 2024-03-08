// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/excel.dart';
import 'package:form_designer/mainScreen/excel_admin.dart';
import 'package:form_designer/mainScreen/form_ro.dart';
// import 'package:form_designer/mainScreen/form_ro.dart';
import 'dart:convert';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/mainScreen/form_view_screen.dart';
import 'package:form_designer/mainScreen/printing.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
import 'package:form_designer/mainScreen/view_photo_screen.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/widgets/loading_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  TextEditingController siklus = TextEditingController();
  String? updateSiklus = '';
  TextEditingController addSiklus = TextEditingController();

  String siklusDesigner = '';
  List<FormDesignerModel>? listJenisBarang;
  List<FormDesignerModel>? uniqListJenisBarang;

  List<String> listKelasHarga = [];
  List<String> uniqListKelasHarga = [];

  List<FormDesignerModel>? listJenisBarangView1;
  List sumNamaModeller = [
    'Arif Kurniawan',
    'Aris Pravidan',
    'Fikryansyah',
    'Yuse'
  ];

  List<int> sumHarga = [];
  int totalHarga = 0;
  int totalSPK = 0;
  int batuLengkap = 0;
  int batuBelumLengkap = 0;
  double pointArif = 0.0;
  double pointAris = 0.0;
  double pointFikri = 0.0;
  double pointyuse = 0.0;
  double beratArif = 0.0;
  double beratAris = 0.0;
  double beratFikri = 0.0;
  double beratyuse = 0.0;
  int totalSPKPending = 0;
  int totalSPKSelesai = 0;
  bool isSelected1 = false;
  TextEditingController controller = TextEditingController();
  bool sort = true;
  int _currentSortColumn = 0;
  List<FormDesignerModel>? filterCrm;
  List<FormDesignerModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;
  bool isJenisBarangView1 = false;
  bool isKelasHargaView1 = false;
  bool isLoadingJenisBarang = false;
  bool isLoadingKelasHarga = false;
  bool isLoadingReport = false;
  bool isLoadingPointModeller = false;
  var nowSiklus = '';
  String? namaJenisBarangView1 = '';
  String? namaKelasHargaView1 = '';

  bool isSummaryModeller = false;

  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    siklusDesigner = month;
    _getAllData("all", sharedPreferences!.getString('nama')!);
    nowSiklus = sharedPreferences!.getString('siklus')!;
    // _getDataJenisBarang('all', '');
    //star notifi
  }

  _getAllData(month, name) async {
    setState(() {
      isLoading = true;
      isLoadingJenisBarang = true;
      isLoadingKelasHarga = true;
      isLoadingReport = true;
      isLoadingPointModeller = true;
    });
    try {
      final response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        var allData = jsonResponse
            .map((data) => FormDesignerModel.fromJson(data))
            .toList();
        var g = jsonResponse
            .map((data) => FormDesignerModel.fromJson(data))
            .toList();
        var dataHarga = jsonResponse
            .map((data) => FormDesignerModel.fromJson(data))
            .toList();

        //! method admin

        if (month.toString().toLowerCase() == "all") {
          //! point modeller
          var filterByPoint = g
              .where((element) => double.tryParse(element.pointModeller!)! > 0);
          print('filter by point oke');
          //? point modeller arif
          var filterByArif = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() ==
              "arif kurniawan");
          pointArif = 0.0;
          for (var i = 0; i < filterByArif.length; i++) {
            pointArif += double.parse(filterByArif.toList()[i].pointModeller!);
          }
          //? point modeller aris
          var filterByAris = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() == "aris pravidan");
          pointAris = 0.0;
          for (var i = 0; i < filterByAris.length; i++) {
            pointAris += double.parse(filterByAris.toList()[i].pointModeller!);
          }

          //? point modeller fikri
          var filterByFikri = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() == "fikryansyah");
          pointFikri = 0.0;
          for (var i = 0; i < filterByFikri.length; i++) {
            pointFikri +=
                double.parse(filterByFikri.toList()[i].pointModeller!);
          }

          //? point modeller yuse
          var filterByyuse = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() == "yuse");
          pointyuse = 0.0;
          for (var i = 0; i < filterByyuse.length; i++) {
            pointyuse += double.parse(filterByyuse.toList()[i].pointModeller!);
          }

          //! berat modeller
          var filterByberat =
              g.where((element) => double.parse(element.beratModeller!) > 0);
          //? berat modeller arif
          var filterBeratByArif = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() ==
              "arif kurniawan");
          beratArif = 0.0;
          for (var i = 0; i < filterBeratByArif.length; i++) {
            beratArif +=
                double.parse(filterBeratByArif.toList()[i].beratModeller!);
          }
          //? berat modeller aris
          var filterBeratByAris = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() == "aris pravidan");
          beratAris = 0.0;
          for (var i = 0; i < filterBeratByAris.length; i++) {
            beratAris +=
                double.parse(filterBeratByAris.toList()[i].beratModeller!);
          }

          //? berat modeller fikri
          var filterBeratByFikri = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() == "fikryansyah");
          beratFikri = 0.0;
          for (var i = 0; i < filterBeratByFikri.length; i++) {
            beratFikri +=
                double.parse(filterBeratByFikri.toList()[i].beratModeller!);
          }

          //? berat modeller yuse
          var filterBeratByyuse = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() == "yuse");
          beratyuse = 0.0;
          for (var i = 0; i < filterBeratByyuse.length; i++) {
            beratyuse +=
                double.parse(filterBeratByyuse.toList()[i].beratModeller!);
          }
          listJenisBarang = allData;
          var filterByStatusBatu = allData.where((element) =>
              element.keteranganStatusBatu.toString().toLowerCase() ==
              "batu lengkap");
          batuLengkap = filterByStatusBatu.toList().length;
        } else {
          var filterBySiklus = allData.where((element) =>
              element.siklus.toString().toLowerCase() ==
              month.toString().toLowerCase());
          dataHarga = filterBySiklus.toList();
          var filterByStatusBatu = filterBySiklus.where((element) =>
              element.keteranganStatusBatu.toString().toLowerCase() ==
              "batu lengkap");
          batuLengkap = filterByStatusBatu.toList().length;
          allData = filterBySiklus.toList();
          listJenisBarang = filterBySiklus.toList();

          //! point modeller
          var filterByPoint = filterBySiklus
              .where((element) => double.parse(element.pointModeller!) > 0);
          //? point modeller arif
          var filterByArif = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() ==
              "arif kurniawan");
          pointArif = 0.0;
          for (var i = 0; i < filterByArif.length; i++) {
            pointArif += double.parse(filterByArif.toList()[i].pointModeller!);
          }
          //? point modeller aris
          var filterByAris = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() == "aris pravidan");
          pointAris = 0.0;
          for (var i = 0; i < filterByAris.length; i++) {
            pointAris += double.parse(filterByAris.toList()[i].pointModeller!);
          }

          //? point modeller fikri
          var filterByFikri = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() == "fikryansyah");
          pointFikri = 0.0;
          for (var i = 0; i < filterByFikri.length; i++) {
            pointFikri +=
                double.parse(filterByFikri.toList()[i].pointModeller!);
          }

          //? point modeller yuse
          var filterByyuse = filterByPoint.where((element) =>
              element.namaModeller.toString().toLowerCase() == "yuse");
          pointyuse = 0.0;
          for (var i = 0; i < filterByyuse.length; i++) {
            pointyuse += double.parse(filterByyuse.toList()[i].pointModeller!);
          }

          //! berat modeller
          var filterByberat =
              g.where((element) => double.parse(element.beratModeller!) > 0);
          //? berat modeller arif
          var filterBeratByArif = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() ==
              "arif kurniawan");
          beratArif = 0.0;
          for (var i = 0; i < filterBeratByArif.length; i++) {
            beratArif +=
                double.parse(filterBeratByArif.toList()[i].beratModeller!);
          }
          //? berat modeller aris
          var filterBeratByAris = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() == "aris pravidan");
          beratAris = 0.0;
          for (var i = 0; i < filterBeratByAris.length; i++) {
            beratAris +=
                double.parse(filterBeratByAris.toList()[i].beratModeller!);
          }

          //? berat modeller fikri
          var filterBeratByFikri = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() == "fikryansyah");
          beratFikri = 0.0;
          for (var i = 0; i < filterBeratByFikri.length; i++) {
            beratFikri +=
                double.parse(filterBeratByFikri.toList()[i].beratModeller!);
          }

          //? berat modeller yuse
          var filterBeratByyuse = filterByberat.where((element) =>
              element.namaModeller.toString().toLowerCase() == "yuse");
          beratyuse = 0.0;
          for (var i = 0; i < filterBeratByyuse.length; i++) {
            beratyuse +=
                double.parse(filterBeratByyuse.toList()[i].beratModeller!);
          }
        }
        var alldataJenisBarang = allData.toList();
        alldataJenisBarang = removeDuplicates(listJenisBarang!);
        uniqListJenisBarang = alldataJenisBarang;

        //* fungsi looping untuk menambahakn beberapa item kje dalam list kosong
        listKelasHarga.clear();
        uniqListKelasHarga.clear();
        sumHarga.clear();
        sumHarga.add(0);

        for (var i = 0; i < dataHarga.length; i++) {
          if (dataHarga[i].brand.toString().toLowerCase() == "parva" ||
              dataHarga[i].brand.toString().toLowerCase() == "fine") {
            int nilai = ((dataHarga[i].estimasiHarga! * 0.37) * 11500).round();
            sumHarga.add(nilai);
            if (((dataHarga[i].estimasiHarga! * 0.37) * 11500) <= 5000000) {
              listKelasHarga.add(
                  'XS'); //!menambahakn item baru ke dalam list yang sudah dibuatkan
            } else if (((dataHarga[i].estimasiHarga! * 0.37) * 11500) <=
                10000000) {
              listKelasHarga.add('S');
            } else if (((dataHarga[i].estimasiHarga! * 0.37) * 11500) <=
                20000000) {
              listKelasHarga.add('M');
            } else if (((dataHarga[i].estimasiHarga! * 0.37) * 11500) <=
                35000000) {
              listKelasHarga.add('L');
            } else {
              listKelasHarga.add('XL');
            }
          }
          //? untuk beli berlian dan metier
          else {
            int nilai = dataHarga[i].estimasiHarga!;
            sumHarga.add(nilai);
            if (dataHarga[i].estimasiHarga! <= 5000000) {
              listKelasHarga.add(
                  'XS'); //!menambahakn item baru ke dalam list yang sudah dibuatkan
            } else if (dataHarga[i].estimasiHarga! <= 10000000) {
              listKelasHarga.add('S');
            } else if (dataHarga[i].estimasiHarga! <= 20000000) {
              listKelasHarga.add('M');
            } else if (dataHarga[i].estimasiHarga! <= 35000000) {
              listKelasHarga.add('L');
            } else {
              listKelasHarga.add('XL');
            }
          }
        }
        uniqListKelasHarga = listKelasHarga.toSet().toList();
        totalHarga = sumHarga.reduce((a, b) => a + b);

        setState(() {
          filterCrm = allData;
          myCrm = allData;
          // isLoadingJenisBarang = true;
          totalSPK = allData.length;
          totalSPKSelesai = allData
              .where((element) => double.parse(element.pointModeller!) > 0)
              .length;
          isLoading = false;
          isLoadingJenisBarang = false;
          isLoadingKelasHarga = false;
          isLoadingReport = false;
          isLoadingPointModeller = false;
        });
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get data all $c');
    }
  }

  Future<List<FormDesignerModel>> _getDataJeniBarangView1(
      chooseSiklus, nama, jenisBarangView1) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      //! method admin
      if (chooseSiklus.toString().toLowerCase() == "all") {
        var filterByJenisBarang = g.where((element) =>
            element.jenisBarang.toString().toLowerCase() ==
            jenisBarangView1.toString().toLowerCase());
        listJenisBarangView1 = filterByJenisBarang.toList();
      } else {
        var filterBySiklus = g.where((element) =>
            element.siklus.toString().toLowerCase() ==
            chooseSiklus.toString().toLowerCase());
        var filterByJenisBarang = filterBySiklus.where((element) =>
            element.jenisBarang.toString().toLowerCase() ==
            jenisBarangView1.toString().toLowerCase());
        listJenisBarangView1 = filterByJenisBarang.toList();
      }

      // g = removeDuplicates(listJenisBarangView1!);
      g = listJenisBarangView1!;
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  // fungsi remove duplicate object
  List<FormDesignerModel> removeDuplicates(List<FormDesignerModel> items) {
    List<FormDesignerModel> uniqueItems = []; // uniqueList
    var uniqueNames = items
        .map((e) => e.jenisBarang)
        .toSet(); //list if UniqueID to remove duplicates
    for (var e in uniqueNames) {
      uniqueItems.add(items.firstWhere((i) => i.jenisBarang == e));
    }
    return uniqueItems; //send back the unique items list
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
            //change siklus
            leading: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Text(
                      "Siklus Saat Ini : $nowSiklus",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade700),
                    ),
                    sharedPreferences!.getString('level') != '1'
                        ? const SizedBox()
                        : IconButton(
                            color: Colors.grey.shade700,
                            onPressed: () {
                              final dropdownFormKey = GlobalKey<FormState>();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      // title: const Text('Pilih Siklus'),
                                      content: SizedBox(
                                        height: 150,
                                        child: Column(
                                          children: [
                                            Form(
                                                key: dropdownFormKey,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    DropdownSearch<String>(
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
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Pilih Siklus',
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ),
                                                      ),
                                                      validator: (value) =>
                                                          value == null
                                                              ? "Siklus tidak boleh kosong"
                                                              : null,
                                                      onChanged:
                                                          (String? newValue) {
                                                        addSiklus.text =
                                                            newValue!;
                                                      },
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            if (dropdownFormKey
                                                                .currentState!
                                                                .validate()) {
                                                              //? method untuk mengganti siklus
                                                              await postSiklus();
                                                              // ignore: use_build_context_synchronously
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (c) =>
                                                                          MainViewScm(
                                                                              col: 0)));
                                                              // ignore: use_build_context_synchronously

                                                              // ignore: use_build_context_synchronously
                                                              showDialog<
                                                                      String>(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      const AlertDialog(
                                                                        title:
                                                                            Text(
                                                                          'Siklus Berhasil Diterapkan',
                                                                        ),
                                                                      ));
                                                              setState(() {
                                                                nowSiklus =
                                                                    addSiklus
                                                                        .text;
                                                                sharedPreferences!
                                                                    .setString(
                                                                        'siklus',
                                                                        addSiklus
                                                                            .text);
                                                              });
                                                            }
                                                          },
                                                          child: const Text(
                                                            "Submit",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                            ),
                                                          )),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.change_circle,
                            ))
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
                          element.kodeDesignMdbc!
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element.namaDesigner!
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element.kodeDesign!
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element.kodeMarketing!
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
          body: ListView(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.only(top: 26),
                child: const Text(
                  'Dashboard',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              dashboardSCM()
            ]),
          ]),
        ));
  }

//! data table
  DataTable _dataTableSumModeller() {
    return DataTable(
        headingTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.blue),
        columnSpacing: 1,
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('NAMA')),
      DataColumn(label: _verticalDivider),
      const DataColumn(label: Text('TOTAL SPK')),
      DataColumn(label: _verticalDivider),
      const DataColumn(label: Text('SPK PENDING')),
      DataColumn(label: _verticalDivider),
      const DataColumn(label: Text('SPK SELESAI')),
      DataColumn(label: _verticalDivider),
      const DataColumn(label: Text('POINT')),
      DataColumn(label: _verticalDivider),
      const DataColumn(label: Text('BERAT'))
    ];
  }

  List<DataRow> _createRows() {
    return [
      for (var i = 0; i < sumNamaModeller.length; i++)
        DataRow(cells: [
          DataCell(Text(sumNamaModeller[i])),
          DataCell(_verticalDivider),
          DataCell(FutureBuilder(
              future: siklus.text.isEmpty
                  ? _getSpkByName('all', sumNamaModeller[i])
                  : _getSpkByName(siklusDesigner, sumNamaModeller[i]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Database Off');
                }
                if (snapshot.hasData) {
                  return Text(snapshot.data!.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })),
          DataCell(_verticalDivider),
          DataCell(FutureBuilder(
              future: siklus.text.isEmpty
                  ? _getSpkPendingByName('all', sumNamaModeller[i])
                  : _getSpkPendingByName(siklusDesigner, sumNamaModeller[i]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Database Off');
                }
                if (snapshot.hasData) {
                  return Text(snapshot.data!.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })),
          DataCell(_verticalDivider),
          DataCell(FutureBuilder(
              future: siklus.text.isEmpty
                  ? _getSpkSelesaiByName('all', sumNamaModeller[i])
                  : _getSpkSelesaiByName(siklusDesigner, sumNamaModeller[i]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Database Off');
                }
                if (snapshot.hasData) {
                  return Text(snapshot.data!.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })),
          DataCell(_verticalDivider),
          DataCell(FutureBuilder(
              future: siklus.text.isEmpty
                  ? _getSumPointByName('all', sumNamaModeller[i])
                  : _getSumPointByName(siklusDesigner, sumNamaModeller[i]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Database Off');
                }
                if (snapshot.hasData) {
                  return Text(snapshot.data!.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })),
          DataCell(_verticalDivider),
          DataCell(FutureBuilder(
              future: siklus.text.isEmpty
                  ? _getSumBeratByName('all', sumNamaModeller[i])
                  : _getSumBeratByName(siklusDesigner, sumNamaModeller[i]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Database Off');
                }
                if (snapshot.hasData) {
                  return Text(snapshot.data!.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })),
        ]),
    ];
  }

  _getSpkByName(month, name) async {
    var spk;
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      print('get data total spk berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByName = allData.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        spk = filterByName.toList().length;
      } else {
        var filterBySiklus = allData.where((element) =>
            element.siklus.toString().toLowerCase() ==
            month.toString().toLowerCase());
        var filterByName = filterBySiklus.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        spk = filterByName.toList().length;
      }

      return spk;
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getSumPointByName(month, name) async {
    double spk = 0;

    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      print('get data total spk berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByName = allData.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        var filterByPoint = filterByName
            .where((element) => double.parse(element.pointModeller!) > 0);
        for (var i = 0; i < filterByPoint.length; i++) {
          spk += double.parse(filterByPoint.toList()[i].pointModeller!);
        }
      } else {
        var filterBySiklus = allData.where((element) =>
            element.siklus.toString().toLowerCase() ==
            month.toString().toLowerCase());
        var filterByName = filterBySiklus.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        var filterByPoint = filterByName
            .where((element) => double.parse(element.pointModeller!) > 0);
        for (var i = 0; i < filterByPoint.length; i++) {
          spk += double.parse(filterByPoint.toList()[i].pointModeller!);
        }
      }

      return spk.toStringAsFixed(2);
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getSumBeratByName(month, name) async {
    double spk = 0;

    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      print('get data total spk berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByName = allData.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        var filterByPoint = filterByName
            .where((element) => double.parse(element.beratModeller!) > 0);
        for (var i = 0; i < filterByPoint.length; i++) {
          spk += double.parse(filterByPoint.toList()[i].beratModeller!);
        }
      } else {
        var filterBySiklus = allData.where((element) =>
            element.siklus.toString().toLowerCase() ==
            month.toString().toLowerCase());
        var filterByName = filterBySiklus.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        var filterByPoint = filterByName
            .where((element) => double.parse(element.beratModeller!) > 0);
        for (var i = 0; i < filterByPoint.length; i++) {
          spk += double.parse(filterByPoint.toList()[i].beratModeller!);
        }
      }

      return spk.toStringAsFixed(2);
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getSpkPendingByName(month, name) async {
    var spk;
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      print('get data total spk berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByName = allData.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        var filterByPoint = filterByName
            .where((element) => double.parse(element.pointModeller!) > 0);
        spk = filterByName.toList().length - filterByPoint.toList().length;
        print(spk);
      } else {
        var filterBySiklus = allData.where((element) =>
            element.siklus.toString().toLowerCase() ==
            month.toString().toLowerCase());
        var filterByName = filterBySiklus.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
            name.toString().toLowerCase());
        var filterByPoint = filterByName
            .where((element) => double.parse(element.pointModeller!) > 0);
        spk = filterByName.toList().length - filterByPoint.toList().length;
      }
      return spk;
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getSpkSelesaiByName(month, name) async {
    var spk;
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      print('get data total spk berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByName = allData.where((element) =>
            element.namaModeller.toString().toLowerCase() ==
                name.toString().toLowerCase() &&
            double.parse(element.pointModeller!) > 0);
        spk = filterByName.toList().length;
      } else {
        var filterBySiklus = allData.where((element) =>
            element.siklus.toString().toLowerCase() ==
            month.toString().toLowerCase());
        var filterByName = filterBySiklus.where((element) =>
            element.namaModeller.toString().toLowerCase() == "asrori" &&
            double.parse(element.pointModeller!) > 0);
        spk = filterByName.toList().length;
      }

      return spk;
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  //! dashboard SCM
  dashboardSCM() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: LayoutBuilder(builder: (context, constraints) {
                print(constraints.maxWidth);
                //? fungsi multi screen
                if (constraints.maxWidth < 900) {
                  return Column(
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
                              listKelasHarga.clear();

                              // isLoadingJenisBarang = true;
                              siklus.text = item!;
                              siklusDesigner = siklus.text.toString();
                              _getAllData(siklusDesigner,
                                  sharedPreferences!.getString('nama')!);
                            });
                            Future.delayed(const Duration(milliseconds: 500))
                                .then((value) {
                              setState(() {
                                // isLoadingJenisBarang = false;
                              });
                            });
                          },
                          popupProps:
                              const PopupPropsMultiSelection.modalBottomSheet(
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
                                labelText: "Pilih Siklus",
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                          ),
                        ),
                      ),
                      Container(
                          width: 300,
                          height: 40,
                          padding: const EdgeInsets.only(left: 0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                // side: BorderSide(color: Colors.white)
                              ))),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (c) {
                                      return const LoadingDialogWidget(
                                        message: "Please Wait...",
                                      );
                                    });
                                //call function another class
                                ExcelScreen().exportExcel(siklus.text);
                                Future.delayed(const Duration(seconds: 1))
                                    .then((value) {
                                  //! lalu eksekusi fungsi ini
                                  Navigator.pop(context);
                                });
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.download),
                                  VerticalDivider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                  SizedBox(width: 15),
                                  Text('Export to excel'),
                                ],
                              ))),
                    ],
                  );
                } else {
                  return Row(
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
                              listKelasHarga.clear();
                              // _getDataJenisBarang(item, '');
                              isLoadingJenisBarang = true;
                              siklus.text = item!;
                              siklusDesigner = siklus.text.toString();
                              _getAllData(siklusDesigner,
                                  sharedPreferences!.getString('nama')!);
                            });
                            Future.delayed(const Duration(milliseconds: 500))
                                .then((value) {
                              setState(() {
                                isLoadingJenisBarang = false;
                              });
                            });
                          },
                          popupProps:
                              const PopupPropsMultiSelection.modalBottomSheet(
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
                                labelText: "Pilih Siklus",
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      const SizedBox(width: 30),
                      Container(
                          height: 40,
                          padding: const EdgeInsets.only(left: 0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                // side: BorderSide(color: Colors.white)
                              ))),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (c) {
                                      return const LoadingDialogWidget(
                                        message: "Please Wait...",
                                      );
                                    });
                                //call function another class
                                ExcelAdmin().exportExcel(siklus.text);

                                Future.delayed(const Duration(seconds: 1))
                                    .then((value) {
                                  //! lalu eksekusi fungsi ini
                                  Navigator.pop(context);
                                });
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.download),
                                  VerticalDivider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                  SizedBox(width: 15),
                                  Text('Export to excel'),
                                ],
                              ))),
                    ],
                  );
                }
              })),

          LayoutBuilder(builder: (context, constraints) {
            print(constraints.maxWidth);
            //? fungsi multi screen
            if (constraints.maxWidth < 900) {
              return mobileScreen();
            } else {
              return webScreen();
            }
          }),

          //? table list scm
          isLoading == true
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.only(left: 500),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Lottie.asset("loadingJSON/loadingV2.json"),
                  ),
                ))
              : Container(
                  padding: const EdgeInsets.all(15),
                  width: 1300,
                  // width: MediaQuery.of(context).size.width * 0.9,

                  child: Theme(
                    data: ThemeData.light().copyWith(
                        // cardColor: Theme.of(context).canvasColor),
                        cardColor: Colors.white,
                        hoverColor: colorDasar,
                        dividerColor: Colors.grey),
                    child: PaginatedDataTable(
                        // ignore: deprecated_member_use
                        dataRowHeight: 200,
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: sort,
                        rowsPerPage: 10,
                        columnSpacing: 0,
                        columns: [
                          DataColumn(
                            label: Container(
                                padding: const EdgeInsets.only(left: 0),
                                child: const Text(
                                  "Aksi",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: const SizedBox(
                                  child: Text(
                                "Kode MDBC",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.kodeDesignMdbc!
                                        .toLowerCase()
                                        .compareTo(
                                            b.kodeDesignMdbc!.toLowerCase()));
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.kodeDesignMdbc!
                                        .toLowerCase()
                                        .compareTo(
                                            a.kodeDesignMdbc!.toLowerCase()));
                                  }
                                });
                              }),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: SizedBox(
                                  child:
                                      sharedPreferences!.getString('level') !=
                                              '1'
                                          ? const Text(
                                              "Kode Marketing",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const Text(
                                              "Nama\nDesigner",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sharedPreferences!.getString('level') ==
                                      '1') {
                                    if (sort == true) {
                                      sort = false;
                                      filterCrm!.sort((a, b) => a.namaDesigner!
                                          .toLowerCase()
                                          .compareTo(
                                              b.namaDesigner!.toLowerCase()));
                                    } else {
                                      sort = true;
                                      filterCrm!.sort((a, b) => b.namaDesigner!
                                          .toLowerCase()
                                          .compareTo(
                                              a.namaDesigner!.toLowerCase()));
                                    }
                                  } else {
                                    if (sort == true) {
                                      sort = false;
                                      filterCrm!.sort((a, b) => a.kodeMarketing!
                                          .toLowerCase()
                                          .compareTo(
                                              b.kodeMarketing!.toLowerCase()));
                                    } else {
                                      sort = true;
                                      filterCrm!.sort((a, b) => b.kodeMarketing!
                                          .toLowerCase()
                                          .compareTo(
                                              a.kodeMarketing!.toLowerCase()));
                                    }
                                  }
                                });
                              }),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: Container(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: const Text(
                                    "Tema",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.tema!
                                        .toLowerCase()
                                        .compareTo(b.tema!.toLowerCase()));
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.tema!
                                        .toLowerCase()
                                        .compareTo(a.tema!.toLowerCase()));
                                  }
                                });
                              }),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: const SizedBox(
                                  child: Text(
                                "Jenis Barang",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.jenisBarang!
                                        .toLowerCase()
                                        .compareTo(
                                            b.jenisBarang!.toLowerCase()));
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.jenisBarang!
                                        .toLowerCase()
                                        .compareTo(
                                            a.jenisBarang!.toLowerCase()));
                                  }
                                });
                              }),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: const SizedBox(
                                  child: Text(
                                "Harga",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                              onSort: (columnIndex, _) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (sort == true) {
                                    // myCrm.sort((a, b) => a['estimasiHarga'].)
                                    sort = false;
                                    filterCrm!.sort((a, b) => a.estimasiHarga!
                                        .compareTo(b.estimasiHarga!));
                                    // onsortColum(columnIndex, ascending);
                                  } else {
                                    sort = true;
                                    filterCrm!.sort((a, b) => b.estimasiHarga!
                                        .compareTo(a.estimasiHarga!));
                                  }
                                });
                              }),
                          DataColumn(label: _verticalDivider),
                          const DataColumn(
                            label: SizedBox(
                                child: Text(
                              "Kelas\nHarga",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )),
                          ),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                            label: Container(
                                padding: const EdgeInsets.only(left: 30),
                                child: const Text(
                                  "Gambar",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                        source:
                            // UserDataTableSource(userData: filterCrm!)),
                            RowSource(myData: myCrm, count: myCrm!.length)),
                  ),
                ),
        ]);
  }

  jenisBarangView1(jenisBarang) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            padding: const EdgeInsets.all(12),
            width: 300,
            height: 300,
            child: Card(
                color: Colors.white,
                child: FutureBuilder(
                    future: siklus.text.isEmpty
                        ? _getDataJeniBarangView1("all",
                            sharedPreferences!.getString('nama')!, jenisBarang)
                        : _getDataJeniBarangView1(siklusDesigner,
                            sharedPreferences!.getString('nama')!, jenisBarang),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Column(children: [
                          SizedBox(
                            height: 33,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isJenisBarangView1 = false;
                                      });
                                    },
                                    icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined)),
                                Container(
                                  padding: const EdgeInsets.only(left: 55),
                                  child: Text(jenisBarang,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: 5),
                          Center(
                              child: SizedBox(
                            width: 250,
                            height: 210,
                            child: Lottie.asset(
                                "loadingJSON/somethingwentwrong.json"),
                          ))
                        ]);
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(children: [
                          SizedBox(
                            height: 33,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isJenisBarangView1 = false;
                                      });
                                    },
                                    icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined)),
                                Container(
                                  padding: const EdgeInsets.only(left: 55),
                                  child: Text(jenisBarang,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: 5),
                          Container(
                            padding: const EdgeInsets.all(0),
                            width: 90,
                            height: 90,
                            child: Lottie.asset("loadingJSON/loadingV1.json"),
                          )
                        ]);
                      }
                      if (snapshot.data!.isEmpty) {
                        return Column(children: [
                          SizedBox(
                            height: 33,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isJenisBarangView1 = false;
                                      });
                                    },
                                    icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined)),
                                Container(
                                  padding: const EdgeInsets.only(left: 55),
                                  child: Text(jenisBarang,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: 5),
                          const Center(
                            child: Text(
                              'Tidak ada data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Acne',
                                  letterSpacing: 1.5),
                            ),
                          )
                        ]);
                      }
                      if (snapshot.hasData) {
                        return Column(children: [
                          SizedBox(
                            height: 33,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isJenisBarangView1 = false;
                                      });
                                    },
                                    icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined)),
                                Container(
                                  padding: const EdgeInsets.only(left: 55),
                                  child: Text(jenisBarang,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: 5),
                          Expanded(
                            child: isLoadingJenisBarang == true
                                ? Container(
                                    padding: const EdgeInsets.all(0),
                                    width: 90,
                                    height: 90,
                                    child: Lottie.asset(
                                        "loadingJSON/loadingV1.json"),
                                  )
                                : ListView.builder(
                                    itemCount: listJenisBarangView1!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = snapshot.data![index];
                                      return Container(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 17),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data.kodeDesignMdbc
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    listJenisBarangView1!
                                                        .where((element) =>
                                                            element
                                                                .kodeDesignMdbc
                                                                .toString()
                                                                .toLowerCase() ==
                                                            data.kodeDesignMdbc
                                                                .toString()
                                                                .toLowerCase())
                                                        .toList()
                                                        .length
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ]);
                      }
                      return Column(children: [
                        const Text('Jenis Barang',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            )),
                        const Divider(thickness: 5),
                        Container(
                          padding: const EdgeInsets.all(0),
                          width: 90,
                          height: 90,
                          child: Lottie.asset("loadingJSON/loadingV1.json"),
                        )
                      ]);
                    }))));
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

  mobileScreen() {
    return isSummaryModeller == true
        ? Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: const EdgeInsets.all(0),
                width: 900,
                height: 330,
                child: Card(
                    color: Colors.white,
                    child: Column(children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSummaryModeller = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("loadingJSON/backbutton.json",
                                fit: BoxFit.cover),
                            Container(
                              padding: const EdgeInsets.only(left: 0),
                              alignment: Alignment.center,
                              child: const Text('Summary Modeller',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 5),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width * 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: Theme(
                              data: ThemeData.light().copyWith(
                                  // cardColor: Theme.of(context).canvasColor),
                                  cardColor: Colors.white,
                                  hoverColor: Colors.grey.shade400,
                                  dividerColor: Colors.grey),
                              child: _dataTableSumModeller(),
                            ),
                          ),
                        ),
                      ),
                    ]))))
        : Column(
            children: [
              //*report jenis barang SCM
              isJenisBarangView1 == true
                  ? jenisBarangView1(namaJenisBarangView1)
                  : Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          width: 300,
                          height: 300,
                          child: Card(
                              color: Colors.white,
                              child: Column(children: [
                                const Text('Sum Jenis Barang',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    )),
                                const Divider(thickness: 5),
                                Expanded(
                                  child: isLoadingJenisBarang == true
                                      ? Container(
                                          padding: const EdgeInsets.all(0),
                                          width: 90,
                                          height: 90,
                                          child: Lottie.asset(
                                              "loadingJSON/loadingV1.json"),
                                        )
                                      : ListView.builder(
                                          itemCount:
                                              uniqListJenisBarang!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var data = listJenisBarang![index];
                                            var dataUniq =
                                                uniqListJenisBarang![index];
                                            return Container(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 17),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          namaJenisBarangView1 =
                                                              data.jenisBarang
                                                                  .toString();
                                                          isJenisBarangView1 =
                                                              true;
                                                        });
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue
                                                                  .shade100,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            dataUniq.jenisBarang
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            listJenisBarang!
                                                                .where((element) =>
                                                                    element
                                                                        .jenisBarang
                                                                        .toString()
                                                                        .toLowerCase() ==
                                                                    dataUniq
                                                                        .jenisBarang
                                                                        .toString()
                                                                        .toLowerCase())
                                                                .toList()
                                                                .length
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ])))),

              //*report kelas harga
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 300,
                      height: 300,
                      child: Card(
                          color: Colors.white,
                          child: Column(children: [
                            const Text('Sum Kelas Harga',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                            const Divider(thickness: 5),
                            Expanded(
                              child: isLoadingKelasHarga == true
                                  ? Container(
                                      padding: const EdgeInsets.all(0),
                                      width: 90,
                                      height: 90,
                                      child: Lottie.asset(
                                          "loadingJSON/loadingV1.json"),
                                    )
                                  : ListView.builder(
                                      itemCount: uniqListKelasHarga.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var data = listKelasHarga[index];
                                        var dataUniq =
                                            uniqListKelasHarga[index];
                                        return Container(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      namaKelasHargaView1 =
                                                          data;
                                                      isKelasHargaView1 = true;
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.blue.shade100,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        dataUniq,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        listKelasHarga
                                                            .where((element) =>
                                                                element
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                dataUniq
                                                                    .toString()
                                                                    .toLowerCase())
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ])))),

              //* report Menu Report
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 300,
                      height: 300,
                      child: Card(
                          color: Colors.white,
                          child: Column(children: [
                            const Text('Report',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                            const Divider(thickness: 5),
                            Expanded(
                                child: isLoadingReport == true
                                    ? Container(
                                        padding: const EdgeInsets.all(0),
                                        width: 90,
                                        height: 90,
                                        child: Lottie.asset(
                                            "loadingJSON/loadingV1.json"),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              //? SPK
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.blue.shade100,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'SPK',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        '$totalSPK',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              //? SPK LENGKAP
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'SPK Lengkap',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        '$batuLengkap',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              //? SPK Tidak LENGKAP
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.orange,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'SPK Tidak Lengkap',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        '$batuBelumLengkap',
                                                        // '($totalSPK - $batuLengkap)',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              //? SPK Cancel
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'SPK Cancel',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        '0',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),

                                              //? Total harga
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.blue.shade100,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Total',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        'Rp. ${CurrencyFormat.convertToDollar(totalHarga, 0)}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                          ])))),

              //* report Point Modeller
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 300,
                      height: 300,
                      child: Card(
                          color: Colors.white,
                          child: Column(children: [
                            const Text('Point Modeller',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                            const Divider(thickness: 5),
                            Expanded(
                                child: isLoadingPointModeller == true
                                    ? Container(
                                        padding: const EdgeInsets.all(0),
                                        width: 90,
                                        height: 90,
                                        child: Lottie.asset(
                                            "loadingJSON/loadingV1.json"),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              //? Arif Kurniawan
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                // child: ElevatedButton(
                                                //   onPressed: () {
                                                //     setState(() {});
                                                //   },
                                                //   style: ElevatedButton.styleFrom(
                                                //       backgroundColor:
                                                //           Colors.blue
                                                //               .shade100,
                                                //       shape: RoundedRectangleBorder(
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(
                                                //                       50.0))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Arif Kurniawan',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //fungsi menampilkan jumlah SESUAI table
                                                    Text(
                                                      pointArif
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                // ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),

                                              //? Aris Pravidan
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                // child: ElevatedButton(
                                                //   onPressed: () {
                                                //     setState(() {});
                                                //   },
                                                //   style: ElevatedButton.styleFrom(
                                                //       backgroundColor:
                                                //           Colors.blue
                                                //               .shade100,
                                                //       shape: RoundedRectangleBorder(
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(
                                                //                       50.0))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Aris Pravidan',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //fungsi menampilkan jumlah SESUAI table
                                                    Text(
                                                      pointAris
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                // ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              //? Fikryansyah
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                // child: ElevatedButton(
                                                //   onPressed: () {
                                                //     setState(() {});
                                                //   },
                                                //   style: ElevatedButton.styleFrom(
                                                //       backgroundColor:
                                                //           Colors.blue
                                                //               .shade100,
                                                //       shape: RoundedRectangleBorder(
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(
                                                //                       50.0))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Fikryansyah',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //fungsi menampilkan jumlah SESUAI table
                                                    Text(
                                                      pointFikri
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                // ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              //? Yuse
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Yuse',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //fungsi menampilkan jumlah SESUAI table
                                                    Text(
                                                      pointyuse
                                                          .toStringAsFixed(2),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                // ),
                                              ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              //? Summary Report Modeller
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isSummaryModeller = true;
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.blue.shade100,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0))),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Summary Report',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_sharp,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                          ])))),
            ],
          );
  }

  webScreen() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: isSummaryModeller == true
          ? Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  padding: const EdgeInsets.all(0),
                  width: 900,
                  height: 330,
                  child: Card(
                      color: Colors.white,
                      child: Column(children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSummaryModeller = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("loadingJSON/backbutton.json",
                                  fit: BoxFit.cover),
                              Container(
                                padding: const EdgeInsets.only(left: 0),
                                alignment: Alignment.center,
                                child: const Text('Summary Modeller',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 5),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width * 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: Theme(
                                data: ThemeData.light().copyWith(
                                    // cardColor: Theme.of(context).canvasColor),
                                    cardColor: Colors.white,
                                    hoverColor: Colors.grey.shade400,
                                    dividerColor: Colors.grey),
                                child: _dataTableSumModeller(),
                              ),
                            ),
                          ),
                        ),
                      ]))))
          : Row(
              children: [
                //*report jenis barang SCM
                isJenisBarangView1 == true
                    ? jenisBarangView1(namaJenisBarangView1)
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            width: 300,
                            height: 300,
                            child: Card(
                                color: Colors.white,
                                child: Column(children: [
                                  const Text('Sum Jenis Barang',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                  const Divider(thickness: 5),
                                  Expanded(
                                    child: isLoadingJenisBarang == true
                                        ? Container(
                                            padding: const EdgeInsets.all(0),
                                            width: 90,
                                            height: 90,
                                            child: Lottie.asset(
                                                "loadingJSON/loadingV1.json"),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                uniqListJenisBarang!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var data =
                                                  listJenisBarang![index];
                                              var dataUniq =
                                                  uniqListJenisBarang![index];
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 17),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            namaJenisBarangView1 =
                                                                data.jenisBarang
                                                                    .toString();
                                                            isJenisBarangView1 =
                                                                true;
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.blue
                                                                    .shade100,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0))),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              dataUniq
                                                                  .jenisBarang
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              listJenisBarang!
                                                                  .where((element) =>
                                                                      element
                                                                          .jenisBarang
                                                                          .toString()
                                                                          .toLowerCase() ==
                                                                      dataUniq
                                                                          .jenisBarang
                                                                          .toString()
                                                                          .toLowerCase())
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      thickness: 1,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                ])))),

                //*report kelas harga
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        width: 300,
                        height: 300,
                        child: Card(
                            color: Colors.white,
                            child: Column(children: [
                              const Text('Sum Kelas Harga',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  )),
                              const Divider(thickness: 5),
                              Expanded(
                                child: isLoadingKelasHarga == true
                                    ? Container(
                                        padding: const EdgeInsets.all(0),
                                        width: 90,
                                        height: 90,
                                        child: Lottie.asset(
                                            "loadingJSON/loadingV1.json"),
                                      )
                                    : ListView.builder(
                                        itemCount: uniqListKelasHarga.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var data = listKelasHarga[index];
                                          var dataUniq =
                                              uniqListKelasHarga[index];
                                          return Container(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        namaKelasHargaView1 =
                                                            data;
                                                        isKelasHargaView1 =
                                                            true;
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .blue.shade100,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          dataUniq,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          listKelasHarga
                                                              .where((element) =>
                                                                  element
                                                                      .toString()
                                                                      .toLowerCase() ==
                                                                  dataUniq
                                                                      .toString()
                                                                      .toLowerCase())
                                                              .length
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ])))),

                //* report Menu Report
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        width: 300,
                        height: 300,
                        child: Card(
                            color: Colors.white,
                            child: Column(children: [
                              const Text('Summary Report',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  )),
                              const Divider(thickness: 5),
                              Expanded(
                                  child: isLoadingReport == true
                                      ? Container(
                                          padding: const EdgeInsets.all(0),
                                          width: 90,
                                          height: 90,
                                          child: Lottie.asset(
                                              "loadingJSON/loadingV1.json"),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Container(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                //? SPK
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .blue.shade100,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'SPK',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        //fungsi menampilkan jumlah SESUAI table
                                                        Text(
                                                          '$totalSPK',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                //? SPK LENGKAP
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'SPK Lengkap',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        //fungsi menampilkan jumlah SESUAI table
                                                        Text(
                                                          '$batuLengkap',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                //? SPK Tidak LENGKAP
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.orange,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'SPK Tidak Lengkap',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        //fungsi menampilkan jumlah SESUAI table
                                                        Text(
                                                          '$batuBelumLengkap',
                                                          // '($totalSPK - $batuLengkap)',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                //? SPK Cancel
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'SPK Cancel',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        //fungsi menampilkan jumlah SESUAI table
                                                        Text(
                                                          '0',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),

                                                //? Total harga
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .blue.shade100,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Total',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        //fungsi menampilkan jumlah SESUAI table
                                                        Text(
                                                          'Rp. ${CurrencyFormat.convertToDollar(totalHarga, 0)}',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                            ])))),

                //* report Point Modeller
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        width: 300,
                        height: 300,
                        child: Card(
                            color: Colors.white,
                            child: Column(children: [
                              const Text('Point Modeller',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  )),
                              const Divider(thickness: 5),
                              Expanded(
                                  child: isLoadingPointModeller == true
                                      ? Container(
                                          padding: const EdgeInsets.all(0),
                                          width: 90,
                                          height: 90,
                                          child: Lottie.asset(
                                              "loadingJSON/loadingV1.json"),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Container(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                //? Arif Kurniawan
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  // child: ElevatedButton(
                                                  //   onPressed: () {
                                                  //     setState(() {});
                                                  //   },
                                                  //   style: ElevatedButton.styleFrom(
                                                  //       backgroundColor:
                                                  //           Colors.blue
                                                  //               .shade100,
                                                  //       shape: RoundedRectangleBorder(
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Arif Kurniawan',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        pointArif
                                                            .toStringAsFixed(2),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  // ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),

                                                //? Aris Pravidan
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  // child: ElevatedButton(
                                                  //   onPressed: () {
                                                  //     setState(() {});
                                                  //   },
                                                  //   style: ElevatedButton.styleFrom(
                                                  //       backgroundColor:
                                                  //           Colors.blue
                                                  //               .shade100,
                                                  //       shape: RoundedRectangleBorder(
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Aris Pravidan',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        pointAris
                                                            .toStringAsFixed(2),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  // ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                //? Fikryansyah
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  // child: ElevatedButton(
                                                  //   onPressed: () {
                                                  //     setState(() {});
                                                  //   },
                                                  //   style: ElevatedButton.styleFrom(
                                                  //       backgroundColor:
                                                  //           Colors.blue
                                                  //               .shade100,
                                                  //       shape: RoundedRectangleBorder(
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       50.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Fikryansyah',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        pointFikri
                                                            .toStringAsFixed(2),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  // ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                //? Yuse
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Yuse',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      //fungsi menampilkan jumlah SESUAI table
                                                      Text(
                                                        pointyuse
                                                            .toStringAsFixed(2),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  // ),
                                                ),

                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                //? Summary Report Modeller
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isSummaryModeller =
                                                            true;
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .blue.shade100,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Summary Report',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        //fungsi menampilkan jumlah SESUAI table
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_sharp,
                                                          color: Colors.black,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                            ])))),
              ],
            ),
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
    // ignore: prefer_interpolation_to_compose_strings
    String? updateSiklus = '';
    return DataRow(cells: [
      //! aksi
      DataCell(Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            sharedPreferences!.getString('level') == '1'
                ? IconButton(
                    onPressed: () {
                      final dropdownFormKey = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              // title: const Text('Pilih Siklus'),
                              content: SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    Form(
                                        key: dropdownFormKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DropdownSearch<String>(
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
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintText: 'Pilih Siklus',
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              validator: (value) => value ==
                                                      null
                                                  ? "Siklus tidak boleh kosong"
                                                  : null,
                                              onChanged: (String? newValue) {
                                                updateSiklus = newValue;
                                              },
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (dropdownFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      //? method untuk mengganti siklus
                                                      updateSiklusDesigner(
                                                          data.id,
                                                          updateSiklus);

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (c) =>
                                                                  MainViewScm(
                                                                      col: 0)));
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const AlertDialog(
                                                                title: Text(
                                                                  'Design Berhasil Dipindahkan',
                                                                ),
                                                              ));
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.rotate_90_degrees_ccw,
                      color: Colors.blue,
                    ))
                : sharedPreferences!.getString('level') == '2'
                    ? IconButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => FormROScreen(
                                        modelDesigner: FormDesignerModel(
                                          id: data.id,
                                          kodeDesignMdbc: data.kodeDesignMdbc,
                                          kodeMarketing: data.kodeMarketing,
                                          kodeProduksi: data.kodeProduksi,
                                          namaDesigner: data.namaDesigner,
                                          namaModeller: data.namaModeller,
                                          kodeDesign: data.kodeDesign,
                                          siklus: data.siklus,
                                          tema: data.tema,
                                          rantai: data.rantai,
                                          qtyRantai: data.qtyRantai,
                                          lain2: data.lain2,
                                          qtyLain2: data.qtyLain2,
                                          earnut: data.earnut,
                                          qtyEarnut: data.qtyEarnut,
                                          panjangRantai: data.panjangRantai,
                                          customKomponen: data.customKomponen,
                                          qtyCustomKomponen:
                                              data.qtyCustomKomponen,
                                          jenisBarang: data.jenisBarang,
                                          kategoriBarang: data.kategoriBarang,
                                          brand: data.brand,
                                          photoShoot: data.photoShoot,
                                          color: data.color,
                                          beratEmas: data.beratEmas,
                                          estimasiHarga: data.estimasiHarga,
                                          ringSize: data.ringSize,
                                          created_at: data.created_at,
                                          batu1: data.batu1,
                                          qtyBatu1: data.qtyBatu1,
                                          batu2: data.batu2,
                                          qtyBatu2: data.qtyBatu2,
                                          batu3: data.batu3,
                                          qtyBatu3: data.qtyBatu3,
                                          batu4: data.batu4,
                                          qtyBatu4: data.qtyBatu4,
                                          batu5: data.batu5,
                                          qtyBatu5: data.qtyBatu5,
                                          batu6: data.batu6,
                                          qtyBatu6: data.qtyBatu6,
                                          batu7: data.batu7,
                                          qtyBatu7: data.qtyBatu7,
                                          batu8: data.batu8,
                                          qtyBatu8: data.qtyBatu8,
                                          batu9: data.batu9,
                                          qtyBatu9: data.qtyBatu9,
                                          batu10: data.batu10,
                                          qtyBatu10: data.qtyBatu10,
                                          batu11: data.batu11,
                                          qtyBatu11: data.qtyBatu11,
                                          batu12: data.batu12,
                                          qtyBatu12: data.qtyBatu12,
                                          batu13: data.batu13,
                                          qtyBatu13: data.qtyBatu13,
                                          batu14: data.batu14,
                                          qtyBatu14: data.qtyBatu14,
                                          batu15: data.batu15,
                                          qtyBatu15: data.qtyBatu15,
                                          batu16: data.batu16,
                                          qtyBatu16: data.qtyBatu16,
                                          batu17: data.batu17,
                                          qtyBatu17: data.qtyBatu17,
                                          batu18: data.batu18,
                                          qtyBatu18: data.qtyBatu18,
                                          batu19: data.batu19,
                                          qtyBatu19: data.qtyBatu19,
                                          batu20: data.batu20,
                                          qtyBatu20: data.qtyBatu20,
                                          batu21: data.batu21,
                                          qtyBatu21: data.qtyBatu21,
                                          batu22: data.batu22,
                                          qtyBatu22: data.qtyBatu22,
                                          batu23: data.batu23,
                                          qtyBatu23: data.qtyBatu23,
                                          batu24: data.batu24,
                                          qtyBatu24: data.qtyBatu24,
                                          batu25: data.batu25,
                                          qtyBatu25: data.qtyBatu25,
                                          batu26: data.batu26,
                                          qtyBatu26: data.qtyBatu26,
                                          batu27: data.batu27,
                                          qtyBatu27: data.qtyBatu27,
                                          batu28: data.batu28,
                                          qtyBatu28: data.qtyBatu28,
                                          batu29: data.batu29,
                                          qtyBatu29: data.qtyBatu29,
                                          batu30: data.batu30,
                                          qtyBatu30: data.qtyBatu30,
                                          batu31: data.batu31,
                                          qtyBatu31: data.qtyBatu31,
                                          batu32: data.batu32,
                                          qtyBatu32: data.qtyBatu32,
                                          batu33: data.batu33,
                                          qtyBatu33: data.qtyBatu33,
                                          batu34: data.batu34,
                                          qtyBatu34: data.qtyBatu34,
                                          batu35: data.batu35,
                                          qtyBatu35: data.qtyBatu35,
                                          imageUrl: data.imageUrl,
                                          keteranganStatusBatu:
                                              data.keteranganStatusBatu,
                                          pointModeller: data.pointModeller,
                                          tanggalInModeller:
                                              data.tanggalInModeller,
                                          tanggalOutModeller:
                                              data.tanggalOutModeller,
                                          tanggalInProduksi:
                                              data.tanggalInProduksi,
                                          beratModeller: data.beratModeller,
                                          statusForm: data.statusForm,
                                          jo: data.jo,
                                        ),
                                      )));
                        },
                        icon: Stack(
                          clipBehavior:
                              Clip.none, //agar tidak menghalangi object

                          children: [
                            //tambahan icon ADD
                            Positioned(
                              right: -13.0,
                              top: -10.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                              ),
                            ),
                            const Text(
                              'RO',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                    : const SizedBox(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => FormViewScreen(
                                modelDesigner: FormDesignerModel(
                                  statusForm: data.statusForm,
                                  id: data.id,
                                  kodeDesignMdbc: data.kodeDesignMdbc,
                                  kodeMarketing: data.kodeMarketing,
                                  kodeProduksi: data.kodeProduksi,
                                  namaDesigner: data.namaDesigner,
                                  namaModeller: data.namaModeller,
                                  kodeDesign: data.kodeDesign,
                                  siklus: data.siklus,
                                  tema: data.tema,
                                  rantai: data.rantai,
                                  qtyRantai: data.qtyRantai,
                                  lain2: data.lain2,
                                  qtyLain2: data.qtyLain2,
                                  earnut: data.earnut,
                                  qtyEarnut: data.qtyEarnut,
                                  panjangRantai: data.panjangRantai,
                                  customKomponen: data.customKomponen,
                                  qtyCustomKomponen: data.qtyCustomKomponen,
                                  jenisBarang: data.jenisBarang,
                                  kategoriBarang: data.kategoriBarang,
                                  brand: data.brand,
                                  photoShoot: data.photoShoot,
                                  color: data.color,
                                  beratEmas: data.beratEmas,
                                  estimasiHarga: data.estimasiHarga,
                                  ringSize: data.ringSize,
                                  created_at: data.created_at,
                                  batu1: data.batu1,
                                  qtyBatu1: data.qtyBatu1,
                                  batu2: data.batu2,
                                  qtyBatu2: data.qtyBatu2,
                                  batu3: data.batu3,
                                  qtyBatu3: data.qtyBatu3,
                                  batu4: data.batu4,
                                  qtyBatu4: data.qtyBatu4,
                                  batu5: data.batu5,
                                  qtyBatu5: data.qtyBatu5,
                                  batu6: data.batu6,
                                  qtyBatu6: data.qtyBatu6,
                                  batu7: data.batu7,
                                  qtyBatu7: data.qtyBatu7,
                                  batu8: data.batu8,
                                  qtyBatu8: data.qtyBatu8,
                                  batu9: data.batu9,
                                  qtyBatu9: data.qtyBatu9,
                                  batu10: data.batu10,
                                  qtyBatu10: data.qtyBatu10,
                                  batu11: data.batu11,
                                  qtyBatu11: data.qtyBatu11,
                                  batu12: data.batu12,
                                  qtyBatu12: data.qtyBatu12,
                                  batu13: data.batu13,
                                  qtyBatu13: data.qtyBatu13,
                                  batu14: data.batu14,
                                  qtyBatu14: data.qtyBatu14,
                                  batu15: data.batu15,
                                  qtyBatu15: data.qtyBatu15,
                                  batu16: data.batu16,
                                  qtyBatu16: data.qtyBatu16,
                                  batu17: data.batu17,
                                  qtyBatu17: data.qtyBatu17,
                                  batu18: data.batu18,
                                  qtyBatu18: data.qtyBatu18,
                                  batu19: data.batu19,
                                  qtyBatu19: data.qtyBatu19,
                                  batu20: data.batu20,
                                  qtyBatu20: data.qtyBatu20,
                                  batu21: data.batu21,
                                  qtyBatu21: data.qtyBatu21,
                                  batu22: data.batu22,
                                  qtyBatu22: data.qtyBatu22,
                                  batu23: data.batu23,
                                  qtyBatu23: data.qtyBatu23,
                                  batu24: data.batu24,
                                  qtyBatu24: data.qtyBatu24,
                                  batu25: data.batu25,
                                  qtyBatu25: data.qtyBatu25,
                                  batu26: data.batu26,
                                  qtyBatu26: data.qtyBatu26,
                                  batu27: data.batu27,
                                  qtyBatu27: data.qtyBatu27,
                                  batu28: data.batu28,
                                  qtyBatu28: data.qtyBatu28,
                                  batu29: data.batu29,
                                  qtyBatu29: data.qtyBatu29,
                                  batu30: data.batu30,
                                  qtyBatu30: data.qtyBatu30,
                                  batu31: data.batu31,
                                  qtyBatu31: data.qtyBatu31,
                                  batu32: data.batu32,
                                  qtyBatu32: data.qtyBatu32,
                                  batu33: data.batu33,
                                  qtyBatu33: data.qtyBatu33,
                                  batu34: data.batu34,
                                  qtyBatu34: data.qtyBatu34,
                                  batu35: data.batu35,
                                  qtyBatu35: data.qtyBatu35,
                                  imageUrl: data.imageUrl,
                                  keteranganStatusBatu:
                                      data.keteranganStatusBatu,
                                  pointModeller: data.pointModeller,
                                  tanggalInModeller: data.tanggalInModeller,
                                  tanggalOutModeller: data.tanggalOutModeller,
                                  tanggalInProduksi: data.tanggalInProduksi,
                                  beratModeller: data.beratModeller,
                                  jo: data.jo,
                                ),
                              )));
                },
                icon: (sharedPreferences!.getString('level') != '3' &&
                        double.parse(data.pointModeller) > 0 &&
                        data.tanggalOutModeller.toString().isEmpty)
                    ? Stack(
                        clipBehavior: Clip.none, //agar tidak menghalangi object

                        children: [
                          //tambahan icon ADD
                          Positioned(
                            right: -10.0,
                            top: -13.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.remove_red_eye,
                            color: Colors.green,
                          ),
                        ],
                      )
                    : sharedPreferences!.getString('level') != '3'
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.blue,
                          )
                        : data.pointModeller != '0'
                            ? const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.blue,
                              )
                            : Stack(
                                clipBehavior:
                                    Clip.none, //agar tidak menghalangi object

                                children: [
                                  //tambahan icon ADD
                                  Positioned(
                                    right: -10.0,
                                    top: -13.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.green,
                                  ),
                                ],
                              )),
            //? printing
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => PrintPage(
                              modelDesigner: FormDesignerModel(
                                id: data.id,
                                kodeDesignMdbc: data.kodeDesignMdbc,
                                kodeMarketing: data.kodeMarketing,
                                kodeProduksi: data.kodeProduksi,
                                namaDesigner: data.namaDesigner,
                                namaModeller: data.namaModeller ?? '  ',
                                kodeDesign: data.kodeDesign,
                                siklus: data.siklus,
                                tema: data.tema,
                                rantai: data.rantai,
                                qtyRantai: data.qtyRantai,
                                lain2: data.lain2,
                                qtyLain2: data.qtyLain2,
                                earnut: data.earnut,
                                qtyEarnut: data.qtyEarnut,
                                panjangRantai: data.panjangRantai,
                                customKomponen: data.customKomponen,
                                qtyCustomKomponen: data.qtyCustomKomponen,
                                jenisBarang: data.jenisBarang,
                                kategoriBarang: data.kategoriBarang,
                                brand: data.brand,
                                photoShoot: data.photoShoot,
                                color: data.color,
                                beratEmas: data.beratEmas,
                                estimasiHarga: data.estimasiHarga,
                                ringSize: data.ringSize,
                                created_at: data.created_at,
                                batu1: data.batu1,
                                qtyBatu1: data.qtyBatu1,
                                batu2: data.batu2,
                                qtyBatu2: data.qtyBatu2,
                                batu3: data.batu3,
                                qtyBatu3: data.qtyBatu3,
                                batu4: data.batu4,
                                qtyBatu4: data.qtyBatu4,
                                batu5: data.batu5,
                                qtyBatu5: data.qtyBatu5,
                                batu6: data.batu6,
                                qtyBatu6: data.qtyBatu6,
                                batu7: data.batu7,
                                qtyBatu7: data.qtyBatu7,
                                batu8: data.batu8,
                                qtyBatu8: data.qtyBatu8,
                                batu9: data.batu9,
                                qtyBatu9: data.qtyBatu9,
                                batu10: data.batu10,
                                qtyBatu10: data.qtyBatu10,
                                batu11: data.batu11,
                                qtyBatu11: data.qtyBatu11,
                                batu12: data.batu12,
                                qtyBatu12: data.qtyBatu12,
                                batu13: data.batu13,
                                qtyBatu13: data.qtyBatu13,
                                batu14: data.batu14,
                                qtyBatu14: data.qtyBatu14,
                                batu15: data.batu15,
                                qtyBatu15: data.qtyBatu15,
                                batu16: data.batu16,
                                qtyBatu16: data.qtyBatu16,
                                batu17: data.batu17,
                                qtyBatu17: data.qtyBatu17,
                                batu18: data.batu18,
                                qtyBatu18: data.qtyBatu18,
                                batu19: data.batu19,
                                qtyBatu19: data.qtyBatu19,
                                batu20: data.batu20,
                                qtyBatu20: data.qtyBatu20,
                                batu21: data.batu21,
                                qtyBatu21: data.qtyBatu21,
                                batu22: data.batu22,
                                qtyBatu22: data.qtyBatu22,
                                batu23: data.batu23,
                                qtyBatu23: data.qtyBatu23,
                                batu24: data.batu24,
                                qtyBatu24: data.qtyBatu24,
                                batu25: data.batu25,
                                qtyBatu25: data.qtyBatu25,
                                batu26: data.batu26,
                                qtyBatu26: data.qtyBatu26,
                                batu27: data.batu27,
                                qtyBatu27: data.qtyBatu27,
                                batu28: data.batu28,
                                qtyBatu28: data.qtyBatu28,
                                batu29: data.batu29,
                                qtyBatu29: data.qtyBatu29,
                                batu30: data.batu30,
                                qtyBatu30: data.qtyBatu30,
                                batu31: data.batu31,
                                qtyBatu31: data.qtyBatu31,
                                batu32: data.batu32,
                                qtyBatu32: data.qtyBatu32,
                                batu33: data.batu33,
                                qtyBatu33: data.qtyBatu33,
                                batu34: data.batu34,
                                qtyBatu34: data.qtyBatu34,
                                batu35: data.batu35,
                                qtyBatu35: data.qtyBatu35,
                                imageUrl: data.imageUrl,
                                keteranganStatusBatu: data.keteranganStatusBatu,
                                pointModeller: data.pointModeller,
                                tanggalInModeller: data.tanggalInModeller,
                                tanggalOutModeller: data.tanggalOutModeller,
                                tanggalInProduksi: data.tanggalInProduksi,
                                beratModeller: data.beratModeller,
                                statusForm: data.statusForm,
                                jo: data.jo,
                              ),
                            )));
              },
              icon: const Icon(
                Icons.print,
                color: Colors.blue,
              ),
            )
          ],
        );
      })),

      DataCell(_verticalDivider),
      //kodeDesignMdbc
      DataCell(
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Text(
              data.kodeDesignMdbc,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
      ),
      DataCell(_verticalDivider),
      //namaDesigner
      DataCell(
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: sharedPreferences!.getString('level') != '1'
                ? Text(
                    data.kodeMarketing,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  )
                : Text(
                    data.namaDesigner,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  )),
      ),
      DataCell(_verticalDivider),
      //tema
      DataCell(
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Text(
              data.tema,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
      ),
      DataCell(_verticalDivider),
      //jenisBarang
      DataCell(
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Text(
              data.jenisBarang,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
      ),
      DataCell(_verticalDivider),
      //estimasiHarga
      DataCell(
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(0),
          child: Text(
            data.brand == "BELI BERLIAN"
                ? 'Rp. ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}'
                : data.brand == "METIER"
                    ? 'Rp. ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}'
                    : '\$ ${CurrencyFormat.convertToDollar(data.estimasiHarga, 0)}',
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      DataCell(_verticalDivider),
      //kelas harga
      DataCell(
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: (data.brand.toString().toLowerCase() == "parva" ||
                    data.brand.toString().toLowerCase() == "fine")
                ? ((data.estimasiHarga * 0.37) * 11500) <= 5000000
                    ? const Text(
                        "XS",
                        maxLines: 2,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                        ? const Text(
                            "S",
                            maxLines: 2,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
                            ? const Text(
                                "M",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )
                            : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
                                ? const Text(
                                    "L",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                                : const Text(
                                    "XL",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )
                : (data.estimasiHarga) <= 5000000
                    ? const Text(
                        "XS",
                        maxLines: 2,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    : (data.estimasiHarga) <= 10000000
                        ? const Text(
                            "S",
                            maxLines: 2,
                            style: TextStyle(fontSize: 20, color: Colors.black),
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
                                        fontSize: 20, color: Colors.black),
                                  )
                                : const Text(
                                    "XL",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )),
      ),
      DataCell(_verticalDivider),
      //gambar
      DataCell(Builder(builder: (context) {
        return Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: 150,
              height: 190,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => ViewPhotoScreen(
                                model: FormDesignerModel(
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
    ]);
  }

  updateSiklusDesigner(id, siklus) async {
    Map<String, String> body = {
      'id': id.toString(),
      'siklus': siklus.toString(),
    };
    final response = await http.post(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.updateSiklusdesigner}'),
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

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
