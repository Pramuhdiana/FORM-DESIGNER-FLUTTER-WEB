// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/produksi/modelProduksi/produksi_model.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FinishingScreen extends StatefulWidget {
  const FinishingScreen({super.key});
  @override
  State<FinishingScreen> createState() => _FinishingScreenState();
}

class _FinishingScreenState extends State<FinishingScreen> {
  List<ProduksiModel>? _listFinishing;
  List<ProduksiModel>? _filterListFinishing;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  String divisi = 'finishing';
  @override
  initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: Scaffold(
          body: Container(
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
                          _listFinishing = _filterListFinishing!
                              .where((element) =>
                                  element.nama!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  element.kodeProduksi!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  element.keterangan!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList();

                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  isLoading == true
                      ? Expanded(
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              width: 90,
                              height: 90,
                              child: Lottie.asset("loadingJSON/loadingV1.json"),
                            ),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: _dataTableFinishing()))),
                ],
              )),
        ));
  }

  Future<List<ProduksiModel>> _getData() async {
    setState(() {
      isLoading = true;
    });
    print('get data finishing');
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getProduksiByDivisi}?divisi=$divisi'));
    print(response.statusCode);
    // if response successful
    if (response.statusCode == 200) {
      print('berhasil');
      List jsonResponse = json.decode(response.body);
      var g;
      try {
        g = jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();
      } catch (c) {
        print('error $c');
      }
      // var filterByDivisiBulan = g.where((element) =>
      //     element.divisi.toString().toLowerCase() == 'finishing' &&
      //     element.bulan.toString().toLowerCase() == 'oktober');
      setState(() {
        _filterListFinishing = g;
        _listFinishing = g;
        isLoading = false;
      });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  DataTable _dataTableFinishing() {
    return DataTable(
        headingTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.black54),
        columnSpacing: 2,
        headingRowHeight: 50,
        // dataRowMaxHeight: 50,
        dataRowHeight: 50,
        columns: _createColumns(),
        border: TableBorder.all(),
        rows: _createRows(_listFinishing, _listFinishing!.length));
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('NAMA')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('TANGGAL IN')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('TANGGAL OUT')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KODE PRODUKSI')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('DEBET')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KREDIT')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('JATAH\nSUSUT')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('SUSUT\nBARANG')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('KETERANGAN')))),
      DataColumn(
          label: Container(
              padding: const EdgeInsets.all(5),
              child: const Center(child: Text('AKSI')))),
    ];
  }

  List<DataRow> _createRows(var data, int count) {
    return [
      for (var i = 0; i < count; i++)
        DataRow(cells: [
          DataCell(InkWell(
              onDoubleTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final _formKey = GlobalKey<FormState>();
                      TextEditingController nama = TextEditingController();
                      String id;
                      id = data[i].id.toString();
                      nama.text = data[i].nama;
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: nama,
                                          decoration: InputDecoration(
                                            // hintText: "example: Cahaya Sanivokasi",
                                            labelText: "Nama",
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
                                              child: const Text("Update"),
                                              onPressed: () async {
                                                Future.delayed(const Duration(
                                                        seconds: 2))
                                                    .then((value) async {
                                                  btnController.success();
                                                  // Map<String, dynamic> body = {
                                                  //   'id': id,
                                                  //   'lot': nama.text,
                                                  // };
                                                  // final response = await http.post(
                                                  //     Uri.parse(ApiConstants
                                                  //             .baseUrl +
                                                  //         ApiConstants
                                                  //             .postUpdateListDataBatu),
                                                  //     body: body);
                                                  Future.delayed(const Duration(
                                                          seconds: 1))
                                                      .then((value) {
                                                    btnController
                                                        .reset(); //reset
                                                  });
                                                  Navigator.pop(context);
                                                  showSimpleNotification(
                                                    Text(
                                                        'Update Berhasil :${data[i].id}'),
                                                    background: Colors.green,
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  );
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder:
                                                  //             (c) =>
                                                  //                 const MainViewBatu()));
                                                });
                                              }),
                                        ),
                                      )
                                    ]))
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(child: Text(data[i].nama))))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].tanggalIn)))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].tanggalOut)))),
          DataCell(InkWell(
              onDoubleTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final _formKey = GlobalKey<FormState>();
                      TextEditingController kodeProduksi =
                          TextEditingController();
                      String id;
                      id = data[i].id.toString();
                      kodeProduksi.text = data[i].kodeProduksi;
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: kodeProduksi,
                                          decoration: InputDecoration(
                                            // hintText: "example: Cahaya Sanivokasi",
                                            labelText: "Kode Produksi",
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
                                              child: const Text("Update"),
                                              onPressed: () async {
                                                Future.delayed(const Duration(
                                                        seconds: 2))
                                                    .then((value) async {
                                                  btnController.success();
                                                  // Map<String, dynamic> body = {
                                                  //   'id': id,
                                                  //   'lot': nama.text,
                                                  // };
                                                  // final response = await http.post(
                                                  //     Uri.parse(ApiConstants
                                                  //             .baseUrl +
                                                  //         ApiConstants
                                                  //             .postUpdateListDataBatu),
                                                  //     body: body);
                                                  Future.delayed(const Duration(
                                                          seconds: 1))
                                                      .then((value) {
                                                    btnController
                                                        .reset(); //reset
                                                  });
                                                  Navigator.pop(context);
                                                  showSimpleNotification(
                                                    Text(
                                                        'Update Berhasil :${data[i].id}'),
                                                    background: Colors.green,
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  );
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder:
                                                  //             (c) =>
                                                  //                 const MainViewBatu()));
                                                });
                                              }),
                                        ),
                                      )
                                    ]))
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(child: Text(data[i].kodeProduksi))))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].debet.toStringAsFixed(2))))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].kredit.toStringAsFixed(2))))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child:
                  Center(child: Text(data[i].jatahSusut.toStringAsFixed(2))))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child:
                  Center(child: Text(data[i].susutBarang.toStringAsFixed(2))))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(data[i].keterangan)))),
          DataCell(Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),

                  // InkWell(
                  //   onTap: () {},
                  //   child: Lottie.asset("loadingJSON/icon_delete.json",
                  //       fit: BoxFit.scaleDown),
                  // ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Lottie.asset("loadingJSON/icon_edit.json",
                  //       fit: BoxFit.scaleDown),
                  // )
                ],
              )))),
        ]),
    ];
  }
}
