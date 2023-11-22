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

class ProduksiNewScreen extends StatefulWidget {
  const ProduksiNewScreen({super.key});
  @override
  State<ProduksiNewScreen> createState() => _ProduksiNewScreenState();
}

class _ProduksiNewScreenState extends State<ProduksiNewScreen>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  TextEditingController addSiklus = TextEditingController();
  bool isLoading = false;
  late TabController _tabController;
  String divisi = 'finishing';
  String inputSearch = '';
  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    nowSiklus = month;
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
    FinishingScreen(input: 'inputSearch'),
    const Poleshing1Screen(),
    const Stell1Screen(),
    const Center(child: Text('Content of Tab Two')),
    const Center(child: Text('Content of Tab Three')),
    const Center(child: Text('Content of Tab Three')),
  ];
  var nowSiklus = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: DefaultTabController(
          length: 6,
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                leadingWidth: 320,
                leading: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Siklus Saat Ini : $nowSiklus",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final dropdownFormKey = GlobalKey<FormState>();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                // title: const Text('Pilih Siklus'),
                                content: SizedBox(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Form(
                                          key: dropdownFormKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              DropdownSearch<String>(
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
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText: 'Pilih Siklus',
                                                    filled: true,
                                                    fillColor: Colors.black,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                                validator: (value) => value ==
                                                        null
                                                    ? "Siklus tidak boleh kosong"
                                                    : null,
                                                onChanged: (String? newValue) {
                                                  addSiklus.text = newValue!;
                                                },
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (dropdownFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        //? method untuk mengganti siklus
                                                        // await postSiklus();
                                                        Navigator.pop(context);
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder:
                                                        //             (c) =>
                                                        //                 const MainView()));

                                                        showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const AlertDialog(
                                                                  title: Text(
                                                                    'Siklus Berhasil Diterapkan',
                                                                  ),
                                                                ));
                                                        setState(() {
                                                          nowSiklus =
                                                              addSiklus.text;
                                                          sharedPreferences!
                                                              .setString(
                                                                  'siklusProduksi',
                                                                  addSiklus
                                                                      .text);
                                                        });
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Submit",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Lottie.asset("loadingJSON/icon_edit_black.json",
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
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
