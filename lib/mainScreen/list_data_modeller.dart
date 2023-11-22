// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_batu.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
  List<ListBatuModel>? filterListBatu;
  List<ListBatuModel>? filterListBatuMode2;
  List<ListBatuModel>? _listBatu;
  TextEditingController controller = TextEditingController();
  bool sort = true;
  bool isLoading = false;
  int? page;
  int? limit;
  int _currentSortColumn = 0;
  int _rowsPerPage = 50;
  var nowSiklus = '';
  TextEditingController addSiklus = TextEditingController();

  @override
  initState() {
    super.initState();
    nowSiklus = sharedPreferences!.getString('siklus')!;
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
                        element.qty!.toString().contains(value.toLowerCase()))
                    .toList();

                setState(() {});
              },
            ),
          ),
        ),

        body: Container(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                                  columnSpacing: 0,
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
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),
                                    // Jenis Batu
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Jenis Batu",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),
                                    // ID
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "ID",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Bulan
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Bulan",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Kode Produk
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Kode Produk",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // No Urut
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "No Urut",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Kode Marketing
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Kode Marketing",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // NO / RO
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "NO / RO",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Kode Produksi
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Kode Produksi",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Kode Grafir
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Kode Grafir",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Project / Tema
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Project / Tema",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Marketing
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Marketing",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Brand
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Brand",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Designer
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Designer",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // No Design
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "No Design",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Modeller
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Modeller",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

                                    // Keterangan
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Keterangan",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterListBatu!.sort((a, b) => a
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.lot!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterListBatu!.sort((a, b) => b
                                                  .lot!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.lot!.toLowerCase()));
                                            }
                                          });
                                        }),

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
                                          myData: _listBatu,
                                          count: _listBatu!.length)),
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),

        floatingActionButton: Stack(children: [
          Positioned(
            left: 40,
            bottom: 5,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final _formKey = GlobalKey<FormState>();
                      TextEditingController lot = TextEditingController();
                      TextEditingController size = TextEditingController();
                      TextEditingController parcel = TextEditingController();
                      TextEditingController qty = TextEditingController();
                      TextEditingController caratPcs = TextEditingController();
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textInputAction: TextInputAction.next,
                                      controller: lot,
                                      decoration: InputDecoration(
                                        // hintText: "example: Cahaya Sanivokasi",
                                        labelText: "Lot",
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
                                  //size
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textInputAction: TextInputAction.next,
                                      controller: size,
                                      decoration: InputDecoration(
                                        // hintText: "example: Cahaya Sanivokasi",
                                        labelText: "Ukuran",
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textInputAction: TextInputAction.next,
                                      controller: parcel,
                                      decoration: InputDecoration(
                                        // hintText: "example: Cahaya Sanivokasi",
                                        labelText: "Parcel",
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textInputAction: TextInputAction.next,
                                      controller: qty,
                                      decoration: InputDecoration(
                                        // hintText: "example: Cahaya Sanivokasi",
                                        labelText: "Qty",
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textInputAction: TextInputAction.next,
                                      controller: caratPcs,
                                      decoration: InputDecoration(
                                        // hintText: "example: Cahaya Sanivokasi",
                                        labelText: "Carat Pcs",
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
                                      controller: keterangan,
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
                                          child: const Text("Simpan Batu"),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              Future.delayed(const Duration(
                                                      seconds: 2))
                                                  .then((value) async {
                                                btnController.success();
                                                print(lot.text);
                                                print(size.text);
                                                print(parcel.text);
                                                print(qty.text);
                                                print(caratPcs.text);
                                                print(keterangan.text);
                                                Map<String, dynamic> body = {
                                                  'lot': lot.text,
                                                  'size': size.text,
                                                  'parcel': parcel.text,
                                                  'qty': qty.text,
                                                  'caratPcs': caratPcs.text,
                                                  'keterangan': keterangan.text,
                                                };
                                                final response =
                                                    await http.post(
                                                        Uri.parse(ApiConstants
                                                                .baseUrl +
                                                            ApiConstants
                                                                .postDataBatu),
                                                        body: body);
                                                print(response.body);
                                                Future.delayed(const Duration(
                                                        seconds: 1))
                                                    .then((value) {
                                                  btnController.reset(); //reset
                                                  showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          const AlertDialog(
                                                            title: Text(
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
                                              Future.delayed(const Duration(
                                                      seconds: 1))
                                                  .then((value) {
                                                btnController.reset(); //reset
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
      //kode Design
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.lot)),
      ),
      //Jenis Batu
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //id
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.id.toString())),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
      ),
      //bulan
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.size)),
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
