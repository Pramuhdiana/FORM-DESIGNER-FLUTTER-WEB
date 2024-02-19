// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_designer/admin/menu_model.dart';
import 'package:form_designer/admin/users_model.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_batu.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
import 'package:form_designer/model/jenis_barang_model.dart';
import 'package:form_designer/model/modeller_model.dart';
import 'package:form_designer/pembelian/add_form_pr.dart';
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

class ListUser extends StatefulWidget {
  const ListUser({super.key});
  @override
  State<ListUser> createState() => _ListUserState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListUserState extends State<ListUser> {
  List<UsersModel>? filterListDataUsers;
  List<UsersModel>? _listDataUsers;
  List<MenuModel>? _listMenu;
  TextEditingController controller = TextEditingController();
  TextEditingController kodeAkses = TextEditingController();
  bool sort = true;
  bool isKodeAkses = false;
  bool isLoading = false;
  int? page;
  int? limit;
  final int _currentSortColumn = 0;
  int _rowsPerPage = 10;
  var nowSiklus = '';
  var kodeBulan = '';
  List<List<String>> dataListMenu = [];
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
    _getListMenu();
    _getData();
  }

  String getHuruf(int angka) {
    return String.fromCharCode(angka + 64);
  }

  _getData() async {
    setState(() {
      isLoading = true;
    });
    List<String> idMenu = [];
    dataListMenu.clear();
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListUsers));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => UsersModel.fromJson(data)).toList();
      for (var i = 0; i < allData.length; i++) {
        idMenu = [];
        if (allData[i].listMenu == '') {
          dataListMenu.add([]);
        } else {
          idMenu = allData[i].listMenu!.split(',').map((String number) {
            return number.toString().trim();
          }).toList();

          dataListMenu.add(idMenu);
        }

        // idMenu[i][j] =
      }
      setState(() {
        print(dataListMenu);
        _listDataUsers = allData;
        filterListDataUsers = allData;
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getListMenu() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListMenu));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => MenuModel.fromJson(data)).toList();
      // print(_listMenu!.where((menu) => menu.idMenu.toString() == '2'));

      // Mencari menu dengan ID yang sesuai dari variabel allData
      int targetId = 2;
      MenuModel? targetMenu = allData.firstWhere(
        (menu) => menu.idMenu == targetId,
        // ignore: cast_from_null_always_fails
        orElse: () => null as MenuModel,
      );

      // ignore: unnecessary_null_comparison
      if (targetMenu != null) {
        print('Menu dengan ID $targetId: ${targetMenu.nama}');
      } else {
        print('Menu dengan ID $targetId tidak ditemukan');
      }
      setState(() {
        _listMenu = allData;
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
    setState(() {
      isLoading = false;
    });
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
                _listDataUsers = filterListDataUsers!
                    .where((element) =>
                        element.nama!
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element.divisi!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
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
                  'List Data User',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  List<String> listEmail = [];
                  for (var i = 0; i < _listDataUsers!.length; i++) {
                    listEmail.add(_listDataUsers![i]
                        .email!
                        .toString()
                        .toLowerCase()
                        .trim());
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final _formKey = GlobalKey<FormState>();
                        bool _obscureText = true;
                        TextEditingController nama = TextEditingController();
                        TextEditingController email = TextEditingController();
                        TextEditingController password =
                            TextEditingController();
                        TextEditingController level = TextEditingController();
                        TextEditingController divisi = TextEditingController();
                        TextEditingController role = TextEditingController();
                        // ignore: unused_local_variable
                        TextEditingController listMenu =
                            TextEditingController();
                        RoundedLoadingButtonController btnController =
                            RoundedLoadingButtonController();
                        return StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                                  content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Form Add User',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: nama,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Nama",
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: email,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Email",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                ),
                                                onChanged: (value) {
                                                  if (listEmail.contains(value
                                                      .toString()
                                                      .toLowerCase()
                                                      .trim())) {
                                                    showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            const AlertDialog(
                                                              title: Text(
                                                                'Email sudah terdaftar',
                                                              ),
                                                            ));
                                                  } else {}
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Wajib diisi *';
                                                  }

                                                  return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                obscureText: _obscureText,
                                                style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: password,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Password",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _obscureText
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: _obscureText
                                                          ? Colors.grey
                                                          : Colors.blue,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _obscureText =
                                                            !_obscureText;
                                                      });
                                                    },
                                                  ),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: level,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Level",
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
                                              child: TextFormField(
                                                style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: divisi,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Divisi",
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: role,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Role",
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 250,
                                                child: CustomLoadingButton(
                                                    controller: btnController,
                                                    child: const Text(
                                                        "Simpan Data"),
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
                                                          btnController
                                                              .success();
                                                          Map<String, dynamic>
                                                              body = {
                                                            'nama': nama.text,
                                                            'email': email.text,
                                                            'password':
                                                                password.text,
                                                            'level': level.text,
                                                            'divisi':
                                                                divisi.text,
                                                            'role': role.text
                                                          };
                                                          final response = await http.post(
                                                              Uri.parse(ApiConstants
                                                                      .baseUrl +
                                                                  ApiConstants
                                                                      .createUsers),
                                                              body: body);
                                                          print(response.body);
                                                          Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          10))
                                                              .then((value) {
                                                            btnController
                                                                .reset(); //reset
                                                            response.statusCode !=
                                                                    200
                                                                ? showSimpleNotification(
                                                                    const Text(
                                                                        'Tambah Data User Gagal'),
                                                                    background:
                                                                        Colors
                                                                            .red,
                                                                    duration: const Duration(
                                                                        seconds:
                                                                            10))
                                                                : showSimpleNotification(
                                                                    const Text(
                                                                        'Tambah Data User Berhasil'),
                                                                    background:
                                                                        Colors
                                                                            .green,
                                                                    duration: const Duration(
                                                                        seconds:
                                                                            1),
                                                                  );
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          _getData();
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
                label: const Text(
                  "Tambah Data User",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add_circle_outline_sharp,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
              ),
              isLoading == true
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

                                  // Nama
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Nama",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  // Email
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  // Level
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Level",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),
                                  // Divisi
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Divisi",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),
                                  // Role
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Role",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),

                                  DataColumn(label: _verticalDivider),

                                  // List Menu
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "List Menu",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  DataColumn(label: _verticalDivider),

                                  // Status Active
                                  const DataColumn(
                                    label: SizedBox(
                                        child: Text(
                                      "Status Active",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ],
                                source:
                                    // UserDataTableSource(userData: filterCrm!)),
                                    RowSource(
                                        myDataMenu: _listMenu,
                                        dataListMenu: dataListMenu,
                                        context: context,
                                        myData: _listDataUsers,
                                        count: _listDataUsers!.length)),
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
}

class RowSource extends DataTableSource {
  BuildContext context;
  var myData;
  var myDataMenu;
  final count;
  List<List<String>> dataListMenu;
  RowSource({
    required this.myData,
    required this.myDataMenu,
    required this.count,
    required this.context,
    required this.dataListMenu,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context, dataListMenu[index],
          dataListMenu[index].length, myDataMenu);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data, BuildContext context, var dataListMenu,
      int countList, var dataMenu) {
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

      //Nama
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
        Padding(padding: const EdgeInsets.all(0), child: Text(data.nama)),
      ),

      DataCell(_verticalDivider),
      //Email
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
        Container(padding: const EdgeInsets.all(0), child: Text(data.email)),
      ),

      DataCell(_verticalDivider),
      //level
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.level.toString())),
      ),
      DataCell(_verticalDivider),
      //divisi
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.divisi)),
      ),
      DataCell(_verticalDivider),
      //role
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.role.toString())),
      ),
      DataCell(_verticalDivider),
      //list menu
      DataCell(Builder(builder: (context) {
        return Expanded(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_to_photos_rounded,
                    color: Colors.green,
                  )),
              // for(var i = 0; i < count; i++)
              Text(dataListMenu.toString()),
            ],
          ),
        );
      })),
      DataCell(_verticalDivider),

      //status active
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.status.toString())),
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
