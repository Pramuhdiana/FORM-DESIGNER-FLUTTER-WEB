// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, avoid_unnecessary_containers

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardControl extends StatefulWidget {
  const DashboardControl({super.key});

  @override
  State<DashboardControl> createState() => _DashboardControlState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _DashboardControlState extends State<DashboardControl> {
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
  TooltipBehavior? _tooltipBehaviorPrintingResin;
  TooltipBehavior? _tooltipBehaviorCasting;
  TooltipBehavior? _tooltipBehaviorFinishing;
  TooltipBehavior? _tooltipBehaviorStell;
  TooltipBehavior? _tooltipBehaviorPolishing;
  TooltipBehavior? _tooltipBehaviorPasangBatu;
  List<ChartData>? chartDataPrintResin;
  List<ChartData>? chartDataCasting;
  List<ChartData>? chartDataFinishing;
  List<ChartData>? chartDataPolishing;
  List<ChartData>? chartDataStell;
  List<ChartData>? chartDataPasangBatu;

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
    _tooltipBehaviorFinishing = TooltipBehavior(
        enable: true, format: 'Total: point.y', canShowMarker: true);
    _tooltipBehaviorPrintingResin = TooltipBehavior(
        enable: true, format: 'Total: point.y', canShowMarker: true);
    _tooltipBehaviorCasting = TooltipBehavior(
        enable: true, format: 'Total: point.y', canShowMarker: true);
    _tooltipBehaviorPolishing = TooltipBehavior(
        enable: true, format: 'Total: point.y', canShowMarker: true);
    _tooltipBehaviorStell = TooltipBehavior(
        enable: true, format: 'Total: point.y', canShowMarker: true);
    _tooltipBehaviorPasangBatu = TooltipBehavior(
        enable: true, format: 'Total: point.y', canShowMarker: true);

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
    chartDataPrintResin = <ChartData>[
      ChartData(xValue: 'Asrori', secondSeriesYValue: 2),
      ChartData(xValue: 'Budi', secondSeriesYValue: 9),
      ChartData(xValue: 'Khoer', secondSeriesYValue: 7),
      ChartData(xValue: 'Abdul', secondSeriesYValue: 4),
    ];
    chartDataCasting = <ChartData>[
      ChartData(xValue: 'Fachri', secondSeriesYValue: 12),
      ChartData(xValue: 'Budi', secondSeriesYValue: 5),
    ];
  }

  Color? _getPointColor(num? value) {
    Color? color;
    if (value! < 2.5) {
      color = const Color.fromRGBO(252, 238, 160, 1);
    } else if (value > 2.5 && value < 3.5) {
      color = const Color.fromRGBO(250, 230, 120, 1);
    } else if (value >= 3.5 && value < 4.5) {
      color = const Color.fromRGBO(247, 203, 90, 1);
    } else if (value > 4.5 && value < 5.5) {
      color = const Color.fromRGBO(237, 162, 0, 1);
    } else if (value > 5.5 && value < 6.5) {
      color = const Color.fromRGBO(221, 146, 0, 1);
    } else if (value > 6.5 && value < 7.5) {
      color = const Color.fromRGBO(228, 133, 22, 1);
    } else if (value > 7.5 && value < 8.5) {
      color = const Color.fromRGBO(212, 102, 0, 1);
    } else if (value > 8.5 && value < 9.5) {
      color = const Color.fromRGBO(182, 87, 0, 1);
    } else if (value > 9.5 && value < 10.5) {
      color = const Color.fromRGBO(182, 87, 0, 1);
    } else if (value > 10.5 && value < 28.5) {
      color = const Color.fromRGBO(173, 66, 16, 1);
    }
    return color;
  }

  void _getAllData(month) async {
    setState(() {
      isLoading = true;
    });
    // await _getName(month);
    // await _getSpk(month);
    // await _getPoint(month);
    // await _getBeratAsal(month);

    // chartData = <ChartData>[
    //   ChartData(
    //       xValue:
    //           'JANUARI\n${((janBrj / janRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: janBrj,
    //       secondSeriesYValue: janRelease),
    //   ChartData(
    //       xValue:
    //           'FEBRUARI\n${((febBrj / febRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: febBrj,
    //       secondSeriesYValue: febRelease),
    //   ChartData(
    //       xValue: 'MARET\n${((marBrj / marRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: marBrj,
    //       secondSeriesYValue: marRelease),
    //   ChartData(
    //       xValue: 'APRIL\n${((aprBrj / aprRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: aprBrj,
    //       secondSeriesYValue: aprRelease),
    //   ChartData(
    //       xValue: 'MEI\n${((mayBrj / meiRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: mayBrj,
    //       secondSeriesYValue: meiRelease),
    //   ChartData(
    //       xValue: 'JUNI\n${((junBrj / junRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: junBrj,
    //       secondSeriesYValue: junRelease),
    //   ChartData(
    //       xValue: 'JULI\n${((julBrj / julRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: julBrj,
    //       secondSeriesYValue: julRelease),
    //   ChartData(
    //       xValue:
    //           'AGUSTUS\n${((augBrj / aguRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: augBrj,
    //       secondSeriesYValue: aguRelease),
    //   ChartData(
    //       xValue:
    //           'SEPTEMBER\n${((sepBrj / sepRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: sepBrj,
    //       secondSeriesYValue: sepRelease),
    //   ChartData(
    //       xValue:
    //           'OKTOBER\n${((octBrj / oktRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: octBrj,
    //       secondSeriesYValue: oktRelease),
    //   ChartData(
    //       xValue:
    //           'NOVEMBER\n${((novBrj / novRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: novBrj,
    //       secondSeriesYValue: novRelease),
    //   ChartData(
    //       xValue:
    //           'DESEMBER\n${((decBrj / desRelease) * 100).toStringAsFixed(2)}%',
    //       yValue: decBrj,
    //       secondSeriesYValue: desRelease)
    // ];

    setState(() {
      isLoading = false;
    });
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
                                  'Dashboard Control',
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
    // var h = 400.0;
    var w = 400.0;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: colorDasar),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: h,
                width: w,
                color: colorCard1,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Printing Resin',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    chartPrintingResin(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(color: Colors.white, thickness: 2),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'See Detailed Report',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                // height: h,
                width: w,
                color: colorCard2,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Casting',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    chartCasting(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(color: Colors.white, thickness: 2),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'See Detailed Report',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                // height: h,
                width: w,
                color: colorCard1,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Finishing',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    chartFinishing(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(color: Colors.white, thickness: 2),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'See Detailed Report',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: h,
                width: w,
                color: colorCard2,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Polishing',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    chartPolishing(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(color: Colors.white, thickness: 2),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'See Detailed Report',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                // height: h,
                width: w,
                color: colorCard1,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Stell Rangka',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    chartStell(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(color: Colors.white, thickness: 2),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'See Detailed Report',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                // height: h,
                width: w,
                color: colorCard2,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 25),
                        child: Text(
                          'Pasang Batu',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    chartPasangBatu(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(color: Colors.white, thickness: 2),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'See Detailed Report',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  chartPrintingResin() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      // legend: Legend(isVisible: true, position: LegendPosition.top),

      //! X axis as numeric axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          axisLine: const AxisLine(width: 0),
          // title: AxisTitle(text: 'Bulan'),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),

      //? Y axis as numeric axis placed here. ATAS
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          maximum: 15,
          interval: (9 / 2), //! avare
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataPrintingResin(),
      tooltipBehavior: _tooltipBehaviorPrintingResin,
    ));
  }

  chartFinishing() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      // legend: Legend(isVisible: true, position: LegendPosition.top),

      //! X axis as numeric axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          axisLine: const AxisLine(width: 0),
          // title: AxisTitle(text: 'Bulan'),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),

      //? Y axis as numeric axis placed here. ATAS
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          maximum: 15,
          interval: (9 / 2), //! avare
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataPrintingResin(),
      tooltipBehavior: _tooltipBehaviorFinishing,
    ));
  }

  chartStell() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      // legend: Legend(isVisible: true, position: LegendPosition.top),

      //! X axis as numeric axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          axisLine: const AxisLine(width: 0),
          // title: AxisTitle(text: 'Bulan'),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),

      //? Y axis as numeric axis placed here. ATAS
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          maximum: 15,
          interval: (9 / 2), //! avare
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataPrintingResin(),
      tooltipBehavior: _tooltipBehaviorStell,
    ));
  }

  chartCasting() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      //! X axis as numeric axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          axisLine: const AxisLine(width: 0),
          // title: AxisTitle(text: 'Bulan'),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),

      //? Y axis as numeric axis placed here. ATAS
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          maximum: 15,
          interval: (9 / 2), //! avare
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataCasting(),
      tooltipBehavior: _tooltipBehaviorCasting,
    ));
  }

  chartPasangBatu() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      //! X axis as numeric axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          axisLine: const AxisLine(width: 0),
          // title: AxisTitle(text: 'Bulan'),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),

      //? Y axis as numeric axis placed here. ATAS
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          maximum: 15,
          interval: (9 / 2), //! avare
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataCasting(),
      tooltipBehavior: _tooltipBehaviorPasangBatu,
    ));
  }

  chartPolishing() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      //! X axis as numeric axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          axisLine: const AxisLine(width: 0),
          // title: AxisTitle(text: 'Bulan'),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),

      //? Y axis as numeric axis placed here. ATAS
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          maximum: 15,
          interval: (9 / 2), //! avare
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataCasting(),
      tooltipBehavior: _tooltipBehaviorPolishing,
    ));
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

  List<ColumnSeries<ChartData, dynamic>> getDataPrintingResin() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings:
            const DataLabelSettings(isVisible: true, offset: Offset(0, -5)
                // labelAlignment: ChartDataLabelAlignment
                //     .middle
                ), //? ini untuk label di dalam diagram
        dataSource: chartDataPrintResin!,
        onCreateShader: (ShaderDetails details) {
          return ui.Gradient.linear(
              details.rect.topCenter,
              details.rect.bottomCenter,
              const <Color>[Colors.red, Colors.orange, Colors.yellow],
              <double>[0.3, 0.6, 0.9]);
        },
        color: Color.fromARGB(255, 45, 45, 43),
        name: 'SPK',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        onPointTap: (event) {},
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataCasting() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(isVisible: true
            // labelAlignment: ChartDataLabelAlignment
            //     .middle
            ), //? ini untuk label di dalam diagram
        dataSource: chartDataCasting!,
        pointColorMapper: (ChartData sales, _) =>
            _getPointColor(sales.secondSeriesYValue),
        name: 'SPK',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        onPointTap: (event) {},
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
