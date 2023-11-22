// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreenProduksi extends StatefulWidget {
  const HomeScreenProduksi({super.key});

  @override
  State<HomeScreenProduksi> createState() => _HomeScreenProduksiState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _HomeScreenProduksiState extends State<HomeScreenProduksi> {
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
  List<ChartData>? chartDataLevel3;
  int indexLevel = 1;
  String titleLevel2 = '';
  int janRelease = 0;
  int febRelease = 0;
  int marRelease = 0;
  int aprRelease = 0;
  int mayRelease = 0;
  int junRelease = 0;
  int julRelease = 0;
  int augRelease = 0;
  int sepRelease = 0;
  int octRelease = 0;
  int novRelease = 0;
  int decRelease = 0;
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
    janRelease = 150;
    febRelease = 160;
    marRelease = 170;
    aprRelease = 250;
    mayRelease = 130;
    junRelease = 190;
    julRelease = 200;
    augRelease = 160;
    sepRelease = 215;
    octRelease = 189;
    novRelease = 185;
    decRelease = 250;
    janBrj = 142;
    febBrj = 160;
    marBrj = 130;
    aprBrj = 200;
    mayBrj = 130;
    junBrj = 180;
    julBrj = 150;
    augBrj = 160;
    sepBrj = 200;
    octBrj = 189;
    novBrj = 185;
    decBrj = 200;

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
          xValue: 'MEI\n${((mayBrj / mayRelease) * 100).toStringAsFixed(2)}%',
          yValue: mayBrj,
          secondSeriesYValue: mayRelease),
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
              'AGUSTUS\n${((augBrj / augRelease) * 100).toStringAsFixed(2)}%',
          yValue: augBrj,
          secondSeriesYValue: augRelease),
      ChartData(
          xValue:
              'SEPTEMBER\n${((sepBrj / sepRelease) * 100).toStringAsFixed(2)}%',
          yValue: sepBrj,
          secondSeriesYValue: sepRelease),
      ChartData(
          xValue:
              'OKTOBER\n${((octBrj / octRelease) * 100).toStringAsFixed(2)}%',
          yValue: octBrj,
          secondSeriesYValue: octRelease),
      ChartData(
          xValue:
              'NOVEMBER\n${((novBrj / novRelease) * 100).toStringAsFixed(2)}%',
          yValue: novBrj,
          secondSeriesYValue: novRelease),
      ChartData(
          xValue:
              'DESEMBER\n${((decBrj / decRelease) * 100).toStringAsFixed(2)}%',
          yValue: decBrj,
          secondSeriesYValue: decRelease)
    ];

    chartDataLevel2 = <ChartData>[
      ChartData(xValue: 'Bangle', yValue: 5, secondSeriesYValue: 7),
      ChartData(xValue: 'Bracelet', yValue: 7, secondSeriesYValue: 7),
      ChartData(xValue: 'Brooch', yValue: 1, secondSeriesYValue: 1),
      ChartData(xValue: 'Earings', yValue: 50, secondSeriesYValue: 77),
      ChartData(xValue: 'Men Ring', yValue: 1, secondSeriesYValue: 1),
      ChartData(xValue: 'Necklace', yValue: 18, secondSeriesYValue: 22),
      ChartData(xValue: 'Pendant', yValue: 47, secondSeriesYValue: 47),
      ChartData(xValue: 'Ring', yValue: 150, secondSeriesYValue: 169),
      ChartData(xValue: 'SET', yValue: 3, secondSeriesYValue: 3),
      ChartData(xValue: 'Wedding Ring', yValue: 3, secondSeriesYValue: 3),
    ];

    chartDataLevel3 = <ChartData>[
      // ChartData(xValue: 'Week 1', yValue: 5, secondSeriesYValue: 7),
      // ChartData(xValue: 'Week 2', yValue: 7, secondSeriesYValue: 7),
      // ChartData(xValue: 'Week 3', yValue: 1, secondSeriesYValue: 1),
      // ChartData(xValue: 'Week 4', yValue: 50, secondSeriesYValue: 77),
      ChartData(x: 'Week 1', y: 7, secondSeriesYValue: 7),
      ChartData(x: 'Week 2', y: 10, secondSeriesYValue: 15),
      ChartData(x: 'Week 3', y: 4, secondSeriesYValue: 4),
      ChartData(x: 'Week 4', y: 70, secondSeriesYValue: 80),
    ];
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
              // leading: Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Siklus Saat Ini : $nowSiklus",
              //         style: const TextStyle(fontSize: 20, color: Colors.black),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         final dropdownFormKey = GlobalKey<FormState>();
              //         showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(8)),
              //                 // title: const Text('Pilih Siklus'),
              //                 content: SizedBox(
              //                   height: 150,
              //                   child: Column(
              //                     children: [
              //                       Form(
              //                           key: dropdownFormKey,
              //                           child: Column(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                               DropdownSearch<String>(
              //                                 items: const [
              //                                   "JANUARI",
              //                                   "FEBRUARI",
              //                                   "MARET",
              //                                   "APRIL",
              //                                   "MEI",
              //                                   "JUNI",
              //                                   "JULI",
              //                                   "AGUSTUS",
              //                                   "SEPTEMBER",
              //                                   "OKTOBER",
              //                                   "NOVEMBER",
              //                                   "DESEMBER"
              //                                 ],
              //                                 dropdownDecoratorProps:
              //                                     DropDownDecoratorProps(
              //                                   dropdownSearchDecoration:
              //                                       InputDecoration(
              //                                     hintText: 'Pilih Siklus',
              //                                     filled: true,
              //                                     fillColor: Colors.black,
              //                                     enabledBorder:
              //                                         OutlineInputBorder(
              //                                       borderSide:
              //                                           const BorderSide(
              //                                               color: Colors.black,
              //                                               width: 2),
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               20),
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 validator: (value) => value ==
              //                                         null
              //                                     ? "Siklus tidak boleh kosong"
              //                                     : null,
              //                                 onChanged: (String? newValue) {
              //                                   addSiklus.text = newValue!;
              //                                 },
              //                               ),
              //                               Container(
              //                                 padding: const EdgeInsets.only(
              //                                     top: 20),
              //                                 child: ElevatedButton(
              //                                     onPressed: () async {
              //                                       if (dropdownFormKey
              //                                           .currentState!
              //                                           .validate()) {
              //                                         //? method untuk mengganti siklus
              //                                         // await postSiklus();
              //                                         Navigator.pop(context);
              //                                         // Navigator.push(
              //                                         //     context,
              //                                         //     MaterialPageRoute(
              //                                         //         builder:
              //                                         //             (c) =>
              //                                         //                 const MainView()));

              //                                         showDialog<String>(
              //                                             context: context,
              //                                             builder: (BuildContext
              //                                                     context) =>
              //                                                 const AlertDialog(
              //                                                   title: Text(
              //                                                     'Siklus Berhasil Diterapkan',
              //                                                   ),
              //                                                 ));
              //                                         setState(() {
              //                                           nowSiklus =
              //                                               addSiklus.text;
              //                                           sharedPreferences!
              //                                               .setString(
              //                                                   'siklusProduksi',
              //                                                   addSiklus.text);
              //                                         });
              //                                       }
              //                                     },
              //                                     child: const Text(
              //                                       "Submit",
              //                                       style: TextStyle(
              //                                         fontSize: 24,
              //                                       ),
              //                                     )),
              //                               )
              //                             ],
              //                           ))
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             });
              //       },
              //       child: SizedBox(
              //         width: 40,
              //         height: 40,
              //         child: Lottie.asset("loadingJSON/icon_edit_black.json",
              //             fit: BoxFit.cover),
              //       ),
              //     )
              //   ],
              // ),
              elevation: 0,
            ),
            body:
                //  isLoading == false
                //     ? Center(
                //         child: Transform.scale(
                //         scale: 2,
                //         child: Container(
                //           padding: const EdgeInsets.all(5),
                //           width: MediaQuery.of(context).size.width * 1,
                //           height: MediaQuery.of(context).size.height * 1,
                //           child: Lottie.asset("loadingJSON/dashboardBuild.json"),
                //         ),
                //       ))
                //     :
                Container(
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
                                  'Dashboard',
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
              border: Border.all(width: 5, color: colorDasar),
            ),
            child: indexLevel == 3
                ? chartLevel3()
                : indexLevel == 2
                    ? chartLevel2()
                    : chartLevel1()),
        SizedBox(height: 10),
      ],
    );
  }

  chartLevel1() {
    return Container(
        child: SfCartesianChart(
      title: ChartTitle(text: 'SPK RELEASE vs SPK BRJ - 2024'),
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true, position: LegendPosition.top),

      //! X axis as numeric axis placed here. BAWAH
      primaryXAxis: CategoryAxis(
          axisLine: const AxisLine(width: 0),
          title: AxisTitle(text: 'Bulan'),
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
    ));
  }

  chartLevel2() {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          child: Center(
              child: Container(
                  child: SfCartesianChart(
        //! X axis as numeric axis placed here. BAWAH
        primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 0),
            title: AxisTitle(text: 'Jenis Barang'),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        //? Y axis as numeric axis placed here. ATAS
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: 'Qty'),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        // Chart title
        title: ChartTitle(text: 'SPK RELEASE vs SPK BRJ - $titleLevel2'),
        // Enable legend
        legend: Legend(isVisible: true, position: LegendPosition.top),
        // Enable tooltip
        tooltipBehavior: _tooltipBehavior,
        series: getDataLevel2(),
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
        // axes: <ChartAxis>[
        //   NumericAxis(
        //       opposedPosition: true,
        //       name: 'yAxis1',
        //       majorGridLines: const MajorGridLines(width: 0),
        //       labelFormat: '{value}°F',
        //       minimum: 40,
        //       maximum: 100,
        //       interval: 10)
        // ],
        primaryXAxis:
            CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          opposedPosition: false,
          labelFormat: '{value}',
        ),
        // Chart title
        title: ChartTitle(text: 'SPK RELEASE vs SPK BRJ - $titleLevel2'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: _tooltipBehavior,
        series: getDataLevel3(),
        //           series: <LineSeries<SalesData, String>>[
        // LineSeries<SalesData, String>(
        //     dataSource: <SalesData>[
        //       SalesData('Week 1', 50),
        //       SalesData('Week 2', 38),
        //       SalesData('Week 3', 70),
        //       SalesData('Week 4', 20),
        //     ],
        //     xValueMapper: (SalesData sales, _) => sales.year,
        //     yValueMapper: (SalesData sales, _) => sales.sales,
        //     // Enable data label
        //     dataLabelSettings: DataLabelSettings(isVisible: true))
        // ]
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

  // void _onTapLevel2(siklus) {
  //   titleLevel2 = siklus.toString();
  //   setState(() {
  //     indexLevel = 2;
  //   });
  // }
  void _onTapLevelGo(siklus) {
    titleLevel2 = siklus.toString();
    setState(() {
      indexLevel += 1;
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
        width: 0.8,
        //? custom diagram batang
        onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
          return _CustomColumnSeriesRenderer();
        },
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
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
          // showSimpleNotification(
          //   Text('tap BRJ oke $i'),
          //   background: Colors.green,
          //   duration: const Duration(seconds: 1),
          // );
        },
        width: 0.8,
        //? custom diagram batang
        onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
          return _CustomColumnSeriesRenderer();
        },
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataLevel2() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel2!,
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'RELEASE',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        pointColorMapper: (ChartData sales, _) => sales.pointColor,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGo(i);
        },
        //? custom diagram batang
        onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
          return _CustomColumnSeriesRenderer();
        },
      ),

      ///? second series named "BRJ".

      ColumnSeries<ChartData, String>(
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment
                .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel2!,
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
        //? custom diagram batang
        onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
          return _CustomColumnSeriesRenderer();
        },
      ),
    ];
  }

  List<ChartSeries<ChartData, String>> getDataLevel3() {
    return <ChartSeries<ChartData, String>>[
      //! first series named "RELEASE".
      LineSeries<ChartData, String>(
        dataSource: chartDataLevel3!,
        yAxisName: 'yAxis1',
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'RELEASE',
        xValueMapper: (ChartData sales, _) => sales.x as String,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        // onPointTap: (event) {
        //   var i = event.dataPoints![event.pointIndex!].x;
        //   _onTapLevelGo(i);
        // },
      ),

      ///? second series named "BRJ".

      ColumnSeries<ChartData, String>(
        // dataLabelSettings: const DataLabelSettings(
        //     isVisible: true,
        //     labelAlignment: ChartDataLabelAlignment
        //         .middle), //? ini untuk label di dalam diagram
        dataSource: chartDataLevel3!,
        color: const Color.fromRGBO(2, 109, 213, 1),
        name: 'BRJ',
        xValueMapper: (ChartData sales, _) => sales.x as String,
        yValueMapper: (ChartData sales, _) => sales.y,

        // onPointTap: (event) {
        //   var i = event.dataPoints![event.pointIndex!].x;
        //   _onTapLevelGo(i);
        // },
        // //? custom diagram batang
        // onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
        //   return _CustomColumnSeriesRenderer();
        // },
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
