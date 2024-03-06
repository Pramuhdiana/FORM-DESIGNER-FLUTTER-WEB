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
  List<String>? listMenu;
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
    loadData();
  }

  String getHuruf(int angka) {
    return String.fromCharCode(angka + 64);
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });
    await _getListMenu();
    await _getData();
    setState(() {
      isLoading = false;
    });
  }

  _getData() async {
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
    listMenu = [];
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListMenu));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => MenuModel.fromJson(data)).toList();
      for (var i = 0; i < allData.length; i++) {
        listMenu!.add(allData[i].menu!);
      }
      setState(() {
        _listMenu = allData;
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
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
                                        onRowPressed: () {
                                          loadData();
                                        }, //! mengirim data untuk me refresh state
                                        listNamaMenu: listMenu!,
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
  final VoidCallback onRowPressed; //* menerima data untuk me refresh screen
  var myData;
  var myDataMenu;
  final count;
  List<List<String>> dataListMenu;
  List<String> listDivisi = [];
  List<String> listNamaMenu = [];
  List<String> listIdMenu = [];
  List<bool> selectedList = List.generate(
      100, (index) => false); // List untuk menyimpan status pilihan

  RowSource({
    required this.myData,
    required this.myDataMenu,
    required this.onRowPressed,
    required this.count,
    required this.context,
    required this.dataListMenu,
    required this.listNamaMenu,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context, dataListMenu[index],
          dataListMenu[index].length, myDataMenu, index);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(var data, BuildContext context, var dataListMenu,
      int countList, var dataMenu, int i) {
    return DataRow(cells: [
      //Aksi
      DataCell(Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            onPressed: () {},
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
        onLongPress: () {},
        Padding(padding: const EdgeInsets.all(0), child: Text(data.nama)),
      ),

      DataCell(_verticalDivider),
      //Email
      DataCell(
        onLongPress: () {},
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
                  onPressed: () {
                    selectedList =
                        List.generate(listNamaMenu.length, (index) => false);

                    dataListMenu.forEach((item) {
                      selectedList[int.parse(item) - 1] = true;
                    });
                    showGeneralDialog(
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {
                          return const Text('');
                        },
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                              scale: a1.value,
                              child: Opacity(
                                  opacity: a1.value,
                                  child: StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      content: SizedBox(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Pilih list menu untuk ${data.nama}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              for (var j = 0;
                                                  j < listNamaMenu.length;
                                                  j++)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                listNamaMenu[j]
                                                                            .toString()
                                                                            .toLowerCase() ==
                                                                        'orul'
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .blue,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0))),
                                                        onPressed: () {
                                                          setState(() {
                                                            selectedList[j] =
                                                                !selectedList[
                                                                    j]; //* HINTS Mengubah nilai selectedList[j] menjadi kebalikan dari nilai sebelumnya
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${j + 1}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              listNamaMenu[j],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Checkbox(
                                                          value:
                                                              selectedList[j],
                                                          onChanged: null)
                                                    ],
                                                  ),
                                                ),
                                              Container(
                                                width: 350,
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                    onPressed: () {
                                                      Navigator.pop(context);

                                                      for (int i = 0;
                                                          i <
                                                              selectedList
                                                                  .length;
                                                          i++) {
                                                        if (selectedList[i]) {
                                                          listIdMenu
                                                              .add('${i + 1}');
                                                        }
                                                      }

                                                      simpanForm(
                                                          data.id.toString());
                                                    },
                                                    child:
                                                        const Text('Simpan')),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )));
                        });
                  },
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

  simpanForm(String idUser) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal on tap outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Loading, please wait...',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
    await updateMenu(idUser);

    Navigator.pop(context);
    onRowPressed();
  }

  updateMenu(idUser) async {
    try {
      String stringListMenu = listIdMenu.join(',');
      Map<String, String> body = {
        'type': 'updateMenuUser',
        'id': idUser,
        'listMenu': stringListMenu,
      };
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.restFullApi}'),
          body: jsonEncode(body));
      print(response.body);
    } catch (e) {
      print('err update menu $e');
    }
  }

  Future<String> getMenu(String id) async {
    String namaMenu = '';

    // Pastikan myDataMenu tidak null
    if (myDataMenu != null) {
      // Filter myDataMenu berdasarkan idMenu
      var filteredList = myDataMenu!
          .where((element) =>
              element.idMenu.toString().toLowerCase() ==
              id.toString().toLowerCase())
          .toList();

      // Periksa apakah ada data yang ditemukan
      if (filteredList.isNotEmpty) {
        var item = filteredList.first;
        // Periksa jika nilai menu tidak null
        if (item.menu != null) {
          namaMenu = item.menu!;
        }
      } else {
        namaMenu = 'Data tidak ditemukan';
      }
    } else {
      namaMenu = 'Data tidak tersedia';
    }

    // Kembalikan hasil dengan format string yang diinginkan
    return namaMenu;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
