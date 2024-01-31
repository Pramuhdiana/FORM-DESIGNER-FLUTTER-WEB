// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_batu.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
import 'package:form_designer/model/jenis_barang_model.dart';
import 'package:form_designer/model/modeller_model.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../api/api_constant.dart';
import '../global/global.dart';
import '../model/list_batu_model.dart';
import '../widgets/custom_loading.dart';

class ListDataModellerScreen extends StatefulWidget {
  const ListDataModellerScreen({super.key});
  @override
  State<ListDataModellerScreen> createState() => _ListDataModellerScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListDataModellerScreenState extends State<ListDataModellerScreen> {
  List<ModellerModel>? filterListDataModeller;
  List<ModellerModel>? _listDataModeller;
  TextEditingController controller = TextEditingController();
  TextEditingController kodeAkses = TextEditingController();
  bool sort = true;
  bool isKodeAkses = false;
  bool isLoading = false;
  int? page;
  int? limit;
  int _currentSortColumn = 0;
  int _rowsPerPage = 10;
  var nowSiklus = '';
  var kodeBulan = '';
  TextEditingController addSiklus = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? apiIdDataModeller = '';
  String? apiNoUrutDataModeller = '';
  String? valueBulanDesigner;

  String? kodeJenisBarang = '';
  String? kodeKualitasBarang = '';
  String? kodeWarna = '';
  String? kodeMarketing = '';

  @override
  initState() {
    super.initState();
    page = 0;
    limit = 20;
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    String kodeMonth = DateFormat('M', 'id').format(now);
    nowSiklus = month;
    kodeBulan = getHuruf(int.parse(kodeMonth));
    valueBulanDesigner = DateFormat('MMyy', 'id').format(now);
    _getData();
  }

  String getHuruf(int angka) {
    return String.fromCharCode(angka + 64);
  }

  _getData() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getDataModeller));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g = jsonResponse.map((data) => ModellerModel.fromJson(data)).toList();
      g.sort((a, b) => b.id!.compareTo(a.id as num));
      setState(() {
        _listDataModeller = g;
        filterListDataModeller = g;
        isLoading = true;
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
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

  @override
  Widget build(BuildContext context) {
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
          //change siklus
          leading: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text(
                    "Bulan $nowSiklus",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
          // ignore: avoid_unnecessary_containers
          title: Container(
            // width: MediaQuery.of(context).size.width * 0.3,
            child: CupertinoSearchTextField(
              placeholder: 'Search Anything...',
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              itemColor: Colors.black,
              // autofocus: false,
              controller: controller,
              backgroundColor: Colors.black12,
              // keyboardType: TextInputType.number,
              // focusNode: numberFocusNode,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                //fungsi search anyting
                _listDataModeller = filterListDataModeller!
                    .where((element) =>
                        element.kodeMarketing!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.kodeDesign!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.brand!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.marketing!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.jenisBatu!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.tema!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.modeller!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.bulan!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.designer!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.id!.toString().contains(value.toLowerCase()))
                    .toList();

                setState(() {});
              },
            ),
          ),
        ),

        body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 26),
                child: const Text(
                  'List Data Modeller',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              sharedPreferences!.getString('divisi') == 'admin' ||
                      sharedPreferences!.getString('divisi') == 'scm'
                  ? FloatingActionButton.extended(
                      onPressed: () async {
                        kodeJenisBarang = '';
                        kodeWarna = '';
                        kodeKualitasBarang = '';
                        try {
                          final response = await http.get(Uri.parse(
                              ApiConstants.baseUrl +
                                  ApiConstants.getDataModeller));
                          if (response.statusCode == 200) {
                            List jsonResponse = json.decode(response.body);

                            var g = jsonResponse
                                .map((data) => ModellerModel.fromJson(data))
                                .toList();
                            apiIdDataModeller = g.last.id.toString();
                            var filterByMonth = g
                                .where((element) =>
                                    element.bulan.toString().toLowerCase() ==
                                    nowSiklus.toString().toLowerCase())
                                .toList();
                            var filterBynoUrut = filterByMonth
                                .where((element) => element.noUrutBulan! > 0)
                                .toList();
                            print(filterBynoUrut);
                            apiNoUrutDataModeller = filterByMonth.isEmpty
                                ? '0'.padLeft(3, '0')
                                : filterBynoUrut.isEmpty
                                    ? '0'.padLeft(3, '0')
                                    : filterBynoUrut.last.noUrutBulan
                                        .toString()
                                        .padLeft(3, '0');
                            print(apiNoUrutDataModeller);
                          } else {
                            throw Exception('Unexpected error occured!');
                          }
                        } catch (c) {
                          print('err msg : get data modeller $c');
                        }
                        sharedPreferences!.getString('divisi') == 'admin'
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String? jenisBatu;
                                  String? warnaEmas;
                                  String? pilihMarketing;
                                  String? statusSPK;
                                  String? brand;
                                  final _formKey = GlobalKey<FormState>();
                                  TextEditingController temaDataModeller =
                                      TextEditingController();
                                  TextEditingController kodeDesignDataModeller =
                                      TextEditingController();
                                  TextEditingController idDataModeller =
                                      TextEditingController();
                                  TextEditingController noUrutDataModeller =
                                      TextEditingController();
                                  TextEditingController
                                      kodeMarketingDataModeller =
                                      TextEditingController();
                                  TextEditingController marketingDataModeller =
                                      TextEditingController();
                                  TextEditingController
                                      namaDesignerDataModeller =
                                      TextEditingController();
                                  TextEditingController
                                      namaModellerDataModeller =
                                      TextEditingController();
                                  TextEditingController keteranganDataModeller =
                                      TextEditingController();
                                  TextEditingController jo =
                                      TextEditingController();
                                  RoundedLoadingButtonController btnController =
                                      RoundedLoadingButtonController();
                                  TextEditingController jenisBarang =
                                      TextEditingController();
                                  idDataModeller.text = apiIdDataModeller!;
                                  noUrutDataModeller.text =
                                      apiNoUrutDataModeller!;
                                  print(statusSPK);

                                  return StatefulBuilder(
                                      builder:
                                          (context, setState) => AlertDialog(
                                                content: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: <Widget>[
                                                    // Positioned(
                                                    //   right: -47.0,
                                                    //   top: -47.0,
                                                    //   child: InkResponse(
                                                    //     onTap: () {
                                                    //       Navigator.of(context).pop();
                                                    //     },
                                                    //     child: const CircleAvatar(
                                                    //       backgroundColor: Colors.red,
                                                    //       child: Icon(Icons.close),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                readOnly: statusSPK ==
                                                                        'NO'
                                                                    ? true
                                                                    : statusSPK ==
                                                                            null
                                                                        ? true
                                                                        : false,
                                                                style: const TextStyle(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                controller:
                                                                    kodeMarketingDataModeller,
                                                                decoration:
                                                                    InputDecoration(
                                                                  // hintText: "example: Cahaya Sanivokasi",
                                                                  labelText:
                                                                      "Kode Marketing",
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0)),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Wajib diisi *';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              const Text(
                                                                'Pilih terlebih dahulu NO atau RO',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            child: Form(
                                                              key: _formKey,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <Widget>[
                                                                  //! status memilih no atau ro
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            color: statusSPK != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                            border: Border.all(
                                                                              color: Colors.black38,
                                                                              // width:
                                                                              //     3
                                                                            ), //border of dropdown button
                                                                            borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                            boxShadow: const <BoxShadow>[]),
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                            child: DropdownButton(
                                                                              value: statusSPK,
                                                                              items: const [
                                                                                //add items in the dropdown
                                                                                DropdownMenuItem(
                                                                                  value: "NO",
                                                                                  child: Text("NO"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "RO",
                                                                                  child: Text("RO"),
                                                                                ),
                                                                              ],
                                                                              hint: const Text('NO Atau RO'),
                                                                              onChanged: (value) {
                                                                                statusSPK = value;
                                                                                print("You have selected $value");
                                                                                value == 'RO' ? noUrutDataModeller.text = '' : noUrutDataModeller.text = (int.parse(apiNoUrutDataModeller!) + 1).toString().padLeft(3, '0');
                                                                                value == 'NO' ? kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing' : kodeMarketingDataModeller.text = '';
                                                                                setState(() => statusSPK);
                                                                              },
                                                                              icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                              iconEnabledColor: Colors.black, //Icon color
                                                                              style: const TextStyle(
                                                                                color: Colors.black, //Font color
                                                                                // fontSize:
                                                                                //     15 //font size on dropdown button
                                                                              ),

                                                                              dropdownColor: Colors.white, //dropdown background color
                                                                              underline: Container(), //remove underline
                                                                              isExpanded: true, //make true to make width 100%
                                                                            ))),
                                                                  ),
                                                                  //? id
                                                                  Container(
                                                                    // width: MediaQuery.of(context).size.width *
                                                                    //     0.25,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              TextFormField(
                                                                            readOnly:
                                                                                true,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold),
                                                                            textInputAction:
                                                                                TextInputAction.next,
                                                                            controller:
                                                                                idDataModeller,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              // hintText: "example: Cahaya Sanivokasi",
                                                                              labelText: "ID",
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              TextFormField(
                                                                            readOnly:
                                                                                true,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold),
                                                                            textInputAction:
                                                                                TextInputAction.next,
                                                                            controller:
                                                                                noUrutDataModeller,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              // hintText: "example: Cahaya Sanivokasi",
                                                                              labelText: "No Urut",
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  //Kode Design
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      controller:
                                                                          kodeDesignDataModeller,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        // hintText: "example: Cahaya Sanivokasi",
                                                                        labelText:
                                                                            "Kode Design",
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  //Jenis Batu
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            color: jenisBatu != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                            border: Border.all(
                                                                              color: Colors.black38,
                                                                              // width:
                                                                              //     3
                                                                            ), //border of dropdown button
                                                                            borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                            boxShadow: const <BoxShadow>[
                                                                              //apply shadow on Dropdown button
                                                                              // BoxShadow(
                                                                              //     color: Color.fromRGBO(
                                                                              //         0,
                                                                              //         0,
                                                                              //         0,
                                                                              //         0.57), //shadow for button
                                                                              //     blurRadius:
                                                                              //         5) //blur radius of shadow
                                                                            ]),
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                            child: DropdownButton(
                                                                              value: jenisBatu,
                                                                              items: const [
                                                                                //add items in the dropdown
                                                                                DropdownMenuItem(
                                                                                  value: "VVS",
                                                                                  child: Text("VVS"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "VS",
                                                                                  child: Text("VS"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "SI",
                                                                                  child: Text("SI"),
                                                                                )
                                                                              ],
                                                                              hint: const Text('Jenis Batu'),
                                                                              onChanged: (value) {
                                                                                jenisBatu = value;
                                                                                if (statusSPK == 'NO') {
                                                                                  jenisBatu == 'SI'
                                                                                      ? kodeKualitasBarang = 'I'
                                                                                      : jenisBatu == 'VS'
                                                                                          ? kodeKualitasBarang = 'E'
                                                                                          : kodeKualitasBarang = 'A';
                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                } else {}

                                                                                setState(() => kodeMarketingDataModeller);
                                                                              },
                                                                              icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                              iconEnabledColor: Colors.black, //Icon color
                                                                              style: const TextStyle(
                                                                                color: Colors.black, //Font color
                                                                                // fontSize:
                                                                                //     15 //font size on dropdown button
                                                                              ),

                                                                              dropdownColor: Colors.white, //dropdown background color
                                                                              underline: Container(), //remove underline
                                                                              isExpanded: true, //make true to make width 100%
                                                                            ))),
                                                                  ),

                                                                  // warna emas
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 8,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                          color: warnaEmas != null
                                                                              ? const Color.fromARGB(255, 8, 209, 69)
                                                                              : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black38,
                                                                            // width:
                                                                            //     3
                                                                          ), //border of dropdown button
                                                                          borderRadius:
                                                                              BorderRadius.circular(0), //border raiuds of dropdown button
                                                                        ),
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                            child: DropdownButton(
                                                                              value: warnaEmas,
                                                                              items: const [
                                                                                //add items in the dropdown
                                                                                DropdownMenuItem(
                                                                                  value: "WG",
                                                                                  child: Text("WG"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "RG",
                                                                                  child: Text("RG"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "MIX",
                                                                                  child: Text("MIX"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "MIX WHITE,YELLOW",
                                                                                  child: Text("MIX WHITE,YELLOW"),
                                                                                )
                                                                              ],
                                                                              hint: const Text('Warna Emas'),
                                                                              onChanged: (value) {
                                                                                warnaEmas = value;
                                                                                if (statusSPK == 'NO') {
                                                                                  warnaEmas == 'WG'
                                                                                      ? kodeWarna = '0'
                                                                                      : warnaEmas == 'RG'
                                                                                          ? kodeWarna = '2'
                                                                                          : warnaEmas == 'MIX'
                                                                                              ? kodeWarna = '4'
                                                                                              : warnaEmas == 'MIX WHITE,YELLOW'
                                                                                                  ? kodeWarna = '5'
                                                                                                  : kodeKualitasBarang = '0';

                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                } else {}

                                                                                setState(() => kodeMarketingDataModeller);
                                                                              },
                                                                              icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                              iconEnabledColor: Colors.black, //Icon color
                                                                              style: const TextStyle(
                                                                                color: Colors.black, //Font color
                                                                                // fontSize:
                                                                                //     15 //font size on dropdown button
                                                                              ),

                                                                              dropdownColor: Colors.white, //dropdown background color
                                                                              underline: Container(), //remove underline
                                                                              isExpanded: true, //make true to make width 100%
                                                                            ))),
                                                                  ),

                                                                  statusSPK ==
                                                                          null
                                                                      ? const SizedBox()
                                                                      : statusSPK !=
                                                                              'NO'
                                                                          ? const SizedBox()
                                                                          : Container(
                                                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                                                              child: DropdownSearch<JenisbarangModel>(
                                                                                asyncItems: (String? filter) => getListJenisbarang(filter),
                                                                                popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                                                                                  showSelectedItems: true,
                                                                                  itemBuilder: _listJenisbarang,
                                                                                  showSearchBox: true,
                                                                                ),
                                                                                compareFn: (item, sItem) => item.id == sItem.id,
                                                                                onChanged: (item) {
                                                                                  // setState(() {
                                                                                  jenisBarang.text = item!.nama;
                                                                                  kodeJenisBarang = item.kodeBarang;
                                                                                  // });
                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';

                                                                                  setState(() => kodeMarketingDataModeller.text);
                                                                                },
                                                                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                                  dropdownSearchDecoration: InputDecoration(
                                                                                    labelText: "Jenis Barang",
                                                                                    filled: true,
                                                                                    fillColor: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      controller:
                                                                          temaDataModeller,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            "Tema / Project",
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  // MARKETING
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            8,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                          color: pilihMarketing != null
                                                                              ? const Color.fromARGB(255, 8, 209, 69)
                                                                              : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black38,
                                                                            // width:
                                                                            //     3
                                                                          ), //border of dropdown button
                                                                          borderRadius:
                                                                              BorderRadius.circular(0), //border raiuds of dropdown button
                                                                        ),
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                            child: DropdownButton(
                                                                              value: pilihMarketing,
                                                                              items: const [
                                                                                //add items in the dropdown
                                                                                DropdownMenuItem(
                                                                                  value: "N",
                                                                                  child: Text("JONATHAN"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "E",
                                                                                  child: Text("STEPHANIE"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "T",
                                                                                  child: Text("ADIT"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "K",
                                                                                  child: Text("ERICK"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "I",
                                                                                  child: Text("FEBRI / BHESTADI"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "O",
                                                                                  child: Text("RUDIANTO"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "A",
                                                                                  child: Text("RITA"),
                                                                                ),
                                                                              ],
                                                                              hint: const Text('Marketing'),
                                                                              onChanged: (value) {
                                                                                pilihMarketing = value;
                                                                                kodeMarketing = value;
                                                                                if (statusSPK == 'NO') {
                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                } else {}

                                                                                setState(() => kodeMarketingDataModeller);
                                                                              },
                                                                              icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                              iconEnabledColor: Colors.black, //Icon color
                                                                              style: const TextStyle(
                                                                                color: Colors.black, //Font color
                                                                                // fontSize:
                                                                                //     15 //font size on dropdown button
                                                                              ),

                                                                              dropdownColor: Colors.white, //dropdown background color
                                                                              underline: Container(), //remove underline
                                                                              isExpanded: true, //make true to make width 100%
                                                                            ))),
                                                                  ),

                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            color: brand != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                            border: Border.all(
                                                                              color: Colors.black38,
                                                                              // width:
                                                                              //     3
                                                                            ), //border of dropdown button
                                                                            borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                            boxShadow: const <BoxShadow>[
                                                                              //apply shadow on Dropdown button
                                                                              // BoxShadow(
                                                                              //     color: Color.fromRGBO(
                                                                              //         0,
                                                                              //         0,
                                                                              //         0,
                                                                              //         0.57), //shadow for button
                                                                              //     blurRadius:
                                                                              //         5) //blur radius of shadow
                                                                            ]),
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                            child: DropdownButton(
                                                                              value: brand,
                                                                              items: const [
                                                                                //add items in the dropdown
                                                                                DropdownMenuItem(
                                                                                  value: "PARVA",
                                                                                  child: Text("PARVA"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "METIER",
                                                                                  child: Text("METIER"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "BELI BERLIAN",
                                                                                  child: Text("BELI BERLIAN"),
                                                                                ),
                                                                                DropdownMenuItem(
                                                                                  value: "FINE",
                                                                                  child: Text("FINE"),
                                                                                )
                                                                              ],
                                                                              hint: const Text('Brand'),
                                                                              onChanged: (value) async {
                                                                                brand = value;
                                                                                var kodeBrand = '';
                                                                                if (brand == 'PARVA') {
                                                                                  kodeBrand = '0';
                                                                                  kodeJenisBarang = '$kodeJenisBarang$kodeBrand';
                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                } else if (brand == 'METIER') {
                                                                                  kodeBrand = 'M';
                                                                                  kodeJenisBarang = '$kodeBrand$kodeJenisBarang';

                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                } else if (brand == 'BELI BERLIAN') {
                                                                                  kodeBrand = 'B';
                                                                                  kodeJenisBarang = '$kodeBrand$kodeJenisBarang';

                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                } else {
                                                                                  kodeBrand = '0';
                                                                                  kodeJenisBarang = '$kodeJenisBarang$kodeBrand';
                                                                                  kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                }

                                                                                setState(() => brand);
                                                                              },
                                                                              icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                              iconEnabledColor: Colors.black, //Icon color
                                                                              style: const TextStyle(
                                                                                color: Colors.black, //Font color
                                                                                // fontSize:
                                                                                //     15 //font size on dropdown button
                                                                              ),

                                                                              dropdownColor: Colors.white, //dropdown background color
                                                                              underline: Container(), //remove underline
                                                                              isExpanded: true, //make true to make width 100%
                                                                            ))),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      controller:
                                                                          namaDesignerDataModeller,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            "Nama Designer",
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      controller:
                                                                          namaModellerDataModeller,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            "Nama Modeller",
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      controller:
                                                                          keteranganDataModeller,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        // hintText: "example: Cahaya Sanivokasi",
                                                                        labelText:
                                                                            "Keterangan",
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      controller:
                                                                          jo,
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Wajib diisi *';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      decoration:
                                                                          InputDecoration(
                                                                        // hintText: "example: Cahaya Sanivokasi",
                                                                        labelText:
                                                                            "JO",

                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          250,
                                                                      child: CustomLoadingButton(
                                                                          controller: btnController,
                                                                          child: const Text("Simpan Data"),
                                                                          onPressed: () async {
                                                                            if (_formKey.currentState!.validate()) {
                                                                              _formKey.currentState!.save();
                                                                              Future.delayed(const Duration(milliseconds: 10)).then((value) async {
                                                                                btnController.success();
                                                                                Map<String, dynamic> body = {
                                                                                  'kodeDesign': kodeDesignDataModeller.text,
                                                                                  'jenisBatu': jenisBatu,
                                                                                  'bulan': nowSiklus,
                                                                                  'tema': temaDataModeller.text,
                                                                                  'kodeBulan': kodeBulan,
                                                                                  'noUrutBulan': noUrutDataModeller.text,
                                                                                  'kodeMarketing': kodeMarketingDataModeller.text,
                                                                                  'status': statusSPK,
                                                                                  'marketing': marketingDataModeller.text,
                                                                                  'brand': brand,
                                                                                  'designer': namaDesignerDataModeller.text,
                                                                                  'modeller': namaModellerDataModeller.text,
                                                                                  'keterangan': keteranganDataModeller.text,
                                                                                  'jo': jo.text
                                                                                };
                                                                                final response = await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.postDataModeller), body: body);
                                                                                print(response.body);
                                                                                Future.delayed(const Duration(milliseconds: 10)).then((value) {
                                                                                  btnController.reset(); //reset
                                                                                  response.statusCode != 200
                                                                                      ? showSimpleNotification(const Text('Tambah Data Modeller Gagal'), background: Colors.red, duration: const Duration(seconds: 10))
                                                                                      : showSimpleNotification(
                                                                                          const Text('Tambah Data Modeller Berhasil'),
                                                                                          background: Colors.green,
                                                                                          duration: const Duration(seconds: 1),
                                                                                        );
                                                                                });
                                                                                Navigator.push(context, MaterialPageRoute(builder: (c) => MainViewScm(col: 1)));
                                                                              });
                                                                            } else {
                                                                              btnController.error();
                                                                              Future.delayed(const Duration(seconds: 1)).then((value) {
                                                                                btnController.reset(); //reset
                                                                              });
                                                                            }
                                                                          }),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    Positioned(
                                                      right: -47.0,
                                                      top: -47.0,
                                                      child: InkResponse(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const CircleAvatar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          child:
                                                              Icon(Icons.close),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                })
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Positioned(
                                          right: -47.0,
                                          top: -47.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(Icons.close),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 190,
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 10),
                                                  child: Text(
                                                      'Masukan Kode Akses'),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    autofocus: true,
                                                    obscureText: true,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller: kodeAkses,
                                                    validator: (value) {
                                                      if (value! != aksesKode) {
                                                        return 'Kode akses salah';
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (value) {
                                                      isKodeAkses = true;
                                                      kodeAkses.text ==
                                                              aksesKode
                                                          ? isKodeAkses = true
                                                          : isKodeAkses = false;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: "Kode Akses",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  height: 50,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: ElevatedButton(
                                                    child: const Text("Submit"),
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        setState(() {
                                                          Navigator.of(context)
                                                              .pop();
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                String?
                                                                    jenisBatu;
                                                                String?
                                                                    warnaEmas;
                                                                String?
                                                                    pilihMarketing;
                                                                String?
                                                                    statusSPK;
                                                                String? brand;
                                                                final _formKey =
                                                                    GlobalKey<
                                                                        FormState>();
                                                                TextEditingController
                                                                    temaDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    kodeDesignDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    idDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    noUrutDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    kodeMarketingDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    marketingDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    namaDesignerDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    namaModellerDataModeller =
                                                                    TextEditingController();
                                                                TextEditingController
                                                                    keteranganDataModeller =
                                                                    TextEditingController();
                                                                RoundedLoadingButtonController
                                                                    btnController =
                                                                    RoundedLoadingButtonController();
                                                                TextEditingController
                                                                    jenisBarang =
                                                                    TextEditingController();
                                                                idDataModeller
                                                                        .text =
                                                                    apiIdDataModeller!;
                                                                noUrutDataModeller
                                                                        .text =
                                                                    apiNoUrutDataModeller!;
                                                                print(
                                                                    statusSPK);

                                                                return StatefulBuilder(
                                                                    builder: (context,
                                                                            setState) =>
                                                                        AlertDialog(
                                                                          content:
                                                                              Stack(
                                                                            clipBehavior:
                                                                                Clip.none,
                                                                            children: <Widget>[
                                                                              // Positioned(
                                                                              //   right: -47.0,
                                                                              //   top: -47.0,
                                                                              //   child: InkResponse(
                                                                              //     onTap: () {
                                                                              //       Navigator.of(context).pop();
                                                                              //     },
                                                                              //     child: const CircleAvatar(
                                                                              //       backgroundColor: Colors.red,
                                                                              //       child: Icon(Icons.close),
                                                                              //     ),
                                                                              //   ),
                                                                              // ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        TextFormField(
                                                                                          readOnly: statusSPK == 'NO'
                                                                                              ? true
                                                                                              : statusSPK == null
                                                                                                  ? true
                                                                                                  : false,
                                                                                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                          textInputAction: TextInputAction.next,
                                                                                          controller: kodeMarketingDataModeller,
                                                                                          decoration: InputDecoration(
                                                                                            // hintText: "example: Cahaya Sanivokasi",
                                                                                            labelText: "Kode Marketing",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                          ),
                                                                                          validator: (value) {
                                                                                            if (value!.isEmpty) {
                                                                                              return 'Wajib diisi *';
                                                                                            }
                                                                                            return null;
                                                                                          },
                                                                                        ),
                                                                                        const Text(
                                                                                          'Pilih terlebih dahulu NO atau RO',
                                                                                          style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 12),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: SingleChildScrollView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      child: Form(
                                                                                        key: _formKey,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: <Widget>[
                                                                                            //! status memilih no atau ro
                                                                                            Container(
                                                                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                              child: DecoratedBox(
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: statusSPK != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                                                      border: Border.all(
                                                                                                        color: Colors.black38,
                                                                                                        // width:
                                                                                                        //     3
                                                                                                      ), //border of dropdown button
                                                                                                      borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                                                      boxShadow: const <BoxShadow>[]),
                                                                                                  child: Padding(
                                                                                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                                      child: DropdownButton(
                                                                                                        value: statusSPK,
                                                                                                        items: const [
                                                                                                          //add items in the dropdown
                                                                                                          DropdownMenuItem(
                                                                                                            value: "NO",
                                                                                                            child: Text("NO"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "RO",
                                                                                                            child: Text("RO"),
                                                                                                          ),
                                                                                                        ],
                                                                                                        hint: const Text('NO Atau RO'),
                                                                                                        onChanged: (value) {
                                                                                                          statusSPK = value;
                                                                                                          print("You have selected $value");
                                                                                                          value == 'RO' ? noUrutDataModeller.text = '' : noUrutDataModeller.text = (int.parse(apiNoUrutDataModeller!) + 1).toString().padLeft(3, '0');
                                                                                                          value == 'NO' ? kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing' : kodeMarketingDataModeller.text = '';
                                                                                                          setState(() => statusSPK);
                                                                                                        },
                                                                                                        icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                                                        iconEnabledColor: Colors.black, //Icon color
                                                                                                        style: const TextStyle(
                                                                                                          color: Colors.black, //Font color
                                                                                                          // fontSize:
                                                                                                          //     15 //font size on dropdown button
                                                                                                        ),

                                                                                                        dropdownColor: Colors.white, //dropdown background color
                                                                                                        underline: Container(), //remove underline
                                                                                                        isExpanded: true, //make true to make width 100%
                                                                                                      ))),
                                                                                            ),
                                                                                            //? id
                                                                                            Container(
                                                                                              // width: MediaQuery.of(context).size.width *
                                                                                              //     0.25,
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  SizedBox(
                                                                                                    width: 100,
                                                                                                    child: TextFormField(
                                                                                                      readOnly: true,
                                                                                                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                      textInputAction: TextInputAction.next,
                                                                                                      controller: idDataModeller,
                                                                                                      decoration: InputDecoration(
                                                                                                        // hintText: "example: Cahaya Sanivokasi",
                                                                                                        labelText: "ID",
                                                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 100,
                                                                                                    child: TextFormField(
                                                                                                      readOnly: true,
                                                                                                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                      textInputAction: TextInputAction.next,
                                                                                                      controller: noUrutDataModeller,
                                                                                                      decoration: InputDecoration(
                                                                                                        // hintText: "example: Cahaya Sanivokasi",
                                                                                                        labelText: "No Urut",
                                                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),

                                                                                            //Kode Design
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: TextFormField(
                                                                                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                textInputAction: TextInputAction.next,
                                                                                                controller: kodeDesignDataModeller,
                                                                                                decoration: InputDecoration(
                                                                                                  // hintText: "example: Cahaya Sanivokasi",
                                                                                                  labelText: "Kode Design",
                                                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),

                                                                                            //Jenis Batu
                                                                                            Container(
                                                                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                              child: DecoratedBox(
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: jenisBatu != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                                                      border: Border.all(
                                                                                                        color: Colors.black38,
                                                                                                        // width:
                                                                                                        //     3
                                                                                                      ), //border of dropdown button
                                                                                                      borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                                                      boxShadow: const <BoxShadow>[
                                                                                                        //apply shadow on Dropdown button
                                                                                                        // BoxShadow(
                                                                                                        //     color: Color.fromRGBO(
                                                                                                        //         0,
                                                                                                        //         0,
                                                                                                        //         0,
                                                                                                        //         0.57), //shadow for button
                                                                                                        //     blurRadius:
                                                                                                        //         5) //blur radius of shadow
                                                                                                      ]),
                                                                                                  child: Padding(
                                                                                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                                      child: DropdownButton(
                                                                                                        value: jenisBatu,
                                                                                                        items: const [
                                                                                                          //add items in the dropdown
                                                                                                          DropdownMenuItem(
                                                                                                            value: "VVS",
                                                                                                            child: Text("VVS"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "VS",
                                                                                                            child: Text("VS"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "SI",
                                                                                                            child: Text("SI"),
                                                                                                          )
                                                                                                        ],
                                                                                                        hint: const Text('Jenis Batu'),
                                                                                                        onChanged: (value) {
                                                                                                          jenisBatu = value;
                                                                                                          if (statusSPK == 'NO') {
                                                                                                            jenisBatu == 'SI'
                                                                                                                ? kodeKualitasBarang = 'I'
                                                                                                                : jenisBatu == 'VS'
                                                                                                                    ? kodeKualitasBarang = 'E'
                                                                                                                    : kodeKualitasBarang = 'A';
                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                                          } else {}

                                                                                                          setState(() => kodeMarketingDataModeller);
                                                                                                        },
                                                                                                        icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                                                        iconEnabledColor: Colors.black, //Icon color
                                                                                                        style: const TextStyle(
                                                                                                          color: Colors.black, //Font color
                                                                                                          // fontSize:
                                                                                                          //     15 //font size on dropdown button
                                                                                                        ),

                                                                                                        dropdownColor: Colors.white, //dropdown background color
                                                                                                        underline: Container(), //remove underline
                                                                                                        isExpanded: true, //make true to make width 100%
                                                                                                      ))),
                                                                                            ),

                                                                                            // warna emas
                                                                                            Container(
                                                                                              padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                                                                                              child: DecoratedBox(
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: warnaEmas != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                                                    border: Border.all(
                                                                                                      color: Colors.black38,
                                                                                                      // width:
                                                                                                      //     3
                                                                                                    ), //border of dropdown button
                                                                                                    borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                                      child: DropdownButton(
                                                                                                        value: warnaEmas,
                                                                                                        items: const [
                                                                                                          //add items in the dropdown
                                                                                                          DropdownMenuItem(
                                                                                                            value: "WG",
                                                                                                            child: Text("WG"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "RG",
                                                                                                            child: Text("RG"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "MIX",
                                                                                                            child: Text("MIX"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "MIX WHITE,YELLOW",
                                                                                                            child: Text("MIX WHITE,YELLOW"),
                                                                                                          )
                                                                                                        ],
                                                                                                        hint: const Text('Warna Emas'),
                                                                                                        onChanged: (value) {
                                                                                                          warnaEmas = value;
                                                                                                          if (statusSPK == 'NO') {
                                                                                                            warnaEmas == 'WG'
                                                                                                                ? kodeWarna = '0'
                                                                                                                : warnaEmas == 'RG'
                                                                                                                    ? kodeWarna = '2'
                                                                                                                    : warnaEmas == 'MIX'
                                                                                                                        ? kodeWarna = '4'
                                                                                                                        : warnaEmas == 'MIX WHITE,YELLOW'
                                                                                                                            ? kodeWarna = '5'
                                                                                                                            : kodeKualitasBarang = '0';

                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                                          } else {}

                                                                                                          setState(() => kodeMarketingDataModeller);
                                                                                                        },
                                                                                                        icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                                                        iconEnabledColor: Colors.black, //Icon color
                                                                                                        style: const TextStyle(
                                                                                                          color: Colors.black, //Font color
                                                                                                          // fontSize:
                                                                                                          //     15 //font size on dropdown button
                                                                                                        ),

                                                                                                        dropdownColor: Colors.white, //dropdown background color
                                                                                                        underline: Container(), //remove underline
                                                                                                        isExpanded: true, //make true to make width 100%
                                                                                                      ))),
                                                                                            ),

                                                                                            statusSPK == null
                                                                                                ? const SizedBox()
                                                                                                : statusSPK != 'NO'
                                                                                                    ? const SizedBox()
                                                                                                    : Container(
                                                                                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                                        child: DropdownSearch<JenisbarangModel>(
                                                                                                          asyncItems: (String? filter) => getListJenisbarang(filter),
                                                                                                          popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                                                                                                            showSelectedItems: true,
                                                                                                            itemBuilder: _listJenisbarang,
                                                                                                            showSearchBox: true,
                                                                                                          ),
                                                                                                          compareFn: (item, sItem) => item.id == sItem.id,
                                                                                                          onChanged: (item) {
                                                                                                            // setState(() {
                                                                                                            jenisBarang.text = item!.nama;
                                                                                                            kodeJenisBarang = item.kodeBarang;
                                                                                                            // });
                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';

                                                                                                            setState(() => kodeMarketingDataModeller.text);
                                                                                                          },
                                                                                                          dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                                                            dropdownSearchDecoration: InputDecoration(
                                                                                                              labelText: "Jenis Barang",
                                                                                                              filled: true,
                                                                                                              fillColor: Colors.white,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: TextFormField(
                                                                                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                textInputAction: TextInputAction.next,
                                                                                                controller: temaDataModeller,
                                                                                                decoration: InputDecoration(
                                                                                                  labelText: "Tema / Project",
                                                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),

                                                                                            // MARKETING
                                                                                            Container(
                                                                                              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                                                                                              child: DecoratedBox(
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: pilihMarketing != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                                                    border: Border.all(
                                                                                                      color: Colors.black38,
                                                                                                      // width:
                                                                                                      //     3
                                                                                                    ), //border of dropdown button
                                                                                                    borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                                      child: DropdownButton(
                                                                                                        value: pilihMarketing,
                                                                                                        items: const [
                                                                                                          //add items in the dropdown
                                                                                                          DropdownMenuItem(
                                                                                                            value: "N",
                                                                                                            child: Text("JONATHAN"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "E",
                                                                                                            child: Text("STEPHANIE"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "T",
                                                                                                            child: Text("ADIT"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "K",
                                                                                                            child: Text("ERICK"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "I",
                                                                                                            child: Text("FEBRI / BHESTADI"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "O",
                                                                                                            child: Text("RUDIANTO"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "A",
                                                                                                            child: Text("RITA"),
                                                                                                          ),
                                                                                                        ],
                                                                                                        hint: const Text('Marketing'),
                                                                                                        onChanged: (value) {
                                                                                                          pilihMarketing = value;
                                                                                                          kodeMarketing = value;
                                                                                                          if (statusSPK == 'NO') {
                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                                          } else {}

                                                                                                          setState(() => kodeMarketingDataModeller);
                                                                                                        },
                                                                                                        icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                                                        iconEnabledColor: Colors.black, //Icon color
                                                                                                        style: const TextStyle(
                                                                                                          color: Colors.black, //Font color
                                                                                                          // fontSize:
                                                                                                          //     15 //font size on dropdown button
                                                                                                        ),

                                                                                                        dropdownColor: Colors.white, //dropdown background color
                                                                                                        underline: Container(), //remove underline
                                                                                                        isExpanded: true, //make true to make width 100%
                                                                                                      ))),
                                                                                            ),

                                                                                            Container(
                                                                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                              child: DecoratedBox(
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: brand != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                                                      border: Border.all(
                                                                                                        color: Colors.black38,
                                                                                                        // width:
                                                                                                        //     3
                                                                                                      ), //border of dropdown button
                                                                                                      borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
                                                                                                      boxShadow: const <BoxShadow>[
                                                                                                        //apply shadow on Dropdown button
                                                                                                        // BoxShadow(
                                                                                                        //     color: Color.fromRGBO(
                                                                                                        //         0,
                                                                                                        //         0,
                                                                                                        //         0,
                                                                                                        //         0.57), //shadow for button
                                                                                                        //     blurRadius:
                                                                                                        //         5) //blur radius of shadow
                                                                                                      ]),
                                                                                                  child: Padding(
                                                                                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                                      child: DropdownButton(
                                                                                                        value: brand,
                                                                                                        items: const [
                                                                                                          //add items in the dropdown
                                                                                                          DropdownMenuItem(
                                                                                                            value: "PARVA",
                                                                                                            child: Text("PARVA"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "METIER",
                                                                                                            child: Text("METIER"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "BELI BERLIAN",
                                                                                                            child: Text("BELI BERLIAN"),
                                                                                                          ),
                                                                                                          DropdownMenuItem(
                                                                                                            value: "FINE",
                                                                                                            child: Text("FINE"),
                                                                                                          )
                                                                                                        ],
                                                                                                        hint: const Text('Brand'),
                                                                                                        onChanged: (value) async {
                                                                                                          brand = value;
                                                                                                          var kodeBrand = '';
                                                                                                          if (brand == 'PARVA') {
                                                                                                            kodeBrand = '0';
                                                                                                            kodeJenisBarang = '$kodeJenisBarang$kodeBrand';
                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                                          } else if (brand == 'METIER') {
                                                                                                            kodeBrand = 'M';
                                                                                                            kodeJenisBarang = '$kodeBrand$kodeJenisBarang';

                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                                          } else if (brand == 'BELI BERLIAN') {
                                                                                                            kodeBrand = 'B';
                                                                                                            kodeJenisBarang = '$kodeBrand$kodeJenisBarang';

                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                                          } else {
                                                                                                            kodeBrand = '0';
                                                                                                            kodeJenisBarang = '$kodeJenisBarang$kodeBrand';
                                                                                                            kodeMarketingDataModeller.text = '$kodeJenisBarang$valueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                                                                          }

                                                                                                          setState(() => brand);
                                                                                                        },
                                                                                                        icon: const Padding(padding: EdgeInsets.only(left: 20), child: Icon(Icons.arrow_circle_down_sharp)),
                                                                                                        iconEnabledColor: Colors.black, //Icon color
                                                                                                        style: const TextStyle(
                                                                                                          color: Colors.black, //Font color
                                                                                                          // fontSize:
                                                                                                          //     15 //font size on dropdown button
                                                                                                        ),

                                                                                                        dropdownColor: Colors.white, //dropdown background color
                                                                                                        underline: Container(), //remove underline
                                                                                                        isExpanded: true, //make true to make width 100%
                                                                                                      ))),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: TextFormField(
                                                                                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                textInputAction: TextInputAction.next,
                                                                                                controller: namaDesignerDataModeller,
                                                                                                decoration: InputDecoration(
                                                                                                  labelText: "Nama Designer",
                                                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: TextFormField(
                                                                                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                textInputAction: TextInputAction.next,
                                                                                                controller: namaModellerDataModeller,
                                                                                                decoration: InputDecoration(
                                                                                                  labelText: "Nama Modeller",
                                                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: TextFormField(
                                                                                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                textInputAction: TextInputAction.next,
                                                                                                controller: keteranganDataModeller,
                                                                                                decoration: InputDecoration(
                                                                                                  // hintText: "example: Cahaya Sanivokasi",
                                                                                                  labelText: "Keterangan",
                                                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: SizedBox(
                                                                                                width: 250,
                                                                                                child: CustomLoadingButton(
                                                                                                    controller: btnController,
                                                                                                    child: const Text("Simpan Data"),
                                                                                                    onPressed: () async {
                                                                                                      if (_formKey.currentState!.validate()) {
                                                                                                        _formKey.currentState!.save();
                                                                                                        Future.delayed(const Duration(milliseconds: 10)).then((value) async {
                                                                                                          btnController.success();
                                                                                                          Map<String, dynamic> body = {
                                                                                                            'kodeDesign': kodeDesignDataModeller.text,
                                                                                                            'jenisBatu': jenisBatu,
                                                                                                            'bulan': nowSiklus,
                                                                                                            'tema': temaDataModeller.text,
                                                                                                            'kodeBulan': kodeBulan,
                                                                                                            'noUrutBulan': noUrutDataModeller.text,
                                                                                                            'kodeMarketing': kodeMarketingDataModeller.text,
                                                                                                            'status': statusSPK,
                                                                                                            'marketing': marketingDataModeller.text,
                                                                                                            'brand': brand,
                                                                                                            'designer': namaDesignerDataModeller.text,
                                                                                                            'modeller': namaModellerDataModeller.text,
                                                                                                            'keterangan': keteranganDataModeller.text
                                                                                                          };
                                                                                                          final response = await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.postDataModeller), body: body);
                                                                                                          print(response.body);
                                                                                                          Future.delayed(const Duration(milliseconds: 10)).then((value) {
                                                                                                            btnController.reset(); //reset
                                                                                                            response.statusCode != 200
                                                                                                                ? showSimpleNotification(const Text('Tambah Data Modeller Gagal'), background: Colors.red, duration: const Duration(seconds: 10))
                                                                                                                : showSimpleNotification(
                                                                                                                    const Text('Tambah Data Modeller Berhasil'),
                                                                                                                    background: Colors.green,
                                                                                                                    duration: const Duration(seconds: 1),
                                                                                                                  );
                                                                                                          });
                                                                                                          Navigator.push(context, MaterialPageRoute(builder: (c) => MainViewScm(col: 1)));
                                                                                                        });
                                                                                                      } else {
                                                                                                        btnController.error();
                                                                                                        Future.delayed(const Duration(seconds: 1)).then((value) {
                                                                                                          btnController.reset(); //reset
                                                                                                        });
                                                                                                      }
                                                                                                    }),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),

                                                                              Positioned(
                                                                                right: -47.0,
                                                                                top: -47.0,
                                                                                child: InkResponse(
                                                                                  onTap: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: const CircleAvatar(
                                                                                    backgroundColor: Colors.red,
                                                                                    child: Icon(Icons.close),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ));
                                                              });
                                                        });
                                                      } else {}
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                      },
                      label: const Text(
                        "Tambah Data Modeller",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.add_circle_outline_sharp,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue,
                    )
                  : const SizedBox(height: 30),
              isLoading == false
                  ? Expanded(
                      child: Center(
                          child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 90,
                      height: 90,
                      child: Lottie.asset("loadingJSON/loadingV1.json"),
                    )))
                  : Expanded(
                      child: ListView(children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Theme(
                            data: ThemeData.light().copyWith(
                                // cardColor: Theme.of(context).canvasColor),
                                cardColor: Colors.white,
                                hoverColor: Colors.grey.shade400,
                                dividerColor: Colors.grey),
                            child: PaginatedDataTable(
                                showCheckboxColumn: false,
                                availableRowsPerPage: const [10, 50, 100],
                                rowsPerPage: _rowsPerPage,
                                onRowsPerPageChanged: (value) {
                                  setState(() {
                                    _rowsPerPage = value!;
                                  });
                                },
                                sortColumnIndex: _currentSortColumn,
                                sortAscending: sort,
                                // rowsPerPage: 25,
                                columnSpacing: 0,
                                columns: [
                                  //AKSI
                                  DataColumn(
                                    label: Container(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: const Text(
                                          "AKSI",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // kode Design
                                  DataColumn(
                                      label: const SizedBox(
                                          child: Text(
                                        "Kode Design",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      onSort: (columnIndex, _) {
                                        setState(() {
                                          _currentSortColumn = columnIndex;
                                          if (sort == true) {
                                            sort = false;
                                            filterListDataModeller!.sort(
                                                (a, b) => a
                                                    .kodeDesign!
                                                    .toLowerCase()
                                                    .compareTo(b.kodeDesign!
                                                        .toLowerCase()));
                                          } else {
                                            sort = true;
                                            filterListDataModeller!.sort(
                                                (a, b) => b
                                                    .kodeDesign!
                                                    .toLowerCase()
                                                    .compareTo(a.kodeDesign!
                                                        .toLowerCase()));
                                          }
                                        });
                                      }),
                                  DataColumn(label: _verticalDivider),
                                  // Jenis batu
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Jenis\nBatu",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  // ID
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "ID",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),
                                  // Bulan
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Bulan",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),

                                  // No Urut
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "No Urut",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // Kode Marketing
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Kode Marketing",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),
                                  //* NO / RO
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "NO / RO",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),

                                  // Project / Tema
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Project / Tema",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // Marketing
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Marketing",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // Brand
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Brand",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // Designer
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Designer",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),

                                  // Modeller
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Modeller",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // Keterangan
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Keterangan",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ],
                                source:
                                    // UserDataTableSource(userData: filterCrm!)),
                                    RowSource(
                                        context: context,
                                        myData: _listDataModeller,
                                        count: _listDataModeller!.length)),
                          ),
                        ),
                      ]),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<JenisbarangModel>> getListJenisbarang(filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListJenisbarang,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return JenisbarangModel.fromJsonList(data);
    }
    return [];
  }
}

class RowSource extends DataTableSource {
  BuildContext context;
  var myData;
  final count;
  RowSource({
    required this.myData,
    required this.count,
    required this.context,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data, BuildContext context) {
    return DataRow(cells: [
      //Aksi
      DataCell(Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final _formKey = GlobalKey<FormState>();
                    String? newJenisBatu;
                    String? newStatusSpk;
                    String? newBrand;
                    String? apinewJenisBatu;
                    String? apinewStatusSpk;
                    String? apinewBrand;

                    TextEditingController newTemaDataModeller =
                        TextEditingController();
                    TextEditingController newKodeDesignDataModeller =
                        TextEditingController();
                    TextEditingController newIdDataModeller =
                        TextEditingController();
                    TextEditingController newNoUrutDataModeller =
                        TextEditingController();
                    TextEditingController newKodeMarketingDataModeller =
                        TextEditingController();
                    TextEditingController newMarketingDataModeller =
                        TextEditingController();
                    TextEditingController newNamaDesignerDataModeller =
                        TextEditingController();
                    TextEditingController newNamaModellerDataModeller =
                        TextEditingController();
                    TextEditingController newKeteranganDataModeller =
                        TextEditingController();
                    RoundedLoadingButtonController newBtnController =
                        RoundedLoadingButtonController();
                    TextEditingController newBulan = TextEditingController();

                    newKodeDesignDataModeller.text = data.kodeDesign;
                    apinewJenisBatu = data.jenisBatu;
                    apinewBrand = data.brand;
                    apinewStatusSpk = data.status;
                    newBulan.text = data.bulan;
                    newNoUrutDataModeller.text =
                        data.noUrutBulan.toString().padLeft(3, '0');
                    newKodeMarketingDataModeller.text = data.kodeMarketing;
                    newTemaDataModeller.text = data.tema;
                    newMarketingDataModeller.text = data.marketing;
                    newNamaDesignerDataModeller.text = data.designer;
                    newNamaModellerDataModeller.text = data.modeller;
                    newKeteranganDataModeller.text = data.keterangan;
                    newIdDataModeller.text = data.id.toString();

                    return StatefulBuilder(
                        builder: (context, setState) => AlertDialog(
                              content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller:
                                                  newKodeMarketingDataModeller,
                                              decoration: InputDecoration(
                                                // hintText: "example: Cahaya Sanivokasi",
                                                labelText: "Kode Marketing",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Wajib diisi *';
                                                }
                                                return null;
                                              },
                                            ),
                                            const Text(
                                              'Pilih terlebih dahulu NO atau RO',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                //! status memilih no atau ro
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              8,
                                                              209,
                                                              69), //background color of dropdown button
                                                          border: Border.all(
                                                            color:
                                                                Colors.black38,
                                                            // width:
                                                            //     3
                                                          ), //border of dropdown button
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  0), //border raiuds of dropdown button
                                                          boxShadow: const <BoxShadow>[]),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: DropdownButton(
                                                            value: newStatusSpk,
                                                            items: const [
                                                              //add items in the dropdown
                                                              DropdownMenuItem(
                                                                value: "NO",
                                                                child:
                                                                    Text("NO"),
                                                              ),
                                                              DropdownMenuItem(
                                                                value: "RO",
                                                                child:
                                                                    Text("RO"),
                                                              ),
                                                            ],
                                                            hint: Text(
                                                                data.status),
                                                            onChanged: (value) {
                                                              newStatusSpk =
                                                                  value!;
                                                              apinewStatusSpk =
                                                                  newStatusSpk;
                                                              setState(() =>
                                                                  newStatusSpk);
                                                            },
                                                            icon: const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                child: Icon(Icons
                                                                    .arrow_circle_down_sharp)),
                                                            iconEnabledColor: Colors
                                                                .black, //Icon color
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black, //Font color
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
                                                //? id
                                                Container(
                                                  // width: MediaQuery.of(context).size.width *
                                                  //     0.25,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 100,
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          controller:
                                                              newIdDataModeller,
                                                          decoration:
                                                              InputDecoration(
                                                            // hintText: "example: Cahaya Sanivokasi",
                                                            labelText: "ID",
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 100,
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          controller:
                                                              newNoUrutDataModeller,
                                                          decoration:
                                                              InputDecoration(
                                                            // hintText: "example: Cahaya Sanivokasi",
                                                            labelText:
                                                                "No Urut",
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //Kode Design
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller:
                                                        newKodeDesignDataModeller,
                                                    decoration: InputDecoration(
                                                      // hintText: "example: Cahaya Sanivokasi",
                                                      labelText: "Kode Design",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                    ),
                                                  ),
                                                ),

                                                //Jenis Batu
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              8,
                                                              209,
                                                              69), //background color of dropdown button
                                                          border: Border.all(
                                                            color:
                                                                Colors.black38,
                                                            // width:
                                                            //     3
                                                          ), //border of dropdown button
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  0), //border raiuds of dropdown button
                                                          boxShadow: const <BoxShadow>[
                                                            //apply shadow on Dropdown button
                                                            // BoxShadow(
                                                            //     color: Color.fromRGBO(
                                                            //         0,
                                                            //         0,
                                                            //         0,
                                                            //         0.57), //shadow for button
                                                            //     blurRadius:
                                                            //         5) //blur radius of shadow
                                                          ]),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: DropdownButton(
                                                            value: newJenisBatu,
                                                            items: const [
                                                              //add items in the dropdown
                                                              DropdownMenuItem(
                                                                value: "VVS",
                                                                child:
                                                                    Text("VVS"),
                                                              ),
                                                              DropdownMenuItem(
                                                                value: "VS",
                                                                child:
                                                                    Text("VS"),
                                                              ),
                                                              DropdownMenuItem(
                                                                value: "SI",
                                                                child:
                                                                    Text("SI"),
                                                              )
                                                            ],
                                                            hint: Text(
                                                                data.jenisBatu),
                                                            onChanged: (value) {
                                                              newJenisBatu =
                                                                  value!;

                                                              apinewJenisBatu =
                                                                  newJenisBatu;
                                                              setState(() =>
                                                                  newJenisBatu);
                                                            },
                                                            icon: const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                child: Icon(Icons
                                                                    .arrow_circle_down_sharp)),
                                                            iconEnabledColor: Colors
                                                                .black, //Icon color
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black, //Font color
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

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller:
                                                        newTemaDataModeller,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Tema / Project",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller:
                                                        newMarketingDataModeller,
                                                    decoration: InputDecoration(
                                                      labelText: "Marketing",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              8,
                                                              209,
                                                              69), //background color of dropdown button
                                                          border: Border.all(
                                                            color:
                                                                Colors.black38,
                                                            // width:
                                                            //     3
                                                          ), //border of dropdown button
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  0), //border raiuds of dropdown button
                                                          boxShadow: const <BoxShadow>[
                                                            //apply shadow on Dropdown button
                                                            // BoxShadow(
                                                            //     color: Color.fromRGBO(
                                                            //         0,
                                                            //         0,
                                                            //         0,
                                                            //         0.57), //shadow for button
                                                            //     blurRadius:
                                                            //         5) //blur radius of shadow
                                                          ]),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: DropdownButton(
                                                            value: newBrand,
                                                            items: const [
                                                              //add items in the dropdown
                                                              DropdownMenuItem(
                                                                value: "PARVA",
                                                                child: Text(
                                                                    "PARVA"),
                                                              ),
                                                              DropdownMenuItem(
                                                                value: "METIER",
                                                                child: Text(
                                                                    "METIER"),
                                                              ),
                                                              DropdownMenuItem(
                                                                value:
                                                                    "BELI BERLIAN",
                                                                child: Text(
                                                                    "BELI BERLIAN"),
                                                              ),
                                                              DropdownMenuItem(
                                                                value: "FINE",
                                                                child: Text(
                                                                    "FINE"),
                                                              )
                                                            ],
                                                            hint: Text(
                                                                data.brand),
                                                            onChanged: (value) {
                                                              newBrand = value!;
                                                              apinewBrand =
                                                                  newBrand;
                                                              setState(() =>
                                                                  newBrand);
                                                            },
                                                            icon: const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                child: Icon(Icons
                                                                    .arrow_circle_down_sharp)),
                                                            iconEnabledColor: Colors
                                                                .black, //Icon color
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black, //Font color
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller:
                                                        newNamaDesignerDataModeller,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Nama Designer",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller:
                                                        newNamaModellerDataModeller,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Nama Modeller",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller:
                                                        newKeteranganDataModeller,
                                                    decoration: InputDecoration(
                                                      // hintText: "example: Cahaya Sanivokasi",
                                                      labelText: "Keterangan",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: CustomLoadingButton(
                                                        controller:
                                                            newBtnController,
                                                        child: const Text(
                                                            "Simpan Perubahan Data"),
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _formKey
                                                                .currentState!
                                                                .save();
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then(
                                                                    (value) async {
                                                              newBtnController
                                                                  .success();
                                                              Map<String,
                                                                      dynamic>
                                                                  body = {
                                                                'id':
                                                                    newIdDataModeller
                                                                        .text,
                                                                'kodeDesign':
                                                                    newKodeDesignDataModeller
                                                                        .text,
                                                                'jenisBatu':
                                                                    apinewJenisBatu,
                                                                'bulan':
                                                                    newBulan
                                                                        .text,
                                                                'tema':
                                                                    newTemaDataModeller
                                                                        .text,
                                                                'kodeBulan': data
                                                                    .kodeBulan,
                                                                'noUrutBulan':
                                                                    newNoUrutDataModeller
                                                                        .text,
                                                                'kodeMarketing':
                                                                    newKodeMarketingDataModeller
                                                                        .text,
                                                                'status':
                                                                    apinewStatusSpk,
                                                                'marketing':
                                                                    newMarketingDataModeller
                                                                        .text,
                                                                'brand':
                                                                    apinewBrand,
                                                                'designer':
                                                                    newNamaDesignerDataModeller
                                                                        .text,
                                                                'modeller':
                                                                    newNamaModellerDataModeller
                                                                        .text,
                                                                'keterangan':
                                                                    newKeteranganDataModeller
                                                                        .text
                                                              };
                                                              final response = await http.post(
                                                                  Uri.parse(ApiConstants
                                                                          .baseUrl +
                                                                      ApiConstants
                                                                          .updateDataModeller),
                                                                  body: body);
                                                              print(response
                                                                  .body);
                                                              Future.delayed(
                                                                      const Duration(
                                                                          milliseconds:
                                                                              10))
                                                                  .then(
                                                                      (value) {
                                                                newBtnController
                                                                    .reset(); //reset
                                                                response.statusCode !=
                                                                        200
                                                                    ? showSimpleNotification(
                                                                        const Text(
                                                                            'Edit Data Modeller Gagal'),
                                                                        background:
                                                                            Colors
                                                                                .red,
                                                                        duration:
                                                                            const Duration(seconds: 1))
                                                                    : showSimpleNotification(
                                                                        const Text(
                                                                            'Edit Data Modeller Berhasil'),
                                                                        background:
                                                                            Colors.green,
                                                                        duration:
                                                                            const Duration(seconds: 1),
                                                                      );
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (c) =>
                                                                          MainViewScm(
                                                                              col: 1)));
                                                            });
                                                          } else {
                                                            newBtnController
                                                                .error();
                                                            Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            1))
                                                                .then((value) {
                                                              newBtnController
                                                                  .reset(); //reset
                                                            });
                                                          }
                                                        }),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: -47.0,
                                    top: -47.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  });
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
        );
      })),

      DataCell(_verticalDivider),

      //kode Design
      DataCell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final _formKey = GlobalKey<FormState>();
                // ignore: unused_local_variable
                String? newJenisBatu;
                // ignore: unused_local_variable
                String? newStatusSpk;
                // ignore: unused_local_variable
                String? newBrand;
                String? apinewJenisBatu;
                String? apinewStatusSpk;
                String? apinewBrand;

                TextEditingController newTemaDataModeller =
                    TextEditingController();
                TextEditingController newKodeDesignDataModeller =
                    TextEditingController();
                TextEditingController newIdDataModeller =
                    TextEditingController();
                TextEditingController newNoUrutDataModeller =
                    TextEditingController();
                TextEditingController newKodeMarketingDataModeller =
                    TextEditingController();
                TextEditingController newMarketingDataModeller =
                    TextEditingController();
                TextEditingController newNamaDesignerDataModeller =
                    TextEditingController();
                TextEditingController newNamaModellerDataModeller =
                    TextEditingController();
                TextEditingController newKeteranganDataModeller =
                    TextEditingController();
                RoundedLoadingButtonController newBtnController =
                    RoundedLoadingButtonController();
                TextEditingController newBulan = TextEditingController();

                newKodeDesignDataModeller.text = data.kodeDesign;
                apinewJenisBatu = data.jenisBatu;
                apinewBrand = data.brand;
                apinewStatusSpk = data.status;
                newBulan.text = data.bulan;
                newNoUrutDataModeller.text =
                    data.noUrutBulan.toString().padLeft(3, '0');
                newKodeMarketingDataModeller.text = data.kodeMarketing;
                newTemaDataModeller.text = data.tema;
                newMarketingDataModeller.text = data.marketing;
                newNamaDesignerDataModeller.text = data.designer;
                newNamaModellerDataModeller.text = data.modeller;
                newKeteranganDataModeller.text = data.keterangan;
                newIdDataModeller.text = data.id.toString();

                return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              //Kode Design
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller:
                                                      newKodeDesignDataModeller,
                                                  decoration: InputDecoration(
                                                    // hintText: "example: Cahaya Sanivokasi",
                                                    labelText: "Kode Design",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: CustomLoadingButton(
                                                      controller:
                                                          newBtnController,
                                                      child: const Text(
                                                          "Simpan Perubahan Data"),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then(
                                                                  (value) async {
                                                            newBtnController
                                                                .success();
                                                            Map<String, dynamic>
                                                                body = {
                                                              'id':
                                                                  newIdDataModeller
                                                                      .text,
                                                              'kodeDesign':
                                                                  newKodeDesignDataModeller
                                                                      .text,
                                                              'jenisBatu':
                                                                  apinewJenisBatu,
                                                              'bulan':
                                                                  newBulan.text,
                                                              'tema':
                                                                  newTemaDataModeller
                                                                      .text,
                                                              'kodeBulan': data
                                                                  .kodeBulan,
                                                              'noUrutBulan':
                                                                  newNoUrutDataModeller
                                                                      .text,
                                                              'kodeMarketing':
                                                                  newKodeMarketingDataModeller
                                                                      .text,
                                                              'status':
                                                                  apinewStatusSpk,
                                                              'marketing':
                                                                  newMarketingDataModeller
                                                                      .text,
                                                              'brand':
                                                                  apinewBrand,
                                                              'designer':
                                                                  newNamaDesignerDataModeller
                                                                      .text,
                                                              'modeller':
                                                                  newNamaModellerDataModeller
                                                                      .text,
                                                              'keterangan':
                                                                  newKeteranganDataModeller
                                                                      .text
                                                            };
                                                            final response = await http.post(
                                                                Uri.parse(ApiConstants
                                                                        .baseUrl +
                                                                    ApiConstants
                                                                        .updateDataModeller),
                                                                body: body);
                                                            print(
                                                                response.body);
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then((value) {
                                                              newBtnController
                                                                  .reset(); //reset
                                                              response.statusCode !=
                                                                      200
                                                                  ? showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Gagal'),
                                                                      background:
                                                                          Colors
                                                                              .red,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1))
                                                                  : showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Berhasil'),
                                                                      background:
                                                                          Colors
                                                                              .green,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    );
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (c) =>
                                                                        MainViewScm(
                                                                            col:
                                                                                1)));
                                                          });
                                                        } else {
                                                          newBtnController
                                                              .error();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then((value) {
                                                            newBtnController
                                                                .reset(); //reset
                                                          });
                                                        }
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -47.0,
                                top: -47.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              });
        },
        Padding(padding: const EdgeInsets.all(0), child: Text(data.kodeDesign)),
      ),

      DataCell(_verticalDivider),
      //Jenis Batu
      DataCell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final _formKey = GlobalKey<FormState>();
                // ignore: unused_local_variable
                String? newJenisBatu;
                // ignore: unused_local_variable
                String? newStatusSpk;
                // ignore: unused_local_variable
                String? newBrand;
                String? apinewJenisBatu;
                String? apinewStatusSpk;
                String? apinewBrand;

                TextEditingController newTemaDataModeller =
                    TextEditingController();
                TextEditingController newKodeDesignDataModeller =
                    TextEditingController();
                TextEditingController newIdDataModeller =
                    TextEditingController();
                TextEditingController newNoUrutDataModeller =
                    TextEditingController();
                TextEditingController newKodeMarketingDataModeller =
                    TextEditingController();
                TextEditingController newMarketingDataModeller =
                    TextEditingController();
                TextEditingController newNamaDesignerDataModeller =
                    TextEditingController();
                TextEditingController newNamaModellerDataModeller =
                    TextEditingController();
                TextEditingController newKeteranganDataModeller =
                    TextEditingController();
                RoundedLoadingButtonController newBtnController =
                    RoundedLoadingButtonController();
                TextEditingController newBulan = TextEditingController();

                newKodeDesignDataModeller.text = data.kodeDesign;
                apinewJenisBatu = data.jenisBatu;
                apinewBrand = data.brand;
                apinewStatusSpk = data.status;
                newBulan.text = data.bulan;
                newNoUrutDataModeller.text =
                    data.noUrutBulan.toString().padLeft(3, '0');
                newKodeMarketingDataModeller.text = data.kodeMarketing;
                newTemaDataModeller.text = data.tema;
                newMarketingDataModeller.text = data.marketing;
                newNamaDesignerDataModeller.text = data.designer;
                newNamaModellerDataModeller.text = data.modeller;
                newKeteranganDataModeller.text = data.keterangan;
                newIdDataModeller.text = data.id.toString();

                return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              //Jenis Batu
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255,
                                                            8,
                                                            209,
                                                            69), //background color of dropdown button
                                                        border: Border.all(
                                                          color: Colors.black38,
                                                          // width:
                                                          //     3
                                                        ), //border of dropdown button
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                0), //border raiuds of dropdown button
                                                        boxShadow: const <BoxShadow>[
                                                          //apply shadow on Dropdown button
                                                          // BoxShadow(
                                                          //     color: Color.fromRGBO(
                                                          //         0,
                                                          //         0,
                                                          //         0,
                                                          //         0.57), //shadow for button
                                                          //     blurRadius:
                                                          //         5) //blur radius of shadow
                                                        ]),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: DropdownButton(
                                                          value: newJenisBatu,
                                                          items: const [
                                                            //add items in the dropdown
                                                            DropdownMenuItem(
                                                              value: "VVS",
                                                              child:
                                                                  Text("VVS"),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: "VS",
                                                              child: Text("VS"),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: "SI",
                                                              child: Text("SI"),
                                                            )
                                                          ],
                                                          hint: Text(
                                                              data.jenisBatu),
                                                          onChanged: (value) {
                                                            newJenisBatu =
                                                                value!;

                                                            apinewJenisBatu =
                                                                newJenisBatu;
                                                            setState(() =>
                                                                newJenisBatu);
                                                          },
                                                          icon: const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Icon(Icons
                                                                  .arrow_circle_down_sharp)),
                                                          iconEnabledColor: Colors
                                                              .black, //Icon color
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .black, //Font color
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

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: CustomLoadingButton(
                                                      controller:
                                                          newBtnController,
                                                      child: const Text(
                                                          "Simpan Perubahan Data"),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then(
                                                                  (value) async {
                                                            newBtnController
                                                                .success();
                                                            Map<String, dynamic>
                                                                body = {
                                                              'id':
                                                                  newIdDataModeller
                                                                      .text,
                                                              'kodeDesign':
                                                                  newKodeDesignDataModeller
                                                                      .text,
                                                              'jenisBatu':
                                                                  apinewJenisBatu,
                                                              'bulan':
                                                                  newBulan.text,
                                                              'tema':
                                                                  newTemaDataModeller
                                                                      .text,
                                                              'kodeBulan': data
                                                                  .kodeBulan,
                                                              'noUrutBulan':
                                                                  newNoUrutDataModeller
                                                                      .text,
                                                              'kodeMarketing':
                                                                  newKodeMarketingDataModeller
                                                                      .text,
                                                              'status':
                                                                  apinewStatusSpk,
                                                              'marketing':
                                                                  newMarketingDataModeller
                                                                      .text,
                                                              'brand':
                                                                  apinewBrand,
                                                              'designer':
                                                                  newNamaDesignerDataModeller
                                                                      .text,
                                                              'modeller':
                                                                  newNamaModellerDataModeller
                                                                      .text,
                                                              'keterangan':
                                                                  newKeteranganDataModeller
                                                                      .text
                                                            };
                                                            final response = await http.post(
                                                                Uri.parse(ApiConstants
                                                                        .baseUrl +
                                                                    ApiConstants
                                                                        .updateDataModeller),
                                                                body: body);
                                                            print(
                                                                response.body);
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then((value) {
                                                              newBtnController
                                                                  .reset(); //reset
                                                              response.statusCode !=
                                                                      200
                                                                  ? showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Gagal'),
                                                                      background:
                                                                          Colors
                                                                              .red,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1))
                                                                  : showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Berhasil'),
                                                                      background:
                                                                          Colors
                                                                              .green,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    );
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (c) =>
                                                                        MainViewScm(
                                                                            col:
                                                                                1)));
                                                          });
                                                        } else {
                                                          newBtnController
                                                              .error();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then((value) {
                                                            newBtnController
                                                                .reset(); //reset
                                                          });
                                                        }
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -47.0,
                                top: -47.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              });
        },
        Container(
            padding: const EdgeInsets.all(0), child: Text(data.jenisBatu)),
      ),

      DataCell(_verticalDivider),
      //id
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.id.toString())),
      ),
      DataCell(_verticalDivider),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.bulan)),
      ),
      DataCell(_verticalDivider),
      //no urut
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.noUrutBulan.toString().padLeft(3, '0'))),
      ),
      DataCell(_verticalDivider),
      //kode marketing
      DataCell(onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              final _formKey = GlobalKey<FormState>();
              // ignore: unused_local_variable
              String? newJenisBatu;
              // ignore: unused_local_variable
              String? newStatusSpk;
              // ignore: unused_local_variable
              String? newBrand;
              String? apinewJenisBatu;
              String? apinewStatusSpk;
              String? apinewBrand;

              TextEditingController newTemaDataModeller =
                  TextEditingController();
              TextEditingController newKodeDesignDataModeller =
                  TextEditingController();
              TextEditingController newIdDataModeller = TextEditingController();
              TextEditingController newNoUrutDataModeller =
                  TextEditingController();
              TextEditingController newKodeMarketingDataModeller =
                  TextEditingController();
              TextEditingController newMarketingDataModeller =
                  TextEditingController();
              TextEditingController newNamaDesignerDataModeller =
                  TextEditingController();
              TextEditingController newNamaModellerDataModeller =
                  TextEditingController();
              TextEditingController newKeteranganDataModeller =
                  TextEditingController();
              RoundedLoadingButtonController newBtnController =
                  RoundedLoadingButtonController();
              TextEditingController newBulan = TextEditingController();

              newKodeDesignDataModeller.text = data.kodeDesign;
              apinewJenisBatu = data.jenisBatu;
              apinewBrand = data.brand;
              apinewStatusSpk = data.status;
              newBulan.text = data.bulan;
              newNoUrutDataModeller.text =
                  data.noUrutBulan.toString().padLeft(3, '0');
              newKodeMarketingDataModeller.text = data.kodeMarketing;
              newTemaDataModeller.text = data.tema;
              newMarketingDataModeller.text = data.marketing;
              newNamaDesignerDataModeller.text = data.designer;
              newNamaModellerDataModeller.text = data.modeller;
              newKeteranganDataModeller.text = data.keterangan;
              newIdDataModeller.text = data.id.toString();

              return StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            //Kode Marketing
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller:
                                                    newKodeMarketingDataModeller,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Kode Marketing",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 250,
                                                child: CustomLoadingButton(
                                                    controller:
                                                        newBtnController,
                                                    child: const Text(
                                                        "Simpan Perubahan Data"),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        10))
                                                            .then(
                                                                (value) async {
                                                          newBtnController
                                                              .success();
                                                          Map<String, dynamic>
                                                              body = {
                                                            'id':
                                                                newIdDataModeller
                                                                    .text,
                                                            'kodeDesign':
                                                                newKodeDesignDataModeller
                                                                    .text,
                                                            'jenisBatu':
                                                                apinewJenisBatu,
                                                            'bulan':
                                                                newBulan.text,
                                                            'tema':
                                                                newTemaDataModeller
                                                                    .text,
                                                            'kodeBulan':
                                                                data.kodeBulan,
                                                            'noUrutBulan':
                                                                newNoUrutDataModeller
                                                                    .text,
                                                            'kodeMarketing':
                                                                newKodeMarketingDataModeller
                                                                    .text,
                                                            'status':
                                                                apinewStatusSpk,
                                                            'marketing':
                                                                newMarketingDataModeller
                                                                    .text,
                                                            'brand':
                                                                apinewBrand,
                                                            'designer':
                                                                newNamaDesignerDataModeller
                                                                    .text,
                                                            'modeller':
                                                                newNamaModellerDataModeller
                                                                    .text,
                                                            'keterangan':
                                                                newKeteranganDataModeller
                                                                    .text
                                                          };
                                                          final response = await http.post(
                                                              Uri.parse(ApiConstants
                                                                      .baseUrl +
                                                                  ApiConstants
                                                                      .updateDataModeller),
                                                              body: body);
                                                          print(response.body);
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then((value) {
                                                            newBtnController
                                                                .reset(); //reset
                                                            response.statusCode !=
                                                                    200
                                                                ? showSimpleNotification(
                                                                    const Text(
                                                                        'Edit Data Modeller Gagal'),
                                                                    background:
                                                                        Colors
                                                                            .red,
                                                                    duration: const Duration(
                                                                        seconds:
                                                                            1))
                                                                : showSimpleNotification(
                                                                    const Text(
                                                                        'Edit Data Modeller Berhasil'),
                                                                    background:
                                                                        Colors
                                                                            .green,
                                                                    duration: const Duration(
                                                                        seconds:
                                                                            1),
                                                                  );
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (c) =>
                                                                      MainViewScm(
                                                                          col:
                                                                              1)));
                                                        });
                                                      } else {
                                                        newBtnController
                                                            .error();
                                                        Future.delayed(
                                                                const Duration(
                                                                    seconds: 1))
                                                            .then((value) {
                                                          newBtnController
                                                              .reset(); //reset
                                                        });
                                                      }
                                                    }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: -47.0,
                              top: -47.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
            });
      },
          Padding(
              padding: const EdgeInsets.all(0),
              child: Text(data.kodeMarketing))),
      DataCell(_verticalDivider),
      //no at ro
      DataCell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final _formKey = GlobalKey<FormState>();
                // ignore: unused_local_variable
                String? newJenisBatu;
                // ignore: unused_local_variable
                String? newStatusSpk;
                // ignore: unused_local_variable
                String? newBrand;
                String? apinewJenisBatu;
                String? apinewStatusSpk;
                String? apinewBrand;

                TextEditingController newTemaDataModeller =
                    TextEditingController();
                TextEditingController newKodeDesignDataModeller =
                    TextEditingController();
                TextEditingController newIdDataModeller =
                    TextEditingController();
                TextEditingController newNoUrutDataModeller =
                    TextEditingController();
                TextEditingController newKodeMarketingDataModeller =
                    TextEditingController();
                TextEditingController newMarketingDataModeller =
                    TextEditingController();
                TextEditingController newNamaDesignerDataModeller =
                    TextEditingController();
                TextEditingController newNamaModellerDataModeller =
                    TextEditingController();
                TextEditingController newKeteranganDataModeller =
                    TextEditingController();
                RoundedLoadingButtonController newBtnController =
                    RoundedLoadingButtonController();
                TextEditingController newBulan = TextEditingController();

                newKodeDesignDataModeller.text = data.kodeDesign;
                apinewJenisBatu = data.jenisBatu;
                apinewBrand = data.brand;
                apinewStatusSpk = data.status;
                newBulan.text = data.bulan;
                newNoUrutDataModeller.text =
                    data.noUrutBulan.toString().padLeft(3, '0');
                newKodeMarketingDataModeller.text = data.kodeMarketing;
                newTemaDataModeller.text = data.tema;
                newMarketingDataModeller.text = data.marketing;
                newNamaDesignerDataModeller.text = data.designer;
                newNamaModellerDataModeller.text = data.modeller;
                newKeteranganDataModeller.text = data.keterangan;
                newIdDataModeller.text = data.id.toString();

                return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              //no atau ro
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255,
                                                            8,
                                                            209,
                                                            69), //background color of dropdown button
                                                        border: Border.all(
                                                          color: Colors.black38,
                                                          // width:
                                                          //     3
                                                        ), //border of dropdown button
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                0), //border raiuds of dropdown button
                                                        boxShadow: const <BoxShadow>[]),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: DropdownButton(
                                                          value: newStatusSpk,
                                                          items: const [
                                                            //add items in the dropdown
                                                            DropdownMenuItem(
                                                              value: "NO",
                                                              child: Text("NO"),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: "RO",
                                                              child: Text("RO"),
                                                            ),
                                                          ],
                                                          hint:
                                                              Text(data.status),
                                                          onChanged: (value) {
                                                            newStatusSpk =
                                                                value!;
                                                            apinewStatusSpk =
                                                                newStatusSpk;
                                                            setState(() =>
                                                                newStatusSpk);
                                                          },
                                                          icon: const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Icon(Icons
                                                                  .arrow_circle_down_sharp)),
                                                          iconEnabledColor: Colors
                                                              .black, //Icon color
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .black, //Font color
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: CustomLoadingButton(
                                                      controller:
                                                          newBtnController,
                                                      child: const Text(
                                                          "Simpan Perubahan Data"),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then(
                                                                  (value) async {
                                                            newBtnController
                                                                .success();
                                                            Map<String, dynamic>
                                                                body = {
                                                              'id':
                                                                  newIdDataModeller
                                                                      .text,
                                                              'kodeDesign':
                                                                  newKodeDesignDataModeller
                                                                      .text,
                                                              'jenisBatu':
                                                                  apinewJenisBatu,
                                                              'bulan':
                                                                  newBulan.text,
                                                              'tema':
                                                                  newTemaDataModeller
                                                                      .text,
                                                              'kodeBulan': data
                                                                  .kodeBulan,
                                                              'noUrutBulan':
                                                                  newNoUrutDataModeller
                                                                      .text,
                                                              'kodeMarketing':
                                                                  newKodeMarketingDataModeller
                                                                      .text,
                                                              'status':
                                                                  apinewStatusSpk,
                                                              'marketing':
                                                                  newMarketingDataModeller
                                                                      .text,
                                                              'brand':
                                                                  apinewBrand,
                                                              'designer':
                                                                  newNamaDesignerDataModeller
                                                                      .text,
                                                              'modeller':
                                                                  newNamaModellerDataModeller
                                                                      .text,
                                                              'keterangan':
                                                                  newKeteranganDataModeller
                                                                      .text
                                                            };
                                                            final response = await http.post(
                                                                Uri.parse(ApiConstants
                                                                        .baseUrl +
                                                                    ApiConstants
                                                                        .updateDataModeller),
                                                                body: body);
                                                            print(
                                                                response.body);
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then((value) {
                                                              newBtnController
                                                                  .reset(); //reset
                                                              response.statusCode !=
                                                                      200
                                                                  ? showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Gagal'),
                                                                      background:
                                                                          Colors
                                                                              .red,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1))
                                                                  : showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Berhasil'),
                                                                      background:
                                                                          Colors
                                                                              .green,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    );
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (c) =>
                                                                        MainViewScm(
                                                                            col:
                                                                                1)));
                                                          });
                                                        } else {
                                                          newBtnController
                                                              .error();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then((value) {
                                                            newBtnController
                                                                .reset(); //reset
                                                          });
                                                        }
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -47.0,
                                top: -47.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              });
        },
        Padding(padding: const EdgeInsets.all(0), child: Text(data.status)),
      ),
      DataCell(_verticalDivider),
      //project tema
      DataCell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final _formKey = GlobalKey<FormState>();
                // ignore: unused_local_variable
                String? newJenisBatu;
                // ignore: unused_local_variable
                String? newStatusSpk;
                // ignore: unused_local_variable
                String? newBrand;
                String? apinewJenisBatu;
                String? apinewStatusSpk;
                String? apinewBrand;

                TextEditingController newTemaDataModeller =
                    TextEditingController();
                TextEditingController newKodeDesignDataModeller =
                    TextEditingController();
                TextEditingController newIdDataModeller =
                    TextEditingController();
                TextEditingController newNoUrutDataModeller =
                    TextEditingController();
                TextEditingController newKodeMarketingDataModeller =
                    TextEditingController();
                TextEditingController newMarketingDataModeller =
                    TextEditingController();
                TextEditingController newNamaDesignerDataModeller =
                    TextEditingController();
                TextEditingController newNamaModellerDataModeller =
                    TextEditingController();
                TextEditingController newKeteranganDataModeller =
                    TextEditingController();
                RoundedLoadingButtonController newBtnController =
                    RoundedLoadingButtonController();
                TextEditingController newBulan = TextEditingController();

                newKodeDesignDataModeller.text = data.kodeDesign;
                apinewJenisBatu = data.jenisBatu;
                apinewBrand = data.brand;
                apinewStatusSpk = data.status;
                newBulan.text = data.bulan;
                newNoUrutDataModeller.text =
                    data.noUrutBulan.toString().padLeft(3, '0');
                newKodeMarketingDataModeller.text = data.kodeMarketing;
                newTemaDataModeller.text = data.tema;
                newMarketingDataModeller.text = data.marketing;
                newNamaDesignerDataModeller.text = data.designer;
                newNamaModellerDataModeller.text = data.modeller;
                newKeteranganDataModeller.text = data.keterangan;
                newIdDataModeller.text = data.id.toString();

                return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              //Tema
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller:
                                                      newTemaDataModeller,
                                                  decoration: InputDecoration(
                                                    // hintText: "example: Cahaya Sanivokasi",
                                                    labelText: "Tema",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: CustomLoadingButton(
                                                      controller:
                                                          newBtnController,
                                                      child: const Text(
                                                          "Simpan Perubahan Data"),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then(
                                                                  (value) async {
                                                            newBtnController
                                                                .success();
                                                            Map<String, dynamic>
                                                                body = {
                                                              'id':
                                                                  newIdDataModeller
                                                                      .text,
                                                              'kodeDesign':
                                                                  newKodeDesignDataModeller
                                                                      .text,
                                                              'jenisBatu':
                                                                  apinewJenisBatu,
                                                              'bulan':
                                                                  newBulan.text,
                                                              'tema':
                                                                  newTemaDataModeller
                                                                      .text,
                                                              'kodeBulan': data
                                                                  .kodeBulan,
                                                              'noUrutBulan':
                                                                  newNoUrutDataModeller
                                                                      .text,
                                                              'kodeMarketing':
                                                                  newKodeMarketingDataModeller
                                                                      .text,
                                                              'status':
                                                                  apinewStatusSpk,
                                                              'marketing':
                                                                  newMarketingDataModeller
                                                                      .text,
                                                              'brand':
                                                                  apinewBrand,
                                                              'designer':
                                                                  newNamaDesignerDataModeller
                                                                      .text,
                                                              'modeller':
                                                                  newNamaModellerDataModeller
                                                                      .text,
                                                              'keterangan':
                                                                  newKeteranganDataModeller
                                                                      .text
                                                            };
                                                            final response = await http.post(
                                                                Uri.parse(ApiConstants
                                                                        .baseUrl +
                                                                    ApiConstants
                                                                        .updateDataModeller),
                                                                body: body);
                                                            print(
                                                                response.body);
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then((value) {
                                                              newBtnController
                                                                  .reset(); //reset
                                                              response.statusCode !=
                                                                      200
                                                                  ? showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Gagal'),
                                                                      background:
                                                                          Colors
                                                                              .red,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1))
                                                                  : showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Berhasil'),
                                                                      background:
                                                                          Colors
                                                                              .green,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    );
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (c) =>
                                                                        MainViewScm(
                                                                            col:
                                                                                1)));
                                                          });
                                                        } else {
                                                          newBtnController
                                                              .error();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then((value) {
                                                            newBtnController
                                                                .reset(); //reset
                                                          });
                                                        }
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -47.0,
                                top: -47.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              });
        },
        Padding(padding: const EdgeInsets.all(0), child: Text(data.tema)),
      ),
      DataCell(_verticalDivider),
      //marketing
      DataCell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final _formKey = GlobalKey<FormState>();
                // ignore: unused_local_variable
                String? newJenisBatu;
                // ignore: unused_local_variable
                String? newStatusSpk;
                // ignore: unused_local_variable
                String? newBrand;
                String? apinewJenisBatu;
                String? apinewStatusSpk;
                String? apinewBrand;

                TextEditingController newTemaDataModeller =
                    TextEditingController();
                TextEditingController newKodeDesignDataModeller =
                    TextEditingController();
                TextEditingController newIdDataModeller =
                    TextEditingController();
                TextEditingController newNoUrutDataModeller =
                    TextEditingController();
                TextEditingController newKodeMarketingDataModeller =
                    TextEditingController();
                TextEditingController newMarketingDataModeller =
                    TextEditingController();
                TextEditingController newNamaDesignerDataModeller =
                    TextEditingController();
                TextEditingController newNamaModellerDataModeller =
                    TextEditingController();
                TextEditingController newKeteranganDataModeller =
                    TextEditingController();
                RoundedLoadingButtonController newBtnController =
                    RoundedLoadingButtonController();
                TextEditingController newBulan = TextEditingController();

                newKodeDesignDataModeller.text = data.kodeDesign;
                apinewJenisBatu = data.jenisBatu;
                apinewBrand = data.brand;
                apinewStatusSpk = data.status;
                newBulan.text = data.bulan;
                newNoUrutDataModeller.text =
                    data.noUrutBulan.toString().padLeft(3, '0');
                newKodeMarketingDataModeller.text = data.kodeMarketing;
                newTemaDataModeller.text = data.tema;
                newMarketingDataModeller.text = data.marketing;
                newNamaDesignerDataModeller.text = data.designer;
                newNamaModellerDataModeller.text = data.modeller;
                newKeteranganDataModeller.text = data.keterangan;
                newIdDataModeller.text = data.id.toString();

                return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              //Marketing
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller:
                                                      newMarketingDataModeller,
                                                  decoration: InputDecoration(
                                                    // hintText: "example: Cahaya Sanivokasi",
                                                    labelText: "Marketing",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: CustomLoadingButton(
                                                      controller:
                                                          newBtnController,
                                                      child: const Text(
                                                          "Simpan Perubahan Data"),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then(
                                                                  (value) async {
                                                            newBtnController
                                                                .success();
                                                            Map<String, dynamic>
                                                                body = {
                                                              'id':
                                                                  newIdDataModeller
                                                                      .text,
                                                              'kodeDesign':
                                                                  newKodeDesignDataModeller
                                                                      .text,
                                                              'jenisBatu':
                                                                  apinewJenisBatu,
                                                              'bulan':
                                                                  newBulan.text,
                                                              'tema':
                                                                  newTemaDataModeller
                                                                      .text,
                                                              'kodeBulan': data
                                                                  .kodeBulan,
                                                              'noUrutBulan':
                                                                  newNoUrutDataModeller
                                                                      .text,
                                                              'kodeMarketing':
                                                                  newKodeMarketingDataModeller
                                                                      .text,
                                                              'status':
                                                                  apinewStatusSpk,
                                                              'marketing':
                                                                  newMarketingDataModeller
                                                                      .text,
                                                              'brand':
                                                                  apinewBrand,
                                                              'designer':
                                                                  newNamaDesignerDataModeller
                                                                      .text,
                                                              'modeller':
                                                                  newNamaModellerDataModeller
                                                                      .text,
                                                              'keterangan':
                                                                  newKeteranganDataModeller
                                                                      .text
                                                            };
                                                            final response = await http.post(
                                                                Uri.parse(ApiConstants
                                                                        .baseUrl +
                                                                    ApiConstants
                                                                        .updateDataModeller),
                                                                body: body);
                                                            print(
                                                                response.body);
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then((value) {
                                                              newBtnController
                                                                  .reset(); //reset
                                                              response.statusCode !=
                                                                      200
                                                                  ? showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Gagal'),
                                                                      background:
                                                                          Colors
                                                                              .red,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1))
                                                                  : showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Berhasil'),
                                                                      background:
                                                                          Colors
                                                                              .green,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    );
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (c) =>
                                                                        MainViewScm(
                                                                            col:
                                                                                1)));
                                                          });
                                                        } else {
                                                          newBtnController
                                                              .error();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then((value) {
                                                            newBtnController
                                                                .reset(); //reset
                                                          });
                                                        }
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -47.0,
                                top: -47.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              });
        },
        Padding(padding: const EdgeInsets.all(0), child: Text(data.marketing)),
      ),
      DataCell(_verticalDivider),
      //brand
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.brand)),
      ),
      DataCell(_verticalDivider),
      //designer
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.designer)),
      ),
      DataCell(_verticalDivider),
      //modeller
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.modeller)),
      ),
      DataCell(_verticalDivider),
      //keterangan
      DataCell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final _formKey = GlobalKey<FormState>();
                // ignore: unused_local_variable
                String? newJenisBatu;
                // ignore: unused_local_variable
                String? newStatusSpk;
                // ignore: unused_local_variable
                String? newBrand;
                String? apinewJenisBatu;
                String? apinewStatusSpk;
                String? apinewBrand;

                TextEditingController newTemaDataModeller =
                    TextEditingController();
                TextEditingController newKodeDesignDataModeller =
                    TextEditingController();
                TextEditingController newIdDataModeller =
                    TextEditingController();
                TextEditingController newNoUrutDataModeller =
                    TextEditingController();
                TextEditingController newKodeMarketingDataModeller =
                    TextEditingController();
                TextEditingController newMarketingDataModeller =
                    TextEditingController();
                TextEditingController newNamaDesignerDataModeller =
                    TextEditingController();
                TextEditingController newNamaModellerDataModeller =
                    TextEditingController();
                TextEditingController newKeteranganDataModeller =
                    TextEditingController();
                RoundedLoadingButtonController newBtnController =
                    RoundedLoadingButtonController();
                TextEditingController newBulan = TextEditingController();

                newKodeDesignDataModeller.text = data.kodeDesign;
                apinewJenisBatu = data.jenisBatu;
                apinewBrand = data.brand;
                apinewStatusSpk = data.status;
                newBulan.text = data.bulan;
                newNoUrutDataModeller.text =
                    data.noUrutBulan.toString().padLeft(3, '0');
                newKodeMarketingDataModeller.text = data.kodeMarketing;
                newTemaDataModeller.text = data.tema;
                newMarketingDataModeller.text = data.marketing;
                newNamaDesignerDataModeller.text = data.designer;
                newNamaModellerDataModeller.text = data.modeller;
                newKeteranganDataModeller.text = data.keterangan;
                newIdDataModeller.text = data.id.toString();

                return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              //Keterangan
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller:
                                                      newKeteranganDataModeller,
                                                  decoration: InputDecoration(
                                                    // hintText: "example: Cahaya Sanivokasi",
                                                    labelText: "Keterangan",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: 250,
                                                  child: CustomLoadingButton(
                                                      controller:
                                                          newBtnController,
                                                      child: const Text(
                                                          "Simpan Perubahan Data"),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey.currentState!
                                                              .save();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then(
                                                                  (value) async {
                                                            newBtnController
                                                                .success();
                                                            Map<String, dynamic>
                                                                body = {
                                                              'id':
                                                                  newIdDataModeller
                                                                      .text,
                                                              'kodeDesign':
                                                                  newKodeDesignDataModeller
                                                                      .text,
                                                              'jenisBatu':
                                                                  apinewJenisBatu,
                                                              'bulan':
                                                                  newBulan.text,
                                                              'tema':
                                                                  newTemaDataModeller
                                                                      .text,
                                                              'kodeBulan': data
                                                                  .kodeBulan,
                                                              'noUrutBulan':
                                                                  newNoUrutDataModeller
                                                                      .text,
                                                              'kodeMarketing':
                                                                  newKodeMarketingDataModeller
                                                                      .text,
                                                              'status':
                                                                  apinewStatusSpk,
                                                              'marketing':
                                                                  newMarketingDataModeller
                                                                      .text,
                                                              'brand':
                                                                  apinewBrand,
                                                              'designer':
                                                                  newNamaDesignerDataModeller
                                                                      .text,
                                                              'modeller':
                                                                  newNamaModellerDataModeller
                                                                      .text,
                                                              'keterangan':
                                                                  newKeteranganDataModeller
                                                                      .text
                                                            };
                                                            final response = await http.post(
                                                                Uri.parse(ApiConstants
                                                                        .baseUrl +
                                                                    ApiConstants
                                                                        .updateDataModeller),
                                                                body: body);
                                                            print(
                                                                response.body);
                                                            Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            10))
                                                                .then((value) {
                                                              newBtnController
                                                                  .reset(); //reset
                                                              response.statusCode !=
                                                                      200
                                                                  ? showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Gagal'),
                                                                      background:
                                                                          Colors
                                                                              .red,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1))
                                                                  : showSimpleNotification(
                                                                      const Text(
                                                                          'Edit Data Modeller Berhasil'),
                                                                      background:
                                                                          Colors
                                                                              .green,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    );
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (c) =>
                                                                        MainViewScm(
                                                                            col:
                                                                                1)));
                                                          });
                                                        } else {
                                                          newBtnController
                                                              .error();
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then((value) {
                                                            newBtnController
                                                                .reset(); //reset
                                                          });
                                                        }
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -47.0,
                                top: -47.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
              });
        },
        Padding(padding: const EdgeInsets.all(0), child: Text(data.keterangan)),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

Widget _listJenisbarang(
  BuildContext context,
  JenisbarangModel? item,
  bool isSelected,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(50),
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.nama ?? ''),
    ),
  );
}

//class untuk ambil character
extension E on String {
  String lastChars(int n) => substring(length - n);
}
