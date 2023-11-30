// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_batu.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
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
  bool sort = true;
  bool isLoading = false;
  int? page;
  int? limit;
  int _currentSortColumn = 0;
  int _rowsPerPage = 50;
  var nowSiklus = '';
  var kodeBulan = '';
  TextEditingController addSiklus = TextEditingController();
  String? apiIdDataModeller = '';
  String? apiNoUrutDataModeller = '';

  @override
  initState() {
    super.initState();
    nowSiklus = sharedPreferences!.getString('siklus')!;
    page = 0;
    limit = 20;
     var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    String kodeMonth = DateFormat('M', 'id').format(now);
    nowSiklus = month;
    kodeBulan = getHuruf(int.parse(kodeMonth));
    _getData();
  }

  String getHuruf(int angka) {
 return String.fromCharCode(angka + 64);
}

  Future<List<ModellerModel>> _getData() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getDataModeller));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g = jsonResponse.map((data) => ModellerModel.fromJson(data)).toList();
      setState(() {
        _listDataModeller = g;
        filterListDataModeller = g;
        isLoading = true;
      });
      return g;
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
                    "Siklus Saat Ini : $nowSiklus",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                  ),
                  sharedPreferences!.getString('level') != '1'
                      ? const SizedBox()
                      : IconButton(
                          color: Colors.grey.shade700,
                          onPressed: () {
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
                                                        hintText:
                                                            'Pilih Siklus',
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    validator: (value) => value ==
                                                            null
                                                        ? "Siklus tidak boleh kosong"
                                                        : null,
                                                    onChanged:
                                                        (String? newValue) {
                                                      addSiklus.text =
                                                          newValue!;
                                                    },
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          if (dropdownFormKey
                                                              .currentState!
                                                              .validate()) {
                                                            //? method untuk mengganti siklus
                                                            await postSiklus();
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (c) =>
                                                                        MainViewScm(
                                                                            col:
                                                                                0)));

                                                            showDialog<String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Siklus Berhasil Diterapkan',
                                                                      ),
                                                                    ));
                                                            setState(() {
                                                              nowSiklus =
                                                                  addSiklus
                                                                      .text;
                                                              sharedPreferences!
                                                                  .setString(
                                                                      'siklus',
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
                          icon: const Icon(
                            Icons.change_circle,
                          ))
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
                        element.tema!
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
              FloatingActionButton.extended(
                onPressed: () async {
  final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getDataModeller));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g = jsonResponse.map((data) => ModellerModel.fromJson(data)).toList();
      apiIdDataModeller = g.last.id.toString();
      var filterByMonth = g.where((element) => element.bulan.toString().toLowerCase() == nowSiklus.toString().toLowerCase()).toList();
      var filterBynoUrut =
       filterByMonth.where((element) => element.noUrutBulan! > 0).toList();
    
      apiNoUrutDataModeller = 
      filterByMonth.isEmpty ? '0'
      : filterBynoUrut.last.noUrutBulan.toString();
    print(apiNoUrutDataModeller);
    } else {
      throw Exception('Unexpected error occured!');
    }

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        
                        String? jenisBatu;
                        String? statusSPK;
                        String? brand;
                        final _formKey = GlobalKey<FormState>();
                        TextEditingController temaDataModeller = TextEditingController();
                        TextEditingController kodeDesignDataModeller = TextEditingController();
                        TextEditingController idDataModeller = TextEditingController();
                        TextEditingController noUrutDataModeller = TextEditingController();
                        TextEditingController kodeMarketingDataModeller = TextEditingController();
                        TextEditingController marketingDataModeller = TextEditingController();
                        TextEditingController namaDesignerDataModeller = TextEditingController();
                        TextEditingController namaModellerDataModeller = TextEditingController();
                        TextEditingController keteranganDataModeller =
                            TextEditingController();
                        RoundedLoadingButtonController btnController =
                            RoundedLoadingButtonController();
                            idDataModeller.text = apiIdDataModeller!;
                            noUrutDataModeller.text = apiNoUrutDataModeller!;
                        return 
                        
                        StatefulBuilder(
                                                                      builder: (context,
                                                                              setState) =>
                                                                        
                        AlertDialog(
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
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      //Kode Design
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: kodeDesignDataModeller,
                                          decoration: InputDecoration(
                                            // hintText: "example: Cahaya Sanivokasi",
                                            labelText: "Kode Design",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          
                                        ),
                                      ),

                                      //Jenis Batu
                                      Container(
padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: jenisBatu != null
                                                    ? const Color.fromARGB(
                                                        255, 8, 209, 69)
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
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
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
                                                  hint:
                                                      const Text('Jenis Batu'),
                                                  onChanged: (value) {
                                                    jenisBatu = value;
                                                    print(
                                                        "You have selected $value");
                                                             setState(() => jenisBatu);
                                                  
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: TextFormField(
                                                readOnly: true,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: idDataModeller,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "ID",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: noUrutDataModeller,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "No Urut",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: kodeMarketingDataModeller,
                                          decoration: InputDecoration(
                                            // hintText: "example: Cahaya Sanivokasi",
                                            labelText: "Kode Marketing",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Wajib diisi *';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      //! status memilih no atau ro
                                     Container(
padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: statusSPK != null
                                                    ? const Color.fromARGB(
                                                        255, 8, 209, 69)
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
                                                    0), //border raiuds of dropdown button
                                                boxShadow: const <BoxShadow>[
                                                ]),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
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
                                                  hint:
                                                      const Text('NO Atau RO'),
                                                  onChanged: (value) {
                                                    statusSPK = value;
                                                    print(
                                                        "You have selected $value");
                                                        value == 'RO' ? noUrutDataModeller.text ='' : noUrutDataModeller.text = (int.parse(apiNoUrutDataModeller!) + 1).toString(); 
                                                             setState(() => statusSPK);
                                                  
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: temaDataModeller,
                                          decoration: InputDecoration(
                                            labelText: "Tema / Project",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                        ),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: marketingDataModeller,
                                          decoration: InputDecoration(
                                            labelText: "Marketing",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                        ),
                                      ),
                                      Container(
padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: brand != null
                                                    ? const Color.fromARGB(
                                                        255, 8, 209, 69)
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
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
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
                                                  hint:
                                                      const Text('Brand'),
                                                  onChanged: (value) {
                                                    brand = value;
                                                    print(
                                                        "You have selected $value");
                                                             setState(() => brand);
                                                  
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: namaDesignerDataModeller,
                                          decoration: InputDecoration(
                                            labelText: "Nama Designer",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                        ),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: namaModellerDataModeller,
                                          decoration: InputDecoration(
                                            labelText: "Nama Modeller",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: keteranganDataModeller,
                                          decoration: InputDecoration(
                                            // hintText: "example: Cahaya Sanivokasi",
                                            labelText: "Keterangan",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
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
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  Future.delayed(const Duration(
                                                          seconds: 2))
                                                      .then((value) async {
                                                    btnController.success();
                                                    Map<String, dynamic> body =
                                                        {
                                                  'kodeDesign' : kodeDesignDataModeller.text,
                                                  'jenisBatu' : jenisBatu,
                                                  'bulan' : nowSiklus,
                                                  'kodeBulan': kodeBulan,
                                                  'noUrutBulan': noUrutDataModeller.text,
                                                  'kodeMarketing': kodeMarketingDataModeller.text,
                                                  'status': jenisBatu,
                                                  'marketing': marketingDataModeller.text,
                                                  'brand': brand,
                                                  'designer': namaDesignerDataModeller.text,
                                                  'modeller': namaModellerDataModeller.text,
                                                  'keterangan': keteranganDataModeller.text
                                                    };
                                                    final response = await http.post(
                                                        Uri.parse(ApiConstants
                                                                .baseUrl +
                                                            ApiConstants
                                                                .postDataModeller),
                                                        body: body);
                                                    print(response.body);
                                                    Future.delayed(
                                                            const Duration(
                                                                seconds: 1))
                                                        .then((value) {
                                                      btnController
                                                          .reset(); //reset
                                                       showSimpleNotification(
            const Text('Tambah Data Modeller Berhasil'),
            background: Colors.green,
            duration: const Duration(seconds: 1),
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
                                                  btnController.error();
                                                  Future.delayed(const Duration(
                                                          seconds: 1))
                                                      .then((value) {
                                                    btnController
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
                            ],
                          ),
                        ));
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
              ),
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * 1,
                          child: SizedBox(
                            width: double.infinity,
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
                                  columnSpacing: 2,
                                  columns: [
                                    // kode Design
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
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
                                              filterListDataModeller!.sort((a, b) => a
                                                  .kodeDesign!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.kodeDesign!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListDataModeller!.sort((a, b) => b
                                                  .kodeDesign!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.kodeDesign!.toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    // Jenis batu
                                    const DataColumn(
                                        label: SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Jenis Batu",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        ),
                                    DataColumn(label: _verticalDivider),
                                    // ID
                                    const DataColumn(
                                        label: SizedBox(
                                            width: 120,
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
                                            width: 120,
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
                                            width: 120,
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
                                            width: 120,
                                            child: Text(
                                              "Kode Marketing",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        ),

                                    DataColumn(label: _verticalDivider),
                                    // NO / RO
                                    const DataColumn(
                                        label: SizedBox(
                                            width: 120,
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
                                            width: 120,
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
                                            width: 120,
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
                                            width: 120,
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
                                            width: 120,
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
                                            width: 120,
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
                                            width: 120,
                                            child: Text(
                                              "Keterangan",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        ),

                                    DataColumn(label: _verticalDivider),
                                    //AKSI
                                    sharedPreferences!.getString('level') != '1'
                                        ? const DataColumn(label: SizedBox())
                                        : DataColumn(
                                            label: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                width: 120,
                                                child: const Text(
                                                  "AKSI",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                  ],
                                  source:
                                      // UserDataTableSource(userData: filterCrm!)),
                                      RowSource(
                                          myData: _listDataModeller,
                                          count: _listDataModeller!.length)),
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
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
      //kode Design
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.kodeDesign))
      ),
      DataCell(_verticalDivider),
      //Jenis Batu
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.jenisBatu)),
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
        Padding(padding: const EdgeInsets.all(0), child: Text(data.noUrutBulan.toString())),
      ),
      DataCell(_verticalDivider),
      //kode marketing
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.kodeMarketing))
      ),
      DataCell(_verticalDivider),
      //no at ro
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.status)),
      ),
      DataCell(_verticalDivider),
      //project tema
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.tema)),
      ),
      DataCell(_verticalDivider),
      //marketing
      DataCell(
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
        Padding(padding: const EdgeInsets.all(0), child: Text(data.keterangan)),
      ),
      

      DataCell(_verticalDivider),
      //Aksi
      DataCell(Builder(builder: (context) {
        return sharedPreferences!.getString('level') != '1'
            ? const Row()
            : Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'Perhatian',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Row(
                            children: [
                              const Text(
                                'Apakah anda yakin ingin menghapus data batu ',
                              ),
                              Text(
                                '${data.size}  ?',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(
                                context,
                                'Batal',
                              ),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () async {
                                var id = data.id.toString();
                                Map<String, String> body = {'id': id};
                                final response = await http.post(
                                    Uri.parse(ApiConstants.baseUrl +
                                        ApiConstants.postDeleteBatuById),
                                    body: body);
                                print(response.body);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => const MainViewBatu()));
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        const AlertDialog(
                                          title: Text(
                                            'Hapus Batu Berhasil',
                                          ),
                                        ));
                              },
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final _formKey = GlobalKey<FormState>();
                              TextEditingController lot =
                                  TextEditingController();
                              TextEditingController size =
                                  TextEditingController();
                              TextEditingController parcel =
                                  TextEditingController();
                              TextEditingController qty =
                                  TextEditingController();
                              String id;

                              id = data.id.toString();
                              lot.text = data.lot;
                              size.text = data.size;
                              parcel.text = data.parcel;
                              qty.text = data.qty.toString();
                              RoundedLoadingButtonController btnController =
                                  RoundedLoadingButtonController();
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
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          //lot
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: lot,
                                              decoration: InputDecoration(
                                                // hintText: "example: Cahaya Sanivokasi",
                                                labelText: "Lot",
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
                                          ),
                                          //size
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: size,
                                              decoration: InputDecoration(
                                                // hintText: "example: Cahaya Sanivokasi",
                                                labelText: "Ukuran",
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
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: parcel,
                                              decoration: InputDecoration(
                                                // hintText: "example: Cahaya Sanivokasi",
                                                labelText: "Parcel",
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
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: qty,
                                              decoration: InputDecoration(
                                                // hintText: "example: Cahaya Sanivokasi",
                                                labelText: "Qty",
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
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: 250,
                                              child: CustomLoadingButton(
                                                  controller: btnController,
                                                  child: const Text("Update"),
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                      Future.delayed(
                                                              const Duration(
                                                                  seconds: 2))
                                                          .then((value) async {
                                                        btnController.success();
                                                        Map<String, dynamic>
                                                            body = {
                                                          'id': id,
                                                          'lot': lot.text,
                                                          'size': size.text,
                                                          'parcel': parcel.text,
                                                          'qty': qty.text,
                                                        };
                                                        final response = await http.post(
                                                            Uri.parse(ApiConstants
                                                                    .baseUrl +
                                                                ApiConstants
                                                                    .postUpdateListDataBatu),
                                                            body: body);
                                                        print(response.body);
                                                        Future.delayed(
                                                                const Duration(
                                                                    seconds: 1))
                                                            .then((value) {
                                                          btnController
                                                              .reset(); //reset
                                                          showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  const AlertDialog(
                                                                    title: Text(
                                                                      'Update Berhasil',
                                                                    ),
                                                                  ));
                                                        });
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (c) =>
                                                                    const MainViewBatu()));
                                                      });
                                                    } else {
                                                      btnController.error();
                                                      Future.delayed(
                                                              const Duration(
                                                                  seconds: 1))
                                                          .then((value) {
                                                        btnController
                                                            .reset(); //reset
                                                      });
                                                    }
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              );
      }))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

class RowSourceMode2 extends DataTableSource {
  var myData;
  final count;
  RowSourceMode2({
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
      //lot
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.lot)),
      ),
      DataCell(_verticalDivider),
      //ukuran
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      DataCell(_verticalDivider),
      //parcel
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.parcel)),
      ),
      DataCell(_verticalDivider),
      //qty
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.qty.toString())),
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
