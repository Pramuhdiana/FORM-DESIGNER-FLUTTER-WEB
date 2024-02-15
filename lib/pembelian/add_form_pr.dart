// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_pembelian.dart';
import 'package:form_designer/pembelian/form_pr_model.dart';
import 'package:http/http.dart' as http;
import 'package:form_designer/pembelian/list_item_model.dart';
import 'package:overlay_support/overlay_support.dart';

class AddFormPr extends StatefulWidget {
  final VoidCallback? onBackPressed;

  const AddFormPr({super.key, this.onBackPressed});

  @override
  State<AddFormPr> createState() => _AddFormPrState();
}

class _AddFormPrState extends State<AddFormPr> {
  var satuan = '';
  int limitItem = 0;
  int totalItem = 0;
  int totalQty = 0;
  double totalBerat = 0.0;
  bool isCheckedDiamond = false;
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
  TextEditingController noPR = TextEditingController();
  String? jenisForm;
  List<String> listItem = [];
  List<List<String>> selectListItem = [];
  TextEditingController notes = TextEditingController();

  @override
  initState() {
    super.initState();
    noPR.text = 'PR-001';
    getFormPR();
  }

  getFormPR() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getFormPR));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g = jsonResponse.map((data) => FormPrModel.fromJson(data)).toList();
      setState(() {
        noPR.text = 'PR-${(g.length + 1).toString().padLeft(4, '0')}';
      });
      // print(nowSiklus);
    } else {
      print(response.body);
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Pagi';
      }
      if (hour < 15) {
        return 'Siang';
      }
      if (hour < 17) {
        return 'Sore';
      }
      return 'Malam';
    }

    return Scaffold(
        backgroundColor: colorGrey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          foregroundColor: Colors.black, //! mengganti warna kenbali
          backgroundColor: Colors.white,
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
              onChanged: (value) {},
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          color: colorGrey,
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 26),
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
              )),
        ));
  }

  formInput() {
    double wid = 20;
    double widQty = 80;
    double widCrt = 80;
    double hig = 20;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 65,
                  width: 200,
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.next,
                    controller: vendor,
                    decoration: InputDecoration(
                      labelText: "Vendor",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Wajib diisi *';
                      }
                      return null;
                    },
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
                    controller: noPR,
                    decoration: InputDecoration(
                      filled: true, // Mengaktifkan fill color
                      fillColor: const Color.fromARGB(207, 236, 231, 231),
                      labelText: "NO PR",
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
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
                          : const Color.fromARGB(255, 255, 255,
                              255), //background color of dropdown button
                      border: Border.all(
                        color: Colors.black38,
                        // width:
                        //     3
                      ), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          0), //border raiuds of dropdown button
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
                            padding: EdgeInsets.only(left: 20),
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
              ],
            ),
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
                  : Container(
                      color: Colors.white10,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 65,
                            width: 200,
                            child: DropdownSearch<ListItemModel>(
                              asyncItems: (String? filter) => getData(filter),
                              popupProps:
                                  PopupPropsMultiSelection.modalBottomSheet(
                                searchFieldProps: TextFieldProps(
                                    controller: dumNama,
                                    decoration: InputDecoration(
                                      labelText: "Search..",
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            postDataListItem(dumNama.text);
                                            Navigator.pop(context);
                                            showSimpleNotification(
                                              const Text(
                                                  'Tambah Item Berhasil'),
                                              background: Colors.green,
                                              duration:
                                                  const Duration(seconds: 1),
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
                              compareFn: (item, sItem) => item.id == sItem.id,
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
                                dropdownSearchDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: wid),
                          SizedBox(
                            height: 65,
                            width: widQty,
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Qty",
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              onChanged: (item) {
                                dumQty = item;
                                selectListItem[i].isNotEmpty
                                    ? selectListItem[i][1] = '$dumQty'
                                    : null;
                                print(selectListItem);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Wajib diisi *';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: wid),
                          SizedBox(
                            height: 65,
                            width: 120,
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Berat $satuan",
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              onChanged: (item) {
                                dumBerat = item;
                                selectListItem[i].isNotEmpty
                                    ? selectListItem[i][2] = '$dumBerat'
                                    : null;
                                print(selectListItem);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Wajib diisi *';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: wid),
                          isCheckedDiamond == false
                              ? SizedBox(
                                  height: 65,
                                  width: widCrt,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
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
                                          ? selectListItem[i][3] = '$dumKadar'
                                          : null;
                                      print(selectListItem);
                                    },
                                  ),
                                )
                              : SizedBox(width: wid),
                          SizedBox(width: wid),
                          isCheckedDiamond == false
                              ? SizedBox(
                                  height: 65,
                                  width: widCrt,
                                  child: TextFormField(
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
                              : SizedBox(width: wid),
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
                                  '$dumColor'
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
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            onPressed: () async {
                              if (jenisForm == null) {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        const AlertDialog(
                                          title: Text(
                                            'jenis form wajib diisi',
                                          ),
                                        ));
                              } else {
                                for (var i = 0;
                                    i < selectListItem.length;
                                    i++) {
                                  totalBerat +=
                                      double.tryParse(selectListItem[i][2]) ??
                                          0;
                                  totalQty +=
                                      int.tryParse(selectListItem[i][1]) ?? 0;
                                  selectListItem[i][0] != ''
                                      ? totalItem += 1
                                      : null;
                                }
                                await postApiFormPR();

                                for (var i = 0;
                                    i < selectListItem.length;
                                    i++) {
                                  isCheckedDiamond == false
                                      ? postApiListFormPR(
                                          selectListItem[i][0],
                                          selectListItem[i][1],
                                          selectListItem[i][2],
                                          selectListItem[i][3],
                                          selectListItem[i][4])
                                      : postApiListFormPR(
                                          selectListItem[i][0],
                                          selectListItem[i][1],
                                          selectListItem[i][2],
                                          '',
                                          '');
                                }
                                sharedPreferences!.getString('divisi') ==
                                        'admin'
                                    ? Navigator.pop(context)
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => MainViewPembelian(
                                                  col: 1,
                                                )));
                                showSimpleNotification(
                                  const Text('Form PR Berhasil Dibuat'),
                                  background: Colors.green,
                                  duration: const Duration(seconds: 1),
                                );
                              }
                            },
                            child: const Text('Simpan')),
                      ),
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
          ]),
    );
  }

  postApiFormPR() async {
    Map<String, String> body = {
      'noPR': noPR.text,
      'vendor': vendor.text,
      'notes': notes.text,
      'total_item': totalItem.toString(),
      'total_berat': totalBerat.toString(),
      'total_qty': totalQty.toString(),
      'jenis_form': jenisForm.toString(),
      'jenis_item': jenisFormItem.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postFormPR}'),
        body: body);
    print(response.body);
  }

  postApiListFormPR(item, qty, berat, kadar, color) async {
    Map<String, String> body = {
      'noPR': noPR.text,
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
