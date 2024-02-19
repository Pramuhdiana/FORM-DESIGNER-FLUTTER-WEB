// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/qc/modelQc/lebarModel.dart';
import 'package:form_designer/qc/modelQc/panjangModel.dart';
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
  TextEditingController jenisBatu = TextEditingController();
  bool isLoading = false;
  final List<DataRow> _rows = []; // List untuk menyimpan setiap DataRow
  List<String> dataRow = [];
  List<PanjangModel>? listPanjang;
  List<LebarModel>? listLebar;
  String? tglOut;
  int no = 0;
  @override
  void initState() {
    super.initState();
    tglOut = DateFormat('dd/MMMM/yyyy HH:ss').format(DateTime.now());
    _getData();
  }

  _getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListPanjang));
      // 'http://203.174.11.254:1212/Api_flutter/spk/get_list_ukuran.php?type=panjang'));
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
      print('err get data ukuran = $c');
    }
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListLebar));
      // 'http://203.174.11.254:1212/Api_flutter/spk/get_list_ukuran.php?type=panjang'));
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
      print('err get data ukuran = $c');
    }
    setState(() {
      isLoading = false;
    });
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
        ? Container(
            padding: const EdgeInsets.all(5),
            width: 90,
            height: 90,
            child: Lottie.asset("loadingJSON/loadingV1.json"),
          )
        : Column(
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
                    color: Colors.white,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text('NO. QC')),
                                      const Text(':'),
                                      SizedBox(
                                          width: widValue,
                                          child: Text(widget.dataFormPr!.noPR
                                              .toString()))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text('TGL QC IN')),
                                      const Text(':'),
                                      SizedBox(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text('TGL QC OUT')),
                                      const Text(':'),
                                      SizedBox(
                                          width: widValue,
                                          child: Text('$tglOut'))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text('VENDOR')),
                                      const Text(':'),
                                      SizedBox(
                                          width: widValue,
                                          child: Text(widget.dataFormPr!.vendor
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text('UKURAN BATU')),
                                      const Text(':'),
                                      SizedBox(
                                        width: widValue,
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: ukuranBatu,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "Kode Design MDBC",
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
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text('JENIS BATU')),
                                      const Text(':'),
                                      SizedBox(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text('KUALITAS')),
                                      const Text(':'),
                                      SizedBox(
                                          width: widValue,
                                          child: Text('$tglOut'))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text('KEBUTUHAN')),
                                      const Text(':'),
                                      SizedBox(
                                          width: widValue,
                                          child: Text(widget.dataFormPr!.vendor
                                              .toString()))
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
                            'accepted by qc',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                        ),
                        DataTable(
                          border: TableBorder.all(),
                          columns: const [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Keluarga')),
                            DataColumn(label: Text('Anggota Keluarga')),
                            DataColumn(label: Text('Kode Mdbc')),
                            DataColumn(label: Text('Panjang')),
                            DataColumn(label: Text('x')),
                            DataColumn(label: Text('Lebar')),
                            DataColumn(label: Text('Qty')),
                            DataColumn(label: Text('Berat')),
                            DataColumn(label: Text('Aksi')),
                          ],
                          rows: _rows.isNotEmpty
                              ? _rows
                              : [
                                  // Default empty row
                                ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _addRow,
                        ),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 100, child: Text('NO. QC')),
                            Text(':'),
                            Text('VALUE NO QC')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
          const DataCell(Text('')),
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
          const DataCell(Text('keluarga oke')),
          const DataCell(Text('anggtoa keluara oke')),
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
}
