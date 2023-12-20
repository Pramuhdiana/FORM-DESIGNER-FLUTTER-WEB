// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/view_photo_screen.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
// ignore: unused_import
import 'package:overlay_support/overlay_support.dart';
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
  bool isLoadingFinishing = false;
  bool isLoadingPasangBatu = false;
  bool isLoadingPolishing = false;
  bool isLoadingStell = false;
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
  List<ChartData>? chartDataPolishingLevel2;
  List<ChartData>? chartDataStell;
  List<ChartData>? chartDataStellLevel2;
  List<ChartData>? chartDataPasangBatu;
  //! varaible
  List<String> artistPrintingResin = [];
  List<num> qtyArtistPrintingResin = [];
  List<String> artistFinishing = [];
  List<num> qtyArtistFinishing = [];
  List<String> artistStell = [];
  List<num> qtyArtistStell = [];
  List<String> artistCasting = [];
  List<num> qtyArtistCasting = [];
  List<String> artistPolishing = [];
  List<num> qtyArtistPolishing = [];
  List<num> qtyArtistPolishing1 = [];
  List<num> qtyArtistPolishing2 = [];
  List<num> qtyArtistStell1 = [];
  List<num> qtyArtistStell2 = [];
  List<String> artistPasangBatu = [];
  List<num> qtyArtistPasangBatu = [];
  //? end variable
  int isPolishing = 0;
  int isStell = 0;
  bool isFinishingClick = false;
  bool isPasangBatuClick = false;
  String? pilihArtistFinishing;
  String? pilihArtistPasangBatu;
  String? pilihArtistPolishing;
  String? pilihArtistStell;
  List<FormDesignerModel>? _listFinishing;
  List<FormDesignerModel>? _listPolishing;
  List<FormDesignerModel>? _listPasangBatu;
  List<FormDesignerModel>? _listStell;

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
  final DateTime targetDate = DateTime(2023, 12, 1);
  final today = DateTime.now();

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
    final difference = today
        .difference(targetDate)
        .inDays; //! untuk menentukan sudah berapa lama dari tanggal create sampai tanggal sekarang
    print(difference);
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

  void handleClickFinishing(artist) {
    artist == ''
        ? setState(() {
            isFinishingClick = !isFinishingClick;
            pilihArtistFinishing = null;
          })
        : setState(() {
            isFinishingClick = !isFinishingClick;
            pilihArtistFinishing = artist;
            _getAllDataFinishing(pilihArtistFinishing);
          });
  }

  void handleClickPasangBatu(artist) {
    artist == ''
        ? setState(() {
            isPasangBatuClick = !isPasangBatuClick;
            pilihArtistPasangBatu = null;
          })
        : setState(() {
            isPasangBatuClick = !isPasangBatuClick;
            pilihArtistPasangBatu = artist;
            _getAllDataPasangBatu(pilihArtistPasangBatu);
          });
  }

  Color? _getPointColor(num? value) {
    Color? color;
    if (value! < 2.5) {
      color = const Color.fromRGBO(252, 238, 160, 1);
    } else if (value > 2.5 && value < 3.5) {
      color = const Color.fromRGBO(247, 203, 90, 1);
    } else if (value >= 3.5 && value < 4.5) {
      color = const Color.fromRGBO(237, 162, 0, 1);
    } else if (value > 4.5 && value < 5.5) {
      color = const Color.fromRGBO(221, 146, 0, 1);
    } else if (value > 5.5 && value < 6.5) {
      color = const Color.fromRGBO(212, 102, 0, 1);
    } else if (value > 6.5 && value < 7.5) {
      color = const Color.fromRGBO(228, 133, 22, 1);
    } else if (value > 7.5 && value < 8.5) {
      color = const Color.fromRGBO(182, 87, 0, 1);
    } else if (value > 8.5 && value < 9.5) {
      color = const Color.fromRGBO(182, 87, 0, 1);
    } else if (value > 9.5 && value < 10.5) {
      color = const Color.fromRGBO(173, 66, 16, 1);
    } else if (value > 10.5 && value < 28.5) {
      color = ui.Color.fromARGB(255, 130, 49, 11);
    }
    return color;
  }

  void _getAllDataFinishing(artist) async {
    setState(() {
      isLoadingFinishing = true;
    });
    await getDataTable(artist);
    setState(() {
      isLoadingFinishing = false;
    });
  }

  void _getAllDataPasangBatu(artist) async {
    setState(() {
      isLoadingPasangBatu = true;
    });
    await getDataTablePasangBatu(artist);
    setState(() {
      isLoadingPasangBatu = false;
    });
  }

  void _getAllDataPolishing(artist) async {
    setState(() {
      isLoadingPolishing = true;
    });
    await getDataTablePolishing(artist);
    setState(() {
      isLoadingPolishing = false;
    });
  }

  void _getAllDataStell(artist) async {
    setState(() {
      isLoadingStell = true;
    });
    await getDataTableStell(artist);
    setState(() {
      isLoadingStell = false;
    });
  }

  void _getAllData(month) async {
    setState(() {
      isLoading = true;
    });
    await _getName(month);
    // await _getSpk(month);
    // await _getPoint(month);
    // await _getBeratAsal(month);
    print('tes');
    print(artistPrintingResin);
    print('end tes');
    //! looping list lebih simple
    chartDataPrintResin = [
      for (var i = 0; i < artistPrintingResin.length; i++)
        ChartData(
            xValue: artistPrintingResin[i],
            secondSeriesYValue: qtyArtistPrintingResin[i])
    ];
    chartDataFinishing = [
      for (var i = 0; i < artistFinishing.length; i++)
        ChartData(
            xValue: artistFinishing[i],
            secondSeriesYValue: qtyArtistFinishing[i])
    ];
    chartDataStell = [
      for (var i = 0; i < artistStell.length; i++)
        ChartData(xValue: artistStell[i], secondSeriesYValue: qtyArtistStell[i])
    ];
    chartDataCasting = [
      for (var i = 0; i < artistCasting.length; i++)
        ChartData(
            xValue: artistCasting[i], secondSeriesYValue: qtyArtistCasting[i])
    ];

    chartDataPolishing = [
      for (var i = 0; i < artistPolishing.length; i++)
        ChartData(
            xValue: artistPolishing[i],
            secondSeriesYValue: qtyArtistPolishing[i])
    ];
    chartDataPolishingLevel2 = [
      for (var i = 0; i < artistPolishing.length; i++)
        ChartData(
            xValue: artistPolishing[i],
            secondSeriesYValue: qtyArtistPolishing2[i],
            yValue: qtyArtistPolishing1[i])
    ];

    chartDataStellLevel2 = [
      for (var i = 0; i < artistStell.length; i++)
        ChartData(
            xValue: artistStell[i],
            secondSeriesYValue: qtyArtistStell2[i],
            yValue: qtyArtistStell1[i])
    ];

    chartDataPasangBatu = [
      for (var i = 0; i < artistPasangBatu.length; i++)
        ChartData(
            xValue: artistPasangBatu[i],
            secondSeriesYValue: qtyArtistPasangBatu[i],
            text: '${artistPasangBatu[i]} \n ${qtyArtistPasangBatu[i]}')
    ];

    setState(() {
      isLoading = false;
    });
  }

  _getName(month) async {
    print('get nama on');
    artistPrintingResin = [];
    List<String> dummyArtistPrintingResin = [];
    artistFinishing = [];
    List<String> dummyArtistFinishing = [];
    artistStell = [];
    List<String> dummyArtistStell = [];
    artistCasting = [];
    List<String> dummyArtistCasting = [];
    artistPasangBatu = [];
    List<String> dummyArtistPasangBatu = [];
    artistPolishing = [];
    List<String> dummyArtistPolishing = [];
    List<String> dummyArtistPolishing1 = [];
    List<String> dummyArtistPolishing2 = [];
    List<String> dummyArtistStell1 = [];
    List<String> dummyArtistStell2 = [];

    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();

      //! printing resin
      var filterByPrintingResin = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'printing resin')
          .toList();

      //! looping list lebih simple
      for (var item in filterByPrintingResin) {
        dummyArtistPrintingResin.add(item.artist!);
      }
      artistPrintingResin = dummyArtistPrintingResin.toSet().toList();
      for (var i = 0; i < artistPrintingResin.length; i++) {
        int count = dummyArtistPrintingResin
            .where((artist) => artist == artistPrintingResin[i])
            .length;
        qtyArtistPrintingResin.add(count);
      }
      //? end function PrintingResin

      //! finishing
      var filterByFinishing = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'finishing')
          .toList();
      // _listFinishing = filterByFinishing;

      //! looping list lebih simple
      for (var item in filterByFinishing) {
        dummyArtistFinishing.add(item.artist!);
      }
      artistFinishing = dummyArtistFinishing.toSet().toList();
      for (var i = 0; i < artistFinishing.length; i++) {
        int count = dummyArtistFinishing
            .where((artist) => artist == artistFinishing[i])
            .length;
        qtyArtistFinishing.add(count);
      }
      //? end function Finishing

      //! stell rangka
      var filterByStell = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'stell 1' ||
              element.posisi.toString().toLowerCase() == 'stell 2')
          .toList();

      //! looping list lebih simple
      for (var item in filterByStell) {
        dummyArtistStell.add(item.artist!);
      }
      artistStell = dummyArtistStell.toSet().toList();
      for (var i = 0; i < artistStell.length; i++) {
        int count =
            dummyArtistStell.where((artist) => artist == artistStell[i]).length;
        qtyArtistStell.add(count);
      }
      //? end function Stell

      //! casting
      var filterByCasting = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'casting' ||
              element.posisi.toString().toLowerCase() == 'finishing casting')
          .toList();

      //! looping list lebih simple
      for (var item in filterByCasting) {
        dummyArtistCasting.add(item.artist!);
      }
      artistCasting = dummyArtistCasting.toSet().toList();
      for (var i = 0; i < artistCasting.length; i++) {
        int count = dummyArtistCasting
            .where((artist) => artist == artistCasting[i])
            .length;
        qtyArtistCasting.add(count);
      }
      //? end function Casting

      //! polishing
      var filterByPolishing = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'polishing 1' ||
              element.posisi.toString().toLowerCase() == 'polishing 2')
          .toList();

      //! looping list lebih simple
      for (var item in filterByPolishing) {
        dummyArtistPolishing.add(item.artist!);
      }
      artistPolishing = dummyArtistPolishing.toSet().toList();
      for (var i = 0; i < artistPolishing.length; i++) {
        int count = dummyArtistPolishing
            .where((artist) => artist == artistPolishing[i])
            .length;
        qtyArtistPolishing.add(count);
      }
      //? end function Polishing

      //! polishing1
      var filterByPolishing1 = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'polishing 1')
          .toList();

      //! looping list lebih simple
      for (var item in filterByPolishing1) {
        dummyArtistPolishing1.add(item.artist!);
      }
      for (var i = 0; i < artistPolishing.length; i++) {
        int count = dummyArtistPolishing1
            .where((artist) => artist == artistPolishing[i])
            .length;
        qtyArtistPolishing1.add(count);
      }
      //? end function Polishing1

      //! polishing2
      var filterByPolishing2 = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'polishing 2')
          .toList();

      //! looping list lebih simple
      for (var item in filterByPolishing2) {
        dummyArtistPolishing2.add(item.artist!);
      }
      for (var i = 0; i < artistPolishing.length; i++) {
        int count = dummyArtistPolishing2
            .where((artist) => artist == artistPolishing[i])
            .length;
        qtyArtistPolishing2.add(count);
      }
      //? end function Polishing2

      //! Stell1
      var filterByStell1 = allData
          .where(
              (element) => element.posisi.toString().toLowerCase() == 'stell 1')
          .toList();

      //! looping list lebih simple
      for (var item in filterByStell1) {
        dummyArtistStell1.add(item.artist!);
      }
      for (var i = 0; i < artistStell.length; i++) {
        int count = dummyArtistStell1
            .where((artist) => artist == artistStell[i])
            .length;
        qtyArtistStell1.add(count);
      }
      //? end function Stell1

      //! Stell2
      var filterByStell2 = allData
          .where(
              (element) => element.posisi.toString().toLowerCase() == 'stell 2')
          .toList();

      //! looping list lebih simple
      for (var item in filterByStell2) {
        dummyArtistStell2.add(item.artist!);
      }
      for (var i = 0; i < artistStell.length; i++) {
        int count = dummyArtistStell2
            .where((artist) => artist == artistStell[i])
            .length;
        qtyArtistStell2.add(count);
      }
      //? end function Stell2

      //! PasangBatu
      var filterByPasangBatu = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'pasang batu')
          .toList();

      //! looping list lebih simple
      for (var item in filterByPasangBatu) {
        dummyArtistPasangBatu.add(item.artist!);
      }
      artistPasangBatu = dummyArtistPasangBatu.toSet().toList();
      for (var i = 0; i < artistPasangBatu.length; i++) {
        int count = dummyArtistPasangBatu
            .where((artist) => artist == artistPasangBatu[i])
            .length;
        qtyArtistPasangBatu.add(count);
      }
      //? end function PasangBatu
    } else {}
  }

  getDataTable(artist) async {
    print('get data divisi on');
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      //! finishing
      var filterByFinishing = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'finishing')
          .toList();
      var filterByArtist = filterByFinishing
          .where((element) =>
              element.artist.toString().toLowerCase() ==
              artist.toString().toLowerCase())
          .toList();
      _listFinishing = filterByArtist;
    } else {}
  }

  getDataTablePasangBatu(artist) async {
    print('get data divisi on');
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      //! finishing
      var filterByPasangBatu = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'pasang batu')
          .toList();
      var filterByArtist = filterByPasangBatu
          .where((element) =>
              element.artist.toString().toLowerCase() ==
              artist.toString().toLowerCase())
          .toList();
      _listPasangBatu = filterByArtist;
    } else {}
  }

  getDataTablePolishing(artist) async {
    print('get data divisi on');
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      //! polishing
      var filterBypolishing = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'polishing 1' ||
              element.posisi.toString().toLowerCase() == 'polishing 2')
          .toList();
      var filterByArtist = filterBypolishing
          .where((element) =>
              element.artist.toString().toLowerCase() ==
              artist.toString().toLowerCase())
          .toList();
      _listPolishing = filterByArtist;
    } else {}
  }

  getDataTableStell(artist) async {
    print('get data divisi on');
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      //! polishing
      var filterByStell = allData
          .where((element) =>
              element.posisi.toString().toLowerCase() == 'stell 1' ||
              element.posisi.toString().toLowerCase() == 'stell 2')
          .toList();
      var filterByArtist = filterByStell
          .where((element) =>
              element.artist.toString().toLowerCase() ==
              artist.toString().toLowerCase())
          .toList();
      _listStell = filterByArtist;
      print(_listFinishing);
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
                      scrollDirection: Axis.horizontal,
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
                              ])),
                    ))));
  }

  //! dashboard produksi
  dashboardProduksi() {
    var h = 400.0;
    var w = 600.0;
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
                height: h,
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
                height: h,
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
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isPolishing == 2
                  ? Container(
                      height: h,
                      width: w,
                      color: colorCard2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _onTapLevelBackPolishing();
                                },
                                child: SizedBox(
                                  width: 50,
                                  child: Lottie.asset(
                                      "loadingJSON/backbutton.json",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: pilihArtistPolishing != null
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
                                          value: pilihArtistPolishing,
                                          items: [
                                            for (var item in artistPolishing)
                                              DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              ),
                                          ],
                                          hint: const Text(
                                              'Pilih Artist Polishing'),
                                          onChanged: (value) {
                                            print(value);
                                            pilihArtistPolishing = value;
                                            _getAllDataPolishing(
                                                pilihArtistPolishing);
                                          },
                                          icon: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Icon(Icons
                                                  .arrow_circle_down_sharp)),
                                          iconEnabledColor:
                                              Colors.black, //Icon color
                                          style: const TextStyle(
                                            color: Colors.black, //Font color
                                            // fontSize:
                                            //     15 //font size on dropdown button
                                          ),

                                          dropdownColor: Colors
                                              .white, //dropdown background color
                                          underline:
                                              Container(), //remove underline
                                          isExpanded:
                                              true, //make true to make width 100%
                                        ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            height: (h - 120),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: pilihArtistPolishing == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          'pilih artist terlebih dahulu',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  : isLoadingPolishing == true
                                      ? Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 90,
                                          height: 90,
                                          child: Lottie.asset(
                                              "loadingJSON/loadingV1.json"),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: dataTablePolishing(),
                                          )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Divider(color: Colors.white, thickness: 2),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : isPolishing == 1
                      ? Container(
                          height: h,
                          width: w,
                          color: colorCard2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _onTapLevelBackPolishing();
                                    },
                                    child: SizedBox(
                                      width: 50,
                                      child: Lottie.asset(
                                          "loadingJSON/backbutton.json",
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 0, top: 25),
                                      child: Text(
                                        'Polishing 1 dan 2',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              chartPolishingLevel2(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child:
                                    Divider(color: Colors.white, thickness: 2),
                              ),
                              InkWell(
                                onTap: () {
                                  _onTapLevelGoPolishing('');
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Text(
                                        'See Detailed Report',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
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
                        )
                      : Container(
                          height: h,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child:
                                    Divider(color: Colors.white, thickness: 2),
                              ),
                              InkWell(
                                onTap: () {
                                  _onTapLevelGoPolishing('');
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Text(
                                        'See Detailed Report',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isStell == 2
                      ? Container(
                          height: h,
                          width: w,
                          color: colorCard1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _onTapLevelBackStell();
                                    },
                                    child: SizedBox(
                                      width: 50,
                                      child: Lottie.asset(
                                          "loadingJSON/backbutton.json",
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: pilihArtistStell != null
                                              ? ui.Color.fromARGB(
                                                  255, 42, 255, 23)
                                              : const Color.fromRGBO(
                                                  238,
                                                  240,
                                                  235,
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
                                              value: pilihArtistStell,
                                              items: [
                                                for (var item in artistStell)
                                                  DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item),
                                                  ),
                                              ],
                                              hint: const Text(
                                                  'Pilih Artist Stell'),
                                              onChanged: (value) {
                                                print(value);
                                                pilihArtistStell = value;
                                                _getAllDataStell(
                                                    pilihArtistStell);
                                              },
                                              icon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(Icons
                                                      .arrow_circle_down_sharp)),
                                              iconEnabledColor:
                                                  Colors.black, //Icon color
                                              style: const TextStyle(
                                                color:
                                                    Colors.black, //Font color
                                                // fontSize:
                                                //     15 //font size on dropdown button
                                              ),

                                              dropdownColor: Colors
                                                  .white, //dropdown background color
                                              underline:
                                                  Container(), //remove underline
                                              isExpanded:
                                                  true, //make true to make width 100%
                                            ))),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                height: (h - 120),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: pilihArtistStell == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Text(
                                              'pilih artist terlebih dahulu',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      : isLoadingStell == true
                                          ? Container(
                                              padding: const EdgeInsets.all(5),
                                              width: 90,
                                              height: 90,
                                              child: Lottie.asset(
                                                  "loadingJSON/loadingV1.json"),
                                            )
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: dataTableStell(),
                                              )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child:
                                    Divider(color: Colors.white, thickness: 2),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text(
                                      '',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : isStell == 1
                          ? Container(
                              height: h,
                              width: w,
                              color: colorCard1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _onTapLevelBackStell();
                                        },
                                        child: SizedBox(
                                          width: 50,
                                          child: Lottie.asset(
                                              "loadingJSON/backbutton.json",
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 180,
                                      ),
                                      Container(
                                          padding:
                                              EdgeInsets.only(left: 0, top: 25),
                                          child: Text(
                                            'Stell rangka 1 dan 2',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                  chartStellLevel2(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Divider(
                                        color: Colors.white, thickness: 2),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _onTapLevelGoStell('');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Text(
                                            'See Detailed Report',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
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
                            )
                          : Container(
                              height: h,
                              width: w,
                              color: colorCard1,
                              child: Column(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 25),
                                      child: Text(
                                        'Stell Rangka',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  chartStell(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Divider(
                                        color: Colors.white, thickness: 2),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _onTapLevelGoStell('');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Text(
                                            'See Detailed Report',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
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
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isFinishingClick == true
                  ? Container(
                      height: h,
                      width: w,
                      color: colorCard1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  handleClickFinishing('');
                                },
                                child: SizedBox(
                                  width: 50,
                                  child: Lottie.asset(
                                      "loadingJSON/backbutton.json",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: pilihArtistFinishing != null
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
                                          value: pilihArtistFinishing,
                                          items: [
                                            for (var item in artistFinishing)
                                              DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              ),
                                          ],
                                          hint: const Text(
                                              'Pilih Artist Finishing'),
                                          onChanged: (value) {
                                            print(value);
                                            pilihArtistFinishing = value;
                                            _getAllDataFinishing(
                                                pilihArtistFinishing);
                                          },
                                          icon: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Icon(Icons
                                                  .arrow_circle_down_sharp)),
                                          iconEnabledColor:
                                              Colors.black, //Icon color
                                          style: const TextStyle(
                                            color: Colors.black, //Font color
                                            // fontSize:
                                            //     15 //font size on dropdown button
                                          ),

                                          dropdownColor: Colors
                                              .white, //dropdown background color
                                          underline:
                                              Container(), //remove underline
                                          isExpanded:
                                              true, //make true to make width 100%
                                        ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            height: (h - 120),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: pilihArtistFinishing == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          'pilih artist terlebih dahulu',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  : isLoadingFinishing == true
                                      ? Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 90,
                                          height: 90,
                                          child: Lottie.asset(
                                              "loadingJSON/loadingV1.json"),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: dataTableFinishing(),
                                          )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Divider(color: Colors.white, thickness: 2),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: h,
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
                            onTap: () {
                              handleClickFinishing('');
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'See Detailed Report',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
              isPasangBatuClick == true
                  ? Container(
                      height: h,
                      width: w,
                      color: colorCard2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  handleClickPasangBatu('');
                                },
                                child: SizedBox(
                                  width: 50,
                                  child: Lottie.asset(
                                      "loadingJSON/backbutton.json",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: pilihArtistPasangBatu != null
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
                                          value: pilihArtistPasangBatu,
                                          items: [
                                            for (var item in artistPasangBatu)
                                              DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              ),
                                          ],
                                          hint: const Text(
                                              'Pilih Artist Pasang Batu'),
                                          onChanged: (value) {
                                            print(value);
                                            pilihArtistPasangBatu = value;
                                            _getAllDataPasangBatu(
                                                pilihArtistPasangBatu);
                                          },
                                          icon: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Icon(Icons
                                                  .arrow_circle_down_sharp)),
                                          iconEnabledColor:
                                              Colors.black, //Icon color
                                          style: const TextStyle(
                                            color: Colors.black, //Font color
                                            // fontSize:
                                            //     15 //font size on dropdown button
                                          ),

                                          dropdownColor: Colors
                                              .white, //dropdown background color
                                          underline:
                                              Container(), //remove underline
                                          isExpanded:
                                              true, //make true to make width 100%
                                        ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            height: (h - 120),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: pilihArtistPasangBatu == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          'pilih artist terlebih dahulu',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  : isLoadingPasangBatu == true
                                      ? Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 90,
                                          height: 90,
                                          child: Lottie.asset(
                                              "loadingJSON/loadingV1.json"),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: dataTablePasangBatu()),
                                        ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Divider(color: Colors.white, thickness: 2),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: h,
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
                          chartPasangBatuPie(),
                          // chartPasangBatu(),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Divider(color: Colors.white, thickness: 2),
                          ),
                          InkWell(
                            onTap: () {
                              handleClickPasangBatu('');
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'See Detailed Report',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          // maximum: 10,
          // interval: 5,
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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataFinishing(),
      tooltipBehavior: _tooltipBehaviorFinishing,
    ));
  }

  dataTableFinishing() {
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
        columns: columnsDataFinishing(),
        border: TableBorder.all(),
        rows: rowsDataFinishing(_listFinishing, _listFinishing!.length));
  }

  dataTablePasangBatu() {
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
        columns: columnsDataFinishing(),
        border: TableBorder.all(),
        rows: rowsDataFinishing(_listPasangBatu, _listPasangBatu!.length));
  }

  dataTablePolishing() {
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
        columns: columnsDataPolishing(),
        border: TableBorder.all(),
        rows: rowsDataPolishing(_listPolishing, _listPolishing!.length));
  }

  dataTableStell() {
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
        columns: columnsDataPolishing(),
        border: TableBorder.all(),
        rows: rowsDataPolishing(_listStell, _listStell!.length));
  }

  List<DataColumn> columnsDataFinishing() {
    return [
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('NO')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('IMAGE')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KODE\nMARKETING')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('TEMA')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KELAS\nHARGA')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KETERANGAN\nBATU')))),
    ];
  }

  List<DataColumn> columnsDataPolishing() {
    return [
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('POSISI')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('NO')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('IMAGE')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KODE\nMARKETING')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('TEMA')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KELAS\nHARGA')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KETERANGAN\nBATU')))),
    ];
  }

  List<DataRow> rowsDataFinishing(var data, int count) {
    return [
      for (var i = 0; i < count; i++)
        DataRow(cells: [
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text((i + 1).toString())))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 100,
                height: 140,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ViewPhotoScreen(
                                  model: FormDesignerModel(
                                      kodeDesignMdbc: data[i].kodeDesignMdbc,
                                      imageUrl: data[i].imageUrl),
                                )));
                  },
                  child: Image.network(
                    ApiConstants.baseUrlImage + data[i].imageUrl!,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].kodeMarketing.toString())))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].tema.toString())))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: (data[i].brand.toString().toLowerCase() == "parva" ||
                          data[i].brand.toString().toLowerCase() == "fine")
                      ? ((data[i].estimasiHarga * 0.37) * 11500) <= 5000000
                          ? const Text(
                              "XS",
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                            )
                          : ((data[i].estimasiHarga * 0.37) * 11500) <= 10000000
                              ? const Text(
                                  "S",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black),
                                )
                              : ((data[i].estimasiHarga * 0.37) * 11500) <=
                                      20000000
                                  ? const Text(
                                      "M",
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : ((data[i].estimasiHarga * 0.37) * 11500) <=
                                          35000000
                                      ? const Text(
                                          "L",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : const Text(
                                          "XL",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )
                      : (data[i].estimasiHarga) <= 5000000
                          ? const Text(
                              "XS",
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                            )
                          : (data[i].estimasiHarga) <= 10000000
                              ? const Text(
                                  "S",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black),
                                )
                              : (data[i].estimasiHarga) <= 20000000
                                  ? const Text(
                                      "M",
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : (data[i].estimasiHarga) <= 35000000
                                      ? const Text(
                                          "L",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : const Text(
                                          "XL",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Text(data[i].keteranganStatusBatu.toString())))),
        ]),
    ];
  }

  List<DataRow> rowsDataPolishing(var data, int count) {
    return [
      for (var i = 0; i < count; i++)
        DataRow(cells: [
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].posisi.toString())))),
          DataCell(Container(
              padding: const EdgeInsets.all(0),
              child: Center(child: Text((i + 1).toString())))),
          DataCell(Container(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 100,
                height: 140,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ViewPhotoScreen(
                                  model: FormDesignerModel(
                                      kodeDesignMdbc: data[i].kodeDesignMdbc,
                                      imageUrl: data[i].imageUrl),
                                )));
                  },
                  child: Image.network(
                    ApiConstants.baseUrlImage + data[i].imageUrl!,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].kodeMarketing.toString())))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].tema.toString())))),
          DataCell(Container(
              padding: const EdgeInsets.all(0),
              child: Center(
                  child: (data[i].brand.toString().toLowerCase() == "parva" ||
                          data[i].brand.toString().toLowerCase() == "fine")
                      ? ((data[i].estimasiHarga * 0.37) * 11500) <= 5000000
                          ? const Text(
                              "XS",
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                            )
                          : ((data[i].estimasiHarga * 0.37) * 11500) <= 10000000
                              ? const Text(
                                  "S",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black),
                                )
                              : ((data[i].estimasiHarga * 0.37) * 11500) <=
                                      20000000
                                  ? const Text(
                                      "M",
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : ((data[i].estimasiHarga * 0.37) * 11500) <=
                                          35000000
                                      ? const Text(
                                          "L",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : const Text(
                                          "XL",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )
                      : (data[i].estimasiHarga) <= 5000000
                          ? const Text(
                              "XS",
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                            )
                          : (data[i].estimasiHarga) <= 10000000
                              ? const Text(
                                  "S",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black),
                                )
                              : (data[i].estimasiHarga) <= 20000000
                                  ? const Text(
                                      "M",
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : (data[i].estimasiHarga) <= 35000000
                                      ? const Text(
                                          "L",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : const Text(
                                          "XL",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black),
                                        )))),
          DataCell(Container(
              padding: const EdgeInsets.all(0),
              child: Center(
                  child: Text(data[i].keteranganStatusBatu.toString())))),
        ]),
    ];
  }

  chartStell() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      // legend: Legend(isVisible: true, position: LegendPosition.top),

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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataStell(),
      tooltipBehavior: _tooltipBehaviorStell,
    ));
  }

  chartCasting() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          // maximum: 15,
          // interval: (9 / 2), //! avare
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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          // maximum: 15,
          // interval: (9 / 2), //! avare
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataPasangBatu(),
      tooltipBehavior: _tooltipBehaviorPasangBatu,
    ));
  }

  chartPasangBatuPie() {
    return Container(
        child: SfCircularChart(
      legend: Legend(isVisible: true),
      series: _getRadiusPieSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    ));
  }

  chartPolishing() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataPolishing(),
      tooltipBehavior: _tooltipBehaviorPolishing,
    ));
  }

  chartPolishingLevel2() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true, position: LegendPosition.top),
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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataPolishingLevel2(),
      tooltipBehavior: _tooltipBehaviorPolishing,
    ));
  }

  chartStellLevel2() {
    return Container(
        child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true, position: LegendPosition.top),
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
          labelFormat: '{value}',
          // title: AxisTitle(text: 'Total'),
          minimum: 0,
          axisLine: const AxisLine(width: 0),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: getDataStellLevel2(),
      tooltipBehavior: _tooltipBehaviorStell,
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

  void _onTapLevelGoPolishing(artist) {
    artist == ''
        ? setState(() {
            isPolishing += 1;
            pilihArtistPolishing = null;
          })
        : setState(() {
            isPolishing += 1;
            pilihArtistPolishing = artist;
            _getAllDataPolishing(pilihArtistPolishing);
          });
  }

  void _onTapLevelGoStell(artist) {
    artist == ''
        ? setState(() {
            isStell += 1;
            pilihArtistStell = null;
          })
        : setState(() {
            isStell += 1;
            pilihArtistStell = artist;
            _getAllDataStell(pilihArtistStell);
          });
  }

  void _onTapLevelBackPolishing() {
    setState(() {
      isPolishing -= 1;
      pilihArtistPolishing = null;
    });
  }

  void _onTapLevelBackStell() {
    setState(() {
      isStell -= 1;
      pilihArtistStell = null;
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

  List<ColumnSeries<ChartData, dynamic>> getDataFinishing() {
    return <ColumnSeries<ChartData, dynamic>>[
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings:
            const DataLabelSettings(isVisible: true, offset: Offset(0, -5)
                // labelAlignment: ChartDataLabelAlignment
                //     .middle
                ), //? ini untuk label di dalam diagram
        dataSource: chartDataFinishing!,
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
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          // showSimpleNotification(
          //   Text('$i'),
          //   background: Colors.green,
          //   duration: const Duration(seconds: 1),
          // );
          handleClickFinishing(i);
        },
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataStell() {
    return <ColumnSeries<ChartData, dynamic>>[
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings:
            const DataLabelSettings(isVisible: true, offset: Offset(0, -5)
                // labelAlignment: ChartDataLabelAlignment
                //     .middle
                ), //? ini untuk label di dalam diagram
        dataSource: chartDataStell!,
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
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;

          _onTapLevelGoStell(i);
        },
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

  List<ColumnSeries<ChartData, dynamic>> getDataPasangBatu() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(isVisible: true
            // labelAlignment: ChartDataLabelAlignment
            //     .middle
            ), //? ini untuk label di dalam diagram
        dataSource: chartDataPasangBatu!,
        pointColorMapper: (ChartData sales, _) =>
            _getPointColor(sales.secondSeriesYValue),
        name: 'SPK',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          handleClickPasangBatu(i);
        },
      ),
    ];
  }

  /// Returns the pie series.
  List<PieSeries<ChartData, String>> _getRadiusPieSeries() {
    return <PieSeries<ChartData, String>>[
      PieSeries<ChartData, String>(
          onPointTap: (event) {
            var i = event.dataPoints![event.pointIndex!].x;
            handleClickPasangBatu(i);
          },
          explode: true,
          explodeIndex: 0,
          explodeOffset: '10%',
          dataSource: chartDataPasangBatu!,
          xValueMapper: (ChartData data, _) => data.xValue as String,
          yValueMapper: (ChartData data, _) => data.secondSeriesYValue,
          dataLabelMapper: (ChartData data, _) => data.text,
          startAngle: 100,
          endAngle: 100,
          // pointRadiusMapper: (ChartData data, _) =>
          //     data.secondSeriesYValue as String,
          // pointRadiusMapper: (ChartData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside))
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataPolishing() {
    return <ColumnSeries<ChartData, dynamic>>[
      //! first series named "RELEASE".
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(isVisible: true
            // labelAlignment: ChartDataLabelAlignment
            //     .middle
            ), //? ini untuk label di dalam diagram
        dataSource: chartDataPolishing!,
        pointColorMapper: (ChartData sales, _) =>
            _getPointColor(sales.secondSeriesYValue),
        name: 'SPK',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        onPointTap: (event) {
          _onTapLevelGoPolishing('');
        },
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataPolishingLevel2() {
    return <ColumnSeries<ChartData, dynamic>>[
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
        ),
        dataSource: chartDataPolishingLevel2!,
        // pointColorMapper: (ChartData sales, _) =>
        //     _getPointColor(sales.secondSeriesYValue),
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'POLISHING 1',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGoPolishing(i);
        },
      ),
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(isVisible: true
            // labelAlignment: ChartDataLabelAlignment
            //     .middle
            ), //? ini untuk label di dalam diagram
        dataSource: chartDataPolishingLevel2!,
        // pointColorMapper: (ChartData sales, _) =>
        //     _getPointColor(sales.secondSeriesYValue),
        color: const Color.fromRGBO(2, 109, 213, 1),
        name: 'POLISHING 2',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGoPolishing(i);
        },
      ),
    ];
  }

  List<ColumnSeries<ChartData, dynamic>> getDataStellLevel2() {
    return <ColumnSeries<ChartData, dynamic>>[
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
        ),
        dataSource: chartDataStellLevel2!,
        // pointColorMapper: (ChartData sales, _) =>
        //     _getPointColor(sales.secondSeriesYValue),
        color: const Color.fromRGBO(237, 221, 76, 1),
        name: 'STELL RANGKA 1',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGoStell(i);
        },
      ),
      ColumnSeries<ChartData, dynamic>(
        dataLabelSettings: const DataLabelSettings(isVisible: true
            // labelAlignment: ChartDataLabelAlignment
            //     .middle
            ), //? ini untuk label di dalam diagram
        dataSource: chartDataStellLevel2!,
        // pointColorMapper: (ChartData sales, _) =>
        //     _getPointColor(sales.secondSeriesYValue),
        color: const Color.fromRGBO(2, 109, 213, 1),
        name: 'Stell Rangka 2',
        width: 0.8,
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.secondSeriesYValue,
        onPointTap: (event) {
          var i = event.dataPoints![event.pointIndex!].x;
          _onTapLevelGoStell(i);
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
