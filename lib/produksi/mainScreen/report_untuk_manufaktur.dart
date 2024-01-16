// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportUntukManufaktur extends StatefulWidget {
  const ReportUntukManufaktur({super.key});

  @override
  State<ReportUntukManufaktur> createState() => _ReportUntukManufakturState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ReportUntukManufakturState extends State<ReportUntukManufaktur> {
  TextEditingController siklus = TextEditingController();
  String? updateSiklus = '';
  TextEditingController addSiklus = TextEditingController();

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
  TooltipBehavior? _tooltipBehavior;
  List<ChartData>? chartData;
  List<ChartData>? chartDataLevel2;
  List<ChartData>? chartDataLevel2SeeMore;
  List<ChartData>? chartDataLevel3;
  List<ChartData>? chartDataLevel4;
  List<ChartData>? chartDataLevel5;
  //!jalur double tap
  List<ChartData>? chartDataLevel3B;

  List<String> artist = [
    'Asrori',
    'Budi Lesmana',
    'Carkiyad',
    'Dikdik Maulana',
    'Encup Supriatna',
    'Fachri Santosa',
    'Khoerul Anwar',
    'Muhammad Abdul Kodir',
    'Muhammad Deeko',
  ];
  List<String> divisi = [
    'Finishing',
    'Polishing',
    'Stell Rangka',
    'Pasang Batu',
    'Brj',
  ];

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
  int mayBrj = 0;
  int junBrj = 0;
  int julBrj = 0;
  int augBrj = 0;
  int sepBrj = 0;
  int octBrj = 0;
  int novBrj = 0;
  int decBrj = 0;

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
    mayBrj = 0;
    junBrj = 0;
    julBrj = 0;
    augBrj = 0;
    sepBrj = 0;
    octBrj = 0;
    novBrj = 140;
    decBrj = 150;

    chartDataLevel2 = <ChartData>[
      ChartData(xValue: 'Week 1', yValue: 50, secondSeriesYValue: 50),
      ChartData(xValue: 'Week 2', yValue: 80, secondSeriesYValue: 90),
      ChartData(xValue: 'Week 3', yValue: 0, secondSeriesYValue: 70),
      ChartData(xValue: 'Week 4', yValue: 0, secondSeriesYValue: 40),
    ];

    chartDataLevel3 = <ChartData>[
      ChartData(xValue: divisi[0], yValue: 80),
      ChartData(xValue: divisi[1], yValue: 0),
      ChartData(xValue: divisi[2], yValue: 0),
      ChartData(xValue: divisi[3], yValue: 0),
      ChartData(xValue: divisi[4], yValue: 0),
    ];

    chartDataLevel4 = <ChartData>[
      // for (var i = 0; i < artist.length; i++)
      ChartData(xValue: artist[0], yValue: 10),
      ChartData(xValue: artist[1], yValue: 15),
      ChartData(xValue: artist[2], yValue: 5),
      ChartData(xValue: artist[3], yValue: 15),
      ChartData(xValue: artist[4], yValue: 10),
      ChartData(xValue: artist[5], yValue: 20),
      ChartData(xValue: artist[6], yValue: 5),
      ChartData(xValue: artist[7], yValue: 10),
      ChartData(xValue: artist[8], yValue: 20),
    ];

    chartDataLevel5 = <ChartData>[
      ChartData(xValue: 'Bangle', yValue: 1),
      ChartData(xValue: 'Bracelet', yValue: 5),
      ChartData(xValue: 'Brooch', yValue: 2),
      ChartData(xValue: 'Earings', yValue: 2),
      ChartData(xValue: 'Men Ring', yValue: 1),
      ChartData(xValue: 'Necklace', yValue: 10),
      ChartData(xValue: 'Pendant', yValue: 3),
      ChartData(xValue: 'Ring', yValue: 7),
      ChartData(xValue: 'SET', yValue: 2),
      ChartData(xValue: 'Wedding Ring', yValue: 8),
    ];

    chartDataLevel3B = <ChartData>[
      ChartData(xValue: 'Bangle', yValue: 10, secondSeriesYValue: 20),
      ChartData(xValue: 'Bracelet', yValue: 15, secondSeriesYValue: 15),
      ChartData(xValue: 'Brooch', yValue: 24, secondSeriesYValue: 24),
      ChartData(xValue: 'Earings', yValue: 15, secondSeriesYValue: 20),
      ChartData(xValue: 'Men Ring', yValue: 18, secondSeriesYValue: 25),
      ChartData(xValue: 'Necklace', yValue: 10, secondSeriesYValue: 16),
      ChartData(xValue: 'Pendant', yValue: 13, secondSeriesYValue: 13),
      ChartData(xValue: 'Ring', yValue: 17, secondSeriesYValue: 20),
      ChartData(xValue: 'SET', yValue: 21, secondSeriesYValue: 21),
      ChartData(xValue: 'Wedding Ring', yValue: 18, secondSeriesYValue: 20),
    ];

    //! jalur see More
    chartDataLevel2SeeMore = <ChartData>[
      ChartData(xValue: 'Bulan Lalu', yValue: 25, secondSeriesYValue: 50),
      ChartData(xValue: 'Bulan Ini', yValue: 47, secondSeriesYValue: 47),
      ChartData(
          xValue: 'Bulan Yang Akan Datang',
          yValue: 100,
          secondSeriesYValue: 100),
    ];
  }

  void _getAllData(month) async {
    setState(() {
      isLoading = true;
    });
    // await _getName(month);
    await _getSpk(month);
    // await _getPoint(month);
    // await _getBeratAsal(month);

    chartData = <ChartData>[
      ChartData(
          xValue:
              'JANUARI\n${((janBrj / janRelease) * 100).toStringAsFixed(2)}%',
          yValue: janBrj,
          secondSeriesYValue: janRelease),
      ChartData(
          xValue:
              'FEBRUARI\n${((febBrj / febRelease) * 100).toStringAsFixed(2)}%',
          yValue: febBrj,
          secondSeriesYValue: febRelease),
      ChartData(
          xValue: 'MARET\n${((marBrj / marRelease) * 100).toStringAsFixed(2)}%',
          yValue: marBrj,
          secondSeriesYValue: marRelease),
      ChartData(
          xValue: 'APRIL\n${((aprBrj / aprRelease) * 100).toStringAsFixed(2)}%',
          yValue: aprBrj,
          secondSeriesYValue: aprRelease),
      ChartData(
          xValue: 'MEI\n${((mayBrj / meiRelease) * 100).toStringAsFixed(2)}%',
          yValue: mayBrj,
          secondSeriesYValue: meiRelease),
      ChartData(
          xValue: 'JUNI\n${((junBrj / junRelease) * 100).toStringAsFixed(2)}%',
          yValue: junBrj,
          secondSeriesYValue: junRelease),
      ChartData(
          xValue: 'JULI\n${((julBrj / julRelease) * 100).toStringAsFixed(2)}%',
          yValue: julBrj,
          secondSeriesYValue: julRelease),
      ChartData(
          xValue:
              'AGUSTUS\n${((augBrj / aguRelease) * 100).toStringAsFixed(2)}%',
          yValue: augBrj,
          secondSeriesYValue: aguRelease),
      ChartData(
          xValue:
              'SEPTEMBER\n${((sepBrj / sepRelease) * 100).toStringAsFixed(2)}%',
          yValue: sepBrj,
          secondSeriesYValue: sepRelease),
      ChartData(
          xValue:
              'OKTOBER\n${((octBrj / oktRelease) * 100).toStringAsFixed(2)}%',
          yValue: octBrj,
          secondSeriesYValue: oktRelease),
      ChartData(
          xValue:
              'NOVEMBER\n${((novBrj / novRelease) * 100).toStringAsFixed(2)}%',
          yValue: novBrj,
          secondSeriesYValue: novRelease),
      ChartData(
          xValue:
              'DESEMBER\n${((decBrj / desRelease) * 100).toStringAsFixed(2)}%',
          yValue: decBrj,
          secondSeriesYValue: desRelease)
    ];

    setState(() {
      isLoading = false;
    });
  }

  _getSpk(month) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      //! jan
      var filterBySiklusjan = allData.where((element) =>
          element.siklus.toString().toLowerCase() == jan.toLowerCase());
      janRelease = filterBySiklusjan.length;
      //! feb
      var filterBySiklusfeb = allData.where((element) =>
          element.siklus.toString().toLowerCase() == feb.toLowerCase());
      febRelease = filterBySiklusfeb.length;
      //! mar
      var filterBySiklusmar = allData.where((element) =>
          element.siklus.toString().toLowerCase() == mar.toLowerCase());
      marRelease = filterBySiklusmar.length;
      //! apr
      var filterBySiklusapr = allData.where((element) =>
          element.siklus.toString().toLowerCase() == apr.toLowerCase());
      aprRelease = filterBySiklusapr.length;
      //! mei
      var filterBySiklusmei = allData.where((element) =>
          element.siklus.toString().toLowerCase() == mei.toLowerCase());
      meiRelease = filterBySiklusmei.length;
      //! jun
      var filterBySiklusjun = allData.where((element) =>
          element.siklus.toString().toLowerCase() == jun.toLowerCase());
      junRelease = filterBySiklusjun.length;
      //! jul
      var filterBySiklusjul = allData.where((element) =>
          element.siklus.toString().toLowerCase() == jul.toLowerCase());
      julRelease = filterBySiklusjul.length;
      //! agu
      var filterBySiklusagu = allData.where((element) =>
          element.siklus.toString().toLowerCase() == agu.toLowerCase());
      aguRelease = filterBySiklusagu.length;
      //! sep
      var filterBySiklussep = allData.where((element) =>
          element.siklus.toString().toLowerCase() == sep.toLowerCase());
      sepRelease = filterBySiklussep.length;
      //! okt
      var filterBySiklusokt = allData.where((element) =>
          element.siklus.toString().toLowerCase() == okt.toLowerCase());
      oktRelease = filterBySiklusokt.length;
      //! nov
      var filterBySiklusnov = allData.where((element) =>
          element.siklus.toString().toLowerCase() == nov.toLowerCase());
      novRelease = filterBySiklusnov.length;
      //! des
      var filterBySiklusdes = allData.where((element) =>
          element.siklus.toString().toLowerCase() == des.toLowerCase());
      desRelease = filterBySiklusdes.length;
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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              leadingWidth: 320,
              elevation: 0,
            ),
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
                                  'Report Untuk Manufaktur',
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
        Container(
            height: 550,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 5, color: colorCard1),
            ),
            child: indexLevel == 13
                ? chartLevel3B()
                : indexLevel == 203
                    ? chartLevel3()
                    : indexLevel == 102
                        ? chartLevel2SeeMore()
                        : indexLevel == 5
                            ? chartLevel5()
                            : indexLevel == 4
                                ? chartLevel4()
                                : indexLevel == 3
                                    ? chartLevel3()
                                    : indexLevel == 2
                                        ? chartLevel2()
                                        : chartLevel1()),
        SizedBox(height: 10),
        // Container(
        //     padding: const EdgeInsets.all(5),
        //     decoration: BoxDecoration(
        //       border: Border.all(width: 5, color: colorDasar),
        //     ),
        //     child: chartLevel2())
      ],
    );
  }

  chartLevel1() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        color: colorCard1,
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        title: ChartTitle(text: 'SPK RELEASE vs SPK BRJ - 2024'),
        plotAreaBorderWidth: 0,
        legend: Legend(isVisible: true, position: LegendPosition.top),

        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            labelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            axisLine: const AxisLine(width: 0),
            // title: AxisTitle(text: 'Bulan'),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),

        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Total'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: getDataLevel1(),
        tooltipBehavior: _tooltipBehavior,
      )))),
      Positioned(
        right: 2.0,
        top: -40.0,
        child: InkWell(
          onTap: () {
            _onTapLevelGoSeeMore('see more');
          },
          child: SizedBox(
            width: 130,
            height: 130,
            child: Lottie.asset("loadingJSON/seeMore.json", fit: BoxFit.cover),
          ),
        ),
      ),
    ]);
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

  // chartLevel3() {
  //   return Stack(clipBehavior: Clip.none, children: [
  //     Container(
  //         child: Center(
  //             child: Container(
  //                 child: SfCartesianChart(
  //       // axes: <ChartAxis>[
  //       //   NumericAxis(
  //       //       opposedPosition: true,
  //       //       name: 'yAxis1',
  //       //       majorGridLines: const MajorGridLines(width: 0),
  //       //       labelFormat: '{value}°F',
  //       //       minimum: 40,
  //       //       maximum: 100,
  //       //       interval: 10)
  //       // ],
  //       primaryXAxis:
  //           CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
  //       primaryYAxis: NumericAxis(
  //         majorGridLines: const MajorGridLines(width: 0),
  //         opposedPosition: false,
  //         labelFormat: '{value}',
  //       ),
  //       // Chart title
  //       title: ChartTitle(text: 'SPK RELEASE vs SPK BRJ - $titleLevel2'),
  //       // Enable legend
  //       legend: Legend(isVisible: true),
  //       // Enable tooltip
  //       tooltipBehavior: _tooltipBehavior,
  //       series: getDataLevel3(),
  //       //           series: <LineSeries<SalesData, String>>[
  //       // LineSeries<SalesData, String>(
  //       //     dataSource: <SalesData>[
  //       //       SalesData('Week 1', 50),
  //       //       SalesData('Week 2', 38),
  //       //       SalesData('Week 3', 70),
  //       //       SalesData('Week 4', 20),
  //       //     ],
  //       //     xValueMapper: (SalesData sales, _) => sales.year,
  //       //     yValueMapper: (SalesData sales, _) => sales.sales,
  //       //     // Enable data label
  //       //     dataLabelSettings: DataLabelSettings(isVisible: true))
  //       // ]
  //     )))),
  //     Positioned(
  //       left: 2.0,
  //       top: -2.0,
  //       child: InkResponse(
  //         onTap: () {
  //           _onTapLevelBack('');
  //         },
  //         child: Transform.scale(
  //           scale: 1.5,
  //           child:
  //               Lottie.asset("loadingJSON/backbutton.json", fit: BoxFit.cover),
  //         ),
  //       ),
  //     ),
  //   ]);
  // }

  //! jalur See More
  chartLevel2SeeMore() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 0),
            title: AxisTitle(text: 'Bulan'),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Qty'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        // Chart title
        title: ChartTitle(text: 'SPK RELEASE vs SPK BRJ'),
        // Enable legend
        legend: Legend(isVisible: true, position: LegendPosition.top),
        // Enable tooltip
        tooltipBehavior: _tooltipBehavior,
        series: getDataLevel2SeeMore(),
      )))),
      Positioned(
        left: 2.0,
        top: -2.0,
        child: InkResponse(
          onTap: () {
            _onTapLevelBackSeeMore('');
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

  List<ColumnSeries<ChartData, dynamic>> getDataLevel1() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartData!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'RELEASE',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
          // showSimpleNotification(
          //   Text('tap RELEASE oke $i & $isLevel2'),
          //   background: Colors.yellow,
          //   duration: const Duration(seconds: 1),
          // );
        },
        //? custom diagram batang
        // onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
        //   return _CustomColumnSeriesRenderer();
        // },
      ),

      ///? second series named "BRJ".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartData!,
        color: const Color.fromRGBO(2, 109, 213, 1),
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        name: 'BRJ',
        width: 0.8,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
        },
      ),
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
