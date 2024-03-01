// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:form_designer/pembelian/list_form_pr_model.dart';
import 'package:form_designer/qc/modelQc/kualitasBatuModel.dart';
import 'package:http/http.dart' as http;
import 'package:form_designer/pembelian/list_item_model.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

// ignore: must_be_immutable
class AddFormPr extends StatefulWidget {
  final VoidCallback? onCloseForm;
  final VoidCallback? onCloseFormLoadData;
  String? nomorPr;
  List<ListItemPRModel>? listItemPR;
  List<FormPrModel>? dataFormPR;
  String? mode;

  AddFormPr(
      {super.key,
      this.onCloseForm,
      this.onCloseFormLoadData,
      this.listItemPR,
      this.dataFormPR,
      this.nomorPr,
      this.mode});

  @override
  State<AddFormPr> createState() => _AddFormPrState();
}

class _AddFormPrState extends State<AddFormPr> {
  String? kualitasBatu;
  List<KualitasBatuModel>? listKualitasBatu;
  var satuan = '';
  String? jenisBatu = 'ROUND';
  int limitItem = 0;
  int totalItem = 0;
  int totalQty = 0;
  double totalBerat = 0.0;
  bool isCheckedDiamond = false;
  bool isCheckedRound = false;
  bool isCheckedEmas = false;
  bool isCheckedBarangBerharga = false;
  String? jenisFormItem = '';
  String? dumItem = '';
  String? dumQty = '';
  String? dumBerat = '';
  String? dumKadar = '';
  String? dumColor = '';
  TextEditingController dumNama = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController qty1 = TextEditingController();
  TextEditingController vendor = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController noPr = TextEditingController();
  String? jenisForm;
  List<String> listItem = [];
  List<List<String>> selectListItem = [];
  TextEditingController notes = TextEditingController();
  bool isLoading = false;
  List<ListItemPRModel>? _listItemPR;
  List<FormPrModel>? _formPR;

  double wid = 20;
  double widQty = 80;
  double widCrt = 80;
  double hig = 20;

  @override
  initState() {
    super.initState();
    print(widget.nomorPr);
    getAllData();
  }

  simpanForm() async {
    for (var i = 0; i < selectListItem.length; i++) {
      totalBerat += double.tryParse(selectListItem[i][2]) ?? 0;
      totalQty += int.tryParse(selectListItem[i][1]) ?? 0;
      selectListItem[i][0] != '' ? totalItem += 1 : null;
    }
    await postApiFormPR();

    for (var i = 0; i < selectListItem.length; i++) {
      isCheckedDiamond == false
          ? postApiListFormPR(selectListItem[i][0], selectListItem[i][1],
              selectListItem[i][2], selectListItem[i][3], selectListItem[i][4])
          : postApiListFormPR(selectListItem[i][0], selectListItem[i][1],
              selectListItem[i][2], selectListItem[i][3], selectListItem[i][4]);
    }
    Navigator.pop(context);
    widget.onCloseFormLoadData!.call();
    showSimpleNotification(
      const Text('Form PR Berhasil Dibuat'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  editForm() async {
    for (var i = 0; i < selectListItem.length; i++) {
      totalBerat += double.tryParse(selectListItem[i][2]) ?? 0;
      totalQty += int.tryParse(selectListItem[i][1]) ?? 0;
      selectListItem[i][0] != '' ? totalItem += 1 : null;
    }

    for (var i = 0; i < selectListItem.length; i++) {
      isCheckedDiamond == false
          ? await updateItem(
              selectListItem[i][5],
              selectListItem[i][0],
              selectListItem[i][1],
              selectListItem[i][2],
              selectListItem[i][3],
              selectListItem[i][4])
          : await updateItem(
              selectListItem[i][5],
              selectListItem[i][0],
              selectListItem[i][1],
              selectListItem[i][2],
              selectListItem[i][3],
              selectListItem[i][4]);
    }
    await updateForm();
    Navigator.pop(context);
    widget.onCloseFormLoadData!.call();
    showSimpleNotification(
      const Text('Form PR Berhasil Dibuat'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  getAllData() async {
    setState(() {
      isLoading = true;
    });
    if (widget.nomorPr != '') {
      await getDataFormEdit();
    }
    await getKualitasBatu();
    await getFormPR();
    setState(() {
      isLoading = false;
    });
  }

  getDataFormEdit() async {
    try {
      setState(() {
        _listItemPR = widget.listItemPR!
            .where((element) => element.noPr == widget.nomorPr)
            .toList();

        for (var i = 0; i < _listItemPR!.length; i++) {
          dumItem = _listItemPR![i].item;
          dumQty = _listItemPR![i].qty;
          dumBerat = _listItemPR![i].berat;
          dumKadar = _listItemPR![i].kadar;
          dumColor = _listItemPR![i].color;
          var dumId = _listItemPR![i].id;
          selectListItem.add([
            '$dumItem',
            '$dumQty',
            '$dumBerat',
            '$dumKadar',
            '$dumColor',
            '$dumId'
          ]);
        }

        limitItem += _listItemPR!.length;
        print(selectListItem);
      });
    } catch (c) {
      print('err get data form edit listitem PR = $c');
    }
    try {
      setState(() {
        _formPR = widget.dataFormPR!
            .where((element) => element.noPr == widget.nomorPr)
            .toList();

        jenisBatu = _formPR!.first.jenisBatu;
        jenisFormItem = _formPR!.first.jenisItem;
        jenisForm = _formPR!.first.jenisForm;
        vendor.text = _formPR!.first.vendor!;
        lokasi.text = _formPR!.first.lokasi!;
        notes.text = _formPR!.first.notes!;
        jenisFormItem.toString().toLowerCase() == 'diamond'
            ? isCheckedDiamond = true
            : jenisFormItem.toString().toLowerCase() == 'emas'
                ? isCheckedEmas = true
                : isCheckedBarangBerharga = true;
        jenisBatu.toString().toLowerCase() != 'round'
            ? isCheckedRound = true
            : isCheckedRound = false;
      });
    } catch (c) {
      print('err get data form edit formPR = $c');
    }
  }

  getFormPR() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getFormPR));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        var allData =
            jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();
        setState(() {
          widget.nomorPr != ''
              ? noPr.text = widget.nomorPr!
              : noPr.text =
                  'PR-${(allData.length + 1).toString().padLeft(4, '0')}';
        });
        // print(nowSiklus);
      } else {
        print(response.body);
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get data form = $c');
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
            width: MediaQuery.of(context).size.width * 1,
            color: colorBG,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    widget.onCloseForm!.call();
                  },
                  child: SizedBox(
                    width: 50,
                    child: Lottie.asset(
                      "loadingJSON/backbutton.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: const Text(
                              'Form PR',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                            ),
                          ),
                          formInput()
                        ]),
                  ),
                ),
              ],
            ),
          );
  }

  buildFormField() {
    return [
      SizedBox(
        height: 65,
        width: 200,
        child: TextFormField(
          style: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          textInputAction: TextInputAction.next,
          controller: vendor,
          decoration: InputDecoration(
            labelText: "Vendor",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
      SizedBox(width: wid),
      SizedBox(
        height: 65,
        width: 200,
        child: TextFormField(
          style: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          textInputAction: TextInputAction.next,
          controller: lokasi,
          decoration: InputDecoration(
            labelText: "Lokasi",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
      SizedBox(width: wid),
      SizedBox(
        height: 65,
        width: 200,
        child: TextFormField(
          enabled: false,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
          textInputAction: TextInputAction.next,
          controller: noPr,
          decoration: InputDecoration(
            filled: true, // Mengaktifkan fill color
            fillColor: const Color.fromARGB(207, 236, 231, 231),
            labelText: "NO PR",
            labelStyle: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
      SizedBox(width: wid),
      DecoratedBox(
        decoration: BoxDecoration(
            color: jenisForm != null
                ? const Color.fromARGB(255, 8, 209, 69)
                : const Color.fromARGB(
                    255, 255, 255, 255), //background color of dropdown button
            border: Border.all(
              color: Colors.black38,
              // width:
              //     3
            ), //border of dropdown button
            borderRadius:
                BorderRadius.circular(0), //border raiuds of dropdown button
            boxShadow: const <BoxShadow>[]),
        child: Container(
            padding: const EdgeInsets.only(left: 10),
            width: 200,
            child: DropdownButton(
              value: jenisForm,
              items: const [
                //add items in the dropdown
                DropdownMenuItem(
                  value: "Retur",
                  child: Text("Retur"),
                ),
                DropdownMenuItem(
                  value: "Pembelian",
                  child: Text("Pembelian"),
                ),
              ],
              hint: const Text('Jenis Form'),
              onChanged: (value) {
                setState(() {
                  jenisForm = value;
                });
              },
              icon: const Padding(
                  padding: EdgeInsets.only(left: 20, right: 5),
                  child: Icon(Icons.arrow_circle_down_sharp)),
              iconEnabledColor: Colors.black, //Icon color
              style: const TextStyle(
                color: Colors.black, //Font color
                // fontSize:
                //     15 //font size on dropdown button
              ),

              dropdownColor: Colors.white, //dropdown background color
              underline: Container(), //remove underline
              isExpanded: true, //make true to make width 100%
            )),
      )
    ];
  }

  formInput() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              10), // Atur nilai radius sesuai keinginan Anda
          color: Colors.white, // Warna latar belakang
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Warna bayangan
              spreadRadius: 2, // Radius penyebaran bayangan
              blurRadius: 3, // Radius blur bayangan
              offset: const Offset(0, 2), // Offset bayangan (x, y)
            ),
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LayoutBuilder(builder: (context, constraints) {
                print(constraints.maxWidth);
                //* HINTS Memeriksa apakah lebar layar kurang dari nilai tertentu
                bool isSmallScreen =
                    constraints.maxWidth < 850; // Atur nilai sesuai kebutuhan
                return isSmallScreen
                    ? Column(
                        // Menggunakan Column untuk tata letak jika layar kecil
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            buildFormField(), // Membangun kolom bidang formulir
                      )
                    : Row(
                        // Menggunakan Row untuk tata letak jika layar cukup besar
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            buildFormField(), // Membangun baris bidang formulir
                      );
              }),
              Row(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: isCheckedDiamond,
                          onChanged: (value) {
                            setState(() {
                              isCheckedDiamond = value!;
                              if (isCheckedDiamond) {
                                satuan = 'Carat';
                                jenisFormItem = 'Diamond';
                                isCheckedEmas = false;
                                isCheckedBarangBerharga = false;
                              }
                            });
                          },
                        ),
                        const Text('Diamond'),
                      ]),
                  SizedBox(width: wid),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: isCheckedEmas,
                          onChanged: (value) {
                            setState(() {
                              isCheckedEmas = value!;
                              if (isCheckedEmas) {
                                jenisFormItem = 'Emas';
                                satuan = 'Gram';

                                isCheckedDiamond = false;
                                isCheckedBarangBerharga = false;
                              }
                            });
                          },
                        ),
                        const Text('Emas'),
                      ]),
                  SizedBox(width: wid),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: isCheckedBarangBerharga,
                          onChanged: (value) {
                            setState(() {
                              isCheckedBarangBerharga = value!;
                              if (isCheckedBarangBerharga) {
                                jenisFormItem = 'Barang Berharga';
                                satuan = 'Gram';
                                isCheckedEmas = false;
                                isCheckedDiamond = false;
                              }
                            });
                          },
                        ),
                        const Text('BarangBerharga'),
                      ]),
                ],
              ),
              isCheckedDiamond == false
                  ? const SizedBox()
                  : Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Checkbox(
                        value: isCheckedRound,
                        onChanged: (value) {
                          setState(() {
                            isCheckedRound = value!;
                            if (isCheckedRound) {
                              jenisBatu = 'FANCY';
                            } else {
                              jenisBatu = 'ROUND';
                            }
                            print(jenisBatu);
                          });
                        },
                      ),
                      const Text(
                        'Fancy ?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: const Divider(
                      color: Colors.black,
                      height: 25,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    'List Item $jenisFormItem',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: const Divider(
                      color: Colors.black,
                      height: 25,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: hig),
              for (var i = 0; i < limitItem; i++)
                isCheckedBarangBerharga == false &&
                        isCheckedEmas == false &&
                        isCheckedDiamond == false
                    ? const SizedBox()
                    : widget.mode == 'edit'
                        ? Container(
                            color: Colors.white10,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content:
                                                DropdownSearch<ListItemModel>(
                                              asyncItems: (String? filter) =>
                                                  getData(filter),
                                              popupProps:
                                                  PopupPropsMultiSelection
                                                      .modalBottomSheet(
                                                searchFieldProps:
                                                    TextFieldProps(
                                                        controller: dumNama,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: "Search..",
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.search),
                                                          suffixIcon: InkWell(
                                                              onTap: () {
                                                                postDataListItem(
                                                                    dumNama
                                                                        .text);
                                                                Navigator.pop(
                                                                    context);
                                                                showSimpleNotification(
                                                                  const Text(
                                                                      'Tambah Item Berhasil'),
                                                                  background:
                                                                      Colors
                                                                          .green,
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                );
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                          //! end fungsi
                                                        )),
                                                showSelectedItems: true,
                                                itemBuilder: _listItem,
                                                showSearchBox: true,
                                              ),
                                              compareFn: (item, sItem) =>
                                                  item.id == sItem.id,
                                              onChanged: (item) async {
                                                setState(() {
                                                  dumNama.text = '';
                                                  dumItem = '$item';
                                                  selectListItem[i].isNotEmpty
                                                      ? selectListItem[i][0] =
                                                          '$dumItem'
                                                      : null;
                                                });

                                                print(selectListItem);
                                                Navigator.pop(context);
                                              },
                                              dropdownDecoratorProps:
                                                  const DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: SizedBox(
                                      height: 65,
                                      width: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              selectListItem[i][0],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(width: wid),
                                SizedBox(
                                  height: 65,
                                  width: widQty,
                                  child: TextFormField(
                                    initialValue: selectListItem[i][1],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Qty",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    onChanged: (item) {
                                      dumQty = item;
                                      selectListItem[i].isNotEmpty
                                          ? selectListItem[i][1] = '$dumQty'
                                          : null;
                                      print(selectListItem);
                                    },
                                  ),
                                ),
                                SizedBox(width: wid),
                                SizedBox(
                                  height: 65,
                                  width: 120,
                                  child: TextFormField(
                                    initialValue: selectListItem[i][2],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Berat $satuan",
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    onChanged: (item) {
                                      dumBerat = item;
                                      selectListItem[i].isNotEmpty
                                          ? selectListItem[i][2] = '$dumBerat'
                                          : null;
                                      print(selectListItem);
                                    },
                                  ),
                                ),
                                SizedBox(width: wid),
                                isCheckedDiamond == false
                                    ? SizedBox(
                                        height: 65,
                                        width: widCrt,
                                        child: TextFormField(
                                          initialValue: selectListItem[i][3],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            labelText: "Kadar",
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          onChanged: (item) {
                                            dumKadar = item;
                                            selectListItem[i].isNotEmpty
                                                ? selectListItem[i][3] =
                                                    '$dumKadar'
                                                : null;
                                            print(selectListItem);
                                          },
                                        ),
                                      )
                                    : SizedBox(
                                        height: 65,
                                        width: widCrt,
                                        child: DropdownButtonFormField(
                                          value: selectListItem[i][3],
                                          items: [
                                            //* hints looping sederhana
                                            for (var item in listKualitasBatu!)
                                              DropdownMenuItem(
                                                value: item.kualitasBatu,
                                                child: Text(item.kualitasBatu!),
                                              ),
                                          ],
                                          onChanged: (item) {
                                            dumKadar = item;
                                            selectListItem[i].isNotEmpty
                                                ? selectListItem[i][3] =
                                                    '$dumKadar'
                                                : null;
                                            print(selectListItem);
                                          },
                                        ),
                                      ),
                                SizedBox(width: wid),
                                SizedBox(
                                  height: 65,
                                  width: widCrt,
                                  child: TextFormField(
                                    initialValue: selectListItem[i][4],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Color",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    onChanged: (item) {
                                      dumColor = item;
                                      selectListItem[i].isNotEmpty
                                          ? selectListItem[i][4] = '$dumColor'
                                          : null;
                                      print(selectListItem);
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            color: Colors.white10,
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 65,
                                    width: 200,
                                    child: DropdownSearch<ListItemModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        searchFieldProps: TextFieldProps(
                                            controller: dumNama,
                                            decoration: InputDecoration(
                                              labelText: "Search..",
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              suffixIcon: InkWell(
                                                  onTap: () {
                                                    postDataListItem(
                                                        dumNama.text);
                                                    Navigator.pop(context);
                                                    showSimpleNotification(
                                                      const Text(
                                                          'Tambah Item Berhasil'),
                                                      background: Colors.green,
                                                      duration: const Duration(
                                                          seconds: 1),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  )),
                                              //! end fungsi
                                            )),
                                        showSelectedItems: true,
                                        itemBuilder: _listItem,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {
                                        dumNama.text = '';

                                        dumItem = '$item';
                                        selectListItem[i].isNotEmpty
                                            ? selectListItem[i][0] = '$dumItem'
                                            : null;
                                        print(selectListItem);
                                      },
                                      dropdownDecoratorProps:
                                          const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    )),
                                SizedBox(width: wid),
                                SizedBox(
                                  height: 65,
                                  width: widQty,
                                  child: TextFormField(
                                    initialValue: selectListItem[i][1],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Qty",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    onChanged: (item) {
                                      dumQty = item;
                                      selectListItem[i].isNotEmpty
                                          ? selectListItem[i][1] = '$dumQty'
                                          : null;
                                      print(selectListItem);
                                    },
                                  ),
                                ),
                                SizedBox(width: wid),
                                SizedBox(
                                  height: 65,
                                  width: 120,
                                  child: TextFormField(
                                    initialValue: selectListItem[i][2],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Berat $satuan",
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    onChanged: (item) {
                                      dumBerat = item;
                                      selectListItem[i].isNotEmpty
                                          ? selectListItem[i][2] = '$dumBerat'
                                          : null;
                                      print(selectListItem);
                                    },
                                  ),
                                ),
                                SizedBox(width: wid),
                                isCheckedDiamond == false
                                    ? SizedBox(
                                        height: 65,
                                        width: widCrt,
                                        child: TextFormField(
                                          initialValue: selectListItem[i][3],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            labelText: "Kadar",
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          onChanged: (item) {
                                            dumKadar = item;
                                            selectListItem[i].isNotEmpty
                                                ? selectListItem[i][3] =
                                                    '$dumKadar'
                                                : null;
                                            print(selectListItem);
                                          },
                                        ),
                                      )
                                    : SizedBox(
                                        height: 65,
                                        width: widCrt,
                                        child: DropdownButtonFormField(
                                          value: selectListItem[i][3],
                                          items: [
                                            //* hints looping sederhana
                                            for (var item in listKualitasBatu!)
                                              DropdownMenuItem(
                                                value: item.kualitasBatu,
                                                child: Text(item.kualitasBatu!),
                                              ),
                                          ],
                                          onChanged: (item) {
                                            dumKadar = item;
                                            selectListItem[i].isNotEmpty
                                                ? selectListItem[i][3] =
                                                    '$dumKadar'
                                                : null;
                                            print(selectListItem);
                                          },
                                        ),
                                      ),
                                SizedBox(width: wid),
                                SizedBox(
                                  height: 65,
                                  width: widCrt,
                                  child: TextFormField(
                                    initialValue: selectListItem[i][4],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Color",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    onChanged: (item) {
                                      dumColor = item;
                                      selectListItem[i].isNotEmpty
                                          ? selectListItem[i][4] = '$dumColor'
                                          : null;
                                      print(selectListItem);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
              isCheckedBarangBerharga == false &&
                      isCheckedEmas == false &&
                      isCheckedDiamond == false
                  ? const SizedBox()
                  : Row(
                      children: [
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  dumItem = '';
                                  dumQty = '';
                                  dumBerat = '';
                                  dumKadar = '';
                                  dumColor = '';
                                  selectListItem.add([
                                    '$dumItem',
                                    '$dumQty',
                                    '$dumBerat',
                                    '$dumKadar',
                                    '$dumColor',
                                    '-1'
                                  ]);
                                  print(selectListItem);
                                  limitItem += 1;
                                  dumNama.text = '';
                                });
                              },
                              child: const Text('Add Item')),
                        ),
                        SizedBox(width: wid),
                        limitItem <= 0
                            ? const SizedBox()
                            : SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        limitItem -= 1;
                                        selectListItem.removeAt(limitItem);
                                        print(selectListItem);
                                      });
                                    },
                                    child: const Text('Delete Item')),
                              ),
                        SizedBox(width: wid),
                      ],
                    ),
              SizedBox(height: hig),
              isCheckedBarangBerharga == false &&
                      isCheckedEmas == false &&
                      isCheckedDiamond == false
                  ? const SizedBox()
                  : ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight:
                              200), //? untuk menenrukan max tinggi di sizedbox
                      child: SizedBox(
                        width: 420,
                        child: TextField(
                          controller: notes,
                          keyboardType: TextInputType.multiline,
                          maxLines:
                              null, // null untuk menyesuaikan tinggi sesuai isi teks
                          decoration: const InputDecoration(
                            labelText: 'Notes',
                            hintText: 'Masukkan keterangan di sini...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
              widget.mode == 'edit'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: 40,
                          padding: const EdgeInsets.only(left: 0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.yellow.shade900),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    // side: BorderSide(color: Colors.white)
                                  ))),
                              onPressed: () {
                                if (jenisForm == null) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title:
                                          const Text('Jenis form wajib diisi'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context), // Menutup dialog
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
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
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.download),
                                  SizedBox(width: 15),
                                  Text(
                                    'Edit Form',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ))),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: 40,
                          padding: const EdgeInsets.only(left: 0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                // side: BorderSide(color: Colors.white)
                              ))),
                              onPressed: () {
                                if (jenisForm == null) {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const AlertDialog(
                                            title: Text(
                                              'jenis form wajib diisi',
                                            ),
                                          ));
                                }
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
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.download),
                                  SizedBox(width: 15),
                                  Text(
                                    'Simpan Form',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ))),
                    ),
            ]),
      ),
    );
  }

  postApiFormPR() async {
    Map<String, String> body = {
      'noPr': noPr.text,
      'vendor': vendor.text,
      'lokasi': lokasi.text,
      'notes': notes.text,
      'total_item': totalItem.toString(),
      'total_berat': totalBerat.toString(),
      'total_qty': totalQty.toString(),
      'jenis_form': jenisForm.toString(),
      'jenis_item': jenisFormItem.toString(),
      'jenis_batu': jenisBatu.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postFormPR}'),
        body: body);
    print(response.body);
  }

  updateForm() async {
    Map<String, String> body = {
      'type': 'formPr',
      'noPr': noPr.text,
      'vendor': vendor.text,
      'lokasi': lokasi.text,
      'notes': notes.text,
      'total_item': totalItem.toString(),
      'total_berat': totalBerat.toString(),
      'total_qty': totalQty.toString(),
      'jenis_form': jenisForm.toString(),
      'jenis_item': jenisFormItem.toString(),
      'jenis_batu': jenisBatu.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.restFullApi}'),
        body: jsonEncode(body));
    print(response.body);
  }

  updateItem(String id, String item, qty, berat, kadar, color) async {
    print(item);
    id == '' ? id = '-1' : id = id;
    Map<String, String> body = {
      'type': 'itemPr',
      'noPr': widget.nomorPr!,
      'id': id,
      'item': item,
      'qty': qty,
      'berat': berat,
      'kadar': kadar,
      'color': color,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateItemPr}'),
        body: jsonEncode(body));
    print(response.body);
  }

  postApiListFormPR(item, qty, berat, kadar, color) async {
    Map<String, String> body = {
      'noPr': noPr.text,
      'item': item,
      'qty': qty,
      'berat': berat,
      'kadar': kadar,
      'color': color,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postListFormPR}'),
        body: body);
    print(response.body);
  }

  postDataListItem(item) async {
    print('ini namanya $item');
    Map<String, String> body = {
      'item': item,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postDataListItem}'),
        body: body);
    print(response.body);
  }
}

Future<List<ListItemModel>> getData(filter) async {
  var response = await Dio().get(
    ApiConstants.baseUrl + ApiConstants.getDataListItem,
    queryParameters: {"filter": filter.toLowerCase()},
  );
  final data = response.data;
  if (data != null) {
    return ListItemModel.fromJsonList(data);
  }
  return [];
}

Widget _listItem(
  BuildContext context,
  ListItemModel? item,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item?.item ?? '',
          ),
        ],
      ),
    ),
  );
}
