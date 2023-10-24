// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'dart:convert';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/produksi/modelProduksi/produksi_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

class SummarySusutScreen extends StatefulWidget {
  const SummarySusutScreen({super.key});

  @override
  State<SummarySusutScreen> createState() => _SummarySusutScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _SummarySusutScreenState extends State<SummarySusutScreen> {
  TextEditingController siklus = TextEditingController();
  String? updateSiklus = '';
  TextEditingController addSiklus = TextEditingController();

  int? spkAsrori = 0;
  double beratAsalAsrori = 0;
  double? susutAsrori = 0;
  double? jatahSusutAsrori = 0;
  double? sbAsrori = 0;
  double? resultAsrori = 0;
  double totalPointAsrori = 0.0;

  int? spkCarkiyad = 0;
  double beratAsalCarkiyad = 0;
  double? susutCarkiyad = 0;
  double? jatahSusutCarkiyad = 0;
  double? sbCarkiyad = 0;
  double? resultCarkiyad = 0;
  double totalPointCarkiyad = 0;

  int? spkEncupSupriatna = 0;
  double beratAsalEncupSupriatna = 0;
  double? susutEncupSupriatna = 0;
  double? jatahSusutEncupSupriatna = 0;
  double? sbEncupSupriatna = 0;
  double? resultEncupSupriatna = 0;
  double totalPointEncupSupriatna = 0;

  int? spkMuhammadAbdulKodir = 0;
  double beratAsalMuhammadAbdulKodir = 0;
  double? susutMuhammadAbdulKodir = 0;
  double? jatahSusutMuhammadAbdulKodir = 0;
  double? sbMuhammadAbdulKodir = 0;
  double? resultMuhammadAbdulKodir = 0;
  double totalPointMuhammadAbdulKodir = 0;
  String siklusDesigner = '';

  bool isSelected1 = false;
  TextEditingController controller = TextEditingController();
  bool sort = true;
  List<FormDesignerModel>? filterCrm;
  List<FormDesignerModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;
  bool isJenisBarangView1 = false;
  bool isLoadingJenisBarang = false;
  var nowSiklus = '';
  String? namaJenisBarangView1 = '';

  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    siklusDesigner = month;
    // _getAllDataProduksi("all", sharedPreferences!.getString('nama')!);
    nowSiklus = sharedPreferences!.getString('siklus')!;
    _getSpk("all", 'noname');
    _getPoint("all", 'noname');
    _getBeratAsal("all", 'noname');
  }

  _getSpkByName(month, name) async {
    var spk;
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

    if (response.statusCode == 200) {
      print('get data produksi berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByName = allData.where((element) =>
            element.nama.toString().toLowerCase() ==
            name.toString().toLowerCase());
        spk = filterByName.toList().length;
      } else {
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() ==
            month.toString().toLowerCase());
        var filterByName = filterBySiklus.where(
            (element) => element.nama.toString().toLowerCase() == "asrori");
        spk = filterByName.toList().length;
      }

      return spk;
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getSpk(month, name) async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

    if (response.statusCode == 200) {
      print('get data produksi berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //? asrori
        var filterByAsrori = allData.where((element) =>
            element.nama.toString().toLowerCase() == 'asrori' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkAsrori = filterByAsrori.toList().length;
        //? carkiyad
        var filterByCarkiyad = allData.where((element) =>
            element.nama.toString().toLowerCase() == 'carkiyad' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkCarkiyad = filterByCarkiyad.toList().length;
        //? encup
        var filterByEncupSupriatna = allData.where((element) =>
            element.nama.toString().toLowerCase() == 'encup supriatna' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkEncupSupriatna = filterByEncupSupriatna.toList().length;
        //? m abdul kodir
        var filterByMuhammadAbdulKodir = allData.where((element) =>
            element.nama.toString().toLowerCase() == 'muhammad abdul kodir' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkMuhammadAbdulKodir = filterByMuhammadAbdulKodir.toList().length;
      } else {
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() ==
            month.toString().toLowerCase());
        //? asrori
        var filterByAsrori = filterBySiklus.where((element) =>
            element.nama.toString().toLowerCase() == 'asrori' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkAsrori = filterByAsrori.toList().length;
        //? carkiyad
        var filterByCarkiyad = filterBySiklus.where((element) =>
            element.nama.toString().toLowerCase() == 'carkiyad' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkCarkiyad = filterByCarkiyad.toList().length;
        //? encup
        var filterByEncupSupriatna = filterBySiklus.where((element) =>
            element.nama.toString().toLowerCase() == 'encup supriatna' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkEncupSupriatna = filterByEncupSupriatna.toList().length;
        //? m abdul kodir
        var filterByMuhammadAbdulKodir = filterBySiklus.where((element) =>
            element.nama.toString().toLowerCase() == 'muhammad abdul kodir' &&
            element.keterangan.toString().toLowerCase() != 'orul');
        spkMuhammadAbdulKodir = filterByMuhammadAbdulKodir.toList().length;
      }
      setState(() {
        print('refresh state get data produksi');
        isLoading = true;
      });
      return allData;
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getPoint(month, name) async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

    if (response.statusCode == 200) {
      print('get data produksi berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //? asrori
        var filterByAsrori = allData
            .where((element) =>
                element.nama.toString().toLowerCase() == 'asrori' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByAsrori.length; i++) {
          if (filterByAsrori[i].point! > 0) {
            totalPointAsrori += filterByAsrori[i].point!;
          }
        }
        //? carkiyad
        var filterByCarkiyad = allData
            .where((element) =>
                element.nama.toString().toLowerCase() == 'carkiyad' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByCarkiyad.length; i++) {
          if (filterByCarkiyad[i].point! > 0) {
            totalPointCarkiyad += filterByCarkiyad[i].point!;
          }
        }
        //? encup
        var filterByEncupSupriatna = allData
            .where((element) =>
                element.nama.toString().toLowerCase() == 'encup supriatna' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByEncupSupriatna.length; i++) {
          if (filterByEncupSupriatna[i].point! > 0) {
            totalPointEncupSupriatna += filterByEncupSupriatna[i].point!;
          }
        }
        //? m abdul kodir
        var filterByMuhammadAbdulKodir = allData
            .where((element) =>
                element.nama.toString().toLowerCase() ==
                    'muhammad abdul kodir' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
          if (filterByMuhammadAbdulKodir[i].point! > 0) {
            totalPointMuhammadAbdulKodir +=
                filterByMuhammadAbdulKodir[i].point!;
          }
        }
      } else {
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() ==
            month.toString().toLowerCase());
        //? asrori
        var filterByAsrori = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'asrori' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByAsrori.length; i++) {
          if (filterByAsrori[i].point! > 0) {
            totalPointAsrori += filterByAsrori[i].point!;
          }
        }
        //? carkiyad
        var filterByCarkiyad = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'carkiyad' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByCarkiyad.length; i++) {
          if (filterByCarkiyad[i].point! > 0) {
            totalPointCarkiyad += filterByCarkiyad[i].point!;
          }
        }
        //? encup
        var filterByEncupSupriatna = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'encup supriatna' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByEncupSupriatna.length; i++) {
          if (filterByEncupSupriatna[i].point! > 0) {
            totalPointEncupSupriatna += filterByEncupSupriatna[i].point!;
          }
        }
        //? m abdul kodir
        var filterByMuhammadAbdulKodir = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'encup supriatna' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
          if (filterByMuhammadAbdulKodir[i].point! > 0) {
            totalPointMuhammadAbdulKodir +=
                filterByMuhammadAbdulKodir[i].point!;
          }
        }
      }
      setState(() {
        print('refresh state get data produksi point');
        isLoading = true;
      });
      return allData;
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getBeratAsal(month, name) async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

    if (response.statusCode == 200) {
      print('get data produksi berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //? asrori
        var filterByAsrori = allData
            .where((element) =>
                element.nama.toString().toLowerCase() == 'asrori' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByAsrori.length; i++) {
          if (filterByAsrori[i].debet! > 0) {
            beratAsalAsrori += filterByAsrori[i].debet!;
          }
        }
        //? carkiyad
        var filterByCarkiyad = allData
            .where((element) =>
                element.nama.toString().toLowerCase() == 'carkiyad' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByCarkiyad.length; i++) {
          if (filterByCarkiyad[i].debet! > 0) {
            beratAsalCarkiyad += filterByCarkiyad[i].debet!;
          }
        }
        //? encup
        var filterByEncupSupriatna = allData
            .where((element) =>
                element.nama.toString().toLowerCase() == 'encup supriatna' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByEncupSupriatna.length; i++) {
          if (filterByEncupSupriatna[i].debet! > 0) {
            beratAsalEncupSupriatna += filterByEncupSupriatna[i].debet!;
          }
        }
        //? m abdul kodir
        var filterByMuhammadAbdulKodir = allData
            .where((element) =>
                element.nama.toString().toLowerCase() ==
                    'muhammad abdul kodir' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
          if (filterByMuhammadAbdulKodir[i].debet! > 0) {
            beratAsalMuhammadAbdulKodir += filterByMuhammadAbdulKodir[i].debet!;
          }
        }
      } else {
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() ==
            month.toString().toLowerCase());
        //? asrori
        var filterByAsrori = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'asrori' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByAsrori.length; i++) {
          if (filterByAsrori[i].debet! > 0) {
            beratAsalAsrori += filterByAsrori[i].debet!;
          }
        }
        //? carkiyad
        var filterByCarkiyad = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'carkiyad' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByCarkiyad.length; i++) {
          if (filterByCarkiyad[i].debet! > 0) {
            beratAsalCarkiyad += filterByCarkiyad[i].debet!;
          }
        }
        //? encup
        var filterByEncupSupriatna = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'encup supriatna' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByEncupSupriatna.length; i++) {
          if (filterByEncupSupriatna[i].debet! > 0) {
            beratAsalEncupSupriatna += filterByEncupSupriatna[i].debet!;
          }
        }
        //? m abdul kodir
        var filterByMuhammadAbdulKodir = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() == 'encup supriatna' &&
                element.keterangan.toString().toLowerCase() != 'orul')
            .toList();
        for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
          if (filterByMuhammadAbdulKodir[i].debet! > 0) {
            beratAsalMuhammadAbdulKodir += filterByMuhammadAbdulKodir[i].debet!;
          }
        }
      }
      setState(() {
        print('refresh state get data produksi point');
        isLoading = true;
      });
      return allData;
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

  _getBeratAsalByName(month, name) async {
    double sumDebet = 0.0;

    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

    if (response.statusCode == 200) {
      print('get data produksi berhasil');
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByName = allData
            .where((element) =>
                element.nama.toString().toLowerCase() ==
                name.toString().toLowerCase())
            .toList();
        for (var i = 0; i < filterByName.length; i++) {
          if (filterByName[i].debet! > 0) {
            sumDebet += filterByName[i].debet!;
          }
        }
        // beratAsal = filterByName.toList().length;
      } else {
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() ==
            month.toString().toLowerCase());
        var filterByName = filterBySiklus
            .where((element) =>
                element.nama.toString().toLowerCase() ==
                name.toString().toLowerCase())
            .toList();
        for (var i = 0; i < filterByName.length; i++) {
          if (filterByName[i].debet! > 0) {
            sumDebet += filterByName[i].debet!;
          }
        }
      }
      return sumDebet.toStringAsFixed(2);
    } else {
      print('get data produksi gagal');
      throw Exception('Unexpected error occured!');
    }
  }

//! data table
  DataTable _dataTableFinishing() {
    return DataTable(
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.blue),
        columnSpacing: 1,
        headingRowHeight: 50,
        dataRowMaxHeight: 50,
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('NAMA')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('SPK')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('TOTAL POINT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BERAT ASAL')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('SUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('JATAH SUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('STOR SB ARTIS')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('RESULT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('KETERANGAN')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('Asrori')),
        DataCell(_verticalDivider),
        //! versi get dahulu lalu simpan
        DataCell(Text('$spkAsrori')),
        //!versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getSpkByName("all", "Asrori"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),
        DataCell(_verticalDivider),
        DataCell(Text(totalPointAsrori.toStringAsFixed(2))),
        DataCell(_verticalDivider),
        DataCell(Text(beratAsalAsrori.toStringAsFixed(2))),
        //! versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getBeratAsalByName("all", "Asrori"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),
        DataCell(_verticalDivider),
        DataCell(Text('1.82')),
        DataCell(_verticalDivider),
        DataCell(Text('1.60')),
        DataCell(_verticalDivider),
        DataCell(Text('13.31')),
        DataCell(_verticalDivider),
        DataCell(
          Text('-0.22'),
        ),
        DataCell(_verticalDivider),
        DataCell(
          Text(
            '(POTONGAN)',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('Carkiyad')),
        DataCell(_verticalDivider),
        //! versi get dahulu lalu simpan
        DataCell(Text('$spkCarkiyad')),
        //!versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getSpkByName("all", "Carkiyad"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),
        DataCell(_verticalDivider),
        DataCell(Text(totalPointCarkiyad.toStringAsFixed(2))),
        DataCell(_verticalDivider),
        DataCell(Text(beratAsalCarkiyad.toStringAsFixed(2))),
        //! versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getBeratAsalByName("all", "Carkiyad"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),
        DataCell(_verticalDivider),
        DataCell(Text('1.82')),
        DataCell(_verticalDivider),
        DataCell(Text('1.60')),
        DataCell(_verticalDivider),
        DataCell(Text('13.31')),
        DataCell(_verticalDivider),
        DataCell(
          Text('-0.22'),
        ),
        DataCell(_verticalDivider),
        DataCell(
          Text(
            '(POTONGAN)',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('Encup Supriatna')),
        DataCell(_verticalDivider),
        //! versi get dahulu lalu simpan
        DataCell(Text('$spkEncupSupriatna')),
        //!versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getSpkByName("all", "encup supriatna"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),
        DataCell(_verticalDivider),
        DataCell(Text(totalPointEncupSupriatna.toStringAsFixed(2))),
        DataCell(_verticalDivider),
        DataCell(Text(beratAsalEncupSupriatna.toStringAsFixed(2))),
        //! versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getBeratAsalByName("all", "encup supriatna"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),
        DataCell(_verticalDivider),
        DataCell(Text('1.82')),
        DataCell(_verticalDivider),
        DataCell(Text('1.60')),
        DataCell(_verticalDivider),
        DataCell(Text('13.31')),
        DataCell(_verticalDivider),
        DataCell(
          Text('1.22'),
        ),
        DataCell(_verticalDivider),
        DataCell(
          Text(
            '(BONUS)',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('Muhammad Abdul Kodir')),
        DataCell(_verticalDivider),
        //! versi get dahulu lalu simpan
        DataCell(Text('$spkMuhammadAbdulKodir')),
        //!versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getSpkByName("all", "Muhammad Abdul Kodir"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),
        DataCell(_verticalDivider),
        DataCell(Text(totalPointMuhammadAbdulKodir.toStringAsFixed(2))),
        DataCell(_verticalDivider),
        DataCell(Text(beratAsalMuhammadAbdulKodir.toStringAsFixed(2))),
        //! versi langsung get
        // DataCell(FutureBuilder(
        //     future: _getBeratAsalByName("all", "Muhammad Abdul Kodir"),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('Database Off');
        //       }
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.toString());
        //       } else {
        //         return const CircularProgressIndicator();
        //       }
        //     })),

        DataCell(_verticalDivider),
        DataCell(Text('1.82')),
        DataCell(_verticalDivider),
        DataCell(Text('1.60')),
        DataCell(_verticalDivider),
        DataCell(Text('13.31')),
        DataCell(_verticalDivider),
        DataCell(
          Text('5.22'),
        ),
        DataCell(_verticalDivider),
        DataCell(
          Text(
            '(BONUS)',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    ];
  }

  //! end data table

  @override
  Widget build(BuildContext context) {
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

            // drawer: Drawer1(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              leadingWidth: 320,
              //change siklus
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Siklus Saat Ini : $nowSiklus",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                Text(
                  version,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            body: isLoading == false
                ? Center(
                    child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 90,
                    height: 90,
                    child: Lottie.asset("loadingJSON/loadingV1.json"),
                  ))
                : dashboardProduksi()));
  }

  //! dashboard produksi
  dashboardProduksi() {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width * 0.3,
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
                  isLoadingJenisBarang = false;
                  siklus.text = item!;
                  siklusDesigner = siklus.text.toString();
                  // _getAllDataProduksi(
                  //     siklusDesigner, sharedPreferences!.getString('nama')!);
                });
                Future.delayed(const Duration(milliseconds: 500)).then((value) {
                  setState(() {
                    isLoadingJenisBarang = true;
                  });
                });
              },
              popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                showSelectedItems: true,
                showSearchBox: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                textAlign: TextAlign.center,
                baseStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                dropdownSearchDecoration: InputDecoration(
                    labelText: "Pilih Siklus",
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      //? BARIS 1
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'FINISHING',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),

                      // //? BARIS 2
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'POLESHING 1',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),

                      // //? BARIS 3
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'POLESHING 2',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),

                      // //? BARIS 4
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'POLESHING 2 REPARASI',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),

                      // //? BARIS 5
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'STELL 1',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),

                      // //? BARIS 6
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'STELL 2',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),

                      // //? BARIS 7
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'STELL 2 REP',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),
                      // //? BARIS 8
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'CHROME',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                      SizedBox(height: 20),
                      // //? BARIS 29
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Text(
                                    'CHROME REPARASI',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  _dataTableFinishing(),
                                ],
                              ))),
                    ]),
              ),
            ),
          ),
        ),
      ],
    );
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
      //nama
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.nama)),
      ),
      DataCell(_verticalDivider),
      //tanggal in
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(DateFormat('dd/MMMM/yyyy hh:mm:ss')
                .format(DateTime.parse(data.tanggalIn.toString())))),
      ),
      DataCell(_verticalDivider),
      //tanggal out
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.tanggalOut)),
      ),
      DataCell(_verticalDivider),
      //kode produksi
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.kodeProduksi)),
      ),
      DataCell(_verticalDivider),
      //debet
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.debet.toString())),
      ),
      DataCell(_verticalDivider),

      //kredit
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.kredit.toString())),
      ),
      // sharedPreferences!.getString('level') != '1'
      //     ? const DataCell(SizedBox())
      //     : DataCell(_verticalDivider),
      // sharedPreferences!.getString('level') != '1'
      //     ? const DataCell(SizedBox())
      //     :
      //     //Aksi
      //     DataCell(Builder(builder: (context) {
      //         return sharedPreferences!.getString('level') != '1'
      //             ? const Row()
      //             : Row(
      //                 children: [
      //                   IconButton(
      //                     onPressed: () {
      //                       showDialog<String>(
      //                         context: context,
      //                         builder: (BuildContext context) => AlertDialog(
      //                           title: const Text(
      //                             'Perhatian',
      //                             textAlign: TextAlign.center,
      //                             style: TextStyle(
      //                                 color: Colors.black,
      //                                 fontWeight: FontWeight.bold),
      //                           ),
      //                           content: Row(
      //                             children: [
      //                               const Text(
      //                                 'Apakah anda yakin ingin menghapus data batu ',
      //                               ),
      //                               Text(
      //                                 '${data.size}  ?',
      //                                 style: const TextStyle(
      //                                     fontWeight: FontWeight.bold,
      //                                     color: Colors.black),
      //                               ),
      //                             ],
      //                           ),
      //                           actions: <Widget>[
      //                             TextButton(
      //                               onPressed: () => Navigator.pop(
      //                                 context,
      //                                 'Batal',
      //                               ),
      //                               child: const Text('Batal'),
      //                             ),
      //                             TextButton(
      //                               onPressed: () async {
      //                                 var id = data.id.toString();
      //                                 Map<String, String> body = {'id': id};
      //                                 final response = await http.post(
      //                                     Uri.parse(ApiConstants.baseUrl +
      //                                         ApiConstants.postDeleteBatuById),
      //                                     body: body);
      //                                 print(response.body);

      //                                 Navigator.push(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                         builder: (c) =>
      //                                             const MainViewBatu()));
      //                                 showDialog<String>(
      //                                     context: context,
      //                                     builder: (BuildContext context) =>
      //                                         const AlertDialog(
      //                                           title: Text(
      //                                             'Hapus Batu Berhasil',
      //                                           ),
      //                                         ));
      //                               },
      //                               child: const Text(
      //                                 'Hapus',
      //                                 style: TextStyle(color: Colors.red),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       );
      //                     },
      //                     icon: const Icon(
      //                       Icons.delete,
      //                       color: Colors.red,
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 25),
      //                     child: IconButton(
      //                       onPressed: () {
      //                         showDialog(
      //                             context: context,
      //                             builder: (BuildContext context) {
      //                               final _formKey = GlobalKey<FormState>();
      //                               TextEditingController lot =
      //                                   TextEditingController();
      //                               TextEditingController size =
      //                                   TextEditingController();
      //                               TextEditingController parcel =
      //                                   TextEditingController();
      //                               TextEditingController qty =
      //                                   TextEditingController();
      //                               String id;

      //                               id = data.id.toString();
      //                               lot.text = data.lot;
      //                               size.text = data.size;
      //                               parcel.text = data.parcel;
      //                               qty.text = data.qty.toString();
      //                               RoundedLoadingButtonController
      //                                   btnController =
      //                                   RoundedLoadingButtonController();
      //                               return AlertDialog(
      //                                 content: Stack(
      //                                   clipBehavior: Clip.none,
      //                                   children: <Widget>[
      //                                     Positioned(
      //                                       right: -47.0,
      //                                       top: -47.0,
      //                                       child: InkResponse(
      //                                         onTap: () {
      //                                           Navigator.of(context).pop();
      //                                         },
      //                                         child: const CircleAvatar(
      //                                           backgroundColor: Colors.red,
      //                                           child: Icon(Icons.close),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     Form(
      //                                       key: _formKey,
      //                                       child: Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           //lot
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: lot,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Lot",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }
      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           //size
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: size,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Ukuran",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }
      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: parcel,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Parcel",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }
      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: qty,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Qty",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }

      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: SizedBox(
      //                                               width: 250,
      //                                               child: CustomLoadingButton(
      //                                                   controller:
      //                                                       btnController,
      //                                                   child: const Text(
      //                                                       "Update"),
      //                                                   onPressed: () async {
      //                                                     if (_formKey
      //                                                         .currentState!
      //                                                         .validate()) {
      //                                                       _formKey
      //                                                           .currentState!
      //                                                           .save();
      //                                                       Future.delayed(
      //                                                               const Duration(
      //                                                                   seconds:
      //                                                                       2))
      //                                                           .then(
      //                                                               (value) async {
      //                                                         btnController
      //                                                             .success();
      //                                                         Map<String,
      //                                                                 dynamic>
      //                                                             body = {
      //                                                           'id': id,
      //                                                           'lot': lot.text,
      //                                                           'size':
      //                                                               size.text,
      //                                                           'parcel':
      //                                                               parcel.text,
      //                                                           'qty': qty.text,
      //                                                         };
      //                                                         final response = await http.post(
      //                                                             Uri.parse(ApiConstants
      //                                                                     .baseUrl +
      //                                                                 ApiConstants
      //                                                                     .postUpdateListDataBatu),
      //                                                             body: body);
      //                                                         print(response
      //                                                             .body);
      //                                                         Future.delayed(
      //                                                                 const Duration(
      //                                                                     seconds:
      //                                                                         1))
      //                                                             .then(
      //                                                                 (value) {
      //                                                           btnController
      //                                                               .reset(); //reset
      //                                                           showDialog<
      //                                                                   String>(
      //                                                               context:
      //                                                                   context,
      //                                                               builder: (BuildContext
      //                                                                       context) =>
      //                                                                   const AlertDialog(
      //                                                                     title:
      //                                                                         Text(
      //                                                                       'Update Berhasil',
      //                                                                     ),
      //                                                                   ));
      //                                                         });
      //                                                         Navigator.push(
      //                                                             context,
      //                                                             MaterialPageRoute(
      //                                                                 builder:
      //                                                                     (c) =>
      //                                                                         const MainViewBatu()));
      //                                                       });
      //                                                     } else {
      //                                                       btnController
      //                                                           .error();
      //                                                       Future.delayed(
      //                                                               const Duration(
      //                                                                   seconds:
      //                                                                       1))
      //                                                           .then((value) {
      //                                                         btnController
      //                                                             .reset(); //reset
      //                                                       });
      //                                                     }
      //                                                   }),
      //                                             ),
      //                                           )
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               );
      //                             });
      //                       },
      //                       icon: const Icon(
      //                         Icons.edit,
      //                         color: Colors.green,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               );
      //       }))
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
