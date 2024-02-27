// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/qc/modelQc/itemQcModel.dart';
import 'package:form_designer/qc/modelQc/jenisBatuModel.dart';
import 'package:form_designer/qc/modelQc/kualitasBatuModel.dart';
import 'package:form_designer/qc/modelQc/lebarModel.dart';
import 'package:form_designer/qc/modelQc/panjangModel.dart';
import 'package:form_designer/qc/modelQc/ukuranRoundModel.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

// ignore: must_be_immutable
class FormDetailBatuQc extends StatefulWidget {
  final VoidCallback? onCloseForm;
  final FormPrModel? dataFormPr;
  int? countItem;
  List<ListItemPRModel>? listItemPR;

  FormDetailBatuQc(
      {Key? key,
      this.onCloseForm,
      this.dataFormPr,
      this.countItem,
      this.listItemPR})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FormDetailBatuQcState createState() => _FormDetailBatuQcState();
}

class _FormDetailBatuQcState extends State<FormDetailBatuQc> {
  bool isForm = false;
  bool isloadingItem = false;
  TextEditingController ukuranBatu = TextEditingController();
  TextEditingController notesReject = TextEditingController();
  // TextEditingController jenisBatu = TextEditingController();
  String? jenisBatu;
  String? kodeBatu;
  int? countItemPr;
  String? kualitasBatu;
  bool isLoading = false;
  List<String> dataRow = [];
  List<String> listCaratPcs = [];
  List<String> listBerat = [];
  List<PanjangModel>? listPanjang;
  List<LebarModel>? listLebar;
  List<JenisBatuModel>? listJenisBatu;
  List<KualitasBatuModel>? listKualitasBatu;
  String? tglOut;
  int no = 0;
  String? idItemPr;
  List<List<String>> selectListItemRound = [];
  List<List<dynamic>> indexSelectItemRound = [];
  List<List<String>> selectListItemFancy = [];
  String? ukuran = '';
  String? qty = '';
  String? berat = '';
  String? caratPcs = '';
  String? kodeMdbc = '';
  String? panjang = '';
  String? lebar = '';
  String? qtyFancy = '';
  String? beratFancy = '';
  String? resultPanjang = '';
  String? resultLebar = '';
  double sumBerat = 0.0;
  String? kebutuhanBerat;
  double? previousBerat; // Variabel untuk menyimpan nilai berat sebelumnya
  String? idForm;
  String noQc = '';
  String? nomorQc;
  int totalQty = 0;
  double totalBerat = 0.0;
  String? noPr;
  double? lebarLayar;

  List<bool> _isOpen = []; // List untuk mengatur status container
  List<ListItemPRModel>? listItemPr;
  List<ItemQcModel>? listDetailItemPR;

  @override
  void initState() {
    super.initState();
    tglOut = DateFormat('dd/MMMM/yyyy HH:ss').format(DateTime.now());
    kebutuhanBerat = widget.dataFormPr!.fixTotalBerat.toString();
    idForm = widget.dataFormPr!.id.toString();
    noPr = widget.dataFormPr!.noPR.toString();
    jenisBatu = widget.dataFormPr!.jenisBatu.toString();
    countItemPr = widget.countItem;
    _isOpen = List.generate(
        countItemPr!, (index) => false); // List untuk mengatur status container
    _getData();
  }

  callData(int index) async {
    setState(() {
      isloadingItem = true;
    });
    List<ItemQcModel>? filterBynoQc;
    if (jenisBatu.toString().toLowerCase() != 'round') {
      await getJenisBatu(index);
    }
    for (int i = 0; i < _isOpen.length; i++) {
      if (i != index) {
        _isOpen[i] = false;
      }
    }
    idItemPr = listItemPr![index].id.toString();

    if (double.parse(listItemPr![index].receiveBerat!) > 0
        // &&
        //     _isOpen[index] == false
        ) {
      notesReject.text = listItemPr![index].notesReject.toString();
      filterBynoQc = listDetailItemPR!
          .where((element) => element.noQc == listItemPr![index].noQc)
          .toList();
      for (var i = 0; i < filterBynoQc.length; i++) {
        if (jenisBatu.toString().toLowerCase() == 'round') {
          ukuran = '${filterBynoQc[i].item}';
          qty = '${filterBynoQc[i].qty}';
          berat = '${filterBynoQc[i].berat}';
          caratPcs = '${filterBynoQc[i].caratPcs}';
          String idItem = '${filterBynoQc[i].id}';
          selectListItemRound.add([
            '$ukuran',
            '$qty',
            '$berat',
            '$caratPcs',
            idItem,
          ]);
          print('round = $selectListItemRound');
        } else {
          kodeMdbc = '${filterBynoQc[i].item}';
          panjang = '${filterBynoQc[i].panjang}';
          lebar = '${filterBynoQc[i].lebar}';
          qtyFancy = '${filterBynoQc[i].qty}';
          beratFancy = '${filterBynoQc[i].berat}';
          String idItem = '${filterBynoQc[i].id}';

          selectListItemFancy.add([
            '$kodeMdbc',
            '$panjang',
            '$lebar',
            '$qtyFancy',
            '$beratFancy',
            idItem,
          ]);
          print('fancy = $selectListItemFancy');
        }
      }

      no += filterBynoQc.length;
      _isOpen[index] = !_isOpen[index];
      print('mode edit');
      print('count table akhir = $no');
    } else {
      _isOpen[index] = !_isOpen[index];
      print('mode new');
      print('count table akhir = $no');
    }
    setState(() {
      isloadingItem = false;
    });
  }

  String getMonthName(String month) {
    switch (month) {
      case '01':
        return 'Januari';
      case '02':
        return 'Februari';
      case '03':
        return 'Maret';
      case '04':
        return 'April';
      case '05':
        return 'Mei';
      case '06':
        return 'Juni';
      case '07':
        return 'Juli';
      case '08':
        return 'Agustus';
      case '09':
        return 'September';
      case '10':
        return 'Oktober';
      case '11':
        return 'November';
      case '12':
        return 'Desember';
      default:
        return 'Invalid';
    }
  }

  dataTableForm(String mode, String jenisBatu, int count, int index) {
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
        columns: columnsData(jenisBatu, index),
        border: TableBorder.all(),
        rows: mode == 'edit'
            ? rowsEditData(index, jenisBatu, () {
                setState(() {});
              }, count)
            : rowsData(index, jenisBatu, () {
                setState(() {});
              }, count));
  }

  List<DataColumn> columnsData(String jenisBatu, int index) {
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
                  child: Text(
                    'Ukuran batu\nround',
                    textAlign:
                        TextAlign.center, // Atur alignment sesuai kebutuhan
                    overflow: TextOverflow
                        .ellipsis, // Jika teks melebihi lebar, teks akan terpotong dengan tanda elipsis
                    style: TextStyle(
                        fontSize: 16), // Sesuaikan ukuran font sesuai kebutuhan
                  ),
                ),
              ),
            ),
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
                  child: Text(
                    'Carat\nPcs',
                    textAlign:
                        TextAlign.center, // Atur alignment sesuai kebutuhan
                    overflow: TextOverflow
                        .ellipsis, // Jika teks melebihi lebar, teks akan terpotong dengan tanda elipsis
                    style: TextStyle(
                        fontSize: 16), // Sesuaikan ukuran font sesuai kebutuhan
                  ),
                ),
              ),
            ),
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
              child: Text('Kode Mdbc'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Panjang'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('x'),
            ))),
            const DataColumn(
                label: Center(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Lebar'),
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
          ];
  }

  List<DataRow> rowsData(
      int index, String jenisBatu, Function() onChangedCallback, int count) {
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
                      asyncItems: (String? filter) => getListUkuranRound(
                          listItemPr![index].item!,
                          listItemPr![index].kadar!,
                          filter!),
                      popupProps: PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        itemBuilder: _listUkuranRound,
                        showSearchBox: true,
                      ),
                      compareFn: (item, sItem) => item.idRound == sItem.idRound,
                      onChanged: (item) {
                        ukuran = item!.ukuranRound;
                        caratPcs = item.caratPcs;
                        setState(() {
                          selectListItemRound[i][0] = '$ukuran';
                          selectListItemRound[i][3] = '$caratPcs';
                          print(selectListItemRound);
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

                //? qty round
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text((selectListItemRound[i][1]))))),

                //? berat round
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal:
                              true), //* hHINTS Mengizinkan input nilai desimal
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,3}')), // Membatasi input agar sesuai format desimal
                      ],
                      onChanged: (value) {
                        berat = value;
                        int resultQty = (double.tryParse(value)! /
                                double.parse(selectListItemRound[i][3]))
                            .round();

                        print(
                            'value = $value berat = $berat total : $sumBerat');
                        setState(() {
                          // if (double.parse(kebutuhanBerat!) < sumBerat) {
                          //   showDialog<String>(
                          //       context: context,
                          //       builder: (BuildContext context) =>
                          //           const AlertDialog(
                          //             title: Text(
                          //               'Total carat melibihi yang seharusnya diterima',
                          //             ),
                          //           ));
                          //   berat = '0';
                          //   resultQty = 0;
                          // }
                          qty = resultQty.toString();
                          selectListItemRound[i][1] = '$qty';
                          selectListItemRound[i][2] = '$berat';
                          print(selectListItemRound);
                        });
                        // onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),

                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(selectListItemRound[i][3])))),
              ]),
          ]
        : [
            for (var i = 0; i < count; i++)
              //? nomor
              DataRow(cells: [
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text('${i + 1}')))),
                //? kode mdbc
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(selectListItemFancy[i][0])))),

                //? panjang fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (panjangValue) {
                        final double panjang =
                            double.tryParse(panjangValue) ?? 0;
                        resultPanjang = calculateResultPanjang(panjang);

                        setState(() {
                          selectListItemFancy[i][1] = '$panjang';
                          selectListItemFancy[i][0] =
                              '$kodeBatu$resultPanjang$kualitasBatu$resultLebar';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
                //? x
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(child: Text('x')))),

                //? lebar fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (lebarValue) {
                        final double lebar = double.tryParse(lebarValue) ?? 0;
                        resultLebar = calculateResultLebar(lebar);

                        setState(() {
                          selectListItemFancy[i][2] = '$lebar';
                          selectListItemFancy[i][0] =
                              '$kodeBatu$resultPanjang$kualitasBatu$resultLebar';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
                //? qty fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        qtyFancy = value;
                        setState(() {
                          selectListItemFancy[i][3] = '$qtyFancy';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
                //? berat fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      // initialValue: data[i].kadar,
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      onChanged: (value) {
                        beratFancy = value;
                        setState(() {
                          selectListItemFancy[i][4] = '$beratFancy';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
              ]),
          ];
  }

  List<DataRow> rowsEditData(
      int index, String jenisBatu, Function() onChangedCallback, int count) {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: DropdownSearch<UkuranRoundModel>(
                                asyncItems: (String? filter) =>
                                    getListUkuranRound(
                                  listItemPr![index].item!,
                                  listItemPr![index].kadar!,
                                  filter!,
                                ),
                                popupProps:
                                    PopupPropsMultiSelection.modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listUkuranRound,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) =>
                                    item.idRound == sItem.idRound,
                                onChanged: (item) {
                                  ukuran = item!.ukuranRound;
                                  caratPcs = item.caratPcs;
                                  setState(() {
                                    selectListItemRound[i][0] = '$ukuran';
                                    selectListItemRound[i][3] = '$caratPcs';
                                    print(selectListItemRound);
                                  });
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Text(
                              selectListItemRound[i][0],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //? qty round
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text((selectListItemRound[i][1]))))),

                //? berat round
                DataCell(
                  Center(
                    child: TextFormField(
                      initialValue: selectListItemRound[i][2],
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal:
                              true), //* hHINTS Mengizinkan input nilai desimal
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,3}')), // Membatasi input agar sesuai format desimal
                      ],
                      onChanged: (value) {
                        berat = value;
                        int resultQty = (double.tryParse(value)! /
                                double.parse(selectListItemRound[i][3]))
                            .round();

                        print(
                            'value = $value berat = $berat total : $sumBerat');
                        setState(() {
                          // if (double.parse(kebutuhanBerat!) < sumBerat) {
                          //   showDialog<String>(
                          //       context: context,
                          //       builder: (BuildContext context) =>
                          //           const AlertDialog(
                          //             title: Text(
                          //               'Total carat melibihi yang seharusnya diterima',
                          //             ),
                          //           ));
                          //   berat = '0';
                          //   resultQty = 0;
                          // }
                          qty = resultQty.toString();
                          selectListItemRound[i][1] = '$qty';
                          selectListItemRound[i][2] = '$berat';
                          print(selectListItemRound);
                        });
                        // onChangedCallback(); // Panggil onChangedCallback di sini
                        // print(selectListItem);
                      },
                    ),
                  ),
                ),

                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(selectListItemRound[i][3])))),
              ]),
          ]
        : [
            for (var i = 0; i < count; i++)
              //? nomor
              DataRow(cells: [
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text('${i + 1}')))),
                //? kode mdbc
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: Text(selectListItemFancy[i][0])))),

                //? panjang fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      initialValue: selectListItemFancy[i][1],
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal:
                              true), //* hHINTS Mengizinkan input nilai desimal
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,3}')), // Membatasi input agar sesuai format desimal
                      ],
                      onChanged: (panjangValue) {
                        final double panjang =
                            double.tryParse(panjangValue) ?? 0;
                        resultPanjang = calculateResultPanjang(panjang);

                        setState(() {
                          selectListItemFancy[i][1] = '$panjang';
                          selectListItemFancy[i][0] =
                              '$kodeBatu$resultPanjang$kualitasBatu$resultLebar';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
                //? x
                DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(child: Text('x')))),

                //? lebar fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      initialValue: selectListItemFancy[i][2],
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal:
                              true), //* hHINTS Mengizinkan input nilai desimal
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,3}')), // Membatasi input agar sesuai format desimal
                      ],
                      onChanged: (lebarValue) {
                        final double lebar = double.tryParse(lebarValue) ?? 0;
                        resultLebar = calculateResultLebar(lebar);

                        setState(() {
                          selectListItemFancy[i][2] = '$lebar';
                          selectListItemFancy[i][0] =
                              '$kodeBatu$resultPanjang$kualitasBatu$resultLebar';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
                //? qty fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      initialValue: selectListItemFancy[i][3],
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal:
                              true), //* hHINTS Mengizinkan input nilai desimal
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,3}')), // Membatasi input agar sesuai format desimal
                      ],
                      onChanged: (value) {
                        qtyFancy = value;
                        setState(() {
                          selectListItemFancy[i][3] = '$qtyFancy';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
                //? berat fancy
                DataCell(
                  Center(
                    child: TextFormField(
                      initialValue: selectListItemFancy[i][4],
                      textAlign: TextAlign
                          .center, // Menengahkan teks secara horizontal
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal:
                              true), //* hHINTS Mengizinkan input nilai desimal
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,3}')), // Membatasi input agar sesuai format desimal
                      ],
                      onChanged: (value) {
                        beratFancy = value;
                        setState(() {
                          selectListItemFancy[i][4] = '$beratFancy';
                          print('fancy = $selectListItemFancy');
                        });
                      },
                    ),
                  ),
                ),
              ]),
          ];
  }

  //* HINTS get data dan filter langsung ke API
  Future<List<UkuranRoundModel>> getListUkuranRound(
      String lot, String kualitasBatu, String filter) async {
    print('$lot, $kualitasBatu');
    var filterKualitas = kualitasBatu.toString().toLowerCase();
    if (kualitasBatu.toString().toLowerCase() == 'zr / zs') {
      filterKualitas = 'zr';
    }
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListUkuranRound,
      queryParameters: {
        "jenisRound": filterKualitas,
        "lot": lot,
        "filter": filter.toLowerCase()
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
    // listItemPr = widget.listItemPR;
    // await getCountQc();

    // await getPanjang();
    //* hinst start menyimpan list string lokal ke json
    List<String>? panjangStrings =
        sharedPreferences!.getStringList('listPanjang');
    if (panjangStrings != null) {
      // Mengonversi data JSON menjadi objek PanjangModel
      listPanjang = panjangStrings
          .map((jsonString) => PanjangModel.fromJson(json.decode(jsonString)))
          .toList();
    }
    //* end fungsi
    await getLebar();
    //* hinst start menyimpan list string lokal ke json
    List<String>? jenisBatuStrings =
        sharedPreferences!.getStringList('jenisBatu');
    if (jenisBatuStrings != null) {
      // Mengonversi data JSON menjadi objek PanjangModel
      listJenisBatu = jenisBatuStrings
          .map((jsonString) => JenisBatuModel.fromJson(json.decode(jsonString)))
          .toList();
    }
    //* end fungsi
    // await getKualitasBatu();
    try {
      final responseList = await http.get(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getListFormPR}'));

      if (responseList.statusCode == 200) {
        List jsonResponse = json.decode(responseList.body);

        var dataList = jsonResponse
            .map((dataList) => ListItemPRModel.fromJson(dataList))
            .toList();
        setState(() {
          listItemPr = dataList;
        });

        print('list item pr oke');
      } else {
        print(responseList.body);
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get form list item pr $c');
    }

    var filtBynoPR = listItemPr!
        .where((element) =>
            element.noPr.toString().toLowerCase() ==
            noPr.toString().toLowerCase())
        .toList();

    //get listnya
    final responseList = await http
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getItemQc}'));

    if (responseList.statusCode == 200) {
      List jsonResponse = json.decode(responseList.body);

      var dataList = jsonResponse
          .map((dataList) => ItemQcModel.fromJson(dataList))
          .toList();
      listDetailItemPR = dataList;
    }
    setState(() {
      listItemPr = filtBynoPR;
      isLoading = false;
    });
  }

  // getCountQc() async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getCountQc));
  //     if (response.statusCode == 200) {
  //       List jsonResponse = json.decode(response.body);
  //       var allData =
  //           jsonResponse.map((data) => QcModel.fromJson(data)).toList();
  //       int number = allData.length + 1;
  //       nomorQc = number.toString().padLeft(5, '0');
  //       setState(() {
  //         // DateTime now = DateTime.now();

  //         // String month = now.month.toString().padLeft(2, '0');
  //         // String year = now.year.toString();
  //         // noQc = '${widget.dataFormPr!.noPR}/QC/${getMonthName(month)}/$year';
  //       });
  //     } else {
  //       throw Exception('Unexpected error occured!');
  //     }
  //   } catch (c) {
  //     print('err get data panjang = $c');
  //   }
  // }

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

  getJenisBatu(int i) async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListJenisBatu));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var alldata =
            jsonResponse.map((data) => JenisBatuModel.fromJson(data)).toList();
        var filterByJenis = alldata
            .where((element) =>
                element.jenisBatu.toString().toLowerCase() ==
                listItemPr![i].item.toString().toLowerCase())
            .toList();
        setState(() {
          kodeBatu = filterByJenis.first.kodeBatu.toString();
        });
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      // ignore:
      print('err get data jenisBatu = $c');
    }
  }

  // getKualitasBatu() async {
  //   try {
  //     final response = await http.get(
  //         Uri.parse(ApiConstants.baseUrl + ApiConstants.getListKualitasBatu));
  //     if (response.statusCode == 200) {
  //       List jsonResponse = json.decode(response.body);
  //       var alldata = jsonResponse
  //           .map((data) => KualitasBatuModel.fromJson(data))
  //           .toList();
  //       setState(() {
  //         listKualitasBatu = alldata.toList();
  //       });
  //     } else {
  //       throw Exception('Unexpected error occured!');
  //     }
  //   } catch (c) {
  //     // ignore:
  //     print('err get data jenisBatu = $c');
  //   }
  // }

  refresh() {
    //? hints Panggil onCloseForm untuk menutup form
    widget.onCloseForm?.call();
  }

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        refresh();
                      },
                      child: SizedBox(
                        width: 50,
                        child: Lottie.asset(
                          "loadingJSON/backbutton.json",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  // Tambahkan Expanded agar ListView dapat memanfaatkan sisa ruang yang tersedia
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: countItemPr,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: listItemPr![index].receiveBerat != '0'
                                    ? Container(
                                        color: Colors.green,
                                        child: Text(
                                          '${listItemPr![index].item} Tersimpan',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      )
                                    : Text(
                                        '${listItemPr![index].item} Tap to detail'),
                                onTap: () {
                                  selectListItemFancy.clear();
                                  selectListItemRound.clear();
                                  no = 0;
                                  print('count table awal = $no');

                                  callData(index);
                                },
                              ),
                            ),
                            if (_isOpen[index])
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 8.0), // Atur padding di sini
                                child: Container(
                                  color: colorBG,
                                  padding: const EdgeInsets.all(16.0),
                                  child: isloadingItem == true
                                      ? Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            width: 90,
                                            height: 90,
                                            child: Lottie.asset(
                                                "loadingJSON/loadingV1.json"),
                                          ),
                                        )
                                      : listItemPr![index].receiveBerat != '0'
                                          ? editFormItem(index, listItemPr,
                                              listDetailItemPR)
                                          : detailFormItem(index),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  detailFormItem(i) {
    double widhtMAX = MediaQuery.of(context).size.width;
    double widValue = 250;
    kualitasBatu = listItemPr![i].kadar;
    DateTime now = DateTime.now();

    String month = now.month.toString().padLeft(2, '0');
    String year = now.year.toString();
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: widhtMAX,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors
                    .white), // Atur warna dan ketebalan garis sesuai kebutuhan
            borderRadius:
                BorderRadius.circular(10), // Atur sudut border sesuai kebutuhan
          ),
          padding: const EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade400,
                child: Text(
                  'LEMBAR QUALITY CONTROL ${listItemPr![i].item}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  print(constraints.maxWidth);
                  lebarLayar = constraints.maxWidth;

                  //* hints fungsi multi screen
                  if (constraints.maxWidth < 900) {
                    return Column(
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
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(noQc =
                                          '${widget.dataFormPr!.noPR}/QC/${getMonthName(month)}/$year/${(i + 1).toString().padLeft(5, '0')}'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC IN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                    padding: const EdgeInsets.only(left: 0),
                                    width: widValue,
                                    child: Text(DateFormat('dd/MMMM/yyyy HH:ss')
                                        .format(DateTime.parse(widget
                                            .dataFormPr!.tanggalInQc!
                                            .toString()))),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC OUT')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text('$tglOut'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('VENDOR')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(
                                          widget.dataFormPr!.vendor.toString()))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('KEBUTUHAN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  SizedBox(
                                      width: widValue,
                                      child: Text('${listItemPr![i].fixBerat}'))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
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
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(noQc =
                                          '${widget.dataFormPr!.noPR}/QC/${getMonthName(month)}/$year/${(i + 1).toString().padLeft(5, '0')}'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC IN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                    padding: const EdgeInsets.only(left: 0),
                                    width: widValue,
                                    child: Text(DateFormat('dd/MMMM/yyyy HH:ss')
                                        .format(DateTime.parse(widget
                                            .dataFormPr!.tanggalInQc!
                                            .toString()))),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC OUT')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text('$tglOut'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('VENDOR')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(
                                          widget.dataFormPr!.vendor.toString()))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('KEBUTUHAN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  SizedBox(
                                      width: widValue,
                                      child: Text('${listItemPr![i].fixBerat}'))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
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
              jenisBatu == null
                  ? const SizedBox()
                  : dataTableForm('new', jenisBatu!, no, i),
              //  SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: dataTableForm(jenisBatu!, no),
              //   ),
              const SizedBox(
                height: 20,
              ),
              jenisBatu == null
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (jenisBatu.toString().toLowerCase() ==
                                  'round') {
                                ukuran = '';
                                qty = '0';
                                berat = '';
                                caratPcs = '';
                                selectListItemRound.add([
                                  '$ukuran',
                                  '$qty',
                                  '$berat',
                                  '$caratPcs',
                                ]);
                                print(selectListItemRound);
                              } else {
                                kodeMdbc = '';
                                panjang = '';
                                lebar = '';
                                qtyFancy = '';
                                beratFancy = '';
                                selectListItemFancy.add([
                                  '$kodeMdbc',
                                  '$panjang',
                                  '$lebar',
                                  '$qtyFancy',
                                  '$beratFancy',
                                ]);
                                print('fancy = $selectListItemFancy');
                              }

                              no += 1;
                            });
                          },
                          icon: const Icon(Icons.add), // Icon "add"
                          label: const Text('Tambah Item'),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        no < 1
                            ? const SizedBox()
                            : ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    no -= 1;
                                    if (jenisBatu.toString().toLowerCase() ==
                                        'round') {
                                      selectListItemRound.removeAt(no);
                                      print(selectListItemRound);
                                    } else {
                                      selectListItemFancy.removeAt(no);
                                      print('fancy = $selectListItemFancy');
                                    }
                                  });
                                },
                                icon: const Icon(Icons.delete), // Icon "delete"
                                label: const Text('Hapus Item'), // Label tombol
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red, // Warna latar belakang merah
                                ),
                              )
                      ],
                    ),
              const SizedBox(
                height: 20,
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
                    maxHeight: 200), //? untuk menenrukan max tinggi di sizedbox
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2, // Atur ketebalan border sesuai kebutuhan
                          color: Colors
                              .black, // Atur warna border sesuai kebutuhan
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                height: 45, // Fixed height of 45
                padding: const EdgeInsets.only(bottom: 5),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Prevent dialog dismissal on tap outside
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
                    simpanForm();
                  },
                  child: const Text(
                    'Simpan Form',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  //  const SizedBox(
                  //     width: 200, // Sesuaikan dengan lebar yang diinginkan
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(Icons.save_alt),
                  //         SizedBox(width: 8), // Jarak antara ikon dan teks
                  //         Text('Simpan Form'),
                  //       ],
                  //     ),
                  //   ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // jenisBatu == null
    //     ? const SizedBox()
    //     : Container(
    //         width: MediaQuery.of(context).size.width * 0.7,
    //         padding: const EdgeInsets.only(bottom: 20, top: 20),
    //         child:
    //         FloatingActionButton.extended(
    //           onPressed: () {
    //             showDialog(
    //               context: context,
    //               barrierDismissible:
    //                   false, // Prevent dialog dismissal on tap outside
    //               builder: (BuildContext context) {
    //                 return Dialog(
    //                   backgroundColor: Colors.transparent,
    //                   elevation: 0,
    //                   child: Container(
    //                     padding: const EdgeInsets.all(16),
    //                     color: Colors.white,
    //                     child: const Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         CircularProgressIndicator(),
    //                         SizedBox(height: 20),
    //                         Text(
    //                           'Loading, please wait...',
    //                           style: TextStyle(fontSize: 16),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             );
    //             simpanForm();
    //           },
    //           label: const Text(
    //             'Simpan Form',
    //             style: TextStyle(
    //                 fontSize: 20, fontWeight: FontWeight.bold),
    //           ),
    //           icon: const Icon(
    //             Icons.save_alt,
    //             size: 20,
    //           ),
    //           //  const SizedBox(
    //           //     width: 200, // Sesuaikan dengan lebar yang diinginkan
    //           //     child: Row(
    //           //       mainAxisAlignment: MainAxisAlignment.center,
    //           //       children: [
    //           //         Icon(Icons.save_alt),
    //           //         SizedBox(width: 8), // Jarak antara ikon dan teks
    //           //         Text('Simpan Form'),
    //           //       ],
    //           //     ),
    //           //   ),
    //         ),
    //       )
  }

  editFormItem(i, var allData, var detailItem) {
    double widhtMAX = MediaQuery.of(context).size.width;
    double widValue = 250;
    var data = allData[i];
    var detailItemdata = detailItem[i];
    kualitasBatu = data.kadar;
    noQc = detailItemdata.noQc;
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: widhtMAX,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors
                    .white), // Atur warna dan ketebalan garis sesuai kebutuhan
            borderRadius:
                BorderRadius.circular(10), // Atur sudut border sesuai kebutuhan
          ),
          padding: const EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade400,
                child: Text(
                  'LEMBAR QUALITY CONTROL ${listItemPr![i].item}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  print(constraints.maxWidth);
                  lebarLayar = constraints.maxWidth;

                  //* hints fungsi multi screen
                  if (constraints.maxWidth < 900) {
                    return Column(
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
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(noQc))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC IN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                    padding: const EdgeInsets.only(left: 0),
                                    width: widValue,
                                    child: Text(DateFormat('dd/MMMM/yyyy HH:ss')
                                        .format(DateTime.parse(widget
                                            .dataFormPr!.tanggalInQc!
                                            .toString()))),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC OUT')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text('$tglOut'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('VENDOR')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(
                                          widget.dataFormPr!.vendor.toString()))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('KEBUTUHAN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  SizedBox(
                                      width: widValue,
                                      child: Text('${listItemPr![i].fixBerat}'))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
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
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(noQc))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC IN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                    padding: const EdgeInsets.only(left: 0),
                                    width: widValue,
                                    child: Text(DateFormat('dd/MMMM/yyyy HH:ss')
                                        .format(DateTime.parse(widget
                                            .dataFormPr!.tanggalInQc!
                                            .toString()))),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('TGL QC OUT')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(
                                          DateFormat('dd/MMMM/yyyy HH:ss')
                                              .format(DateTime.parse(widget
                                                  .dataFormPr!.tanggalInQc!
                                                  .toString()))))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('VENDOR')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  Container(
                                      padding: const EdgeInsets.only(left: 0),
                                      width: widValue,
                                      child: Text(
                                          widget.dataFormPr!.vendor.toString()))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      width: 100, child: Text('KEBUTUHAN')),
                                  const SizedBox(width: 30, child: Text(':')),
                                  SizedBox(
                                      width: widValue,
                                      child: Text('${listItemPr![i].fixBerat}'))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
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
              jenisBatu == null
                  ? const SizedBox()
                  : dataTableForm('edit', jenisBatu!, no, i),
              const SizedBox(
                height: 20,
              ),
              jenisBatu == null
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (jenisBatu.toString().toLowerCase() ==
                                  'round') {
                                ukuran = '';
                                qty = '0';
                                berat = '';
                                caratPcs = '';
                                selectListItemRound.add([
                                  '$ukuran',
                                  '$qty',
                                  '$berat',
                                  '$caratPcs',
                                ]);
                                print(selectListItemRound);
                                // Menambahkan index dan selectListItemRound ke indexSelectItemRound
//                                 indexSelectItemRound
//                                     .add([i, selectListItemRound]);

// // Mencetak nilai indexSelectItemRound
//                                 print(indexSelectItemRound);
                              } else {
                                kodeMdbc = '';
                                panjang = '';
                                lebar = '';
                                qtyFancy = '';
                                beratFancy = '';
                                selectListItemFancy.add([
                                  '$kodeMdbc',
                                  '$panjang',
                                  '$lebar',
                                  '$qtyFancy',
                                  '$beratFancy',
                                ]);
                                print('fancy = $selectListItemFancy');
                              }

                              no += 1;
                            });
                          },
                          icon: const Icon(Icons.add), // Icon "add"
                          label: const Text('Tambah Item'),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        no < 1
                            ? const SizedBox()
                            : ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    no -= 1;
                                    if (jenisBatu.toString().toLowerCase() ==
                                        'round') {
                                      selectListItemRound.removeAt(no);
                                      print(selectListItemRound);
                                    } else {
                                      selectListItemFancy.removeAt(no);
                                      print('fancy = $selectListItemFancy');
                                    }
                                  });
                                },
                                icon: const Icon(Icons.delete), // Icon "delete"
                                label: const Text('Hapus Item'), // Label tombol
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red, // Warna latar belakang merah
                                ),
                              )
                      ],
                    ),
              const SizedBox(
                height: 20,
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
                    maxHeight: 200), //? untuk menenrukan max tinggi di sizedbox
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2, // Atur ketebalan border sesuai kebutuhan
                          color: Colors
                              .black, // Atur warna border sesuai kebutuhan
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                height: 45, // Fixed height of 45
                padding: const EdgeInsets.only(bottom: 5),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Prevent dialog dismissal on tap outside
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
                    editForm();
                  },
                  child: const Text(
                    'Edit Form',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  //  const SizedBox(
                  //     width: 200, // Sesuaikan dengan lebar yang diinginkan
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(Icons.save_alt),
                  //         SizedBox(width: 8), // Jarak antara ikon dan teks
                  //         Text('Simpan Form'),
                  //       ],
                  //     ),
                  //   ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  simpanForm() async {
    totalBerat = 0;
    totalQty = 0;
    if (jenisBatu.toString().toLowerCase() == 'round') {
      for (var i = 0; i < selectListItemRound.length; i++) {
        totalBerat += double.tryParse(selectListItemRound[i][2]) ?? 0;
        totalQty += int.tryParse(selectListItemRound[i][1]) ?? 0;

        await postDetailItem(
            selectListItemRound[i][0],
            selectListItemRound[i][1],
            selectListItemRound[i][2],
            '',
            '',
            selectListItemRound[i][3]);
      }
    } else {
      for (var i = 0; i < selectListItemFancy.length; i++) {
        totalBerat += double.tryParse(selectListItemFancy[i][4]) ?? 0;
        totalQty += int.tryParse(selectListItemFancy[i][3]) ?? 0;
        await postDetailItem(
            selectListItemFancy[i][0],
            selectListItemFancy[i][3],
            selectListItemFancy[i][4],
            selectListItemFancy[i][1],
            selectListItemFancy[i][2],
            '0');
      }
    }

    await postStatusItemPR(idItemPr);
    await postStatusPR(idForm);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    refresh();
    showSimpleNotification(
      const Text('Form Berhasil Disimpan'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  editForm() async {
    totalBerat = 0;
    totalQty = 0;
    if (jenisBatu.toString().toLowerCase() == 'round') {
      for (var i = 0; i < selectListItemRound.length; i++) {
        totalBerat += double.tryParse(selectListItemRound[i][2]) ?? 0;
        totalQty += int.tryParse(selectListItemRound[i][1]) ?? 0;

        await updateDetailItem(
            selectListItemRound[i][4], //? id
            selectListItemRound[i][0],
            selectListItemRound[i][1],
            selectListItemRound[i][2],
            '',
            '',
            selectListItemRound[i][3]);
      }
    } else {
      for (var i = 0; i < selectListItemFancy.length; i++) {
        totalBerat += double.tryParse(selectListItemFancy[i][4]) ?? 0;
        totalQty += int.tryParse(selectListItemFancy[i][3]) ?? 0;
        await updateDetailItem(
            selectListItemFancy[i][5], //? id
            selectListItemFancy[i][0],
            selectListItemFancy[i][3],
            selectListItemFancy[i][4],
            selectListItemFancy[i][1],
            selectListItemFancy[i][2],
            '0');
      }
    }

    await postStatusItemPR(idItemPr);
    await postStatusPR(idForm);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    refresh();
    showSimpleNotification(
      const Text('Form Berhasil Disimpan'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  postStatusPR(String? id) async {
    Map<String, String> body = {
      'id': id.toString(),
      'status': 'qc',
      'noQc': noQc.toString(),
      'total_qty_diterima': totalQty.toString(),
      'total_berat_diteirma': totalBerat.toString(),
      'notes_reject': notesReject.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateStatusPR}'),
        body: body);
    print(response.body);
  }

  postStatusItemPR(String? id) async {
    Map<String, String> body = {
      'type': 'itemPr', // Menambahkan jenis data 'itemPr' ke body
      'id': id.toString(),
      'noQc': noQc.toString(),
      'receiveBerat': totalBerat.toString(),
      'receiveQty': totalQty.toString(),
      'notesReject': notesReject.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateItemPr}'),
        body: jsonEncode(body));
    print(response.body);
  }

  postDetailItem(String item, qty, berat, panjang, lebar, caratPcs) async {
    Map<String, String> body = {
      'type': 'itemPr', // Menambahkan jenis data 'itemPr' ke body
      'noPr': noPr!,
      'noQc': noQc,
      'item': item,
      'qty': qty,
      'berat': berat,
      'panjang': panjang,
      'lebar': lebar,
      'caratPcs': caratPcs,
      'jenisBatu': jenisBatu!,
      'kualitasBatu': kualitasBatu!,
      'ukuranBatu': ukuranBatu.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postListFormQc}'),
        body: body);
    print(response.body);
  }

  updateDetailItem(
      String id, String item, qty, berat, panjang, lebar, caratPcs) async {
    Map<String, String> body = {
      'id': id,
      'item': item,
      'qty': qty,
      'berat': berat,
      'panjang': panjang,
      'lebar': lebar,
      'caratPcs': caratPcs,
      'jenisBatu': jenisBatu!,
      'kualitasBatu': kualitasBatu!,
      'ukuranBatu': ukuranBatu.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateItemPr}'),
        body: jsonEncode(body));
    print(response.body);
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
