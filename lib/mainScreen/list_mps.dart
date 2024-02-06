// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/SCM/mainScreen/row_source_scm.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/mainScreen/view_photo_mps.dart';
// import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/model/list_mps_model.dart';
import 'package:form_designer/produksi/modelProduksi/artist_produksi_model.dart';
import 'package:form_designer/produksi/modelProduksi/divisi_produksi_model.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../api/api_constant.dart';
import '../global/global.dart';

class ListMpsScreen extends StatefulWidget {
  const ListMpsScreen({super.key});
  @override
  State<ListMpsScreen> createState() => _ListMpsScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListMpsScreenState extends State<ListMpsScreen> {
  List<dynamic> filteredData = [];
  List<String> listJenisBarang = [];
  List<String> listArtist = [];
  List<String> listDivisi = [];
  List<String> listBulan = [];
  List<int> listIdDivisi = [];
  List<String> listSubDivisiArtistFinishing = [];
  List<String> listSubDivisiArtistPolishing = [];
  List<String> listSubDivisiArtistStell = [];
  List<String> listSubDivisiArtistPasangBatu = [];

  TextEditingController controller = TextEditingController();
  bool sort = true;
  int _currentSortColumn = 0;
  // List<FormDesignerModel>? filterDataProduksi;
  // List<FormDesignerModel>? myCrm;
  // List<FormDesignerModel>? myDataProduksi;
  List<ListMpsModel>? filterDataProduksi;
  List<ListMpsModel>? myDataProduksi;
  final searchController = TextEditingController();
  bool isLoading = false;
  bool isLoadingKeteranganMinggu = false;

  String siklusDesigner = '';
  String pilihWeek = 'all';
  String pilihJenisBarang = 'all';
  TextEditingController siklus = TextEditingController();

  int? idBatu1 = 0;
  int? stokBatu1 = 0;
  int _rowsPerPage = 10;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterDataProduksi!.sort((a, b) => a.kodeDesignMdbc!
            .toLowerCase()
            .compareTo(b.kodeDesignMdbc!.toLowerCase()));
      } else {
        filterDataProduksi!.sort((a, b) => b.kodeDesignMdbc!
            .toLowerCase()
            .compareTo(a.kodeDesignMdbc!.toLowerCase()));
      }
    }
  }

  var nowSiklus = '';

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    // nowSiklus = sharedPreferences!.getString('siklus')!;
    nowSiklus = month;
    _getListBulan();
    _getList('all');
    _getListDivisi();
    _getListSubDivisi();
  }

  String convertMonthToNumber(String monthName) {
    // Map nama bulan ke angka bulan
    Map<String, int> monthMap = {
      'JANUARI': 1,
      'FEBRUARI': 2,
      'MARET': 3,
      'APRIL': 4,
      'MEI': 5,
      'JUNI': 6,
      'JULI': 7,
      'AGUSTUS': 8,
      'SEPTEMBER': 9,
      'OKTOBER': 10,
      'NOVEMBER': 11,
      'DESEMBER': 12,
    };

    // Mengembalikan angka bulan dari map jika ditemukan, atau 0 jika tidak ditemukan
    return monthMap[monthName] != null ? monthMap[monthName].toString() : '';
  }

  postSendAll(List<ListMpsModel> data, newMonth) async {
    var filterByNonBrj = data
        .where((element) => element.posisi.toString().toLowerCase() != 'brj')
        .toList();
    var filterByCancel =
        filterByNonBrj.where((element) => element.isSend == '').toList();
    data = filterByCancel.toList();
    for (var i = 0; i < data.length; i++) {
      await postMps(data, i, newMonth);
    }
  }

  postMps(var dumData, i, bulan) async {
    var data = dumData[i];
    Map<String, String> bodyStatusmps = {
      'id': data.idMps.toString(),
    };
    try {
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postDataMpsIsSend}'),
          body: bodyStatusmps);
      if (response.statusCode == 200) {
      } else {
        print('err : ${response.body}');
        showSimpleNotification(
          Text('Error Data (${response.body})'),
          background: Colors.red,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (c) {
      print('err : $c');
      showSimpleNotification(
        Text('Error Data ($c)'),
        background: Colors.red,
        duration: const Duration(seconds: 2),
      );
    }

    Map<String, String> body = {
      'isUpdate': 'new',
      'id': data.id.toString(),
      'kodeDesignMdbc': data.kodeDesignMdbc.toString(),
      'kodeMarketing': data.kodeMarketing.toString(),
      'posisi': data.posisi.toString(),
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
      'keteranganStatusAcc': data.artist.toString(),
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
      'bulan': bulan.toString().toUpperCase(),
      'totalCarat': data.totalCarat.toString(),
    };
    try {
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postDataMps}'),
          body: body);
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print('err : ${response.body}');
        showSimpleNotification(
          const Text('Error Data ()'),
          background: Colors.red,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (c) {
      print('err : $c');
      showSimpleNotification(
        Text('Error Data ($c)'),
        background: Colors.red,
        duration: const Duration(seconds: 2),
      );
    }
  }

  _getListBulan() async {
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    // ignore: unused_local_variable
    int currentYear = now.year;
    for (int i = currentMonth; i <= 12; i++) {
      listBulan.add(_getNamaBulan(i));
    }
  }

  String _getNamaBulan(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return 'Desember';
    }
  }

  _getList(divisi) async {
    listArtist = [];
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListArtist}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var alldata = jsonResponse
          .map((data) => ArtistProduksiModel.fromJson(data))
          .toList();

      // var filterByDivisi = alldata.where((element) =>
      //     element.divisi.toString().toLowerCase() ==
      //     divisi.toString().toLowerCase());

      // alldata = filterByDivisi.toList();
      for (var i = 0; i < alldata.length; i++) {
        listArtist.add(alldata[i].nama);
      }
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getListDivisi() async {
    listArtist = [];
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListDivisi}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var alldata = jsonResponse
          .map((data) => DivisiProduksiModel.fromJson(data))
          .toList();

      // var filterByDivisi = alldata.where((element) =>
      //     element.divisi.toString().toLowerCase() ==
      //     divisi.toString().toLowerCase());

      // alldata = filterByDivisi.toList();
      if (sharedPreferences!.getString('nama') == 'Tri Sartika R' ||
          sharedPreferences!.getString('role') == '1' ||
          sharedPreferences!.getString('divisi') == 'admin') {
        for (var i = 2; i < alldata.length; i++) {
          listDivisi.add(alldata[i].divisi!);
          listIdDivisi.add(i);
        }
      } else {
        for (var i = 0; i < alldata.length; i++) {
          if (alldata[i].role == sharedPreferences!.getString('role')) {
            listDivisi.add(alldata[i].divisi!);
            listIdDivisi.add(i);
          } else {}
        }
      }
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getListSubDivisi() async {
    listSubDivisiArtistFinishing = [];
    listSubDivisiArtistPolishing = [];
    listSubDivisiArtistStell = [];
    listSubDivisiArtistPasangBatu = [];
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListArtist}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var alldata = jsonResponse
          .map((data) => ArtistProduksiModel.fromJson(data))
          .toList();

      // var filterByDivisiFinishing = alldata.where((element) =>
      //     element.divisi.toString().toLowerCase() ==
      //     'finishing').toList();
      for (var i = 0; i < alldata.length; i++) {
        if (alldata[i].divisi.toString().toLowerCase() == 'finishing') {
          listSubDivisiArtistFinishing.add(alldata[i].nama);
        } else if (alldata[i].divisi.toString().toLowerCase() ==
                'poleshing 1' ||
            alldata[i].nama.toString().toLowerCase() == 'poleshing 2') {
          listSubDivisiArtistPolishing.add(alldata[i].nama);
        } else if (alldata[i].divisi.toString().toLowerCase() ==
                'stell rangka 1' ||
            alldata[i].nama.toString().toLowerCase() == 'stell rangka 2') {
          listSubDivisiArtistStell.add(alldata[i].nama);
        } else {
          listSubDivisiArtistPasangBatu.add(alldata[i].nama);
        }
      }
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getDataBySiklusProduksi(chooseSiklus, chooseWeek, chooseJenisBarang) async {
    print('get data mps produksi');
    listJenisBarang = [];
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getListMpsBySiklus}?siklus=$chooseSiklus'));
    // Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var alldata =
          jsonResponse.map((data) => ListMpsModel.fromJson(data)).toList();
      if (sharedPreferences!.getString('divisi') == 'admin' ||
          sharedPreferences!.getString('divisi') == 'produksi') {
        //! function admin dan head produksi
        if (sharedPreferences!.getString('role') == '1' ||
            sharedPreferences!.getString('role') == '2' ||
            sharedPreferences!.getString('divisi') == 'admin') {
        }
        //! function produksi role 3
        else if (sharedPreferences!.getString('role') == '3') {
          for (var i = 0; i < listDivisi.length; i++) {
            print(listDivisi[i]);
          }
          var filterByPosisi = alldata
              .where((element) =>
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[0].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[1].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[2].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[3].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[4].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() == 'release')
              .toList();
          alldata = filterByPosisi.toList();
        } else if (sharedPreferences!.getString('role') == '4') {
          for (var i = 0; i < listDivisi.length; i++) {
            print(listDivisi[i]);
          }
          var filterByPosisi = alldata
              .where((element) =>
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[1].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[2].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[3].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[4].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[5].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[6].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[7].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() == 'stok finishing' ||
                  element.posisi.toString().toLowerCase() ==
                      'stok pasang batu' ||
                  element.posisi.toString().toLowerCase() == 'out pasang batu')
              .toList();
          alldata = filterByPosisi.toList();
        } else if (sharedPreferences!.getString('role') == '5') {
          for (var i = 0; i < listDivisi.length; i++) {
            print(listDivisi[i]);
          }
          var filterByPosisi = alldata
              .where((element) =>
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[1].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() ==
                      listDivisi[2].toString().toLowerCase() ||
                  element.posisi.toString().toLowerCase() == 'stok pasang batu')
              .toList();
          alldata = filterByPosisi.toList();
        } else {}
      } else {}

      var dataProduksi = alldata.toList();
      alldata.toList();
      listJenisBarang.add('all');
      for (var i = 0; i < dataProduksi.length; i++) {
        listJenisBarang.add(dataProduksi[i].jenisBarang!);
      }
      listJenisBarang = listJenisBarang.toSet().toList();

      if (chooseJenisBarang != 'all' && chooseWeek != 'all') {
        var filterbyJenisBarang = alldata.where((element) =>
            element.jenisBarang.toString().toLowerCase() ==
            chooseJenisBarang.toString().toLowerCase());
        var filterbyPilihMinggu = filterbyJenisBarang.where((element) =>
            element.keteranganMinggu.toString().toLowerCase() ==
            chooseWeek.toString().toLowerCase());
        alldata = filterbyPilihMinggu.toList();
      } else if (chooseJenisBarang != 'all') {
        var filterbyJenisBarang = alldata.where((element) =>
            element.jenisBarang.toString().toLowerCase() ==
            chooseJenisBarang.toString().toLowerCase());
        alldata = filterbyJenisBarang.toList();
      } else if (chooseWeek != 'all') {
        var filterbyPilihMinggu = alldata.where((element) =>
            element.keteranganMinggu.toString().toLowerCase() ==
            chooseWeek.toString().toLowerCase());
        alldata = filterbyPilihMinggu.toList();
      } else {}

      setState(() {
        myDataProduksi = alldata.toList();
        filterDataProduksi = alldata.toList();
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  // _getDataBySiklusProduksi(chooseSiklus, chooseWeek, chooseJenisBarang) async {
  //   print('get data mps produksi');
  //   listJenisBarang = [];
  //   final response = await http.get(Uri.parse(
  //       '${ApiConstants.baseUrl}${ApiConstants.getListFormDesignerBySiklus}?siklus=$chooseSiklus'));
  //   // Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);

  //     var alldata =
  //         jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
  //     var dataProduksi = alldata.toList();
  //     alldata.toList();
  //     listJenisBarang.add('all');
  //     for (var i = 0; i < dataProduksi.length; i++) {
  //       listJenisBarang.add(dataProduksi[i].jenisBarang!);
  //     }
  //     listJenisBarang = listJenisBarang.toSet().toList();

  //     if (chooseJenisBarang != 'all' && chooseWeek != 'all') {
  //       var filterbyJenisBarang = alldata.where((element) =>
  //           element.jenisBarang.toString().toLowerCase() ==
  //           chooseJenisBarang.toString().toLowerCase());
  //       var filterbyPilihMinggu = filterbyJenisBarang.where((element) =>
  //           element.keteranganMinggu.toString().toLowerCase() ==
  //           chooseWeek.toString().toLowerCase());
  //       alldata = filterbyPilihMinggu.toList();
  //     } else if (chooseJenisBarang != 'all') {
  //       var filterbyJenisBarang = alldata.where((element) =>
  //           element.jenisBarang.toString().toLowerCase() ==
  //           chooseJenisBarang.toString().toLowerCase());
  //       alldata = filterbyJenisBarang.toList();
  //     } else if (chooseWeek != 'all') {
  //       var filterbyPilihMinggu = alldata.where((element) =>
  //           element.keteranganMinggu.toString().toLowerCase() ==
  //           chooseWeek.toString().toLowerCase());
  //       alldata = filterbyPilihMinggu.toList();
  //     } else {}

  //     setState(() {
  //       myDataProduksi = alldata.toList();
  //       filterDataProduksi = alldata.toList();
  //       myCrm = alldata.toList();
  //     });
  //   } else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }

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
              leading: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Bulan: $nowSiklus",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              elevation: 0,
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
                    myDataProduksi = filterDataProduksi!
                        .where((element) =>
                            element.kodeDesignMdbc!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.posisi!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.brand!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.statusForm!
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
                            element.keteranganBatu!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.keteranganStatusBatu!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.artist!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.keteranganStatusAcc!
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
              centerTitle: true,
              // actions: [
              //   IconButton(
              //       onPressed: () {
              //         // refresh();
              //       },
              //       icon: const Icon(
              //         Icons.refresh,
              //         color: Colors.black,
              //       ))
              // ],
            ),
            body: mpsProduksi(),

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
            //       ]
            //       )
          )),
    );
  }

  mpsProduksi() {
    double wid = 250;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 26, left: 20),
          child: const Text(
            'Master Planning Siklus',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: wid,
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
                  onChanged: (item) async {
                    setState(() {
                      isLoading = true;
                    });
                    siklusDesigner = item!;
                    print(siklusDesigner);
                    await _getDataBySiklusProduksi(
                        siklusDesigner, pilihWeek, pilihJenisBarang);
                    await _getListSubDivisi();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  popupProps: const PopupPropsMultiSelection.modalBottomSheet(
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
                        labelText: "Pilih Bulan",
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ),
              ),
            ),
            siklusDesigner.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: wid,
                      child: DropdownSearch<String>(
                        items: listJenisBarang,
                        onChanged: (item) async {
                          setState(() {
                            isLoading = true;
                          });
                          pilihJenisBarang = item!;
                          print(pilihJenisBarang);
                          await _getDataBySiklusProduksi(
                              siklusDesigner, pilihWeek, pilihJenisBarang);
                          setState(() {
                            isLoading = false;
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
                              labelText: "Pilih Jenis Barang",
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
                  ),
            siklusDesigner.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: wid,
                      child: DropdownSearch<String>(
                        items: const [
                          "all",
                          "WEEK 1",
                          "WEEK 2",
                          "WEEK 3",
                          "WEEK 4",
                        ],
                        onChanged: (item) async {
                          setState(() {
                            isLoading = true;
                          });
                          pilihWeek = item!;
                          print(pilihWeek);
                          await _getDataBySiklusProduksi(
                              siklusDesigner, pilihWeek, pilihJenisBarang);
                          setState(() {
                            isLoading = false;
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
                              labelText: "Pilih Minggu Ke -",
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
                  ),
            siklusDesigner.isEmpty
                ? const SizedBox()
                : sharedPreferences!.getString('role') == '2' ||
                        sharedPreferences!.getString('role') == '1' ||
                        sharedPreferences!.getString('divisi') == 'admin'
                    ? siklusDesigner == 'DESEMBER'
                        ? const SizedBox()
                        : Container(
                            height: 80,
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0))),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // Prevent dialog dismissal on tap outside
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
                                await postSendAll(
                                    myDataProduksi!,
                                    listBulan[int.parse(convertMonthToNumber(
                                            siklusDesigner)) -
                                        1]);
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Text(
                                  'Kirim semua ke bulan ${listBulan[int.parse(convertMonthToNumber(siklusDesigner)) - 1]}'),
                            ))
                    : const SizedBox()
          ],
        ),
        siklusDesigner.isEmpty
            ? Center(
                child: Column(
                children: [
                  SizedBox(
                    width: 250,
                    height: 210,
                    child: Lottie.asset("loadingJSON/selectDate.json"),
                  ),
                  const Text(
                    'Pilih bulan terlebih dahulu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Acne',
                        letterSpacing: 1.5),
                  ),
                ],
              ))
            : isLoading == true
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
                              dataRowMaxHeight: 150,
                              onRowsPerPageChanged: (value) {
                                setState(() {
                                  isLoading == true;
                                });
                                _rowsPerPage = value!;
                                setState(() {
                                  isLoading == false;
                                });
                              },
                              sortColumnIndex: _currentSortColumn,
                              sortAscending: sort,
                              // rowsPerPage: 25,
                              columnSpacing: 0,
                              columns: sharedPreferences!.getString('divisi') ==
                                          'produksi' ||
                                      sharedPreferences!.getString('divisi') ==
                                          'admin'
                                  ? [
                                      // no
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      // keterangan minggu
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Minggu Ke -",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //gambar
                                      DataColumn(
                                        label: Container(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: const Text(
                                              "Gambar",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      DataColumn(label: _verticalDivider),

                                      // kode mdbc
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Kode\nMDBC",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .kodeDesignMdbc!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .kodeDesignMdbc!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .kodeDesignMdbc!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .kodeDesignMdbc!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //kode marketing
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Kode Marketing",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;

                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .kodeMarketing!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .kodeMarketing!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .kodeMarketing!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .kodeMarketing!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //posisi
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Posisi",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                myDataProduksi!.sort((a, b) => a
                                                    .posisi!
                                                    .compareTo(b.posisi!));
                                              } else {
                                                sort = true;
                                                myDataProduksi!.sort((a, b) => b
                                                    .posisi!
                                                    .compareTo(a.posisi!));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),

                                      //status batu
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Status Batu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;

                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .keteranganStatusBatu!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .keteranganStatusBatu!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .keteranganStatusBatu!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .keteranganStatusBatu!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //status acc
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Status ACC",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;

                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .keteranganStatusAcc!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .keteranganStatusAcc!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .keteranganStatusAcc!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .keteranganStatusAcc!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //ketrangan batu
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Keterangan\nBatu",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        // onSort: (columnIndex, _) {
                                        //   setState(() {
                                        //     _currentSortColumn = columnIndex;

                                        //     if (sort == true) {
                                        //       sort = false;
                                        //       filterDataProduksi!.sort((a, b) => a
                                        //           .keteranganStatusBatu!
                                        //           .toLowerCase()
                                        //           .compareTo(b
                                        //               .keteranganStatusBatu!
                                        //               .toLowerCase()));
                                        //     } else {
                                        //       sort = true;
                                        //       filterDataProduksi!.sort((a, b) => b
                                        //           .keteranganStatusBatu!
                                        //           .toLowerCase()
                                        //           .compareTo(a
                                        //               .keteranganStatusBatu!
                                        //               .toLowerCase()));
                                        //     }
                                        //   });
                                        // }
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //tema
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
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
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .tema!
                                                        .toLowerCase()
                                                        .compareTo(b.tema!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .tema!
                                                        .toLowerCase()
                                                        .compareTo(a.tema!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //jenis barang
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Jenis Barang",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            print('tap jenis barnag');
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                myDataProduksi!.sort((a, b) => a
                                                    .jenisBarang!
                                                    .toLowerCase()
                                                    .compareTo(b.jenisBarang!
                                                        .toLowerCase()));
                                              } else {
                                                sort = true;
                                                myDataProduksi!.sort((a, b) => b
                                                    .jenisBarang!
                                                    .toLowerCase()
                                                    .compareTo(a.jenisBarang!
                                                        .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //brand
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Brand",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                // myCrm.sort((a, b) => a['estimasiHarga'].)
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a.brand!
                                                        .compareTo(b.brand!));
                                                // onsortColum(columnIndex, ascending);
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b.brand!
                                                        .compareTo(a.brand!));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      // harga
                                      sharedPreferences!.getString('role') ==
                                                  '1' ||
                                              sharedPreferences!
                                                      .getString('role') ==
                                                  '2' ||
                                              sharedPreferences!
                                                      .getString('divisi') ==
                                                  'admin'
                                          ? const DataColumn(
                                              label: SizedBox(
                                                  child: Text(
                                                "Harga",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            )
                                          : const DataColumn(label: SizedBox()),
                                      DataColumn(label: _verticalDivider),
                                      //kelas harga
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Kelas\nHarga",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //tanggal in produksi
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Tanggal In\nRelease",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .tanggalInProduksi!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .tanggalInProduksi!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .tanggalInProduksi!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .tanggalInProduksi!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                    ]
                                  : [
                                      // no
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      // keterangan minggu
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Minggu Ke -",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //gambar
                                      DataColumn(
                                        label: Container(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: const Text(
                                              "Gambar",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      DataColumn(label: _verticalDivider),

                                      // kode mdbc
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Kode\nMDBC",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .kodeDesignMdbc!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .kodeDesignMdbc!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .kodeDesignMdbc!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .kodeDesignMdbc!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //kode marketing
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Kode Marketing",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;

                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .kodeMarketing!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .kodeMarketing!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .kodeMarketing!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .kodeMarketing!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //posisi
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Posisi",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                myDataProduksi!.sort((a, b) => a
                                                    .posisi!
                                                    .compareTo(b.posisi!));
                                              } else {
                                                sort = true;
                                                myDataProduksi!.sort((a, b) => b
                                                    .posisi!
                                                    .compareTo(a.posisi!));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),

                                      //status batu
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Status Batu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;

                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .keteranganStatusBatu!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .keteranganStatusBatu!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .keteranganStatusBatu!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .keteranganStatusBatu!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //status acc
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Status ACC",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;

                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .keteranganStatusAcc!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .keteranganStatusAcc!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .keteranganStatusAcc!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .keteranganStatusAcc!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //ketrangan batu
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Keterangan\nBatu",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //tema
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
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
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .tema!
                                                        .toLowerCase()
                                                        .compareTo(b.tema!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .tema!
                                                        .toLowerCase()
                                                        .compareTo(a.tema!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //jenis barang
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Jenis Barang",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            print('tap jenis barnag');
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                myDataProduksi!.sort((a, b) => a
                                                    .jenisBarang!
                                                    .toLowerCase()
                                                    .compareTo(b.jenisBarang!
                                                        .toLowerCase()));
                                              } else {
                                                sort = true;
                                                myDataProduksi!.sort((a, b) => b
                                                    .jenisBarang!
                                                    .toLowerCase()
                                                    .compareTo(a.jenisBarang!
                                                        .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //berat emas
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Berat Emas",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //berat diamond
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Berat Diamond",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //brand
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Brand",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                // myCrm.sort((a, b) => a['estimasiHarga'].)
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a.brand!
                                                        .compareTo(b.brand!));
                                                // onsortColum(columnIndex, ascending);
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b.brand!
                                                        .compareTo(a.brand!));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      // harga
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
                                      //kelas harga
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Kelas\nHarga",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      //tanggal in release
                                      DataColumn(
                                          label: const SizedBox(
                                              child: Text(
                                            "Tanggal In\nRelease",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          onSort: (columnIndex, _) {
                                            setState(() {
                                              _currentSortColumn = columnIndex;
                                              if (sort == true) {
                                                sort = false;
                                                filterDataProduksi!.sort(
                                                    (a, b) => a
                                                        .tanggalInProduksi!
                                                        .toLowerCase()
                                                        .compareTo(b
                                                            .tanggalInProduksi!
                                                            .toLowerCase()));
                                              } else {
                                                sort = true;
                                                filterDataProduksi!.sort(
                                                    (a, b) => b
                                                        .tanggalInProduksi!
                                                        .toLowerCase()
                                                        .compareTo(a
                                                            .tanggalInProduksi!
                                                            .toLowerCase()));
                                              }
                                            });
                                          }),
                                      DataColumn(label: _verticalDivider),
                                      //tanggal in release
                                      const DataColumn(
                                        label: SizedBox(
                                            child: Text(
                                          "Tanggal In\nModeller",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ],
                              source: sharedPreferences!.getString('divisi') ==
                                          'produksi' ||
                                      sharedPreferences!.getString('divisi') ==
                                          'admin'
                                  ? RowSourceProduksi(
                                      onRowPressed: () {
                                        refresh();
                                      }, //! mengirim data untuk me refresh state
                                      listBulan: listBulan,
                                      listArtist: listArtist,
                                      listDivisi: listDivisi,
                                      myData: myDataProduksi,
                                      count: myDataProduksi!.length,
                                      listSubDivisiArtistFinishing:
                                          listSubDivisiArtistFinishing,
                                      listSubDivisiArtistPolishing:
                                          listSubDivisiArtistPolishing,
                                      listSubDivisiArtistStell:
                                          listSubDivisiArtistStell,
                                      listSubDivisiArtistPasangBatu:
                                          listSubDivisiArtistPasangBatu,
                                      siklus: siklusDesigner)
                                  : RowSourceScm(
                                      onRowPressed: () {
                                        refresh();
                                      }, //! mengirim data untuk me refresh state
                                      listArtist: listArtist,
                                      listDivisi: listDivisi,
                                      myData: myDataProduksi,
                                      count: myDataProduksi!.length,
                                      listSubDivisiArtistFinishing:
                                          listSubDivisiArtistFinishing,
                                      listSubDivisiArtistPolishing:
                                          listSubDivisiArtistPolishing,
                                      listSubDivisiArtistStell:
                                          listSubDivisiArtistStell,
                                      listSubDivisiArtistPasangBatu:
                                          listSubDivisiArtistPasangBatu,
                                      siklus: siklusDesigner)),
                        ),
                      ),
                    ]),
                    // ),
                  )
      ],
    );
  }

  refresh() async {
    print('refresh state');
    setState(() {
      isLoadingKeteranganMinggu = true;
    });
    await _getDataBySiklusProduksi(siklusDesigner, pilihWeek, pilihJenisBarang);
    setState(() {
      isLoadingKeteranganMinggu = false;
    });
  }
}

// class RowSource extends DataTableSource {
//   var myData;
//   final count;
//   RowSource({
//     required this.myData,
//     required this.count,
//   });

//   @override
//   DataRow? getRow(int index) {
//     if (index < rowCount) {
//       return recentFileDataRow(myData![index], index);
//     } else {
//       return null;
//     }
//   }

//   DataRow recentFileDataRow(var data, var i) {
//     // ignore: prefer_interpolation_to_compose_strings
//     return DataRow(cells: [
//       //No
//       DataCell(
//         Builder(builder: (context) {
//           return Padding(
//               padding: const EdgeInsets.all(0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text((i + 1).toString()),
//                 ],
//               ));
//         }),
//       ),
//       DataCell(_verticalDivider),
//       //kode design
//       DataCell(
//         Builder(builder: (context) {
//           return Padding(
//               padding: const EdgeInsets.all(0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(data.kodeDesign),
//                 ],
//               ));
//         }),
//       ),
//       DataCell(_verticalDivider),
//       //kode mdbc
//       DataCell(
//         Builder(builder: (context) {
//           return Padding(
//               padding: const EdgeInsets.all(0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(data.kodeDesignMdbc),
//                 ],
//               ));
//         }),
//       ),
//       DataCell(_verticalDivider),
//       //kode marketing
//       DataCell(
//         Builder(builder: (context) {
//           return Padding(
//               padding: const EdgeInsets.all(0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(data.kodeMarketing),
//                 ],
//               ));
//         }),
//       ),
//       DataCell(_verticalDivider),
//       //posisi
//       DataCell(Builder(builder: (context) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(data.posisi),
//             IconButton(
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8)),
//                             content: SizedBox(
//                                 height: 150,
//                                 child: SingleChildScrollView(
//                                     scrollDirection: Axis.vertical,
//                                     child: Column(children: [
//                                       const Text(
//                                         'Pilih Posisi',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.only(top: 15),
//                                         child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blue,
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             50.0))),
//                                             onPressed: () async {
//                                               await postPosisi(
//                                                   data.id, "Casting");
//                                               await postHistory(
//                                                   data.kodeDesignMdbc,
//                                                   data.kodeMarketing,
//                                                   "Casting",
//                                                   "Unknown");
//                                               Navigator.pop(context);
//                                               showDialog<String>(
//                                                   context: context,
//                                                   builder:
//                                                       (BuildContext context) =>
//                                                           const AlertDialog(
//                                                             title: Text(
//                                                               'Posisi Berhasil Diupdate',
//                                                             ),
//                                                           ));
//                                             },
//                                             child: const Text(
//                                               "Casting",
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                               ),
//                                             )),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.only(top: 15),
//                                         child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blue,
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             50.0))),
//                                             onPressed: () async {
//                                               await postPosisi(data.id, "BRJ");
//                                               await postHistory(
//                                                   data.kodeDesignMdbc,
//                                                   data.kodeMarketing,
//                                                   "BRJ",
//                                                   "Unknown");

//                                               Navigator.pop(context);
//                                               // Navigator.push(
//                                               //           context,
//                                               //           MaterialPageRoute(
//                                               //               builder: (c) =>
//                                               //                   const MainView()));
//                                               showDialog<String>(
//                                                   context: context,
//                                                   builder:
//                                                       (BuildContext context) =>
//                                                           const AlertDialog(
//                                                             title: Text(
//                                                               'Posisi Berhasil Diupdate\n Tekan refresh di pojok kanan atas untuk update data',
//                                                             ),
//                                                           ));
//                                             },
//                                             child: const Text(
//                                               "BRJ",
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                               ),
//                                             )),
//                                       ),
//                                     ]))));
//                       });
//                 },
//                 icon: const Icon(
//                   Icons.change_circle,
//                   color: Colors.blue,
//                 )),
//           ],
//         );
//       })),
//       DataCell(_verticalDivider),
//       //status batu
//       DataCell(
//         Padding(
//             padding: const EdgeInsets.all(0),
//             child: Text(data.keteranganStatusBatu)),
//       ),
//       DataCell(_verticalDivider),
//       //namaDesigner
//       DataCell(
//         Padding(
//             padding: const EdgeInsets.all(0), child: Text(data.namaDesigner)),
//       ),
//       DataCell(_verticalDivider),
//       //tema
//       DataCell(
//         Padding(padding: const EdgeInsets.all(0), child: Text(data.tema)),
//       ),
//       DataCell(_verticalDivider),
//       //jenisBarang
//       DataCell(
//         Padding(
//             padding: const EdgeInsets.all(0), child: Text(data.jenisBarang)),
//       ),
//       DataCell(_verticalDivider),
//       //brand
//       DataCell(
//         Padding(padding: const EdgeInsets.all(0), child: Text(data.brand)),
//       ),
//       DataCell(_verticalDivider),
//       //kelas harga
//       DataCell(
//         Container(
//             width: 100,
//             padding: const EdgeInsets.all(0),
//             child: ((data.estimasiHarga * 0.37) * 11500) <= 5000000
//                 ? const Text(
//                     "XS",
//                     maxLines: 2,
//                   )
//                 : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
//                     ? const Text(
//                         "S",
//                         maxLines: 2,
//                       )
//                     : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
//                         ? const Text(
//                             "M",
//                             maxLines: 2,
//                           )
//                         : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
//                             ? const Text(
//                                 "L",
//                                 maxLines: 2,
//                               )
//                             : const Text(
//                                 "XL",
//                                 maxLines: 2,
//                               )),
//       ),
//       DataCell(_verticalDivider),

//       //nama modeller
//       DataCell(
//         Padding(
//             padding: const EdgeInsets.all(0), child: Text(data.namaModeller)),
//       ),
//       DataCell(_verticalDivider),

//       //tanggal out modeller
//       DataCell(
//         Padding(
//             padding: const EdgeInsets.all(0),
//             child: Text(data.tanggalOutModeller)),
//       ),
//       DataCell(_verticalDivider),

//       //tanggal in produksi
//       DataCell(
//         Padding(
//             padding: const EdgeInsets.all(0),
//             child: Text(data.tanggalInProduksi)),
//       ),
//     ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => count;

//   @override
//   int get selectedRowCount => 0;

//   postPosisi(id, posisi) async {
//     Map<String, String> body = {
//       'id': id.toString(),
//       'posisi': posisi.toString(),
//     };
//     final response = await http.post(
//         Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisi}'),
//         body: body);
//     print(response.body);
//   }

//   postHistory(kodeDesignMdbc, kodeMarketing, posisi, namaArtist) async {
//     Map<String, String> body = {
//       'kodeDesignMdbc': kodeDesignMdbc.toString(),
//       'kodeMarketing': kodeMarketing.toString(),
//       'posisi': posisi.toString(),
//       'namaArtis': namaArtist.toString()
//     };
//     final response = await http.post(
//         Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addHistoryPosisi}'),
//         body: body);
//     print(response.body);
//   }

//   postApiQtyBatu1(batu1, qtyBatu1) async {
//     if (qtyBatu1 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu1"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu1 += data[0]['qty'];
//           print(qtyBatu1);
//           try {
//             Map<String, String> body = {
//               'size': batu1.toString(),
//               'qty': qtyBatu1.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu2(batu2, qtyBatu2) async {
//     if (qtyBatu2 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu2"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu2 += data[0]['qty'];
//           print(qtyBatu2);
//           try {
//             Map<String, String> body = {
//               'size': batu2.toString(),
//               'qty': qtyBatu2.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu3(batu3, qtyBatu3) async {
//     if (qtyBatu3 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu3"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu3 += data[0]['qty'];
//           print(qtyBatu3);
//           try {
//             Map<String, String> body = {
//               'size': batu3.toString(),
//               'qty': qtyBatu3.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu4(batu4, qtyBatu4) async {
//     if (qtyBatu4 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu4"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu4 += data[0]['qty'];
//           print(qtyBatu4);
//           try {
//             Map<String, String> body = {
//               'size': batu4.toString(),
//               'qty': qtyBatu4.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu5(batu5, qtyBatu5) async {
//     if (qtyBatu5 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu5"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu5 += data[0]['qty'];
//           print(qtyBatu5);
//           try {
//             Map<String, String> body = {
//               'size': batu5.toString(),
//               'qty': qtyBatu5.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu6(batu6, qtyBatu6) async {
//     if (qtyBatu6 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu6"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu6 += data[0]['qty'];
//           print(qtyBatu6);
//           try {
//             Map<String, String> body = {
//               'size': batu6.toString(),
//               'qty': qtyBatu6.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu7(batu7, qtyBatu7) async {
//     if (qtyBatu7 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu7"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu7 += data[0]['qty'];
//           print(qtyBatu7);
//           try {
//             Map<String, String> body = {
//               'size': batu7.toString(),
//               'qty': qtyBatu7.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu8(batu8, qtyBatu8) async {
//     if (qtyBatu8 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu8"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu8 += data[0]['qty'];
//           print(qtyBatu8);
//           try {
//             Map<String, String> body = {
//               'size': batu8.toString(),
//               'qty': qtyBatu8.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu9(batu9, qtyBatu9) async {
//     if (qtyBatu9 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu9"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu9 += data[0]['qty'];
//           print(qtyBatu9);
//           try {
//             Map<String, String> body = {
//               'size': batu9.toString(),
//               'qty': qtyBatu9.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu10(batu10, qtyBatu10) async {
//     if (qtyBatu10 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu10"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu10 += data[0]['qty'];
//           print(qtyBatu10);
//           try {
//             Map<String, String> body = {
//               'size': batu10.toString(),
//               'qty': qtyBatu10.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu11(batu11, qtyBatu11) async {
//     if (qtyBatu11 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu11"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu11 += data[0]['qty'];
//           print(qtyBatu11);
//           try {
//             Map<String, String> body = {
//               'size': batu11.toString(),
//               'qty': qtyBatu11.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu12(batu12, qtyBatu12) async {
//     if (qtyBatu12 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu12"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu12 += data[0]['qty'];
//           print(qtyBatu12);
//           try {
//             Map<String, String> body = {
//               'size': batu12.toString(),
//               'qty': qtyBatu12.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu13(batu13, qtyBatu13) async {
//     if (qtyBatu13 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu13"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu13 += data[0]['qty'];
//           print(qtyBatu13);
//           try {
//             Map<String, String> body = {
//               'size': batu13.toString(),
//               'qty': qtyBatu13.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu14(batu14, qtyBatu14) async {
//     if (qtyBatu14 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu14"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu14 += data[0]['qty'];
//           print(qtyBatu14);
//           try {
//             Map<String, String> body = {
//               'size': batu14.toString(),
//               'qty': qtyBatu14.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu15(batu15, qtyBatu15) async {
//     if (qtyBatu15 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu15"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu15 += data[0]['qty'];
//           print(qtyBatu15);
//           try {
//             Map<String, String> body = {
//               'size': batu15.toString(),
//               'qty': qtyBatu15.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu16(batu16, qtyBatu16) async {
//     if (qtyBatu16 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu16"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu16 += data[0]['qty'];
//           print(qtyBatu16);
//           try {
//             Map<String, String> body = {
//               'size': batu16.toString(),
//               'qty': qtyBatu16.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu17(batu17, qtyBatu17) async {
//     if (qtyBatu17 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu17"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu17 += data[0]['qty'];
//           print(qtyBatu17);
//           try {
//             Map<String, String> body = {
//               'size': batu17.toString(),
//               'qty': qtyBatu17.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu18(batu18, qtyBatu18) async {
//     if (qtyBatu18 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu18"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu18 += data[0]['qty'];
//           print(qtyBatu18);
//           try {
//             Map<String, String> body = {
//               'size': batu18.toString(),
//               'qty': qtyBatu18.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu19(batu19, qtyBatu19) async {
//     if (qtyBatu19 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu19"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu19 += data[0]['qty'];
//           print(qtyBatu19);
//           try {
//             Map<String, String> body = {
//               'size': batu19.toString(),
//               'qty': qtyBatu19.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu20(batu20, qtyBatu20) async {
//     if (qtyBatu20 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu20"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu20 += data[0]['qty'];
//           print(qtyBatu20);
//           try {
//             Map<String, String> body = {
//               'size': batu20.toString(),
//               'qty': qtyBatu20.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu21(batu21, qtyBatu21) async {
//     if (qtyBatu21 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu21"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu21 += data[0]['qty'];
//           print(qtyBatu21);
//           try {
//             Map<String, String> body = {
//               'size': batu21.toString(),
//               'qty': qtyBatu21.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu22(batu22, qtyBatu22) async {
//     if (qtyBatu22 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu22"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu22 += data[0]['qty'];
//           print(qtyBatu22);
//           try {
//             Map<String, String> body = {
//               'size': batu22.toString(),
//               'qty': qtyBatu22.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu23(batu23, qtyBatu23) async {
//     if (qtyBatu23 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu23"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu23 += data[0]['qty'];
//           print(qtyBatu23);
//           try {
//             Map<String, String> body = {
//               'size': batu23.toString(),
//               'qty': qtyBatu23.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu24(batu24, qtyBatu24) async {
//     if (qtyBatu24 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu24"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu24 += data[0]['qty'];
//           print(qtyBatu24);
//           try {
//             Map<String, String> body = {
//               'size': batu24.toString(),
//               'qty': qtyBatu24.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu25(batu25, qtyBatu25) async {
//     if (qtyBatu25 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu25"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu25 += data[0]['qty'];
//           print(qtyBatu25);
//           try {
//             Map<String, String> body = {
//               'size': batu25.toString(),
//               'qty': qtyBatu25.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu26(batu26, qtyBatu26) async {
//     if (qtyBatu26 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu26"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu26 += data[0]['qty'];
//           print(qtyBatu26);
//           try {
//             Map<String, String> body = {
//               'size': batu26.toString(),
//               'qty': qtyBatu26.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu27(batu27, qtyBatu27) async {
//     if (qtyBatu27 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu27"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu27 += data[0]['qty'];
//           print(qtyBatu27);
//           try {
//             Map<String, String> body = {
//               'size': batu27.toString(),
//               'qty': qtyBatu27.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu28(batu28, qtyBatu28) async {
//     if (qtyBatu28 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu28"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu28 += data[0]['qty'];
//           print(qtyBatu28);
//           try {
//             Map<String, String> body = {
//               'size': batu28.toString(),
//               'qty': qtyBatu28.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu29(batu29, qtyBatu29) async {
//     if (qtyBatu29 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu29"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu29 += data[0]['qty'];
//           print(qtyBatu29);
//           try {
//             Map<String, String> body = {
//               'size': batu29.toString(),
//               'qty': qtyBatu29.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu30(batu30, qtyBatu30) async {
//     if (qtyBatu30 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu30"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu30 += data[0]['qty'];
//           print(qtyBatu30);
//           try {
//             Map<String, String> body = {
//               'size': batu30.toString(),
//               'qty': qtyBatu30.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu31(batu31, qtyBatu31) async {
//     if (qtyBatu31 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu31"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu31 += data[0]['qty'];
//           print(qtyBatu31);
//           try {
//             Map<String, String> body = {
//               'size': batu31.toString(),
//               'qty': qtyBatu31.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu32(batu32, qtyBatu32) async {
//     if (qtyBatu32 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu32"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu32 += data[0]['qty'];
//           print(qtyBatu32);
//           try {
//             Map<String, String> body = {
//               'size': batu32.toString(),
//               'qty': qtyBatu32.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu33(batu33, qtyBatu33) async {
//     if (qtyBatu33 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu33"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu33 += data[0]['qty'];
//           print(qtyBatu33);
//           try {
//             Map<String, String> body = {
//               'size': batu33.toString(),
//               'qty': qtyBatu33.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu34(batu34, qtyBatu34) async {
//     if (qtyBatu34 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu34"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu34 += data[0]['qty'];
//           print(qtyBatu34);
//           try {
//             Map<String, String> body = {
//               'size': batu34.toString(),
//               'qty': qtyBatu34.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }

//   postApiQtyBatu35(batu35, qtyBatu35) async {
//     if (qtyBatu35 > 0) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//               '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu35"'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           // print(data[0]['qty']);
//           qtyBatu35 += data[0]['qty'];
//           print(qtyBatu35);
//           try {
//             Map<String, String> body = {
//               'size': batu35.toString(),
//               'qty': qtyBatu35.toString(),
//             };
//             final response = await http.post(
//                 Uri.parse(ApiConstants.baseUrl +
//                     ApiConstants.postUpdateDataBatuBySize),
//                 body: body);
//             print(response.body);
//           } catch (c) {
//             print(c);
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       null;
//     }
//   }
// }

class RowSourceProduksi extends DataTableSource {
  var myData;
  final count;
  var siklus;
  final VoidCallback onRowPressed; //* menerima data untuk me refresh screen
  var listArtist;
  var listDivisi;
  var listSubDivisiArtistFinishing;
  var listSubDivisiArtistPolishing;
  var listSubDivisiArtistStell;
  var listSubDivisiArtistPasangBatu;
  List<String> listBulan;

  RowSourceProduksi({
    required this.myData,
    required this.count,
    required this.siklus,
    required this.onRowPressed,
    required this.listArtist,
    required this.listDivisi,
    required this.listSubDivisiArtistFinishing,
    required this.listSubDivisiArtistPolishing,
    required this.listSubDivisiArtistStell,
    required this.listSubDivisiArtistPasangBatu,
    required this.listBulan,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(
        myData![index],
        index,
        siklus,
        listArtist,
        listDivisi,
        listSubDivisiArtistFinishing,
        listSubDivisiArtistPolishing,
        listSubDivisiArtistStell,
        listSubDivisiArtistPasangBatu,
        listBulan,
      );
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(
      var data,
      var i,
      var siklus,
      var listArtist,
      var listDivisi,
      var listSubDivisiArtistFinishing,
      var listSubDivisiArtistPolishing,
      var listSubDivisiArtistStell,
      var listSubDivisiArtistPasangBatu,
      List<String> listBulan) {
    // ignore: prefer_interpolation_to_compose_strings
    bool isBackPosisi = false;

    return DataRow(cells: [
      //No
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((i + 1).toString()),
                  Stack(
                    clipBehavior: Clip.none, //agar tidak menghalangi object
                    children: [
                      data.isSend.toString() != ''
                          ? const Icon(
                              Icons.verified,
                              color: Colors.red,
                            )
                          : sharedPreferences!.getString('role') == '1' ||
                                  sharedPreferences!.getString('role') == '2' ||
                                  sharedPreferences!.getString('divisi') ==
                                      'admin'
                              ? data.posisi.toString().toLowerCase() == 'brj'
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        showDialog<String>(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                              'Perhatian',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Row(
                                              children: [
                                                const Text(
                                                  'Apakah anda yakin ingin mengCANCEL - ',
                                                ),
                                                Text(
                                                  '${data.kodeDesignMdbc}  ?',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  'Batal',
                                                ),
                                                child: const Text('Batal'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await postDataMps(
                                                      myData,
                                                      i,
                                                      'cancel',
                                                      context,
                                                      'false');
                                                  onRowPressed();
                                                },
                                                child: const Text(
                                                  'YA',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.cancel_schedule_send_sharp),
                                      color: Colors.red,
                                    )
                              : const SizedBox(),
                    ],
                  )
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //keterangan minggu
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.keteranganMinggu),
                  Stack(
                    clipBehavior: Clip.none, //agar tidak menghalangi object
                    children: [
                      //tambahan icon ADD
                      sharedPreferences!.getString('role') == '1' ||
                              sharedPreferences!.getString('role') == '2' ||
                              sharedPreferences!.getString('divisi') == 'admin'
                          ? Positioned(
                              right: -5.0,
                              top: -3.0,
                              child: InkResponse(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      sharedPreferences!.getString('role') == '1' ||
                              sharedPreferences!.getString('role') == '2' ||
                              sharedPreferences!.getString('divisi') == 'admin'
                          ? IconButton(
                              onPressed: () {
                                showGeneralDialog(
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    barrierDismissible: true,
                                    barrierLabel: '',
                                    context: context,
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return const Text('');
                                    },
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                              opacity: a1.value,
                                              child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  content: SizedBox(
                                                      child:
                                                          SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Pilih Waktu',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganMinggu(data.id,
                                                                                'WEEK 1');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Waktu Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "WEEK 1",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganMinggu(data.id,
                                                                                'WEEK 2');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Waktu Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "WEEK 2",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganMinggu(data.id,
                                                                                'WEEK 3');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Waktu Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "WEEK 3",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganMinggu(data.id,
                                                                                'WEEK 4');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Waktu Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "WEEK 4",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ]))))));
                                    });
                              },
                              icon: const Icon(Icons.calendar_today_outlined),
                              color: Colors.green,
                            )
                          : const SizedBox(),
                    ],
                  )
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //gambar
      DataCell(Builder(builder: (context) {
        return Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: 100,
              height: 140,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => ViewPhotoMpsScreen(
                                modelMps: ListMpsModel(
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

      DataCell(_verticalDivider),
      //kode mdbc
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.kodeDesignMdbc),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //kode marketing
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.kodeMarketing),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //posisi
      DataCell(Builder(builder: (context) {
        // String? posisi = '';
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 63),
              child: Column(
                children: [
                  Text('${data.posisi}'),
                  data.posisi.toString().toLowerCase() == 'brj' ||
                          data.posisi.toString().toLowerCase() ==
                              'out pasang batu'
                      ? const SizedBox()
                      : Text('${data.artist}'),
                ],
              ),
            ),
            sharedPreferences!.getString('nama') == 'Tri Sartika Rahayu'
                ? const SizedBox()
                : sharedPreferences!.getString('divisi') == 'produksi' ||
                        sharedPreferences!.getString('divisi') == 'admin'
                    ? IconButton(
                        onPressed: () {
                          print('tap ke : ${data.posisi}');
                          int idPosisi = 0;
                          if (sharedPreferences!.getString('role') == '3') {
                            data.posisi.toString().toLowerCase() ==
                                    'printing resin'
                                ? idPosisi = 1
                                : data.posisi.toString().toLowerCase() ==
                                        'finishing resin'
                                    ? idPosisi = 2
                                    : data.posisi.toString().toLowerCase() ==
                                            'casting'
                                        ? idPosisi = 3
                                        : idPosisi = 4;
                          } else if (sharedPreferences!.getString('role') ==
                              '4') {
                            data.posisi.toString().toLowerCase() ==
                                    'stok finishing'
                                ? idPosisi = 1
                                : data.posisi.toString().toLowerCase() ==
                                        'finishing'
                                    ? idPosisi = 1
                                    : data.posisi.toString().toLowerCase() ==
                                            'polishing 1'
                                        ? idPosisi = 2
                                        : data.posisi
                                                    .toString()
                                                    .toLowerCase() ==
                                                'stell 1'
                                            ? idPosisi = 3
                                            : data.posisi
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'stok pasang batu'
                                                ? idPosisi = 4
                                                : data.posisi
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'out pasang batu'
                                                    ? idPosisi = 5
                                                    : data.posisi
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'stell 2'
                                                        ? idPosisi = 5
                                                        : data.posisi
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'polishing 2'
                                                            ? idPosisi = 6
                                                            : idPosisi = 7;
                          } else if (sharedPreferences!.getString('role') ==
                              '5') {
                            data.posisi.toString().toLowerCase() ==
                                    'stok pasang batu'
                                ? idPosisi = 1
                                : data.posisi.toString().toLowerCase() ==
                                        'pasang batu'
                                    ? idPosisi = 2
                                    : idPosisi = 3;
                          } else {
                            idPosisi = -99;
                          }

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
                                              scrollDirection: Axis.vertical,
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Pilih Posisi Divisi',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  for (var j = 0;
                                                      j < listDivisi.length;
                                                      j++)
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  listDivisi[j]
                                                                              .toString()
                                                                              .toLowerCase() ==
                                                                          'orul'
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .blue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0))),
                                                          onPressed: () async {
                                                            print(
                                                                '$j kurang dari $idPosisi');
                                                            Navigator.pop(
                                                                context);
                                                            if (j == 0) {
                                                              //! pop up untuk keterangan atau alasan ORUL
                                                              //! function back posisi
                                                              orulReparasiPopup(
                                                                  context,
                                                                  data.idMps,
                                                                  j,
                                                                  data.kodeDesignMdbc,
                                                                  data.kodeMarketing,
                                                                  data.posisi,
                                                                  'orul',
                                                                  '');
                                                            } else if (j <
                                                                idPosisi) {
                                                              isBackPosisi =
                                                                  true;

                                                              //! function back posisi
                                                              showSimpleNotification(
                                                                const Text(
                                                                    'Alert Back Posisi'),
                                                                background:
                                                                    Colors.red,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                              );
                                                              //! back posisi untuk role admin dan head
                                                              artistPopup(
                                                                  context,
                                                                  data.idMps,
                                                                  j,
                                                                  data.kodeDesignMdbc,
                                                                  data.kodeMarketing,
                                                                  data.posisi,
                                                                  isBackPosisi);
                                                            } else {
                                                              isBackPosisi =
                                                                  false;

                                                              //? function pilih posisi
                                                              if (sharedPreferences!
                                                                          .getString(
                                                                              'role') ==
                                                                      '1' ||
                                                                  sharedPreferences!
                                                                          .getString(
                                                                              'divisi') ==
                                                                      'admin') {
                                                                //! admin dan head
                                                                j == 1 ||
                                                                        j ==
                                                                            2 ||
                                                                        j ==
                                                                            10 ||
                                                                        j ==
                                                                            11 ||
                                                                        j ==
                                                                            12 ||
                                                                        j == 13
                                                                    ? postDatabase(
                                                                        data
                                                                            .idMps,
                                                                        j,
                                                                        data
                                                                            .kodeDesignMdbc,
                                                                        data
                                                                            .kodeMarketing)
                                                                    : j == 3
                                                                        ? castingPopup(
                                                                            context,
                                                                            data
                                                                                .id,
                                                                            j,
                                                                            data
                                                                                .kodeDesignMdbc,
                                                                            data
                                                                                .kodeMarketing)
                                                                        : artistPopup(
                                                                            context,
                                                                            data.idMps,
                                                                            j,
                                                                            data.kodeDesignMdbc,
                                                                            data.kodeMarketing,
                                                                            data.posisi,
                                                                            isBackPosisi);
                                                              } else if (sharedPreferences!
                                                                      .getString(
                                                                          'role') ==
                                                                  '2') {
                                                                showSimpleNotification(
                                                                  const Text(
                                                                      'Tidak ada pilihan'),
                                                                  background:
                                                                      Colors
                                                                          .red,
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                );
                                                              } else if (sharedPreferences!
                                                                      .getString(
                                                                          'role') ==
                                                                  '3') {
                                                                j == 3
                                                                    ? castingPopup(
                                                                        context,
                                                                        data.id,
                                                                        j,
                                                                        data
                                                                            .kodeDesignMdbc,
                                                                        data
                                                                            .kodeMarketing)
                                                                    : postDatabase(
                                                                        data.idMps,
                                                                        j,
                                                                        data.kodeDesignMdbc,
                                                                        data.kodeMarketing);
                                                              } else if (sharedPreferences!
                                                                      .getString(
                                                                          'role') ==
                                                                  '4') {
                                                                j == 4 || j == 7
                                                                    ? postDatabase(
                                                                        data
                                                                            .idMps,
                                                                        j,
                                                                        data
                                                                            .kodeDesignMdbc,
                                                                        data
                                                                            .kodeMarketing)
                                                                    : artistPopup(
                                                                        context,
                                                                        data.idMps,
                                                                        j,
                                                                        data.kodeDesignMdbc,
                                                                        data.kodeMarketing,
                                                                        data.posisi,
                                                                        isBackPosisi);
                                                              } else if (sharedPreferences!
                                                                      .getString(
                                                                          'role') ==
                                                                  '5') {
                                                                j == 2
                                                                    ? postDatabase(
                                                                        data
                                                                            .idMps,
                                                                        j,
                                                                        data
                                                                            .kodeDesignMdbc,
                                                                        data
                                                                            .kodeMarketing)
                                                                    : artistPopup(
                                                                        context,
                                                                        data.idMps,
                                                                        j,
                                                                        data.kodeDesignMdbc,
                                                                        data.kodeMarketing,
                                                                        data.posisi,
                                                                        isBackPosisi);
                                                              } else {
                                                                showSimpleNotification(
                                                                  const Text(
                                                                      'Tidak ada pilihan'),
                                                                  background:
                                                                      Colors
                                                                          .red,
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                );
                                                              }
                                                            }
                                                          },
                                                          child: Text(
                                                            "${listDivisi[j]}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          )),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )));
                              });
                        },
                        icon: const Icon(
                          Icons.change_circle,
                          color: Colors.green,
                        ))
                    : const SizedBox(),
          ],
        );
      })),
      DataCell(_verticalDivider),
      //status batu
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.keteranganStatusBatu),
                  Stack(
                    clipBehavior: Clip.none, //agar tidak menghalangi object
                    children: [
                      //tambahan icon ADD
                      sharedPreferences!.getString('role') == '1' ||
                              sharedPreferences!.getString('role') == '2' ||
                              sharedPreferences!.getString('divisi') ==
                                  'admin' ||
                              sharedPreferences!.getString('divisi') == 'scm'
                          ? Positioned(
                              right: -5.0,
                              top: -3.0,
                              child: InkResponse(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      sharedPreferences!.getString('role') == '1' ||
                              sharedPreferences!.getString('role') == '2' ||
                              sharedPreferences!.getString('divisi') ==
                                  'admin' ||
                              sharedPreferences!.getString('divisi') == 'scm'
                          ? IconButton(
                              onPressed: () {
                                showGeneralDialog(
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    barrierDismissible: true,
                                    barrierLabel: '',
                                    context: context,
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return const Text('');
                                    },
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                              opacity: a1.value,
                                              child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  content: SizedBox(
                                                      child:
                                                          SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Pilih Status Batu',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganStatusBatu(data.id,
                                                                                'ECER');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Status Batu Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "ECER",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    sharedPreferences!.getString('divisi') ==
                                                                            'scm'
                                                                        ? Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusBatu(data.id, 'TRANSFER BATU');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Batu Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "TRANSFER BATU",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          )
                                                                        : Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusBatu(data.id, 'KOMPLIT BATU');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Batu Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "KOMPLIT BATU",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganStatusBatu(data.id,
                                                                                'BELUM KOMPLIT BATU');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Status Batu Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "BELUM KOMPLIT BATU",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ]))))));
                                    });
                              },
                              icon:
                                  const Icon(Icons.chat_bubble_outline_rounded),
                              color: Colors.green,
                            )
                          : const SizedBox(),
                    ],
                  )
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //status acc
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.keteranganStatusAcc),
                  Stack(
                    clipBehavior: Clip.none, //agar tidak menghalangi object
                    children: [
                      //tambahan icon ADD
                      sharedPreferences!.getString('role') == '1' ||
                              sharedPreferences!.getString('role') == '2' ||
                              sharedPreferences!.getString('divisi') == 'admin'
                          ? Positioned(
                              right: -5.0,
                              top: -3.0,
                              child: InkResponse(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      sharedPreferences!.getString('role') == '1' ||
                              sharedPreferences!.getString('role') == '2' ||
                              sharedPreferences!.getString('divisi') == 'scm' ||
                              sharedPreferences!.getString('divisi') == 'admin'
                          ? IconButton(
                              onPressed: () {
                                showGeneralDialog(
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    barrierDismissible: true,
                                    barrierLabel: '',
                                    context: context,
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return const Text('');
                                    },
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    transitionBuilder:
                                        (context, a1, a2, widget) {
                                      return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                              opacity: a1.value,
                                              child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  content: SizedBox(
                                                      child:
                                                          SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Pilih Status Acc',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganStatusAcc(data.id,
                                                                                'Tidak Ada');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Status Batu Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "Tidak Ada",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    sharedPreferences!.getString('divisi') ==
                                                                            'scm'
                                                                        ? Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusAcc(data.id, 'TRANSFER ACC');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Acc Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "TRANSFER ACC",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          )
                                                                        : Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusAcc(data.id, 'KOMPLIT ACC');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Acc Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "KOMPLIT ACC",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                          onPressed: () async {
                                                                            await postKeteranganStatusAcc(data.id,
                                                                                'BELUM KOMPLIT ACC');
                                                                            onRowPressed();
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              const Text('Pemilihan Status Acc Berhasil'),
                                                                              background: Colors.green,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          },
                                                                          child: const Text(
                                                                            "BELUM KOMPLIT ACC",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ]))))));
                                    });
                              },
                              icon: const Icon(Icons.toll_outlined),
                              color: Colors.green,
                            )
                          : const SizedBox()
                    ],
                  )
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //keterangan batu
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.keteranganBatu)),
      ),
      DataCell(_verticalDivider),
      //tema
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.tema)),
      ),
      DataCell(_verticalDivider),
      //jenisBarang
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.jenisBarang)),
      ),
      DataCell(_verticalDivider),
      //brand
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.brand)),
      ),
      sharedPreferences!.getString('role') == '1' ||
              sharedPreferences!.getString('role') == '2' ||
              sharedPreferences!.getString('divisi') == 'admin'
          ? DataCell(_verticalDivider)
          : const DataCell(SizedBox()),
      //harga
      sharedPreferences!.getString('role') == '1' ||
              sharedPreferences!.getString('role') == '2' ||
              sharedPreferences!.getString('divisi') == 'admin'
          ? DataCell(
              Container(
                  padding: const EdgeInsets.all(0),
                  child: data.brand.toString().toLowerCase() == 'parva'
                      ? Text(
                          CurrencyFormat.convertToIdr(
                              ((data.estimasiHarga * 0.37) * 11500), 0),
                          maxLines: 2,
                        )
                      : Text(
                          CurrencyFormat.convertToIdr(
                              ((data.estimasiHarga)), 0),
                          maxLines: 2,
                        )),
            )
          : const DataCell(SizedBox()),
      sharedPreferences!.getString('role') == '1' ||
              sharedPreferences!.getString('role') == '2' ||
              sharedPreferences!.getString('divisi') == 'admin'
          ? DataCell(_verticalDivider)
          : const DataCell(SizedBox()),
      //kelas harga
      DataCell(
        Container(
            padding: const EdgeInsets.all(0),
            child: ((data.estimasiHarga * 0.37) * 11500) <= 5000000
                ? const Text(
                    "XS",
                    maxLines: 2,
                  )
                : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                    ? const Text(
                        "S",
                        maxLines: 2,
                      )
                    : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
                        ? const Text(
                            "M",
                            maxLines: 2,
                          )
                        : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
                            ? const Text(
                                "L",
                                maxLines: 2,
                              )
                            : const Text(
                                "XL",
                                maxLines: 2,
                              )),
      ),
      DataCell(_verticalDivider),
      //tanggal in produksi
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.tanggalInProduksi)),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;

  postDataMps(var dumData, index, bulan, context, isUpdate) async {
    var data = dumData[index];
    Map<String, String> body = {
      'id': data.idMps.toString(),
    };
    print(body);
    try {
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postDataMpsIsSend}'),
          body: body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showSimpleNotification(
          const Text('Data berhasil di CANCEL'),
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

  postPosisi(id, posisi, artist) async {
    print('post posisi on');
    Map<String, String> body = {
      'id': id.toString(),
      'posisi': posisi.toString(),
      'artist': artist.toString(),
    };
    print(body);
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  castingPopup(context, id, j, kodeDesignMdbc, kodeMarketing) {
    return showGeneralDialog(
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
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: SizedBox(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                const Text(
                                  'Pilih Minggu Ke -',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W1",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W1",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 1",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W2",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W2",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 2",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W3",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W3",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 3",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W4",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W4",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 4",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                              ]))))));
        });
  }

  postDatabase(id, j, kodeDesignMdbc, kodeMarketing) async {
    print(id);
    print(listDivisi[j]);
    await postPosisi(
      id,
      "${listDivisi[j]}",
      "${listDivisi[j]}",
    );
    onRowPressed();

    await postHistory(
      kodeDesignMdbc,
      kodeMarketing,
      "${listDivisi[j]}",
      "${listDivisi[j]}",
    );
    showSimpleNotification(
      const Text('Posisi berhasil di simpan'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  artistPopup(
      context, id, j, kodeDesignMdbc, kodeMarketing, posisi, isBackPosisi) {
    return isBackPosisi == false
        ? showGeneralDialog(
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
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        content: SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                // SizedBox(
                                //   child: Lottie.asset(
                                //       "loadingJSON/backbutton.json",
                                //       fit: BoxFit
                                //           .cover),
                                // ),
                                Text(
                                  'Pilih Artist ${listDivisi[j]}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                                //! loopimg
                                for (var i = 0;
                                    posisi.toString().toLowerCase() ==
                                            'finishing'
                                        ? i <
                                            listSubDivisiArtistFinishing.length
                                        : posisi.toString().toLowerCase() ==
                                                    'polishing 1' ||
                                                posisi
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 2'
                                            ? i <
                                                listSubDivisiArtistPolishing
                                                    .length
                                            : posisi.toString().toLowerCase() ==
                                                        'stell 1' ||
                                                    posisi
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 2'
                                                ? i <
                                                    listSubDivisiArtistStell
                                                        .length
                                                : i <
                                                    listSubDivisiArtistPasangBatu
                                                        .length;
                                    i++)
                                  Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                        // style: ElevatedButton.styleFrom(backgroundColor: colorDasar, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                // Saat tombol di-hover, atur warna latar belakang yang berbeda di sini
                                                return Colors
                                                    .red; // Ganti dengan warna yang diinginkan
                                              }
                                              // Warna latar belakang saat tidak di-hover
                                              return colorDasar; // Ganti dengan warna yang diinginkan
                                            },
                                          ),
                                        ),
                                        onPressed: () async {
                                          await postPosisi(
                                            id,
                                            "${listDivisi[j]}",
                                            posisi.toString().toLowerCase() ==
                                                    'finishing'
                                                ? listSubDivisiArtistFinishing[
                                                    i]
                                                : posisi
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'polishing 1' ||
                                                        posisi
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'polishing 2'
                                                    ? listSubDivisiArtistPolishing[
                                                        i]
                                                    : posisi
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'stell 1' ||
                                                            posisi
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'stell 2'
                                                        ? listSubDivisiArtistStell[
                                                            i]
                                                        : listSubDivisiArtistPasangBatu[
                                                            i],
                                          );
                                          onRowPressed();

                                          // await postHistory(
                                          //   kodeDesignMdbc,
                                          //   kodeMarketing,
                                          //   "${listDivisi[j]}",
                                          //   posisi.toString().toLowerCase() ==
                                          //           'finishing'
                                          //       ? listSubDivisiArtistFinishing[
                                          //           i]
                                          //       : posisi
                                          //                       .toString()
                                          //                       .toLowerCase() ==
                                          //                   'polishing 1' ||
                                          //               posisi
                                          //                       .toString()
                                          //                       .toLowerCase() ==
                                          //                   'polishing 2'
                                          //           ? listSubDivisiArtistPolishing[
                                          //               i]
                                          //           : posisi
                                          //                           .toString()
                                          //                           .toLowerCase() ==
                                          //                       'stell 1' ||
                                          //                   posisi
                                          //                           .toString()
                                          //                           .toLowerCase() ==
                                          //                       'stell 2'
                                          //               ? listSubDivisiArtistStell[
                                          //                   i]
                                          //               : listSubDivisiArtistPasangBatu[
                                          //                   i],
                                          // );

                                          Navigator.pop(context);
                                          showSimpleNotification(
                                            const Text(
                                                'Menambahkan posisi dan artist berhasil'),
                                            background: Colors.green,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                        },
                                        child: Text(
                                          posisi.toString().toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
                                              : posisi
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 1' ||
                                                      posisi
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 2'
                                                  ? listSubDivisiArtistPolishing[
                                                      i]
                                                  : posisi
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 1' ||
                                                          posisi
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 2'
                                                      ? listSubDivisiArtistStell[
                                                          i]
                                                      : listSubDivisiArtistPasangBatu[
                                                          i],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )));
            })
        :
        //! function untuk artistpop yang back posisi atau juga reparasi
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
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        content: SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Text(
                                  'Pilih Artist ${listDivisi[j]}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                                //! loopimg
                                for (var i = 0;
                                    posisi.toString().toLowerCase() ==
                                            'finishing'
                                        ? i <
                                            listSubDivisiArtistFinishing.length
                                        : posisi.toString().toLowerCase() ==
                                                    'polishing 1' ||
                                                posisi
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 2'
                                            ? i <
                                                listSubDivisiArtistPolishing
                                                    .length
                                            : posisi.toString().toLowerCase() ==
                                                        'stell 1' ||
                                                    posisi
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 2'
                                                ? i <
                                                    listSubDivisiArtistStell
                                                        .length
                                                : i <
                                                    listSubDivisiArtistPasangBatu
                                                        .length;
                                    i++)
                                  Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                        // style: ElevatedButton.styleFrom(backgroundColor: colorDasar, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                // Saat tombol di-hover, atur warna latar belakang yang berbeda di sini
                                                return Colors
                                                    .red; // Ganti dengan warna yang diinginkan
                                              }
                                              // Warna latar belakang saat tidak di-hover
                                              return colorDasar; // Ganti dengan warna yang diinginkan
                                            },
                                          ),
                                        ),
                                        onPressed: () async {
                                          var artisOrulRep = '';
                                          artisOrulRep = posisi
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
                                              : posisi
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 1' ||
                                                      posisi
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 2'
                                                  ? listSubDivisiArtistPolishing[
                                                      i]
                                                  : posisi
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 1' ||
                                                          posisi
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 2'
                                                      ? listSubDivisiArtistStell[
                                                          i]
                                                      : listSubDivisiArtistPasangBatu[
                                                          i];

                                          print(
                                              '$posisi -- $artisOrulRep orul/reparasi');
                                          orulReparasiPopup(
                                              context,
                                              id,
                                              j,
                                              kodeDesignMdbc,
                                              kodeMarketing,
                                              posisi,
                                              'reparasi',
                                              artisOrulRep);
                                          onRowPressed();
                                          await postHistory(
                                              kodeDesignMdbc,
                                              kodeMarketing,
                                              "${listDivisi[j]}",
                                              artisOrulRep);
                                          Navigator.pop(context);
                                          showSimpleNotification(
                                            const Text(
                                                'Data berhasil terkirim'),
                                            background: Colors.green,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                        },
                                        child: Text(
                                          posisi.toString().toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
                                              : posisi
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 1' ||
                                                      posisi
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 2'
                                                  ? listSubDivisiArtistPolishing[
                                                      i]
                                                  : posisi
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 1' ||
                                                          posisi
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 2'
                                                      ? listSubDivisiArtistStell[
                                                          i]
                                                      : listSubDivisiArtistPasangBatu[
                                                          i],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )));
            });
  }

  orulReparasiPopup(context, id, j, kodeDesignMdbc, kodeMarketing, posisi,
      statusBackPosisi, artis) {
    return showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('');
        },
        barrierColor: Colors.red.withOpacity(0.8),
        transitionBuilder: (context, a1, a2, widget) {
          TextEditingController keterangan = TextEditingController();
          RoundedLoadingButtonController btnController =
              RoundedLoadingButtonController();
          final formKey = GlobalKey<FormState>();

          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: SizedBox(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Form(
                                key: formKey,
                                child: Column(children: [
                                  Text(
                                    'Alasan / Keterangan $artis',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    width: 250,
                                    child: TextFormField(
                                      // textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (reportinput) {},
                                      maxLines: 5, //or null
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          labelText: "Keterangan",
                                          hintText: "Keterangan"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Wajib diisi *';
                                        }
                                        return null;
                                      },
                                      controller: keterangan,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: CustomLoadingButton(
                                        controller: btnController,
                                        child: const Text("Simpan"),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            Future.delayed(const Duration(
                                                    milliseconds: 10))
                                                .then((value) async {
                                              btnController.success();
                                              print(
                                                  '$posisi => ${listDivisi[j]} : ${keterangan.text}');
                                              await postOrulReparasi(
                                                  id,
                                                  "${listDivisi[j]}",
                                                  '$artis',
                                                  '$statusBackPosisi',
                                                  '$posisi => ${listDivisi[j]} : ${keterangan.text}');

                                              // await postHistory(
                                              //   kodeDesignMdbc,
                                              //   kodeMarketing,
                                              //   "${listDivisi[j]}",
                                              //   "",
                                              // );
                                              // onRowPressed();
                                              // Navigator.pop(context);
                                              // showSimpleNotification(
                                              //   const Text(
                                              //       'Pemilihan Posisi Berhasil'),
                                              //   background: Colors.green,
                                              //   duration:
                                              //       const Duration(seconds: 1),
                                              // );
                                              Future.delayed(const Duration(
                                                      milliseconds: 10))
                                                  .then((value) {
                                                btnController.reset(); //reset
                                              });
                                            });
                                          } else {
                                            print('validasi tidak');

                                            btnController.error();
                                            Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((value) {
                                              btnController.reset(); //reset
                                            });
                                          }
                                        }),
                                  ),
                                  Container(
                                    width: 250,
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0))),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Batal",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ),
                                ]),
                              ))))));
        });
  }

  postOrulReparasi(
      id, posisi, artist, statusBackPosisi, keteranganBackPosisi) async {
    Map<String, String> body = {
      'id': id.toString(),
      'posisi': posisi.toString(),
      'artist': artist.toString(),
      'statusBackPosisi': statusBackPosisi.toString(),
      'keteranganBackPosisi': keteranganBackPosisi.toString(),
    };
    print(body);
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postKeteranganMinggu(id, keteranganMinggu) async {
    Map<String, String> body = {
      'id': id.toString(),
      'keteranganMinggu': keteranganMinggu,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postKeteranganStatusBatu(id, keteranganStatusBatu) async {
    Map<String, String> body = {
      'id': id.toString(),
      'keteranganStatusBatu': keteranganStatusBatu,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postKeteranganStatusAcc(id, keteranganStatusAcc) async {
    Map<String, String> body = {
      'id': id.toString(),
      'keteranganStatusAcc': keteranganStatusAcc,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postHistory(kodeDesignMdbc, kodeMarketing, posisi, namaArtist) async {
    Map<String, String> body = {
      'kodeDesignMdbc': kodeDesignMdbc.toString(),
      'kodeMarketing': kodeMarketing.toString(),
      'posisi': posisi.toString(),
      'namaArtis': namaArtist.toString()
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addHistoryPosisi}'),
        body: body);
    print(response.body);
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
