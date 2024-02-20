// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/qc/modelQc/jenisBatuModel.dart';
import 'package:form_designer/qc/modelQc/kualitasBatuModel.dart';
import 'package:form_designer/qc/modelQc/lebarModel.dart';
import 'package:form_designer/qc/modelQc/panjangModel.dart';
import 'package:form_designer/qc/modelQc/ukuranRoundModel.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class FormDetailBatuQc extends StatefulWidget {
  final VoidCallback? onCloseForm;
  final FormPrModel? dataFormPr;

  const FormDetailBatuQc({Key? key, this.onCloseForm, this.dataFormPr})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FormDetailBatuQcState createState() => _FormDetailBatuQcState();
}

class _FormDetailBatuQcState extends State<FormDetailBatuQc> {
  bool isForm = false;
  TextEditingController ukuranBatu = TextEditingController();
  TextEditingController notesReject = TextEditingController();
  // TextEditingController jenisBatu = TextEditingController();
  String? jenisBatu;
  String? kualitasBatu;
  bool isLoading = false;
  final List<DataRow> _rows = []; // List untuk menyimpan setiap DataRow
  List<String> dataRow = [];
  List<PanjangModel>? listPanjang;
  List<LebarModel>? listLebar;
  List<JenisBatuModel>? listJenisBatu;
  List<KualitasBatuModel>? listKualitasBatu;
  String? tglOut;
  int no = 0;
  @override
  void initState() {
    super.initState();
    tglOut = DateFormat('dd/MMMM/yyyy HH:ss').format(DateTime.now());
    _getData();
  }

  dataTableForm(jenisBatu) {
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
        columns: columnsData(jenisBatu),
        border: TableBorder.all(),
        rows: rowsData(jenisBatu, () {
          setState(() {});
        }, 5));
  }

  List<DataColumn> columnsData(String jenisBatu) {
    return jenisBatu.toString().toLowerCase() == 'round'
        ? [
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('No'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Ukuran Batu Round'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Qty'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Berat'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Aksi'),
            ))),
          ]
        : [
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('No'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Nama Barang / Dokumen'),
            ))),
          ];
  }

  List<DataRow> rowsData(
      String jenisBatu, Function() onChangedCallback, int count) {
    return jenisBatu.toString().toLowerCase() == 'round'
        ? [
            for (var i = 0; i < count; i++)
              //? nomor
              DataRow(cells: [
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text('${i + 1}')))),
                //? ukuran batu round
                DataCell(
                  Center(
                    child: DropdownSearch<UkuranRoundModel>(
                      asyncItems: (String? filter) =>
                          getListUkuranRound(kualitasBatu, filter),
                      popupProps: PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        itemBuilder: _listUkuranRound,
                        showSearchBox: true,
                      ),
                      compareFn: (item, sItem) => item.idRound == sItem.idRound,
                      onChanged: (item) {
                        setState(() {
                          // rantai.text = item!.nama;
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          // labelText: "",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                //? ukuran round

                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        setState(() {
                          // dumKadar = value;
                          // selectListItem[i].isNotEmpty
                          //     ? selectListItem[i][3] = '$dumKadar'
                          //     : null;
                        });
                        onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),
                //? qty round

                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        setState(() {
                          // dumKadar = value;
                          // selectListItem[i].isNotEmpty
                          //     ? selectListItem[i][3] = '$dumKadar'
                          //     : null;
                        });
                        onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),
                //? berat round

                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        setState(() {
                          // dumKadar = value;
                          // selectListItem[i].isNotEmpty
                          //     ? selectListItem[i][3] = '$dumKadar'
                          //     : null;
                        });
                        onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),
              ]),
          ]
        : [
            for (var i = 0; i < count; i++)
              DataRow(cells: [
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text('${i + 1}')))),
                //? ukuran round
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        setState(() {
                          // dumKadar = value;
                          // selectListItem[i].isNotEmpty
                          //     ? selectListItem[i][3] = '$dumKadar'
                          //     : null;
                        });
                        onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),
                //? qty round
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        setState(() {
                          // dumKadar = value;
                          // selectListItem[i].isNotEmpty
                          //     ? selectListItem[i][3] = '$dumKadar'
                          //     : null;
                        });
                        onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),
                //? berat round
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        setState(() {
                          // dumKadar = value;
                          // selectListItem[i].isNotEmpty
                          //     ? selectListItem[i][3] = '$dumKadar'
                          //     : null;
                        });
                        onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),

                //? aksi round
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        setState(() {
                          // dumKadar = value;
                          // selectListItem[i].isNotEmpty
                          //     ? selectListItem[i][3] = '$dumKadar'
                          //     : null;
                        });
                        onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),
              ]),
          ];
  }

  //* HINTS get data dan filter langsung ke API
  Future<List<UkuranRoundModel>> getListUkuranRound(
      kualitasBatu, filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListUkuranRound,
      queryParameters: {
        "filter": kualitasBatu.toString().toLowerCase() + filter.toLowerCase()
      },
    );
    final data = response.data;
    if (data != null) {
      return UkuranRoundModel.fromJsonList(data);
    }
    return [];
  }

  _getData() async {
    setState(() {
      isLoading = true;
    });
    await getPanjang();
    await getLebar();
    await getJenisBatu();
    await getKualitasBatu();

    setState(() {
      isLoading = false;
    });
  }

  getPanjang() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListPanjang));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var alldata =
            jsonResponse.map((data) => PanjangModel.fromJson(data)).toList();
        setState(() {
          listPanjang = alldata.toList();
        });
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get data panjang = $c');
    }
  }

  getLebar() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListLebar));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var alldata =
            jsonResponse.map((data) => LebarModel.fromJson(data)).toList();
        setState(() {
          listLebar = alldata.toList();
        });
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      // ignore:
      print('err get data lebar = $c');
    }
  }

  getJenisBatu() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListJenisBatu));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var alldata =
            jsonResponse.map((data) => JenisBatuModel.fromJson(data)).toList();
        setState(() {
          listJenisBatu = alldata.toList();
        });
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      // ignore:
      print('err get data jenisBatu = $c');
    }
  }

  getKualitasBatu() async {
    try {
      final response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getListKualitasBatu));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var alldata = jsonResponse
            .map((data) => KualitasBatuModel.fromJson(data))
            .toList();
        setState(() {
          listKualitasBatu = alldata.toList();
        });
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      // ignore:
      print('err get data jenisBatu = $c');
    }
  }

  refresh() {
    //? hints Panggil onCloseForm untuk menutup form
    widget.onCloseForm?.call();
  }

  @override
  Widget build(BuildContext context) {
    double widhtMAX = MediaQuery.of(context).size.width;
    double widValue = 250;
    return isLoading == true
        ? Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 90,
              height: 90,
              child: Lottie.asset("loadingJSON/loadingV1.json"),
            ),
          )
        : Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        refresh();
                      },
                      child: SizedBox(
                        width: 50,
                        child: Lottie.asset("loadingJSON/backbutton.json",
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      width: widhtMAX,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors
                                .white), // Atur warna dan ketebalan garis sesuai kebutuhan
                        borderRadius: BorderRadius.circular(
                            10), // Atur sudut border sesuai kebutuhan
                      ),
                      padding:
                          const EdgeInsets.only(top: 26, left: 20, right: 20),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey.shade400,
                            child: const Text(
                              'LEMBAR QUALITY CONTROL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100, child: Text('NO. QC')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        Container(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            width: widValue,
                                            child: Text(widget.dataFormPr!.noPR
                                                .toString()))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100,
                                            child: Text('TGL QC IN')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          width: widValue,
                                          child: Text(
                                              DateFormat('dd/MMMM/yyyy HH:ss')
                                                  .format(DateTime.parse(widget
                                                      .dataFormPr!.created_at!
                                                      .toString()))),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100,
                                            child: Text('TGL QC OUT')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        Container(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            width: widValue,
                                            child: Text('$tglOut'))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100, child: Text('VENDOR')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        Container(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            width: widValue,
                                            child: Text(widget
                                                .dataFormPr!.vendor
                                                .toString()))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100,
                                            child: Text('KEBUTUHAN')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        SizedBox(
                                            width: widValue,
                                            child: Text(widget
                                                .dataFormPr!.fixTotalBerat
                                                .toString()))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // ignore: avoid_unnecessary_containers
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100,
                                            child: Text('UKURAN BATU')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          width: widValue,
                                          child: TextFormField(
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: ukuranBatu,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelText: "",
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
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100,
                                            child: Text('JENIS BATU')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          width: widValue,
                                          child: DropdownButtonFormField(
                                            value: jenisBatu,
                                            items: [
                                              //* hints looping sederhana
                                              for (var item in listJenisBatu!)
                                                DropdownMenuItem(
                                                  value: item.jenisBatu,
                                                  child: Text(item.jenisBatu!),
                                                ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                jenisBatu = value;
                                              });
                                            },
                                            // decoration: InputDecoration(
                                            //   suffixIcon: Icon(Icons
                                            //       .arrow_circle_down_sharp), // Tambahkan ikon di sini
                                            //   errorText: jenisBatu == null
                                            //       ? 'Pilih jenis batu'
                                            //       : null, // Pesan kesalahan
                                            // ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            width: 100,
                                            child: Text('KUALITAS')),
                                        const SizedBox(
                                            width: 30, child: Text(':')),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          width: widValue,
                                          child: DropdownButtonFormField(
                                            value: kualitasBatu,
                                            items: [
                                              //* hints looping sederhana
                                              for (var item
                                                  in listKualitasBatu!)
                                                DropdownMenuItem(
                                                  value: item.kualitasBatu,
                                                  child:
                                                      Text(item.kualitasBatu!),
                                                ),
                                            ],
                                            onChanged: (value) {
                                              if (value
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'zr / zs') {
                                                value = 'zr';
                                              }
                                              setState(() {
                                                kualitasBatu = value;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.grey.shade400,
                            child: const Text(
                              'TABEL DATA YANG DITEIRMA QC',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          dataTableForm('round'),
                          // DataTable(
                          //   border: TableBorder.all(),
                          //   columns: const [
                          //     DataColumn(label: Text('No')),
                          //     DataColumn(label: Text('Kode Mdbc')),
                          //     DataColumn(label: Text('Panjang')),
                          //     DataColumn(label: Text('x')),
                          //     DataColumn(label: Text('Lebar')),
                          //     DataColumn(label: Text('Qty')),
                          //     DataColumn(label: Text('Berat')),
                          //     DataColumn(label: Text('Aksi')),
                          //   ],
                          //   rows: _rows.isNotEmpty
                          //       ? _rows
                          //       : [
                          //           // Default empty row
                          //         ],
                          // ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _addRow,
                          ),
                          Container(
                            color: Colors.grey.shade400,
                            child: const Text(
                              'KETERANGAN',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 100,
                                maxHeight:
                                    200), //? untuk menenrukan max tinggi di sizedbox
                            child: SizedBox(
                              child: TextField(
                                controller: notesReject,
                                keyboardType: TextInputType.multiline,
                                maxLines:
                                    null, // null untuk menyesuaikan tinggi sesuai isi teks
                                decoration: const InputDecoration(
                                  labelText: 'Notes Reject',
                                  hintText: 'Masukkan keterangan di sini...',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width:
                                          2, // Atur ketebalan border sesuai kebutuhan
                                      color: Colors
                                          .black, // Atur warna border sesuai kebutuhan
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 200,
                                      child: Text(
                                        'Name :  ${sharedPreferences!.getString('nama')!}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const SizedBox(
                                    height: 65,
                                  ),
                                  const SizedBox(
                                      width: 200,
                                      child: Text(
                                        'QUALITY CONTROL',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 200,
                                      child: Text(
                                        'Name :',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: 65,
                                  ),
                                  SizedBox(
                                      width: 200,
                                      child: Text(
                                        'WAREHOUSE',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 200,
                                      child: Text(
                                        'Name :',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: 65,
                                  ),
                                  SizedBox(
                                      width: 200,
                                      child: Text(
                                        'PURCHASING',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void _addRow() {
    setState(() {
      String? valuePanjang = '0';
      String? valueLebar = '0';
      // Menambahkan baris baru di paling bawah tabel
      _rows.add(
        DataRow(cells: [
          DataCell(Text((_rows.length + 1).toString())), //? no
          const DataCell(Text('')),
          DataCell(TextField(
            onChanged: (value) {
              valuePanjang = value;
              _calculateResult(_rows.length, valuePanjang!, valueLebar!);
            },
          )),
          const DataCell(TextField()),
          DataCell(TextField(
            onChanged: (value) {
              valueLebar = value;
              _calculateResult(_rows.length, valuePanjang!, valueLebar!);
            },
          )),
          const DataCell(TextField()),
          const DataCell(TextField()),
          DataCell(IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteRow(_rows.length); // Menghapus baris yang sesuai
            },
          )),
        ]),
      );
    });
    print(_rows);
  }

  void _deleteRow(int index) {
    setState(() {
      _rows.removeAt(index);
    });
  }

  void _calculateResult(int index, String panjangValue, String lebarValue) {
    if (panjangValue.isNotEmpty || lebarValue.isNotEmpty) {
      final double panjang = double.tryParse(panjangValue) ?? 0;
      final double lebar = double.tryParse(lebarValue) ?? 0;
      final String resultPanjang = calculateResultPanjang(panjang);
      final String resultLebar = calculateResultLebar(lebar);
      setState(() {
        _rows[index - 1] = DataRow(cells: [
          DataCell(Text(index.toString())),
          DataCell(
              Text('BQ${resultPanjang}SA$resultLebar')), // Menampilkan hasil
          DataCell(TextField(
            onChanged: (value) {
              panjangValue = value;
              _calculateResult(_rows.length, panjangValue, lebarValue);
            },
          )),
          const DataCell(Text('x')),
          DataCell(TextField(
            onChanged: (value) {
              lebarValue = value;
              _calculateResult(_rows.length, panjangValue, lebarValue);
            },
          )),
          const DataCell(TextField()),
          const DataCell(TextField()),
          DataCell(IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteRow(index);
            },
          )),
        ]);
      });
    }
  }

  //* HINTS Fungsi untuk menentukan hasil berdasarkan range panjang dan lebar fancy
  String calculateResultPanjang(double panjang) {
    // ignore: prefer_typing_uninitialized_variables
    var result;
    int i = 0;
    //! hints Loop untuk mencari indeks yang sesuai
    while (i <= listPanjang!.length) {
      if (panjang <= double.parse(listPanjang![i].panjang!)) {
        result = listPanjang![i].resultPanjang!;
        break; // Jika kondisi terpenuhi, keluar dari loop
      } else {
        i++; // Jika tidak, lanjut ke nilai berikutnya
      }
    }

    result = listPanjang?[i].resultPanjang.toString();

    return result;
  }

  String calculateResultLebar(double lebar) {
    // ignore: prefer_typing_uninitialized_variables
    var result;
    int i = 0;
    //! hints Loop untuk mencari indeks yang sesuai
    while (i <= listLebar!.length) {
      if (lebar <= double.parse(listLebar![i].lebar!)) {
        result = listLebar![i].resultLebar!;
        break; // Jika kondisi terpenuhi, keluar dari loop
      } else {
        i++; // Jika tidak, lanjut ke nilai berikutnya
      }
    }

    result = listLebar?[i].resultLebar.toString();

    return result;
  }

  Widget _listUkuranRound(
    BuildContext context,
    UkuranRoundModel? item,
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
        title: Text(item?.ukuranRound ?? ''),
      ),
    );
  }
}
