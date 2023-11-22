// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/produksi/modelProduksi/produksi_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

class SummaryProduktivitasScreen extends StatefulWidget {
  const SummaryProduktivitasScreen({super.key});

  @override
  State<SummaryProduktivitasScreen> createState() =>
      _SummaryProduktivitasScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _SummaryProduktivitasScreenState
    extends State<SummaryProduktivitasScreen> {
  TextEditingController siklus = TextEditingController();
  String? updateSiklus = '';
  TextEditingController addSiklus = TextEditingController();
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
  List artistProduktivitas = [];
  List pointProduktivitasFinishing = [];
  List pointProduktivitasPolishing1 = [];
  List pointProduktivitasPolishing2 = [];
  List pointProduktivitasPolishing2Rep = [];
  List pointProduktivitasStell1 = [];
  List pointProduktivitasStell2 = [];
  List pointProduktivitasStell2Rep = [];
  List sumProduktivitas = [];
  int qtyArtist = 0;
  var data;

  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    siklusDesigner = month;
    // _getAllDataProduksi("all", sharedPreferences!.getString('nama')!);
    nowSiklus = sharedPreferences!.getString('siklus')!;
    _getDataAll('all');
  }

  Future<dynamic> fetchData() async {
    final url = ApiConstants.baseUrl +
        ApiConstants.getNilaiProduksi; // replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));
      return jsonDecode(response.body);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  void _getDataAll(month) async {
    setState(() {
      isLoading = true;
    });
    data = await fetchData();
    await _getName(month);
    await _getPoint(month);
    setState(() {
      isLoading = false;
    });
  }

  _getName(month) async {
    artistProduktivitas = [];
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data nama');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByDivisi = allData.where((element) =>
            element.divisi.toString().toLowerCase() != 'pasang batu');
        var allDataProduktivitas = filterByDivisi.toList();

        //! jika suklis tidak di pilih
        allData = removeDuplicates(allDataProduktivitas);
        //? ambil data nama
        for (var i = 0; i < allData.length; i++) {
          artistProduktivitas.add(allData[i].nama);
        }
        artistProduktivitas.removeWhere((element) => element.toString() == '');
        artistProduktivitas.sort((a, b) => a.compareTo(b));
        artistProduktivitas.add('Total');

        qtyArtist = artistProduktivitas.length;
      } else {
        //! jika siklus di pilih
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());
        var filterByDivisi = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() != 'pasang batu');
        var allDataProduktivitas = filterByDivisi.toList();
        //! jika suklis tidak di pilih
        allData = removeDuplicates(allDataProduktivitas);
        // allDataFinishing.removeWhere((element) => element == '');
        //? ambil data nama
        for (var i = 0; i < allData.length; i++) {
          artistProduktivitas.add(allData[i].nama);
        }
        artistProduktivitas.removeWhere((element) => element.toString() == '');
        artistProduktivitas.sort((a, b) => a.compareTo(b));
        artistProduktivitas.add('Total');
        qtyArtist = artistProduktivitas.length;
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getPoint(month) async {
    pointProduktivitasFinishing = [];
    pointProduktivitasPolishing1 = [];
    pointProduktivitasPolishing2 = [];
    pointProduktivitasPolishing2Rep = [];
    pointProduktivitasStell1 = [];
    pointProduktivitasStell2 = [];
    pointProduktivitasStell2Rep = [];
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data nama');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        var filterByDivisi = allData.where((element) =>
            element.divisi.toString().toLowerCase() != 'pasang batu');
        var allDataProduktivitas = filterByDivisi.toList();

        //! jika suklis tidak di pilih
        //? ambil data nama
        for (var i = 0; i < artistProduktivitas.length; i++) {
          double apiPointProduktivitasFinishing = 0;
          double apiPointProduktivitasPolishing1 = 0;
          double apiPointProduktivitasPolishing2 = 0;
          double apiPointProduktivitasPolishing2Rep = 0;
          double apiPointProduktivitasStell1 = 0;
          double apiPointProduktivitasStell2 = 0;
          double apiPointProduktivitasStell2Rep = 0;

          //! finishing
          var filterByNameFinishing = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'finishing')
              .toList();
          for (var j = 0; j < filterByNameFinishing.length; j++) {
            apiPointProduktivitasFinishing += filterByNameFinishing[j].point!;
          }
          //? end finishing

          //! Polishing1
          var filterByNamePolishing1 = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'poleshing 1')
              .toList();
          for (var j = 0; j < filterByNamePolishing1.length; j++) {
            apiPointProduktivitasPolishing1 += filterByNamePolishing1[j].point!;
          }
          //? end Polishing1

          //! Polishing2
          var filterByNamePolishing2 = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'Polishing 2')
              .toList();
          for (var j = 0; j < filterByNamePolishing2.length; j++) {
            apiPointProduktivitasPolishing2 += filterByNamePolishing2[j].point!;
          }
          //? end Polishing2

          //! Polishing2Rep
          var filterByNamePolishing2Rep = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'poleshing 2 rep')
              .toList();
          for (var j = 0; j < filterByNamePolishing2Rep.length; j++) {
            apiPointProduktivitasPolishing2Rep +=
                filterByNamePolishing2Rep[j].point!;
          }
          //? end Polishing2Rep

          //! Stell1
          var filterByNameStell1 = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'poleshing 1')
              .toList();
          for (var j = 0; j < filterByNameStell1.length; j++) {
            apiPointProduktivitasStell1 += filterByNameStell1[j].point!;
          }
          //? end Stell1

          //! Stell2
          var filterByNameStell2 = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'Stell 2')
              .toList();
          for (var j = 0; j < filterByNameStell2.length; j++) {
            apiPointProduktivitasStell2 += filterByNameStell2[j].point!;
          }
          //? end Stell2

          //! Stell2Rep
          var filterByNameStell2Rep = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'Stell 2 rep')
              .toList();
          for (var j = 0; j < filterByNameStell2Rep.length; j++) {
            apiPointProduktivitasStell2Rep += filterByNameStell2Rep[j].point!;
          }
          //? end Stell2Rep

          pointProduktivitasFinishing.add(apiPointProduktivitasFinishing);
          pointProduktivitasPolishing1.add(apiPointProduktivitasPolishing1);
          pointProduktivitasPolishing2.add(apiPointProduktivitasPolishing2);
          pointProduktivitasPolishing2Rep
              .add(apiPointProduktivitasPolishing2Rep);
          pointProduktivitasStell1.add(apiPointProduktivitasStell1);
          pointProduktivitasStell2.add(apiPointProduktivitasStell2);
          pointProduktivitasStell2Rep.add(apiPointProduktivitasStell2Rep);
        }
        double sumFinishing =
            pointProduktivitasFinishing.fold(0, (a, b) => a + b);
        double sumPolishing1 =
            pointProduktivitasPolishing1.fold(0, (a, b) => a + b);
        double sumPolishing2 =
            pointProduktivitasPolishing2.fold(0, (a, b) => a + b);
        double sumPolishing2Rep =
            pointProduktivitasPolishing2Rep.fold(0, (a, b) => a + b);
        double sumStell1 = pointProduktivitasStell1.fold(0, (a, b) => a + b);
        double sumStell2 = pointProduktivitasStell2.fold(0, (a, b) => a + b);
        double sumStell2Rep =
            pointProduktivitasStell2Rep.fold(0, (a, b) => a + b);
        sumProduktivitas.add(sumFinishing);
        double allSumPolishing =
            sumPolishing1 + sumPolishing2 + sumPolishing2Rep;
        sumProduktivitas.add(allSumPolishing);

        double allSumStell = sumStell1 + sumStell2 + sumStell2Rep;
        sumProduktivitas.add(allSumStell);
      } else {
        //! jika siklus di pilih
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());
        var filterByDivisi = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() != 'pasang batu');
        var allDataProduktivitas = filterByDivisi.toList();

        //! jika suklis tidak di pilih
        //? ambil data nama
        for (var i = 0; i < artistProduktivitas.length; i++) {
          double apiPointProduktivitas = 0;
          var filterByName = allDataProduktivitas
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                      artistProduktivitas[i].toLowerCase() &&
                  element.divisi.toString().toLowerCase() == 'finishing')
              .toList();
          for (var j = 0; j < filterByName.length; j++) {
            apiPointProduktivitas += filterByName[j].point!;
          }
          pointProduktivitasFinishing.add(apiPointProduktivitas);
        }
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  // fungsi remove duplicate object
  List<ProduksiModel> removeDuplicates(List<ProduksiModel> items) {
    List<ProduksiModel> uniqueItems = []; // uniqueList
    var uniqueNames = items
        .map((e) => e.nama)
        .toSet(); //list if UniqueID to remove duplicates
    for (var e in uniqueNames) {
      uniqueItems.add(items.firstWhere((i) => i.nama == e));
    } // populate uniqueItems with equivalent original Batch items
    return uniqueItems; //send back the unique items list
  }

//! data table
  DataTable _dataTablePendapatan() {
    return DataTable(
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.blue),
        columnSpacing: 0,
        headingRowHeight: 50,
        dataRowMaxHeight: 50,
        columns: _createColumns(),
        // border: TableBorder.all(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('NAMA')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('FINISHING')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('POLISHING 1')),
      // DataColumn(
      //     label: InkWell(
      //         onTap: () {
      //           showSimpleNotification(
      //             Text('tap POLISHING'),
      //             background: Colors.green,
      //             duration: const Duration(seconds: 1),
      //           );
      //         },
      //         child: Text('POLISHING'))),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('STELL RANGKA 1')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('TOTAL\n(produktivitas)')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      for (var i = 0; i < qtyArtist; i++)
        DataRow(cells: [
          DataCell(artistProduktivitas[i].toString().toLowerCase() == 'total'
              ? Text(
                  artistProduktivitas[i],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Text(artistProduktivitas[i])),
          DataCell(_verticalDivider),
          DataCell(artistProduktivitas[i].toString().toLowerCase() == 'total'
              ? Text(
                  CurrencyFormat.convertToIdr(
                      (sumProduktivitas[0] * data[0]['finishing']), 0),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Text(CurrencyFormat.convertToIdr(
                  (pointProduktivitasFinishing[i] * data[0]['finishing']), 0))),
          DataCell(_verticalDivider),
          DataCell(artistProduktivitas[i].toString().toLowerCase() == 'total'
              ? Text(
                  CurrencyFormat.convertToIdr(
                      (sumProduktivitas[1] * data[0]['polishing1']), 0),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Text(CurrencyFormat.convertToIdr(
                  ((pointProduktivitasPolishing1[i] +
                          pointProduktivitasPolishing2[i] +
                          pointProduktivitasPolishing2Rep[i]) *
                      data[0]['polishing1']),
                  0))),
          DataCell(_verticalDivider),
          DataCell(artistProduktivitas[i].toString().toLowerCase() == 'total'
              ? Text(
                  CurrencyFormat.convertToIdr(
                      (sumProduktivitas[2] * data[0]['stell_rangka1']), 0),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Text(CurrencyFormat.convertToIdr(
                  ((pointProduktivitasStell1[i] +
                          pointProduktivitasStell2[i] +
                          pointProduktivitasStell2Rep[i]) *
                      data[0]['stell_rangka1']),
                  0))),
          DataCell(_verticalDivider),
          DataCell(Text(CurrencyFormat.convertToIdr(
              (((
                          //* total Stell
                          pointProduktivitasStell1[i] +
                              pointProduktivitasStell2[i] +
                              pointProduktivitasStell2Rep[i]) *
                      data[0]['polishing1']) +
                  //* total poelshing
                  ((pointProduktivitasPolishing1[i] +
                          pointProduktivitasPolishing2[i] +
                          pointProduktivitasPolishing2Rep[i]) *
                      data[0]['polishing1']) +
                  //* total finis
                  (pointProduktivitasFinishing[i] * data[0]['finishing'])),
              0))),
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
              backgroundColor: Colors.white,
              leadingWidth: 320,
              //change siklus
              leading: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Siklus Saat Ini : $nowSiklus",
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: dashboardProduksi()));
  }

  //! dashboard produksi
  dashboardProduksi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 26),
          child: const Text(
            'Summary Produktivitas',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        Container(
          width: 350,
          padding: const EdgeInsets.all(10.0),
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
            dropdownDecoratorProps: const DropDownDecoratorProps(
              textAlign: TextAlign.center,
              baseStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              dropdownSearchDecoration: InputDecoration(
                  labelText: "Pilih Siklus",
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
          ),
        ),
        Expanded(
          child: isLoading == true
              ? Center(
                  child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 90,
                  height: 90,
                  child: Lottie.asset("loadingJSON/loadingV1.json"),
                ))
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
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
                                        'PRODUKTIVITAS',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      _dataTablePendapatan(),
                                    ],
                                  ))),
                          SizedBox(height: 20),

                          //? BARIS 2
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  color: Colors.grey.shade200,
                                  child: Column(
                                    children: [
                                      Text(
                                        'BONUS',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      _dataTablePendapatan(),
                                    ],
                                  ))),
                          SizedBox(height: 20),
                          //? BARIS 3
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  color: Colors.grey.shade200,
                                  child: Column(
                                    children: [
                                      Text(
                                        'SUSUT',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      _dataTablePendapatan(),
                                    ],
                                  ))),
                          SizedBox(height: 20),
                        ],
                      ),
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
