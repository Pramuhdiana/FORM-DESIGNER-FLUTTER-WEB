// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/mainScreen/side_screen_batu.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FinishingScreen extends StatefulWidget {
  const FinishingScreen({super.key});
  @override
  State<FinishingScreen> createState() => _FinishingScreenState();
}


class _FinishingScreenState extends State<FinishingScreen>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
  }

  static const List<Tab> _tabs = [
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(Icons.looks_one), Text('Finishing')],
    )),
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(Icons.looks_two), Text('Polishing 1')],
    )),
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(Icons.looks_3), Text('Stell Rangka 1')],
    )),
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(Icons.looks_4), Text('Stell Rangka 2')],
    )),
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(Icons.looks_5), Text('Polishing 2')],
    )),
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(Icons.looks_6), Text('Pasang Batu')],
    )),
  ];

  final List<Widget> _views = [
    const FinisScreen(),
    const ListMpsScreen(),
    const Center(child: Text('Content of Tab One')),
    const Center(child: Text('Content of Tab Two')),
    const Center(child: Text('Content of Tab Three')),
    const Center(child: Text('Content of Tab Three')),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: DefaultTabController(
          length: 6,
          child: Scaffold(
              appBar: AppBar(
                title: const Center(child: Text('PRODUKSI')),
                elevation: 0,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      const TextStyle(fontStyle: FontStyle.italic),
                  overlayColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blue;
                    }
                    if (states.contains(MaterialState.focused)) {
                      return Colors.white;
                    } else if (states.contains(MaterialState.hovered)) {
                      return Colors.white;
                    }

                    return Colors.transparent;
                  }),
                  // indicatorWeight: 10,
                  // indicatorColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(5),
                  indicator: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  // isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  onTap: (int index) {
                    print('Tab $index is tapped');
                  },
                  enableFeedback: true,
                  tabs: _tabs,
                ),
                backgroundColor: Colors.blue,
              ),
              body: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: _views,
              )),
        ));
  }
}

class FinisScreen extends StatefulWidget {
  const FinisScreen({super.key});
  @override
  State<FinisScreen> createState() => _FinisScreenState();
}

class _FinisScreenState extends State<FinisScreen> {
  @override
  initState() {
    super.initState();
  }

  DataTable _dataTablePendapatan() {
    return DataTable(
        headingTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.blue),
        columnSpacing: 0,
        headingRowHeight: 50,
        dataRowMaxHeight: 50,
        columns: _createColumns(),
        border: TableBorder.all(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('NAMA')),
      const DataColumn(label: Text('KODE  PRODUKSI')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      for (var i = 0; i < 2; i++)
        DataRow(cells: [
          DataCell(Text('nama $i')),
          DataCell(Text('divisi $i')),
        ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: Scaffold(
          body: _dataTablePendapatan(),
        ));
  }
}
