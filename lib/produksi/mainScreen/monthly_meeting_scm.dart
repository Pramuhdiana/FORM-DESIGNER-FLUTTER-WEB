// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/produksi/mainScreen/CRUD/finishing.dart';
import 'package:form_designer/produksi/mainScreen/CRUD/polishing1.dart';
import 'package:form_designer/produksi/mainScreen/CRUD/stell1.dart';
import 'package:form_designer/produksi/mainScreen/siklus_saat_ini.dart';
import 'package:form_designer/produksi/mainScreen/siklus_sebelumnya.dart';
import 'package:form_designer/produksi/modelProduksi/produksi_model.dart';
import 'package:overlay_support/overlay_support.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MonthlyMeetingScm extends StatefulWidget {
  const MonthlyMeetingScm({super.key});
  @override
  State<MonthlyMeetingScm> createState() => _MonthlyMeetingScmState();
}

class _MonthlyMeetingScmState extends State<MonthlyMeetingScm>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  TextEditingController addSiklus = TextEditingController();
  bool isLoading = false;
  late TabController _tabController;
  String inputSearch = '';
  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
    // var now = DateTime.now();
    // String month = DateFormat('MMMM', 'id').format(now);
    // nowSiklus = month;
  }

  static const List<Tab> _tabs = [
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.looks_one),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Siklus Sebelunnya',
            maxLines: 2,
          ),
        ))
      ],
    )),
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.looks_two),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Siklus Saat Ini',
            maxLines: 2,
          ),
        ))
      ],
    )),
    Tab(
        icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.looks_3),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Siklus Bulan Depan',
            maxLines: 2,
          ),
        ))
      ],
    )),
  ];

  final List<Widget> _views = [
    const SiklusSebelumnya(),
    const SiklusSaatIni(),
    const Center(child: Text('Content of Tab Three')),
  ];
  var nowSiklus = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                leadingWidth: 320,
                // leading: Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(0.0),
                //       child: Text(
                //         "Bulan Saat Ini : $siklusSaatIini",
                //         style:
                //             const TextStyle(fontSize: 20, color: Colors.black),
                //       ),
                //     ),
                //   ],
                // ),
                elevation: 0,
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
              ),
              body: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: _views,
              )),
        ));
  }
}
