// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'dart:convert';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/produksi/modelProduksi/produksi_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

class SummaryPasangBatuScreen extends StatefulWidget {
  const SummaryPasangBatuScreen({super.key});

  @override
  State<SummaryPasangBatuScreen> createState() =>
      _SummaryPasangBatuScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _SummaryPasangBatuScreenState extends State<SummaryPasangBatuScreen> {
  TextEditingController siklus = TextEditingController();
  String? updateSiklus = '';
  TextEditingController addSiklus = TextEditingController();
  List artistPasangBatu = [];
  List spkPasangBatu = [];
  List sumButir = [];
  List sumCarat = [];
  List sumPecahButir = [];
  List sumPecahCarat = [];
  List sumHilangButir = [];
  List sumHilangCarat = [];
  List sumTotalOngkosan = [];
  List sumAsal = [];
  List sumJadi = [];
  List sumSusut = [];
  List sumJatahSusut = [];
  int qtyNamePasangBatu = 0;

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
  String siklusDesigner = '';

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

  void _getDataAll(month) async {
    setState(() {
      isLoading = true;
    });
    await _getName(month);
    await _getSpk(month);
    await _getSum(month);
    setState(() {
      isLoading = false;
    });
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

  _getName(month) async {
    artistPasangBatu = [];

    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data nama');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //* function PasangBatu
        //? filter by divisi PasangBatu
        var filterByDivisiPasangBatu = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'pasang batu');
        var allDataPasangBatu = filterByDivisiPasangBatu.toList();
        //! jika suklis tidak di pilih
        allDataPasangBatu = removeDuplicates(allDataPasangBatu);
        //? ambil data nama
        for (var i = 0; i < allDataPasangBatu.length; i++) {
          artistPasangBatu.add(allDataPasangBatu[i].nama);
        }
        artistPasangBatu.sort((a, b) => a.compareTo(b));
        qtyNamePasangBatu = artistPasangBatu.length;
      } else {
        //! jika siklus di pilih
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //* function PasangBatu
        //? filter by divisi PasangBatu
        var filterByDivisiPasangBatu = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'pasang batu');
        var allDataPasangBatu = filterByDivisiPasangBatu.toList();
        //! jika suklis tidak di pilih
        allDataPasangBatu = removeDuplicates(allDataPasangBatu);
        //? ambil data nama
        for (var i = 0; i < allDataPasangBatu.length; i++) {
          artistPasangBatu.add(allDataPasangBatu[i].nama);
        }
        artistPasangBatu.sort((a, b) => a.compareTo(b));

        qtyNamePasangBatu = artistPasangBatu.length;
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getSpk(month) async {
    spkPasangBatu = [];

    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data nama');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //* function PasangBatu
        //? filter by divisi PasangBatu
        var filterByDivisiPasangBatu = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'pasang batu' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataPasangBatu = filterByDivisiPasangBatu.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNamePasangBatu; i++) {
          var filterByNamePasangBatu = allDataPasangBatu.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistPasangBatu[i].toLowerCase());
          spkPasangBatu.add(filterByNamePasangBatu.length.toString());
        }
      } else {
        //! jika siklus di pilih
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());
        //* function PasangBatu
        //? filter by divisi PasangBatu
        var filterByDivisiPasangBatu = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'pasang batu' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataPasangBatu = filterByDivisiPasangBatu.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNamePasangBatu; i++) {
          var filterByNamePasangBatu = allDataPasangBatu.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistPasangBatu[i].toLowerCase());
          spkPasangBatu.add(filterByNamePasangBatu.length.toString());
        }
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getSum(month) async {
    sumButir = [];
    sumCarat = [];
    sumPecahButir = [];
    sumPecahCarat = [];
    sumHilangButir = [];
    sumHilangCarat = [];
    sumAsal = [];
    sumJadi = [];
    sumTotalOngkosan = [];

    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data nama');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //* function PasangBatu
        //? filter by divisi PasangBatu
        var filterByDivisiPasangBatu = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'pasang batu' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataPasangBatu = filterByDivisiPasangBatu.toList();

        for (var i = 0; i < qtyNamePasangBatu; i++) {
          int dumSumButir = 0;
          double dumSumCarat = 0;
          double dumSumAsal = 0;
          double dumSumPecahButir = 0;
          double dumSumPecahCarat = 0;
          double dumSumHilangButir = 0;
          double dumSumHilangCarat = 0;
          double dumSumJadi = 0;
          int dumSumTotalOngkosan = 0;
          var filterByNamePasangBatu = allDataPasangBatu
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPasangBatu[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePasangBatu.length; j++) {
            dumSumButir += filterByNamePasangBatu[j].butirDiamond!;
            dumSumCarat += filterByNamePasangBatu[j].beratDiamond!;
            dumSumAsal += filterByNamePasangBatu[j].debet!;
            dumSumJadi += filterByNamePasangBatu[j].kredit!;
            dumSumPecahButir += filterByNamePasangBatu[j].pecahButir!;
            dumSumPecahCarat += filterByNamePasangBatu[j].pecahCarat!;
            dumSumHilangButir += filterByNamePasangBatu[j].hilangButir!;
            dumSumHilangCarat += filterByNamePasangBatu[j].hilangCarat!;
            dumSumTotalOngkosan += filterByNamePasangBatu[j].totalOngkosan!;
          }
          sumButir.add(dumSumButir.toString());
          sumCarat.add(dumSumCarat);
          sumAsal.add(dumSumAsal);
          sumJadi.add(dumSumJadi);
          sumSusut.add((dumSumCarat * 0.2) + dumSumAsal - dumSumJadi);
          sumJatahSusut.add((sumSusut[i] * 0.25) + 0.075);
          sumPecahButir.add(dumSumPecahButir);
          sumPecahCarat.add(dumSumPecahCarat);
          sumHilangButir.add(dumSumHilangButir);
          sumHilangCarat.add(dumSumHilangCarat);
          sumTotalOngkosan.add(dumSumTotalOngkosan);
        }
        // final responseSB = await http
        //     .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        // if (responseSB.statusCode == 200) {
        //   List jsonResponseSB = json.decode(responseSB.body);
        //   var allDataSB = jsonResponseSB
        //       .map((data) => ProduksiSBModel.fromJson(data))
        //       .toList();
        //   var filterByDivisiSB = allDataSB.where((element) =>
        //       element.divisi.toString().toLowerCase() == 'finishing');
        //   if (month.toString().toLowerCase() == "all") {
        //     for (var i = 0; i < qtyNamePasangBatu; i++) {
        //       double apiBeratAsalSB = 0;
        //       double apiBeratAkirSB = 0;
        //     }
        //   } else {

        //   }
        // } else {
        //   throw Exception('Unexpected error occured!');
        // }
      } else {
        //! jika siklus di pilih
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());
        //* function PasangBatu
        //? filter by divisi PasangBatu
        var filterByDivisiPasangBatu = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'pasang batu' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataPasangBatu = filterByDivisiPasangBatu.toList();

        for (var i = 0; i < qtyNamePasangBatu; i++) {
          int dumSumButir = 0;
          double dumSumCarat = 0;
          double dumSumAsal = 0;
          double dumSumJadi = 0;
          var filterByNamePasangBatu = allDataPasangBatu
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPasangBatu[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePasangBatu.length; j++) {
            dumSumButir += filterByNamePasangBatu[j].butirDiamond!;
            dumSumCarat += filterByNamePasangBatu[j].beratDiamond!;
            dumSumAsal += filterByNamePasangBatu[j].debet!;
            dumSumJadi += filterByNamePasangBatu[j].kredit!;
          }
          sumButir.add(dumSumButir.toString());
          sumCarat.add(dumSumCarat);
          sumAsal.add(dumSumAsal);
          sumJadi.add(dumSumJadi);
          sumSusut.add((dumSumCarat * 0.2) + dumSumAsal - dumSumJadi);
          sumJatahSusut.add((sumSusut[i] * 0.25) + 0.075);
        }
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

//! data table
  DataTable _dataTable() {
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
      DataColumn(label: Text('TOTAL\nBUTIR')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('TOTAL\nCARAT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BERAT\nASAL')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BERAT\nJADI')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('SUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('JATAH\nSUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('RESULT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('KETERANGAN')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('PECAH\nBUTIR')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('PECAH\nCARAT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('HILANG\nBUTIR')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('HILANG\nCARAT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('TOTAL\nPENDAPATAN')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      for (var i = 0; i < qtyNamePasangBatu; i++)
        DataRow(cells: [
          DataCell(Text(artistPasangBatu[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkPasangBatu[i])),
          DataCell(_verticalDivider),
          DataCell(Text(sumButir[i])),
          DataCell(_verticalDivider),
          DataCell(Text(sumCarat[i].toStringAsFixed(3))),
          DataCell(_verticalDivider),
          DataCell(Text(sumAsal[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(sumJadi[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(sumSusut[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(sumJatahSusut[i].toStringAsFixed(3))),
          DataCell(_verticalDivider),
          DataCell(Text('13.31')),
          DataCell(_verticalDivider),
          DataCell(
            Text(
              '(POTONGAN)',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          DataCell(_verticalDivider),
          DataCell(Text(sumPecahButir[i].toStringAsFixed(0))),
          DataCell(_verticalDivider),
          DataCell(Text(sumPecahCarat[i].toStringAsFixed(3))),
          DataCell(_verticalDivider),
          DataCell(Text(sumHilangButir[i].toStringAsFixed(0))),
          DataCell(_verticalDivider),
          DataCell(Text(sumHilangCarat[i].toStringAsFixed(3))),
          DataCell(_verticalDivider),
          DataCell(Text(CurrencyFormat.convertToIdr(sumTotalOngkosan[i], 0))),
        ]),
    ];
  }

  //! end data table

  //! data table
  DataTable _dataTablePecahHilang() {
    return DataTable(
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.blue),
        columnSpacing: 1,
        headingRowHeight: 50,
        dataRowMaxHeight: 50,
        columns: _createColumnsPecahHilang(),
        rows: _createRowsPecah());
  }

  List<DataColumn> _createColumnsPecahHilang() {
    return [
      DataColumn(label: Text('NAMA')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('PARCEL')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('UKURAN')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BUTIR')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('CARAT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('HARGA')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('KETERANGAN')),
    ];
  }

  List<DataRow> _createRowsPecah() {
    return [
      for (var i = 0; i < qtyNamePasangBatu; i++)
        DataRow(cells: [
          DataCell(Text(artistPasangBatu[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkPasangBatu[i])),
          DataCell(_verticalDivider),
          DataCell(Text(sumButir[i])),
          DataCell(_verticalDivider),
          DataCell(Text(sumCarat[i].toStringAsFixed(3))),
          DataCell(_verticalDivider),
          DataCell(Text(sumAsal[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(sumJadi[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(sumSusut[i].toStringAsFixed(2))),
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
            body: dashboardProduksi()));
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
                                          'SUMMARY SUSUT ARTIS PASANG BATU',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        _dataTable(),
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
                                          'PECAH BATU',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        _dataTablePecahHilang(),
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
                                          'HILANG BATU',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        _dataTablePecahHilang()
                                      ],
                                    ))),
                            SizedBox(height: 20),
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
