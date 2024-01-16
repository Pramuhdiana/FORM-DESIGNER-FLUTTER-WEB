// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/model/list_mps_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SiklusSebelumnya extends StatefulWidget {
  const SiklusSebelumnya({super.key});

  @override
  State<SiklusSebelumnya> createState() => _SiklusSebelumnyaState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _SiklusSebelumnyaState extends State<SiklusSebelumnya> {
  TextEditingController siklus = TextEditingController();
  String? updateSiklus = '';
  TextEditingController addSiklus = TextEditingController();

  bool isSelected1 = false;
  TextEditingController controller = TextEditingController();
  bool sort = true;
  List<ListMpsModel>? filterCrm;
  List<ListMpsModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;
  bool isTimelineClick = false;

  var nowSiklus = '';
  String? namaJenisBarangView1 = '';
  TooltipBehavior? _tooltipBehavior;
  List<ChartData>? chartData;
  List<ChartData>? chartDataReportLevel1;
  List<ChartData>? chartDataLevel2;
  List<ChartData>? chartDataLevel2SeeMore;
  List<ChartData>? chartDataLevel3;
  List<ChartData>? chartDataLevel4;
  List<ChartData>? chartDataLevel5;
  //!jalur double tap
  List<ChartData>? chartDataLevel3B;
  List<ListMpsModel>? _listBrand;
  List<ListMpsModel>? _uniqListBrand;

  Map<String, int> summaryValuePencapaian = {};

  String jan = 'januari';
  String feb = 'februari';
  String mar = 'maret';
  String apr = 'april';
  String mei = 'mei';
  String jun = 'juni';
  String jul = 'juli';
  String agu = 'agustus';
  String sep = 'september';
  String okt = 'oktober';
  String nov = 'november';
  String des = 'desember';

  int indexLevel = 1;
  String titleLevel2 = '';
  int janRelease = 0;
  int febRelease = 0;
  int marRelease = 0;
  int aprRelease = 0;
  int meiRelease = 0;
  int junRelease = 0;
  int julRelease = 0;
  int aguRelease = 0;
  int sepRelease = 0;
  int oktRelease = 0;
  int novRelease = 0;
  int desRelease = 0;
  int janBrj = 0;
  int febBrj = 0;
  int marBrj = 0;
  int aprBrj = 0;
  int meiBrj = 0;
  int junBrj = 0;
  int julBrj = 0;
  int aguBrj = 0;
  int sepBrj = 0;
  int oktBrj = 0;
  int novBrj = 0;
  int desBrj = 0;
  String? pilihBulan;
  bool? isLoadingTimeline;
  List<String> listBulan = [];
  List<String> _listJenisBarang = [];
  List<int> _listXS = [];
  List<int> _listS = [];
  List<int> _listM = [];
  List<int> _listL = [];
  List<int> _listXL = [];
  List<ListMpsModel>? _listBarang;

  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        format: 'Total: point.y',
        canShowMarker: true,
        header: '');
    // var now = DateTime.now();
    nowSiklus = sharedPreferences!.getString('siklus')!;
    _getAllData("all");

    // janRelease = 150;
    // febRelease = 160;
    // marRelease = 170;
    // aprRelease = 250;
    // mayRelease = 130;
    // junRelease = 190;
    // julRelease = 200;
    // augRelease = 160;
    // sepRelease = 215;
    // octRelease = 189;
    // novRelease = 185;
    // decRelease = 250;
    janBrj = 0;
    febBrj = 0;
    marBrj = 0;
    aprBrj = 0;
    meiBrj = 0;
    junBrj = 0;
    julBrj = 0;
    aguBrj = 0;
    sepBrj = 0;
    oktBrj = 0;
    novBrj = 140;
    desBrj = 150;
  }

  void _getAllDataLevel2(month) async {
    setState(() {
      isLoadingTimeline = true;
    });
    await getTableLevel2(month);
    setState(() {
      isLoadingTimeline = false;
    });
  }

  void handleClickTimeline(month) async {
    month == ''
        ? setState(() {
            isTimelineClick = !isTimelineClick;
            pilihBulan = null;
          })
        : setState(() {
            isTimelineClick = !isTimelineClick;
            pilihBulan = month;
            _getAllDataLevel2(pilihBulan);
          });
  }

  getTableLevel2(month) async {
    _listBarang = [];
    _listJenisBarang = [];
    _listXS = [];
    _listS = [];
    _listM = [];
    _listL = [];
    _listXL = [];
    print('get data bulan on');
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListMps));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ListMpsModel.fromJson(data)).toList();
      var filterByMonth = allData
          .where((element) =>
              element.bulan.toString().toLowerCase() ==
              month.toString().toLowerCase())
          .toList();

      for (var i = 0; i < filterByMonth.length; i++) {
        _listJenisBarang.add(filterByMonth[i].jenisBarang!.toUpperCase());
      }
      _listJenisBarang = _listJenisBarang.toSet().toList();

      _listBarang = filterByMonth;

      for (var i = 0; i < _listJenisBarang.length; i++) {
        //? ada 8
        var _listXSDummy = [];
        var _listSDummy = [];
        var _listMDummy = [];
        var _listLDummy = [];
        var _listXLDummy = [];

        var filterByJenisBarang = filterByMonth
            .where((element) =>
                element.jenisBarang.toString().toLowerCase() ==
                _listJenisBarang[i].toString().toLowerCase())
            .toList();

        for (var j = 0; j < filterByJenisBarang.length; j++) {
          (filterByJenisBarang[j].brand.toString().toLowerCase() == "parva" ||
                  filterByJenisBarang[j].brand.toString().toLowerCase() ==
                      "fine")
              ? ((filterByJenisBarang[j].estimasiHarga! * 0.37) * 11500) <=
                      5000000
                  ? _listXSDummy.add(
                      filterByJenisBarang[j].estimasiHarga!.toStringAsFixed(2))
                  : ((filterByJenisBarang[j].estimasiHarga! * 0.37) * 11500) <=
                          10000000
                      ? _listSDummy.add(filterByJenisBarang[j]
                          .estimasiHarga!
                          .toStringAsFixed(2))
                      : ((filterByJenisBarang[j].estimasiHarga! * 0.37) * 11500) <=
                              20000000
                          ? _listMDummy.add(filterByJenisBarang[j]
                              .estimasiHarga!
                              .toStringAsFixed(2))
                          : ((filterByJenisBarang[j].estimasiHarga! * 0.37) * 11500) <=
                                  35000000
                              ? _listLDummy.add(filterByJenisBarang[j]
                                  .estimasiHarga!
                                  .toStringAsFixed(2))
                              : _listXLDummy.add(filterByJenisBarang[j]
                                  .estimasiHarga!
                                  .toStringAsFixed(2))
              : (filterByJenisBarang[j].estimasiHarga!) <= 5000000
                  ? _listXSDummy.add(
                      filterByJenisBarang[j].estimasiHarga!.toStringAsFixed(2))
                  : (filterByJenisBarang[j].estimasiHarga!) <= 10000000
                      ? _listSDummy.add(
                          filterByJenisBarang[j].estimasiHarga!.toStringAsFixed(2))
                      : (filterByJenisBarang[j].estimasiHarga!) <= 20000000
                          ? _listMDummy.add(filterByJenisBarang[j].estimasiHarga!.toStringAsFixed(2))
                          : (filterByJenisBarang[j].estimasiHarga!) <= 35000000
                              ? _listLDummy.add(filterByJenisBarang[j].estimasiHarga!.toStringAsFixed(2))
                              : _listXLDummy.add(filterByJenisBarang[j].estimasiHarga!.toStringAsFixed(2));
        }
        _listXS.add(_listXSDummy.length);
        _listS.add(_listSDummy.length);
        _listM.add(_listMDummy.length);
        _listL.add(_listLDummy.length);
        _listXL.add(_listXLDummy.length);
      }
    } else {}
  }

  dataTableBarang() {
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
        columns: columnsDataBarang(),
        border: TableBorder.all(),
        rows: rowsDataBarang(_listBarang, _listBarang!.length));
  }

  List<DataRow> rowsDataBarang(var data, int count) {
    return [
      for (var i = 0; i < _listJenisBarang.length; i++)
        DataRow(cells: [
          DataCell(Container(
              width: 150,
              padding: const EdgeInsets.all(5),
              // child: Center(child: Text(data[i].posisi.toString())))),
              child: Center(child: Text(_listJenisBarang[i])))),
          DataCell(Container(
              width: 100,
              padding: const EdgeInsets.all(5),
              // child: Center(child: Text(data[i].posisi.toString())))),
              child: Center(child: Text(_listXS[i].toString())))),
          DataCell(Container(
              width: 100,
              padding: const EdgeInsets.all(5),
              // child: Center(child: Text(data[i].posisi.toString())))),
              child: Center(child: Text(_listS[i].toString())))),
          DataCell(Container(
              width: 100,
              padding: const EdgeInsets.all(5),
              // child: Center(child: Text(data[i].posisi.toString())))),
              child: Center(child: Text(_listM[i].toString())))),
          DataCell(Container(
              width: 100,
              padding: const EdgeInsets.all(5),
              // child: Center(child: Text(data[i].posisi.toString())))),
              child: Center(child: Text(_listL[i].toString())))),
          DataCell(Container(
              width: 100,
              padding: const EdgeInsets.all(5),
              // child: Center(child: Text(data[i].posisi.toString())))),
              child: Center(child: Text(_listXL[i].toString())))),
        ])
    ];
  }

  List<DataColumn> columnsDataBarang() {
    return [
      DataColumn(
          label: Expanded(
        child: Container(
            padding: const EdgeInsets.all(5),
            child: const Center(child: Text('JENIS BARANG'))),
      )),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Row(
                children: [
                  Container(
                    width: 40,
                  ),
                  Text('XS'),
                ],
              )))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Row(
                children: [
                  Container(
                    width: 40,
                  ),
                  Text('S'),
                ],
              )))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Row(
                children: [
                  Container(
                    width: 40,
                  ),
                  Text('M'),
                ],
              )))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Row(
                children: [
                  Container(
                    width: 40,
                  ),
                  Text('L'),
                ],
              )))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Row(
                children: [
                  Container(
                    width: 40,
                  ),
                  Text('XL'),
                ],
              )))),
    ];
  }

  void _getAllData(month) async {
    setState(() {
      isLoading = true;
    });
    await _getData(month);
    novBrj =147;
    novRelease = 160;
    desBrj = 186;
    desRelease = 245;
    chartDataReportLevel1 = <ChartData>[
      ChartData(
          xValue: 'JANUARI',
          yValue: janRelease,
          secondSeriesYValue: double.tryParse(
              ((janBrj / (janRelease == 0 ? 1 : janRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: janBrj),
      ChartData(
          xValue: 'FEBRUARI',
          yValue: febRelease,
          secondSeriesYValue: double.tryParse(
              ((febBrj / (febRelease == 0 ? 1 : febRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: febBrj),
      ChartData(
          xValue: 'MARET',
          yValue: marRelease,
          secondSeriesYValue: double.tryParse(
              ((marBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: marBrj),
      ChartData(
          xValue: 'APRIL',
          yValue: aprRelease,
          secondSeriesYValue: double.tryParse(
              ((aprBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: aprBrj),
      ChartData(
          xValue: 'MEI',
          yValue: meiRelease,
          secondSeriesYValue: double.tryParse(
              ((meiBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: meiBrj),
      ChartData(
          xValue: 'JUNI',
          yValue: junRelease,
          secondSeriesYValue: double.tryParse(
              ((junBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: junBrj),
      ChartData(
          xValue: 'JULI',
          yValue: julRelease,
          secondSeriesYValue: double.tryParse(
              ((julBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: julBrj),
      ChartData(
          xValue: 'AGUSTUS',
          yValue: aguRelease,
          secondSeriesYValue: double.tryParse(
              ((aguBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: aguBrj),
      ChartData(
          xValue: 'SEPTEMBER',
          yValue: sepRelease,
          secondSeriesYValue: double.tryParse(
              ((sepBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: sepBrj),
      ChartData(
          xValue: 'OKTOBER',
          yValue: oktRelease,
          secondSeriesYValue: double.tryParse(
              ((oktBrj / (marRelease == 0 ? 1 : marRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: oktBrj),
      ChartData(
          xValue: 'NOVEMBER',
          yValue: novRelease,
          secondSeriesYValue: double.tryParse(
              ((novBrj / (novRelease == 0 ? 1 : novRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: novBrj),
      ChartData(
          xValue: 'DESEMBER',
          yValue: desRelease,
          secondSeriesYValue: double.tryParse(
              ((desBrj / (desRelease == 0 ? 1 : desRelease)) * 100)
                  .toStringAsFixed(2)),
          thirdSeriesYValue: desBrj),
    ];

    setState(() {
      isLoading = false;
    });
  }

  _getDataByMonth(month) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListMps));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => ListMpsModel.fromJson(data)).toList();
      var filterBySiklus = allData.where((element) =>
          element.bulan.toString().toLowerCase() == month.toLowerCase());
      return filterBySiklus.toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  void _getAllDataValuePencapaian(month) async {
    // setState(() {
    //   isLoadingPolishing = true;
    // });
    await getDataTableValuePencapaian(month);
    setState(() {});
  }

  getDataTableValuePencapaian(month) async {
    print('get data value on');
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListMps));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ListMpsModel.fromJson(data)).toList();
      var filterBySiklus = allData
          .where((element) =>
              element.bulan.toString().toLowerCase() ==
              month.toString().toLowerCase())
          .toList();

      _listBrand = filterBySiklus;

      _uniqListBrand = removeDuplicates(_listBrand!);
      //  var filterByBrand = filterBySiklus
      //     .where((element) =>
      //         element.brand.toString().toLowerCase() ==
      //         _uniqListBrand![0].toString().toLowerCase())
      //     .toList();

      for (var item in filterBySiklus) {
        var category = item.brand;
        var value = item.estimasiHarga;

        summaryValuePencapaian[category!] =
            (summaryValuePencapaian[category] ?? 0) + value!;
      }

      print(summaryValuePencapaian);
      print(summaryValuePencapaian.values);
      print(summaryValuePencapaian.keys);
    } else {}
  }

  // fungsi remove duplicate object
  List<ListMpsModel> removeDuplicates(List<ListMpsModel> items) {
    List<ListMpsModel> uniqueItems = []; // uniqueList
    var uniqueNames = items
        .map((e) => e.brand)
        .toSet(); //list if UniqueID to remove duplicates
    for (var e in uniqueNames) {
      uniqueItems.add(items.firstWhere((i) => i.brand == e));
    } // populate uniqueItems with equivalent original Batch items
    return uniqueItems; //send back the unique items list
  }

  _getData(month) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListMps));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => ListMpsModel.fromJson(data)).toList();
      var filterByMonth = allData
          .where((element) => element.bulan.toString().toLowerCase() != '')
          .toList();

      for (var i = 0; i < filterByMonth.length; i++) {
        listBulan.add(filterByMonth[i].siklus!.toUpperCase());
      }
      listBulan = listBulan.toSet().toList();
      print(listBulan);

      //! jan
      var filterBySiklusjan = allData.where((element) =>
          element.bulan.toString().toLowerCase() == jan.toLowerCase());
      janRelease = filterBySiklusjan.length;
      var filterBySiklusjanBrj = filterBySiklusjan
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      janBrj = filterBySiklusjanBrj.length;
      //! feb
      var filterBySiklusfeb = allData.where((element) =>
          element.bulan.toString().toLowerCase() == feb.toLowerCase());
      febRelease = filterBySiklusfeb.length;
      var filterBySiklusfebBrj = filterBySiklusfeb
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      febBrj = filterBySiklusfebBrj.length;
      //! mar
      var filterBySiklusmar = allData.where((element) =>
          element.bulan.toString().toLowerCase() == mar.toLowerCase());
      marRelease = filterBySiklusmar.length;
      var filterBySiklusmarBrj = filterBySiklusmar
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      marBrj = filterBySiklusmarBrj.length;
      //! apr
      var filterBySiklusapr = allData.where((element) =>
          element.bulan.toString().toLowerCase() == apr.toLowerCase());
      aprRelease = filterBySiklusapr.length;
      var filterBySiklusaprBrj = filterBySiklusapr
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      aprBrj = filterBySiklusaprBrj.length;
      //! mei
      var filterBySiklusmei = allData.where((element) =>
          element.bulan.toString().toLowerCase() == mei.toLowerCase());
      meiRelease = filterBySiklusmei.length;
      var filterBySiklusmeiBrj = filterBySiklusmei
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      meiBrj = filterBySiklusmeiBrj.length;
      //! jun
      var filterBySiklusjun = allData.where((element) =>
          element.bulan.toString().toLowerCase() == jun.toLowerCase());
      junRelease = filterBySiklusjun.length;
      var filterBySiklusjunBrj = filterBySiklusjun
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      junBrj = filterBySiklusjunBrj.length;
      //! jul
      var filterBySiklusjul = allData.where((element) =>
          element.bulan.toString().toLowerCase() == jul.toLowerCase());
      julRelease = filterBySiklusjul.length;
      var filterBySiklusjulBrj = filterBySiklusjul
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      julBrj = filterBySiklusjulBrj.length;
      //! agu
      var filterBySiklusagu = allData.where((element) =>
          element.bulan.toString().toLowerCase() == agu.toLowerCase());
      aguRelease = filterBySiklusagu.length;
      var filterBySiklusaguBrj = filterBySiklusagu
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      aguBrj = filterBySiklusaguBrj.length;
      //! sep
      var filterBySiklussep = allData.where((element) =>
          element.bulan.toString().toLowerCase() == sep.toLowerCase());
      sepRelease = filterBySiklussep.length;
      var filterBySiklussepBrj = filterBySiklussep
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      sepBrj = filterBySiklussepBrj.length;
      //! okt
      var filterBySiklusokt = allData.where((element) =>
          element.bulan.toString().toLowerCase() == okt.toLowerCase());
      oktRelease = filterBySiklusokt.length;
      var filterBySiklusoktBrj = filterBySiklusokt
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      oktBrj = filterBySiklusoktBrj.length;
      //! nov
      var filterBySiklusnov = allData.where((element) =>
          element.bulan.toString().toLowerCase() == nov.toLowerCase());
      novRelease = filterBySiklusnov.length;
      var filterBySiklusnovBrj = filterBySiklusnov
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      novBrj = filterBySiklusnovBrj.length;
      //! des
      var filterBySiklusdes = allData.where((element) =>
          element.bulan.toString().toLowerCase() == des.toLowerCase());
      desRelease = filterBySiklusdes.length;
      var filterBySiklusdesBrj = filterBySiklusdes
          .where((element) => element.posisi.toString().toLowerCase() == 'brj');
      desBrj = filterBySiklusdesBrj.length;
    } else {}
  }

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
            backgroundColor: colorBG,
            // drawer: Drawer1(),

            body: isLoading == true
                ? Center(
                    child: Transform.scale(
                    scale: 2,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 1,
                      child: Lottie.asset("loadingJSON/dashboardBuild.json"),
                    ),
                  ))
                : Container(
                    width: MediaQuery.of(context).size.width * 1,
                    color: colorBG,
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 26),
                                child: const Text(
                                  'Report Untuk SCM Siklus Sebelumnya',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26),
                                ),
                              ),
                              dashboardProduksi(),
                            ])))));
  }

  //! dashboard produksi
  dashboardProduksi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        isTimelineClick == true
            ? Container(
                height: 550,
                color: colorCard1,
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            handleClickTimeline('');
                          },
                          child: SizedBox(
                            width: 50,
                            child: Lottie.asset("loadingJSON/backbutton.json",
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 80, top: 25),
                            child: Text(
                              'Tabel Kelas Harga',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: pilihBulan != null
                                    ? ui.Color.fromARGB(255, 42, 255, 23)
                                    : const Color.fromRGBO(238, 240, 235,
                                        1), //background color of dropdown button
                                border: Border.all(
                                  color: Colors.black38,
                                  // width:
                                  //     3
                                ), //border of dropdown button
                                borderRadius: BorderRadius.circular(
                                    35), //border raiuds of dropdown button
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DropdownButton(
                                    value: pilihBulan,
                                    items: [
                                      for (var item in listBulan)
                                        DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        ),
                                    ],
                                    hint: const Text('Pilih Bulan'),
                                    onChanged: (value) {
                                      print(value);
                                      pilihBulan = value;
                                      _getAllDataLevel2(pilihBulan);
                                    },
                                    icon: const Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(
                                            Icons.arrow_circle_down_sharp)),
                                    iconEnabledColor: Colors.black, //Icon color
                                    style: const TextStyle(
                                      color: Colors.black, //Font color
                                      // fontSize:
                                      //     15 //font size on dropdown button
                                    ),

                                    dropdownColor: Colors
                                        .white, //dropdown background color
                                    underline: Container(), //remove underline
                                    isExpanded:
                                        true, //make true to make width 100%
                                  ))),
                        ),
                      ],
                    ),
                    isLoadingTimeline == true
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            width: 90,
                            height: 90,
                            child: Lottie.asset("loadingJSON/loadingV1.json"),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(child: dataTableBarang())),
                  ],
                ))
            : Container(
                height: 550,
                color: colorCard1,
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Timeline Pencapaian Produksi',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    chartReportLevel1()
                  ],
                )),
        SizedBox(height: 10),
      ],
    );
  }

  chartReportLevel1() {
    return Expanded(
        child: SfCartesianChart(
      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: const MajorGridLines(width: 0),
            labelFormat: '{value}%',
            maximum: 100.00,
            labelStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            interval: 5.00)
      ],

      //! X axis as CategoryAxis axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          // maximumLabelWidth: 50,
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelIntersectAction: AxisLabelIntersectAction.wrap),

      //? Y axis as numeric axis placed here. ATAS
      primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          opposedPosition: false,
          interval: 20,
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          labelFormat: '{value}'),

      series: getDataReportLevel1(),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: true),
    ));
  }

  chartLevel2() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        title: ChartTitle(text: 'PLANNING vs ACTUAL - $titleLevel2'),
        plotAreaBorderWidth: 0,
        legend: Legend(isVisible: true, position: LegendPosition.top),

        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            axisLine: const AxisLine(width: 0),
            // title: AxisTitle(text: 'Minggu'),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),

        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Total'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: getDataLevel2(),
        tooltipBehavior: _tooltipBehavior,
      )))),
      Positioned(
        left: 2.0,
        top: -2.0,
        child: InkResponse(
          onTap: () {
            _onTapLevelBack('');
          },
          child: Transform.scale(
            scale: 1.5,
            child:
                Lottie.asset("loadingJSON/backbutton.json", fit: BoxFit.cover),
          ),
        ),
      ),
    ]);
  }

  chartLevel3() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        title: ChartTitle(text: 'DIVISI - $titleLevel2'),
        plotAreaBorderWidth: 0,
        legend: Legend(isVisible: true, position: LegendPosition.top),

        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),

        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Total'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: getDataLevel3(),
        tooltipBehavior: _tooltipBehavior,
      )))),
      Positioned(
        left: 2.0,
        top: -2.0,
        child: InkResponse(
          onTap: () {
            _onTapLevelBack('');
          },
          child: Transform.scale(
            scale: 1.5,
            child:
                Lottie.asset("loadingJSON/backbutton.json", fit: BoxFit.cover),
          ),
        ),
      ),
    ]);
  }

  chartLevel4() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        title: ChartTitle(text: 'Artist - $titleLevel2'),
        plotAreaBorderWidth: 0,
        legend: Legend(isVisible: true, position: LegendPosition.top),

        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),

        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Total'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: getDataLevel4(),
        tooltipBehavior: _tooltipBehavior,
      )))),
      Positioned(
        left: 2.0,
        top: -2.0,
        child: InkResponse(
          onTap: () {
            _onTapLevelBack('');
          },
          child: Transform.scale(
            scale: 1.5,
            child:
                Lottie.asset("loadingJSON/backbutton.json", fit: BoxFit.cover),
          ),
        ),
      ),
    ]);
  }

  chartLevel5() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        title: ChartTitle(text: 'Jenis Barang - $titleLevel2'),
        plotAreaBorderWidth: 0,
        legend: Legend(isVisible: true, position: LegendPosition.top),

        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),

        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Total'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: getDataLevel5(),
        tooltipBehavior: _tooltipBehavior,
      )))),
      Positioned(
        left: 2.0,
        top: -2.0,
        child: InkResponse(
          onTap: () {
            _onTapLevelBack('');
          },
          child: Transform.scale(
            scale: 1.5,
            child:
                Lottie.asset("loadingJSON/backbutton.json", fit: BoxFit.cover),
          ),
        ),
      ),
    ]);
  }

  //! jalur double klik
  chartLevel3B() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        title: ChartTitle(text: 'Jenis Barang - $titleLevel2'),
        plotAreaBorderWidth: 0,
        legend: Legend(isVisible: true, position: LegendPosition.top),

        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),

        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Total'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: getDataLevel3B(),
        tooltipBehavior: _tooltipBehavior,
      )))),
      Positioned(
        left: 2.0,
        top: -2.0,
        child: InkResponse(
          onTap: () {
            _onDoubleTapLevelBack('');
          },
          child: Transform.scale(
            scale: 1.5,
            child:
                Lottie.asset("loadingJSON/backbutton.json", fit: BoxFit.cover),
          ),
        ),
      ),
    ]);
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

  void _onTapLevelGo(siklus) {
    titleLevel2 = siklus.toString();
    setState(() {
      indexLevel += 1;
    });
  }

  void _onDoubleTapLevelGo(siklus) {
    titleLevel2 = siklus.toString();
    setState(() {
      indexLevel += 11;
    });
  }

  void _onDoubleTapLevelBack(siklus) {
    titleLevel2 = siklus.toString();
    setState(() {
      indexLevel -= 11;
    });
  }

  void _onTapLevelGoSeeMore(siklus) {
    titleLevel2 = siklus.toString();
    setState(() {
      indexLevel += 101;
    });
  }

  void _onTapLevelBackSeeMore(siklus) {
    titleLevel2 = siklus.toString();
    setState(() {
      indexLevel -= 101;
    });
  }

  void _onTapLevelBack(siklus) {
    titleLevel2 = siklus.toString();
    setState(() {
      indexLevel -= 1;
    });
  }

  List<ChartSeries<ChartData, dynamic>> getDataReportLevel1() {
    return <ChartSeries<ChartData, dynamic>>[
      //!
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataReportLevel1!, //? <<<- isi data atau valuenya
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'RELEASE',
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,

        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          // showSimpleNotification(
          //   Text(
          //     'on tap batang $i',
          //   ),
          //   background: Colors.green,
          //   duration: const Duration(seconds: 1),
          // );
          handleClickTimeline(i);
          // _onTapLevelGo(i);
        },
      ),

      ///? second series
      LineSeries<ChartData, dynamic>(
        name: '',
        animationDuration: 3500,
        onCreateShader: (ShaderDetails details) {
          return ui.Gradient.linear(
              details.rect.topCenter, details.rect.bottomCenter, <Color>[
            const Color.fromRGBO(4, 8, 195, 1),
            const Color.fromRGBO(4, 8, 195, 1),
            const Color.fromRGBO(26, 112, 23, 1),
            const Color.fromRGBO(26, 112, 23, 1),
            const Color.fromRGBO(229, 11, 10, 1),
            const Color.fromRGBO(229, 11, 10, 1),
          ], <double>[
            0,
            0.333333,
            0.333333,
            0.666666,
            0.666666,
            0.999999,
          ]);
        },
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .top), //? ini untuk label di dalam diagram
        dataSource: chartDataReportLevel1!, //? <<<- isi data atau valuenya
        color: Color.fromARGB(255, 34, 0, 255),
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        yAxisName: 'yAxis1',
        markerSettings: const MarkerSettings(isVisible: true),
        width: 3,
        onPointTap: (event) async {
          var i = event.dataPoints![event.pointIndex!].x;
          await getDataTableValuePencapaian(i);
          // showSimpleNotification(
          //   Text(
          //     'on tap garis $i',
          //   ),
          //   background: Colors.green,
          //   duration: const Duration(seconds: 1),
          // );
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
                            content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: Text(
                                      'Value Pencapaian Produksi',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: dataTableValuePencapaian(),

                                    //  FutureBuilder(
                                    //     future: _getDataByMonth(i),
                                    //     builder: (context, snapshot) {
                                    //       if (snapshot.connectionState ==
                                    //           ConnectionState.waiting) {
                                    //         return Center(
                                    //             child: Container(
                                    //                 padding:
                                    //                     const EdgeInsets.all(0),
                                    //                 width: 90,
                                    //                 height: 90,
                                    //                 child: Lottie.asset(
                                    //                     "loadingJSON/loadingV1.json")));
                                    //       } else if (snapshot.hasData) {
                                    //         return Container(
                                    //           child: dataTableValuePencapaian(),
                                    //         );
                                    //       } else {
                                    //         return Text(
                                    //             snapshot.error.toString());
                                    //       }
                                    //     }),
                                  )
                                ],
                              )
                            ]))));
              });
          // _onTapLevelGo(i);
        },
      ),

      //* data ke 3
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataReportLevel1!, //? <<<- isi data atau valuenya
        color: const Color.fromRGBO(2, 109, 213, 1),
        name: 'BRJ',
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.thirdSeriesYValue,

        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          showSimpleNotification(
            Text(
              'on tap batang 2 $i',
            ),
            background: Colors.green,
            duration: const Duration(seconds: 1),
          );
          // _onTapLevelGo(i);
        },
      ),
    ];
  }

  dataTableValuePencapaian() {
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
        columns: columnsDataValuePencapaian(),
        border: TableBorder.all(),
        rows: rowsDataValuePencapaian(_uniqListBrand, _uniqListBrand!.length));
  }

  List<DataColumn> columnsDataValuePencapaian() {
    return [
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('Brand')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: const Center(child: Text('Value')))),
    ];
  }

  List<DataRow> rowsDataValuePencapaian(var data, int count) {
    return [
      for (var i = 0; i < count; i++)
        DataRow(cells: [
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Text(summaryValuePencapaian.keys.elementAt(i))))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Text(summaryValuePencapaian.keys
                              .elementAt(i)
                              .toString()
                              .toLowerCase() ==
                          "parva" ||
                      summaryValuePencapaian.keys
                              .elementAt(i)
                              .toString()
                              .toLowerCase() ==
                          "fine"
                  ? CurrencyFormat.convertToIdr(
                      ((summaryValuePencapaian.values.elementAt(i) * 0.37) *
                          11500),
                      0)
                  : CurrencyFormat.convertToIdr(
                      summaryValuePencapaian.values.elementAt(i), 0)))),
          // DataCell(Container(
          //     padding: const EdgeInsets.all(0),
          //     child: Center(
          //         child: (data[i].brand.toString().toLowerCase() == "parva" ||
          //                 data[i].brand.toString().toLowerCase() == "fine")
          //             ? Text(
          //                 "${((data[i].estimasiHarga * 0.37) * 11500)}",
          //                 maxLines: 2,
          //                 style: TextStyle(color: Colors.black),
          //               )
          //             : Text(
          //                 "${(data[i].estimasiHarga)}",
          //                 maxLines: 2,
          //                 style: TextStyle(color: Colors.black),
          //               )))),
        ]),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataLevel2() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "PLANNING".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel2!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'PLANNING',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
        },
        onPointDoubleTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onDoubleTapLevelGo(i);
        },
      ),

      ///? second series named "ACTUAL".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel2!,
        color: const Color.fromRGBO(2, 109, 213, 1),
        name: 'ACTUAL',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
        },
        onPointDoubleTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onDoubleTapLevelGo(i);
        },
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataLevel3() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel3!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: '',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
        },
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataLevel5() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel5!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: '',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          // var i = event.dataPoints![event.pointIndex!].x;
          // _onTapLevelGo(i);
        },
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataLevel4() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "ARTIST".
      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel4!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: '',
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
        },
      ),
    ];
  }

  // List<ChartSeries<ChartData, String>> getDataLevel3() {
  //   return <ChartSeries<ChartData, String>>[
  //     //! first series named "RELEASE".
  //     LineSeries<ChartData, String>(
  //       dataSource: chartDataLevel3!,
  //       yAxisName: 'yAxis1',
  //       color: const Color.fromRGBO(237, 221, 76, 1),
  //       name: 'RELEASE',
  //       xValueMapper: (ChartData sales, _) => sales.x as String,
  //       yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
  //       // onPointTap: (event) {
  //       //   var i = event.dataPoints![event.pointIndex!].x;
  //       //   _onTapLevelGo(i);
  //       // },
  //     ),

  //     ///? second series named "BRJ".

  //     ColumnSeries<ChartData, String>(
  //       // dataLabelSettings: const DataLabelSettings(
  //       //     isVisible: true,
  //       //     labelAlignment: ChartDataLabelAlignment
  //       //         .middle), //? ini untuk label di dalam diagram
  //       dataSource: chartDataLevel3!,
  //       color: const Color.fromRGBO(2, 109, 213, 1),
  //       name: 'BRJ',
  //       xValueMapper: (ChartData sales, _) => sales.x as String,
  //       yValueMapper: (ChartData sales, _) => sales.y,

  //       // onPointTap: (event) {
  //       //   var i = event.dataPoints![event.pointIndex!].x;
  //       //   _onTapLevelGo(i);
  //       // },
  //       // //? custom diagram batang
  //       // onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
  //       //   return _CustomColumnSeriesRenderer();
  //       // },
  //     ),
  //   ];
  // }

  //! jalur double klik
  List<ColumnSeries<ChartData, dynamic>> getDataLevel3B() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel3B!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: '',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          // var i = event.dataPoints![event.pointIndex!].x;
          // _onTapLevelGo(i);
        },
      ),
      //! first series named "RELEASE".
      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel3B!,
        color: const Color.fromRGBO(2, 109, 213, 1),
        name: '',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          // var i = event.dataPoints![event.pointIndex!].x;
          // _onTapLevelGo(i);
        },
      ),
    ];
  }

  //! jalur See more
  List<ColumnSeries<ChartData, dynamic>> getDataLevel2SeeMore() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel2SeeMore!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'RELEASE',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGoSeeMore(i);
        },
      ),

      ///? second series named "BRJ".

      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel2SeeMore!,
        color: const Color.fromRGBO(2, 109, 213, 1),
        name: 'BRJ',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
        },
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

/// Chart Sales Data
class BrjData {
  /// Holds the datapoint values like x, y, etc.,
  BrjData(this.x, this.y, [this.date, this.color]);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}

///Chart sample data
class ChartData {
  /// Holds the datapoint values like x, y, etc.,
  ChartData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

//! function untuk customm diagram batang
class _CustomColumnSeriesRenderer extends ColumnSeriesRenderer {
  _CustomColumnSeriesRenderer();

  @override
  ChartSegment createSegment() {
    return _ColumnCustomPainter();
  }
}

class _ColumnCustomPainter extends ColumnSegment {
  @override
  int get currentSegmentIndex => super.currentSegmentIndex!;

  @override
  void onPaint(Canvas canvas) {
    double x, y;
    x = segmentRect.center.dx;
    y = segmentRect.top;
    double width = 0;
    const double height = 20;
    width = segmentRect.width;
    final Paint paint = Paint();
    paint.color = getFillPaint().color;
    paint.style = PaintingStyle.fill;
    final Path path = Path();
    final double factor = segmentRect.height * (1 - animationFactor);
    path.moveTo(x - width / 2, y + factor + height);
    path.lineTo(x, (segmentRect.top + factor + height) - height);
    path.lineTo(x + width / 2, y + factor + height);
    path.lineTo(x + width / 2, segmentRect.bottom + factor);
    path.lineTo(x - width / 2, segmentRect.bottom + factor);
    path.close();
    canvas.drawPath(path, paint);
  }
}
