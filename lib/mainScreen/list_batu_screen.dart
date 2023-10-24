// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:overlay_support/overlay_support.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/mainScreen/side_screen_batu.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../api/api_constant.dart';
import '../global/global.dart';
import '../model/list_batu_model.dart';
import '../widgets/custom_loading.dart';

class ListBatuScreen extends StatefulWidget {
  const ListBatuScreen({super.key});
  @override
  State<ListBatuScreen> createState() => _ListBatuScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListBatuScreenState extends State<ListBatuScreen> {
  List<ListBatuModel>? filterListBatu;
  List<ListBatuModel>? filterListBatuMode2;
  List<ListBatuModel>? _listBatu;
  List<ListBatuModel>? _listBatuMode2;
  TextEditingController controller = TextEditingController();
  bool sort = true;
  bool isLoading = false;
  int? page;
  int? limit;
  int _currentSortColumn = 0;
  bool _switchValue = false;

  @override
  initState() {
    super.initState();
    page = 0;
    limit = 20;
    // _getDataByPagenLimit();
    _getData();
    _getDataMode2();
  }

  Future<List<ListBatuModel>> _getData() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getDataBatu));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g = jsonResponse.map((data) => ListBatuModel.fromJson(data)).toList();
      setState(() {
        _listBatu = g;
        filterListBatu = g;
        isLoading = true;
      });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<ListBatuModel>> _getDataMode2() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getDataBatu));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var g = jsonResponse.map((data) => ListBatuModel.fromJson(data)).toList();

      var modifiedUserData = g.where((element) => element.qty! < 0);

      setState(() {
        _listBatuMode2 = modifiedUserData.toList();
        filterListBatuMode2 = modifiedUserData.toList();
        isLoading = true;
      });

      return g;
    } else {
      throw Exception(response.statusCode);
    }
  }

//! function send file to api
  Future<void> sendFileToApi(File file, String url) async {
    // ignore: unnecessary_null_comparison
    if (file == null) {
      throw ArgumentError('File cannot be null.');
    }

    if (url.isEmpty) {
      throw ArgumentError('URL cannot be empty.');
    }

    final request = http.MultipartRequest('POST', Uri.parse(url));
    final fileStream = http.ByteStream(file.openRead());
    final fileLength = await file.length();

    final multipartFile = http.MultipartFile(
      'file',
      fileStream,
      fileLength,
      filename: file.path.split('/').last,
    );

    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode != 200) {
      throw HttpException(
          'Failed to send file. Status code: ${response.statusCode}');
    }
  }

//! end fungsi send file api

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: null_check_always_fails
      onWillPop: () async => null!,
      child: Scaffold(
        // drawer: Drawer1(),
        appBar: _switchValue != true
            ? AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.blue,
                flexibleSpace: Container(
                  color: Colors.blue,
                ),
                title: const Text(
                  "LIST BATU",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                centerTitle: true,
                actions: sharedPreferences!.getString('level') != '1'
                    ? null
                    : [
                        CupertinoSwitch(
                          value: _switchValue,
                          onChanged: (value) async {
                            setState(() {
                              isLoading = false;
                            });
                            _switchValue = value;
                            Future.delayed(const Duration(seconds: 2))
                                .then((value) {
                              //! lalu eksekusi fungsi ini
                              setState(() {
                                isLoading = true;
                              });
                            });
                          },
                        ),
                      ],
              )
            : AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.black38,
                flexibleSpace: Container(
                  color: Colors.black38,
                ),
                title: const Text(
                  "LIST BATU YANG HARUS DI BELI",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                centerTitle: true,
                actions: [
                  CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (value) async {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
        body: _switchValue != true
            ? Container(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 45,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: "Search Anything ..."),
                          onChanged: (value) {
                            //fungsi search anyting
                            _listBatu = filterListBatu!
                                .where((element) =>
                                    element.lot!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.size
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.parcel!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.qty!
                                        .toString()
                                        .contains(value.toLowerCase()))
                                .toList();

                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600),
                            onPressed: () async {
                              // FilePickerResult? result =
                              //     await FilePicker.platform.pickFiles();

                              // if (result != null) {
                              //   PlatformFile file = result.files.first;
                              //   print(file.name);
                              //   print(file.size);
                              //   print(file.extension);
                              //   // print(file.path);
                              //   showSimpleNotification(
                              //     const Center(
                              //         child: Text(
                              //       'Import Data Berhasil',
                              //       style: TextStyle(
                              //           fontSize: 25,
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold),
                              //     )),
                              //     subtitle: const Center(
                              //         child: Text('Mohon segera refresh data')),
                              //     background: Colors.green,
                              //     duration: const Duration(seconds: 5),
                              //   );
                              //   // Fluttertoast.showToast(
                              //   //     msg: "Import Data Berhasil");
                              // } else {
                              //   // User canceled the picker
                              //   print('cancel pick');
                              // }

                              // // try {
                              // //   await sendFileToApi(
                              // //       result as File, ApiConstants.addSiklus);
                              // //   print('File sent successfully.');
                              // // } catch (e) {
                              // //   print('Error sending file: $e');
                              // // }
                            },
                            child: const Text('Import to excel'))),
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
                                        sortColumnIndex: _currentSortColumn,
                                        sortAscending: sort,
                                        rowsPerPage: 25,
                                        columnSpacing: 0,
                                        columns: [
                                          // LOT
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "LOT",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatu!.sort(
                                                        (a, b) => a
                                                            .lot!
                                                            .toLowerCase()
                                                            .compareTo(b.lot!
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterListBatu!.sort(
                                                        (a, b) => b
                                                            .lot!
                                                            .toLowerCase()
                                                            .compareTo(a.lot!
                                                                .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          //UKURAN
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "UKURAN",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatu!.sort(
                                                        (a, b) => a
                                                            .size
                                                            .toLowerCase()
                                                            .compareTo(b.size
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterListBatu!.sort(
                                                        (a, b) => b
                                                            .size
                                                            .toLowerCase()
                                                            .compareTo(a.size
                                                                .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          //PARCEL
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "PARCEL",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatu!.sort(
                                                        (a, b) => a
                                                            .parcel!
                                                            .toLowerCase()
                                                            .compareTo(b.parcel!
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterListBatu!.sort(
                                                        (a, b) => b
                                                            .parcel!
                                                            .toLowerCase()
                                                            .compareTo(a.parcel!
                                                                .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          //* carat / cps
                                          const DataColumn(
                                            label: SizedBox(
                                                width: 120,
                                                child: Text(
                                                  "CARAT PER PCS",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            // onSort: (columnIndex, _) {
                                            //   setState(() {
                                            //     _currentSortColumn =
                                            //         columnIndex;
                                            //     if (sort == true) {
                                            //       sort = false;
                                            //       filterListBatu!.sort((a, b) =>
                                            //           a.parcel!
                                            //               .toLowerCase()
                                            //               .compareTo(b.parcel!
                                            //                   .toLowerCase()));
                                            //     } else {
                                            //       sort = true;
                                            //       filterListBatu!.sort((a, b) =>
                                            //           b.parcel!
                                            //               .toLowerCase()
                                            //               .compareTo(a.parcel!
                                            //                   .toLowerCase()));
                                            //     }
                                            //   });
                                            // }
                                          ),
                                          DataColumn(label: _verticalDivider),
                                          //QTY
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "QTY",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatu!.sort(
                                                        (a, b) => b.qty!
                                                            .compareTo(a.qty!));
                                                  } else {
                                                    sort = true;
                                                    filterListBatu!.sort(
                                                        (a, b) => a.qty!
                                                            .compareTo(b.qty!));
                                                  }
                                                });
                                              }),
                                          sharedPreferences!
                                                      .getString('level') !=
                                                  '1'
                                              ? const DataColumn(
                                                  label: SizedBox())
                                              : DataColumn(
                                                  label: _verticalDivider),
                                          //AKSI
                                          sharedPreferences!
                                                      .getString('level') !=
                                                  '1'
                                              ? const DataColumn(
                                                  label: SizedBox())
                                              : DataColumn(
                                                  label: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30),
                                                      width: 120,
                                                      child: const Text(
                                                        "AKSI",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                ),
                                        ],
                                        source:
                                            // UserDataTableSource(userData: filterCrm!)),
                                            RowSource(
                                                myData: _listBatu,
                                                count: _listBatu!.length)),
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              )
            //? mode 2 (batu yang harus dibeli)
            : Container(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 45,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: "Search Anything ..."),
                          onChanged: (value) {
                            //fungsi search anyting
                            _listBatuMode2 = filterListBatuMode2!
                                .where((element) =>
                                    element.lot!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.size
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.parcel!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.qty!
                                        .toString()
                                        .contains(value.toLowerCase()))
                                .toList();

                            setState(() {});
                          },
                        ),
                      ),
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
                                        sortColumnIndex: _currentSortColumn,
                                        sortAscending: sort,
                                        rowsPerPage: 25,
                                        columnSpacing: 0,
                                        columns: [
                                          // LOT
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "LOT",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => a.lot!
                                                            .toLowerCase()
                                                            .compareTo(b.lot!
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => b.lot!
                                                            .toLowerCase()
                                                            .compareTo(a.lot!
                                                                .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          //UKURAN
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "UKURAN",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => a.size
                                                            .toLowerCase()
                                                            .compareTo(b.size
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => b.size
                                                            .toLowerCase()
                                                            .compareTo(a.size
                                                                .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          //PARCEL
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "PARCEL",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => a.parcel!
                                                            .toLowerCase()
                                                            .compareTo(b.parcel!
                                                                .toLowerCase()));
                                                  } else {
                                                    sort = true;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => b.parcel!
                                                            .toLowerCase()
                                                            .compareTo(a.parcel!
                                                                .toLowerCase()));
                                                  }
                                                });
                                              }),
                                          DataColumn(label: _verticalDivider),
                                          //QTY
                                          DataColumn(
                                              label: const SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "QTY",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              onSort: (columnIndex, _) {
                                                setState(() {
                                                  _currentSortColumn =
                                                      columnIndex;
                                                  if (sort == true) {
                                                    sort = false;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => b.qty!
                                                            .compareTo(a.qty!));
                                                  } else {
                                                    sort = true;
                                                    filterListBatuMode2!.sort(
                                                        (a, b) => a.qty!
                                                            .compareTo(b.qty!));
                                                  }
                                                });
                                              }),
                                          // DataColumn(label: _verticalDivider),
                                          // //AKSI
                                          // DataColumn(
                                          //   label: Container(
                                          //       padding:
                                          //           const EdgeInsets.only(left: 30),
                                          //       width: 120,
                                          //       child: const Text(
                                          //         "Aksi",
                                          //         style: TextStyle(
                                          //             fontSize: 15,
                                          //             fontWeight: FontWeight.bold),
                                          //       )),
                                          // ),
                                        ],
                                        source: RowSourceMode2(
                                            myData: _listBatuMode2,
                                            count: _listBatuMode2!.length)),
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
        floatingActionButton: sharedPreferences!.getString('level') != '1'
            ? null
            : _switchValue == true
                ? null
                : Stack(children: [
                    Positioned(
                      left: 40,
                      bottom: 5,
                      child: FloatingActionButton.extended(
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
                                TextEditingController caratPcs =
                                    TextEditingController();
                                TextEditingController keterangan =
                                    TextEditingController();
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
                                                controller: caratPcs,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Carat Pcs",
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
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: keterangan,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Keterangan",
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
                                                    controller: btnController,
                                                    child: const Text(
                                                        "Simpan Batu"),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        Future.delayed(
                                                                const Duration(
                                                                    seconds: 2))
                                                            .then(
                                                                (value) async {
                                                          btnController
                                                              .success();
                                                          print(lot.text);
                                                          print(size.text);
                                                          print(parcel.text);
                                                          print(qty.text);
                                                          print(caratPcs.text);
                                                          print(
                                                              keterangan.text);
                                                          Map<String, dynamic>
                                                              body = {
                                                            'lot': lot.text,
                                                            'size': size.text,
                                                            'parcel':
                                                                parcel.text,
                                                            'qty': qty.text,
                                                            'caratPcs':
                                                                caratPcs.text,
                                                            'keterangan':
                                                                keterangan.text,
                                                          };
                                                          final response = await http.post(
                                                              Uri.parse(ApiConstants
                                                                      .baseUrl +
                                                                  ApiConstants
                                                                      .postDataBatu),
                                                              body: body);
                                                          print(response.body);
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then((value) {
                                                            btnController
                                                                .reset(); //reset
                                                            showDialog<String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Tambah batu berhasil',
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
                        label: const Text(
                          "Tambah Batu",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.add_circle_outline_sharp,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ]),
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
      //CARAT /PCS
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.caratPcs)),
      ),
      DataCell(_verticalDivider),
      //qty
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.qty.toString())),
      ),
      sharedPreferences!.getString('level') != '1'
          ? const DataCell(SizedBox())
          : DataCell(_verticalDivider),
      sharedPreferences!.getString('level') != '1'
          ? const DataCell(SizedBox())
          :
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
                                              builder: (c) =>
                                                  const MainViewBatu()));
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
                                    RoundedLoadingButtonController
                                        btnController =
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
                                                    controller: lot,
                                                    decoration: InputDecoration(
                                                      // hintText: "example: Cahaya Sanivokasi",
                                                      labelText: "Lot",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                                    controller: size,
                                                    decoration: InputDecoration(
                                                      // hintText: "example: Cahaya Sanivokasi",
                                                      labelText: "Ukuran",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller: parcel,
                                                    decoration: InputDecoration(
                                                      // hintText: "example: Cahaya Sanivokasi",
                                                      labelText: "Parcel",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller: qty,
                                                    decoration: InputDecoration(
                                                      // hintText: "example: Cahaya Sanivokasi",
                                                      labelText: "Qty",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                                        controller:
                                                            btnController,
                                                        child: const Text(
                                                            "Update"),
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _formKey
                                                                .currentState!
                                                                .save();
                                                            Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            2))
                                                                .then(
                                                                    (value) async {
                                                              btnController
                                                                  .success();
                                                              Map<String,
                                                                      dynamic>
                                                                  body = {
                                                                'id': id,
                                                                'lot': lot.text,
                                                                'size':
                                                                    size.text,
                                                                'parcel':
                                                                    parcel.text,
                                                                'qty': qty.text,
                                                              };
                                                              final response = await http.post(
                                                                  Uri.parse(ApiConstants
                                                                          .baseUrl +
                                                                      ApiConstants
                                                                          .postUpdateListDataBatu),
                                                                  body: body);
                                                              print(response
                                                                  .body);
                                                              Future.delayed(
                                                                      const Duration(
                                                                          seconds:
                                                                              1))
                                                                  .then(
                                                                      (value) {
                                                                btnController
                                                                    .reset(); //reset
                                                                showDialog<
                                                                        String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        const AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            'Update Berhasil',
                                                                          ),
                                                                        ));
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (c) =>
                                                                              const MainViewBatu()));
                                                            });
                                                          } else {
                                                            btnController
                                                                .error();
                                                            Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            1))
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
      // DataCell(_verticalDivider),
      //Aksi
      //   DataCell(Builder(builder: (context) {
      //     return sharedPreferences!.getString('level') != '1'
      //         ? const Row()
      //         : Row(
      //             children: [
      //               IconButton(
      //                 onPressed: () {
      //                   showDialog<String>(
      //                     context: context,
      //                     builder: (BuildContext context) => AlertDialog(
      //                       title: const Text(
      //                         'Perhatian',
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(
      //                             color: Colors.black,
      //                             fontWeight: FontWeight.bold),
      //                       ),
      //                       content: Row(
      //                         children: [
      //                           const Text(
      //                             'Apakah anda yakin ingin menghapus data batu ',
      //                           ),
      //                           Text(
      //                             '${data.size}  ?',
      //                             style: const TextStyle(
      //                                 fontWeight: FontWeight.bold,
      //                                 color: Colors.black),
      //                           ),
      //                         ],
      //                       ),
      //                       actions: <Widget>[
      //                         TextButton(
      //                           onPressed: () => Navigator.pop(
      //                             context,
      //                             'Batal',
      //                           ),
      //                           child: const Text('Batal'),
      //                         ),
      //                         TextButton(
      //                           onPressed: () async {
      //                             var id = data.id.toString();
      //                             Map<String, String> body = {'id': id};
      //                             final response = await http.post(
      //                                 Uri.parse(ApiConstants.baseUrl +
      //                                     ApiConstants.postDeleteBatuById),
      //                                 body: body);
      //                             print(response.body);

      //                             Navigator.push(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                     builder: (c) => const MainViewBatu()));
      //                             showDialog<String>(
      //                                 context: context,
      //                                 builder: (BuildContext context) =>
      //                                     const AlertDialog(
      //                                       title: Text(
      //                                         'Hapus Batu Berhasil',
      //                                       ),
      //                                     ));
      //                           },
      //                           child: const Text(
      //                             'Hapus',
      //                             style: TextStyle(color: Colors.red),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   );
      //                 },
      //                 icon: const Icon(
      //                   Icons.delete,
      //                   color: Colors.red,
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 25),
      //                 child: IconButton(
      //                   onPressed: () {
      //                     showDialog(
      //                         context: context,
      //                         builder: (BuildContext context) {
      //                           final _formKey = GlobalKey<FormState>();
      //                           TextEditingController lot =
      //                               TextEditingController();
      //                           TextEditingController size =
      //                               TextEditingController();
      //                           TextEditingController parcel =
      //                               TextEditingController();
      //                           TextEditingController qty =
      //                               TextEditingController();
      //                           String id;

      //                           id = data.id.toString();
      //                           lot.text = data.lot;
      //                           size.text = data.size;
      //                           parcel.text = data.parcel;
      //                           qty.text = data.qty.toString();
      //                           RoundedLoadingButtonController btnController =
      //                               RoundedLoadingButtonController();
      //                           return AlertDialog(
      //                             content: Stack(
      //                               clipBehavior: Clip.none,
      //                               children: <Widget>[
      //                                 Positioned(
      //                                   right: -47.0,
      //                                   top: -47.0,
      //                                   child: InkResponse(
      //                                     onTap: () {
      //                                       Navigator.of(context).pop();
      //                                     },
      //                                     child: const CircleAvatar(
      //                                       backgroundColor: Colors.red,
      //                                       child: Icon(Icons.close),
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 Form(
      //                                   key: _formKey,
      //                                   child: Column(
      //                                     mainAxisSize: MainAxisSize.min,
      //                                     children: <Widget>[
      //                                       //lot
      //                                       Padding(
      //                                         padding: const EdgeInsets.all(8.0),
      //                                         child: TextFormField(
      //                                           style: const TextStyle(
      //                                               fontSize: 14,
      //                                               color: Colors.black,
      //                                               fontWeight: FontWeight.bold),
      //                                           textInputAction:
      //                                               TextInputAction.next,
      //                                           controller: lot,
      //                                           decoration: InputDecoration(
      //                                             // hintText: "example: Cahaya Sanivokasi",
      //                                             labelText: "Lot",
      //                                             border: OutlineInputBorder(
      //                                                 borderRadius:
      //                                                     BorderRadius.circular(
      //                                                         5.0)),
      //                                           ),
      //                                           validator: (value) {
      //                                             if (value!.isEmpty) {
      //                                               return 'Wajib diisi *';
      //                                             }
      //                                             return null;
      //                                           },
      //                                         ),
      //                                       ),
      //                                       //size
      //                                       Padding(
      //                                         padding: const EdgeInsets.all(8.0),
      //                                         child: TextFormField(
      //                                           style: const TextStyle(
      //                                               fontSize: 14,
      //                                               color: Colors.black,
      //                                               fontWeight: FontWeight.bold),
      //                                           textInputAction:
      //                                               TextInputAction.next,
      //                                           controller: size,
      //                                           decoration: InputDecoration(
      //                                             // hintText: "example: Cahaya Sanivokasi",
      //                                             labelText: "Ukuran",
      //                                             border: OutlineInputBorder(
      //                                                 borderRadius:
      //                                                     BorderRadius.circular(
      //                                                         5.0)),
      //                                           ),
      //                                           validator: (value) {
      //                                             if (value!.isEmpty) {
      //                                               return 'Wajib diisi *';
      //                                             }
      //                                             return null;
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.all(8.0),
      //                                         child: TextFormField(
      //                                           style: const TextStyle(
      //                                               fontSize: 14,
      //                                               color: Colors.black,
      //                                               fontWeight: FontWeight.bold),
      //                                           textInputAction:
      //                                               TextInputAction.next,
      //                                           controller: parcel,
      //                                           decoration: InputDecoration(
      //                                             // hintText: "example: Cahaya Sanivokasi",
      //                                             labelText: "Parcel",
      //                                             border: OutlineInputBorder(
      //                                                 borderRadius:
      //                                                     BorderRadius.circular(
      //                                                         5.0)),
      //                                           ),
      //                                           validator: (value) {
      //                                             if (value!.isEmpty) {
      //                                               return 'Wajib diisi *';
      //                                             }
      //                                             return null;
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.all(8.0),
      //                                         child: TextFormField(
      //                                           style: const TextStyle(
      //                                               fontSize: 14,
      //                                               color: Colors.black,
      //                                               fontWeight: FontWeight.bold),
      //                                           textInputAction:
      //                                               TextInputAction.next,
      //                                           controller: qty,
      //                                           decoration: InputDecoration(
      //                                             // hintText: "example: Cahaya Sanivokasi",
      //                                             labelText: "Qty",
      //                                             border: OutlineInputBorder(
      //                                                 borderRadius:
      //                                                     BorderRadius.circular(
      //                                                         5.0)),
      //                                           ),
      //                                           validator: (value) {
      //                                             if (value!.isEmpty) {
      //                                               return 'Wajib diisi *';
      //                                             }

      //                                             return null;
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.all(8.0),
      //                                         child: SizedBox(
      //                                           width: 250,
      //                                           child: CustomLoadingButton(
      //                                               controller: btnController,
      //                                               child: const Text("Update"),
      //                                               onPressed: () async {
      //                                                 if (_formKey.currentState!
      //                                                     .validate()) {
      //                                                   _formKey.currentState!
      //                                                       .save();
      //                                                   Future.delayed(
      //                                                           const Duration(
      //                                                               seconds: 2))
      //                                                       .then((value) async {
      //                                                     btnController.success();
      //                                                     Map<String, dynamic>
      //                                                         body = {
      //                                                       'id': id,
      //                                                       'lot': lot.text,
      //                                                       'size': size.text,
      //                                                       'parcel': parcel.text,
      //                                                       'qty': qty.text,
      //                                                     };
      //                                                     final response = await http.post(
      //                                                         Uri.parse(ApiConstants
      //                                                                 .baseUrl +
      //                                                             ApiConstants
      //                                                                 .postUpdateListDataBatu),
      //                                                         body: body);
      //                                                     print(response.body);
      //                                                     Future.delayed(
      //                                                             const Duration(
      //                                                                 seconds: 1))
      //                                                         .then((value) {
      //                                                       btnController
      //                                                           .reset(); //reset
      //                                                       showDialog<String>(
      //                                                           context: context,
      //                                                           builder: (BuildContext
      //                                                                   context) =>
      //                                                               const AlertDialog(
      //                                                                 title: Text(
      //                                                                   'Update Berhasil',
      //                                                                 ),
      //                                                               ));
      //                                                     });
      //                                                     Navigator.push(
      //                                                         context,
      //                                                         MaterialPageRoute(
      //                                                             builder: (c) =>
      //                                                                 const MainViewBatu()));
      //                                                   });
      //                                                 } else {
      //                                                   btnController.error();
      //                                                   Future.delayed(
      //                                                           const Duration(
      //                                                               seconds: 1))
      //                                                       .then((value) {
      //                                                     btnController
      //                                                         .reset(); //reset
      //                                                   });
      //                                                 }
      //                                               }),
      //                                         ),
      //                                       )
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           );
      //                         });
      //                   },
      //                   icon: const Icon(
      //                     Icons.edit,
      //                     color: Colors.green,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           );
      //   }))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
