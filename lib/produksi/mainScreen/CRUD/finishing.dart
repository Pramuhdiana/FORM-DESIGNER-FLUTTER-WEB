// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/produksi/modelProduksi/artist_produksi_model.dart';
import 'package:form_designer/produksi/modelProduksi/produksi2024_model.dart';
// import 'package:form_designer/produksi/modelProduksi/produksi_model.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: must_be_immutable
class FinishingScreen extends StatefulWidget {
  var input = '';
  FinishingScreen({super.key, required this.input});
  @override
  State<FinishingScreen> createState() => _FinishingScreenState();
}

class _FinishingScreenState extends State<FinishingScreen> {
  List<ProduksiModel2024>? _listFinishing;
  List<ProduksiModel2024>? _filterListFinishing;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  String divisi = 'finishing';
  //! fungsi go to up
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  int page = 0;
  //? end funciotn

  @override
  initState() {
    //! initstate scroll top button

    //? end function scroll top hide un hide

    super.initState();
    _getData();
    // scrollHide();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page != _listFinishing!.length) {
          // on bottom scroll API Call until last page
          setState(() {
            showbtn = true;
            print('masuk');
          });
        }
      }
    });
  }

  formSimpanBahan() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final _formKey = GlobalKey<FormState>();
          TextEditingController nama = TextEditingController();
          TextEditingController kodeProduksi = TextEditingController();
          TextEditingController debet = TextEditingController();
          TextEditingController kredit = TextEditingController();
          TextEditingController point = TextEditingController();
          TextEditingController keterangan = TextEditingController();
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
                      //NAMA
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<ArtistProduksiModel>(
                          asyncItems: (String? filter) => getListArtist(filter),
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            showSelectedItems: true,
                            itemBuilder: _listArtist,
                            showSearchBox: true,
                          ),
                          compareFn: (item, sItem) => item.id == sItem.id,
                          onChanged: (item) {
                            setState(() {
                              nama.text = item!.nama;
                            });
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "NAMA",
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //kode produksi
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
                            labelText: "KODE PRODUKSI",
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textInputAction: TextInputAction.next,
                          controller: debet,
                          decoration: InputDecoration(
                            // hintText: "example: Cahaya Sanivokasi",
                            labelText: "PRODUCT DEBET",
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

                      //? KREDIT
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textInputAction: TextInputAction.next,
                          controller: kredit,
                          decoration: InputDecoration(
                            // hintText: "example: Cahaya Sanivokasi",
                            labelText: "PRODUCT KREDIT",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      //? point
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textInputAction: TextInputAction.next,
                          controller: point,
                          decoration: InputDecoration(
                            // hintText: "example: Cahaya Sanivokasi",
                            labelText: "POINT",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
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
                            labelText: "KETERANGAN",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 250,
                          child: CustomLoadingButton(
                              controller: btnController,
                              child: const Text("Simpan Data SB"),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  Future.delayed(const Duration(seconds: 2))
                                      .then((value) async {
                                    btnController.success();
                                    // Map<String, dynamic>
                                    //     body = {
                                    //   'lot': lot.text,
                                    //   'size': size.text,
                                    //   'parcel': parcel.text,
                                    //   'qty': qty.text,
                                    //   'caratPcs':
                                    //       caratPcs.text,
                                    //   'keterangan':
                                    //       keterangan.text,
                                    // };
                                    // final response = await http.post(
                                    //     Uri.parse(ApiConstants
                                    //             .baseUrl +
                                    //         ApiConstants
                                    //             .postDataBatu),
                                    //     body: body);
                                    // print(response.body);
                                    Future.delayed(const Duration(seconds: 1))
                                        .then((value) {
                                      btnController.reset(); //reset
                                      setState(() {
                                        _getData();
                                      });
                                    });
                                    Navigator.pop(context);
                                    showSimpleNotification(
                                      const Text('Tambah Data Berhasil'),
                                      background: Colors.green,
                                      duration: const Duration(seconds: 2),
                                    );

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (c) =>
                                    //             const MainViewBatu()));
                                  });
                                } else {
                                  btnController.error();
                                  Future.delayed(const Duration(seconds: 1))
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
  }

  // scrollHide() {
  //   scrollController.addListener(() {
  //     //scroll listener
  //     double showoffset =
  //         10.0; //Back to top botton will show on scroll offset 10.0

  //     if (scrollController.offset > showoffset) {
  //       showbtn = true;
  //       setState(() {
  //         print('true');
  //       });
  //     } else {
  //       showbtn = false;
  //       setState(() {
  //         print('false');
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: Scaffold(
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000), //show/hide animation
            opacity: showbtn ? 1.0 : 0.0, //set obacity to 1 on visible, or hide
            child: FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(
                    //go to top of scroll
                    0, //scroll offset to go
                    duration:
                        const Duration(milliseconds: 500), //duration of scroll
                    curve: Curves.fastOutSlowIn //scroll type
                    );
                setState(() {
                  showbtn = false;
                });
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.arrow_upward),
            ),
          ),
          body: Container(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //! simpan sisa bahan
                      FloatingActionButton.extended(
                        backgroundColor: Colors.black,
                        onPressed: () {},
                        label: const Text(
                          "Tambah Sisa Bahan Finishing",
                          style: TextStyle(color: Colors.white),
                        ),
                        hoverElevation: 50,
                        hoverColor: Colors.blue,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 55,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: CupertinoSearchTextField(
                          placeholder: 'Search Anything...',
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          itemColor: Colors.black,
                          controller: controller,
                          backgroundColor: Colors.black12,
                          keyboardType: TextInputType.text,
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
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
                              controller:
                                  scrollController, //? gunakan controllernya
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                  width: 1200, child: _dataTableFinishing()))),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ));
  }

  Future<List<ProduksiModel2024>> _getData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      'Location': divisi,
      'strindate': '2024-01-01',
      'stroutdate': '2024-01-30',
    };
    final response =
        await http.post(Uri.parse(ApiConstants.baseUrlDummySusut), body: body);
    print(response.body);
    // if response successful
    if (response.statusCode == 200) {
      print('berhasil');
      List jsonResponse = json.decode(response.body);
      var g;
      try {
        g = jsonResponse
            .map((data) => ProduksiModel2024.fromJson(data))
            .toList();
      } catch (c) {
        print('error $c');
      }
      // var filterByDivisiBulan = g.where((element) =>
      //     element.divisi.toString().toLowerCase() == 'poleshing 1' &&
      //     element.bulan.toString().toLowerCase() == 'oktober');
      _filterListFinishing = g;
      _listFinishing = g;

      setState(() {
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
        rows: _createRows(_listFinishing, 20));
    // rows: _createRows(_listFinishing, _listFinishing!.length));
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
              onLongPress: () {
                var copy = data[i].kodeProduksi.toString();
                Clipboard.setData(ClipboardData(text: copy));
                showSimpleNotification(
                  const Text('Text Berhasil Dicopy'),
                  background: Colors.green,
                  duration: const Duration(seconds: 2),
                );
              },
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
                            content: Text(
                              'Apakah anda yakin ingin menghapus data ${data[i].kodeProduksi} ',
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
                                  // var id = data.id.toString();
                                  // Map<String, String> body = {'id': id};
                                  // final response = await http.post(
                                  //     Uri.parse(ApiConstants.baseUrl +
                                  //         ApiConstants.postDeleteBatuById),
                                  //     body: body);
                                  // print(response.body);
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (c) =>
                                  //             const MainViewBatu()));
                                  showSimpleNotification(
                                    Text(
                                        'Delete Data Berhasil : ${data[i].id}'),
                                    background: Colors.green,
                                    duration: const Duration(seconds: 2),
                                  );
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

  Future<List<ArtistProduksiModel>> getListArtist(filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListArtist,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return ArtistProduksiModel.fromJsonList(data);
    }
    return [];
  }

  Widget _listArtist(
    BuildContext context,
    ArtistProduksiModel? item,
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
        title: Text(item?.nama ?? ''),
      ),
    );
  }
}

//? button tambah data
   // FloatingActionButton.extended(
                      //   onPressed: () {
                      //     showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           final _formKey = GlobalKey<FormState>();
                      //           TextEditingController nama =
                      //               TextEditingController();
                      //           TextEditingController kodeProduksi =
                      //               TextEditingController();
                      //           TextEditingController debet =
                      //               TextEditingController();
                      //           TextEditingController kredit =
                      //               TextEditingController();
                      //           TextEditingController point =
                      //               TextEditingController();
                      //           TextEditingController keterangan =
                      //               TextEditingController();
                      //           RoundedLoadingButtonController btnController =
                      //               RoundedLoadingButtonController();
                      //           return AlertDialog(
                      //             content: Stack(
                      //               clipBehavior: Clip.none,
                      //               children: <Widget>[
                      //                 Positioned(
                      //                   right: -47.0,
                      //                   top: -47.0,
                      //                   child: InkResponse(
                      //                     onTap: () {
                      //                       Navigator.of(context).pop();
                      //                     },
                      //                     child: const CircleAvatar(
                      //                       backgroundColor: Colors.red,
                      //                       child: Icon(Icons.close),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Form(
                      //                   key: _formKey,
                      //                   child: Column(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: <Widget>[
                      //                       //NAMA
                      //                       Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: DropdownSearch<
                      //                             ArtistProduksiModel>(
                      //                           asyncItems: (String? filter) =>
                      //                               getListArtist(filter),
                      //                           popupProps:
                      //                               PopupPropsMultiSelection
                      //                                   .modalBottomSheet(
                      //                             showSelectedItems: true,
                      //                             itemBuilder: _listArtist,
                      //                             showSearchBox: true,
                      //                           ),
                      //                           compareFn: (item, sItem) =>
                      //                               item.id == sItem.id,
                      //                           onChanged: (item) {
                      //                             setState(() {
                      //                               nama.text = item!.nama;
                      //                             });
                      //                           },
                      //                           dropdownDecoratorProps:
                      //                               const DropDownDecoratorProps(
                      //                             dropdownSearchDecoration:
                      //                                 InputDecoration(
                      //                               labelText: "NAMA",
                      //                               filled: true,
                      //                               fillColor: Colors.white,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       //kode produksi
                      //                       Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: TextFormField(
                      //                           style: const TextStyle(
                      //                               fontSize: 14,
                      //                               color: Colors.black,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           controller: kodeProduksi,
                      //                           decoration: InputDecoration(
                      //                             // hintText: "example: Cahaya Sanivokasi",
                      //                             labelText: "KODE PRODUKSI",
                      //                             border: OutlineInputBorder(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         5.0)),
                      //                           ),
                      //                           validator: (value) {
                      //                             if (value!.isEmpty) {
                      //                               return 'Wajib diisi *';
                      //                             }
                      //                             return null;
                      //                           },
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: TextFormField(
                      //                           style: const TextStyle(
                      //                               fontSize: 14,
                      //                               color: Colors.black,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           controller: debet,
                      //                           decoration: InputDecoration(
                      //                             // hintText: "example: Cahaya Sanivokasi",
                      //                             labelText: "PRODUCT DEBET",
                      //                             border: OutlineInputBorder(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         5.0)),
                      //                           ),
                      //                           validator: (value) {
                      //                             if (value!.isEmpty) {
                      //                               return 'Wajib diisi *';
                      //                             }
                      //                             return null;
                      //                           },
                      //                         ),
                      //                       ),

                      //                       //? KREDIT
                      //                       Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: TextFormField(
                      //                           style: const TextStyle(
                      //                               fontSize: 14,
                      //                               color: Colors.black,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           controller: kredit,
                      //                           decoration: InputDecoration(
                      //                             // hintText: "example: Cahaya Sanivokasi",
                      //                             labelText: "PRODUCT KREDIT",
                      //                             border: OutlineInputBorder(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         5.0)),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       //? point
                      //                       Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: TextFormField(
                      //                           style: const TextStyle(
                      //                               fontSize: 14,
                      //                               color: Colors.black,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           controller: point,
                      //                           decoration: InputDecoration(
                      //                             // hintText: "example: Cahaya Sanivokasi",
                      //                             labelText: "POINT",
                      //                             border: OutlineInputBorder(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         5.0)),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: TextFormField(
                      //                           style: const TextStyle(
                      //                               fontSize: 14,
                      //                               color: Colors.black,
                      //                               fontWeight:
                      //                                   FontWeight.bold),
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           controller: keterangan,
                      //                           decoration: InputDecoration(
                      //                             // hintText: "example: Cahaya Sanivokasi",
                      //                             labelText: "KETERANGAN",
                      //                             border: OutlineInputBorder(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         5.0)),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: SizedBox(
                      //                           width: 250,
                      //                           child: CustomLoadingButton(
                      //                               controller: btnController,
                      //                               child: const Text(
                      //                                   "Simpan Data"),
                      //                               onPressed: () async {
                      //                                 if (_formKey.currentState!
                      //                                     .validate()) {
                      //                                   _formKey.currentState!
                      //                                       .save();
                      //                                   Future.delayed(
                      //                                           const Duration(
                      //                                               seconds: 2))
                      //                                       .then(
                      //                                           (value) async {
                      //                                     btnController
                      //                                         .success();
                      //                                     // Map<String, dynamic>
                      //                                     //     body = {
                      //                                     //   'lot': lot.text,
                      //                                     //   'size': size.text,
                      //                                     //   'parcel': parcel.text,
                      //                                     //   'qty': qty.text,
                      //                                     //   'caratPcs':
                      //                                     //       caratPcs.text,
                      //                                     //   'keterangan':
                      //                                     //       keterangan.text,
                      //                                     // };
                      //                                     // final response = await http.post(
                      //                                     //     Uri.parse(ApiConstants
                      //                                     //             .baseUrl +
                      //                                     //         ApiConstants
                      //                                     //             .postDataBatu),
                      //                                     //     body: body);
                      //                                     // print(response.body);
                      //                                     Future.delayed(
                      //                                             const Duration(
                      //                                                 seconds:
                      //                                                     1))
                      //                                         .then((value) {
                      //                                       btnController
                      //                                           .reset(); //reset
                      //                                       setState(() {
                      //                                         _getData();
                      //                                       });
                      //                                     });
                      //                                     Navigator.pop(
                      //                                         context);
                      //                                     showSimpleNotification(
                      //                                       const Text(
                      //                                           'Tambah Data Berhasil'),
                      //                                       background:
                      //                                           Colors.green,
                      //                                       duration:
                      //                                           const Duration(
                      //                                               seconds: 2),
                      //                                     );

                      //                                     // Navigator.push(
                      //                                     //     context,
                      //                                     //     MaterialPageRoute(
                      //                                     //         builder: (c) =>
                      //                                     //             const MainViewBatu()));
                      //                                   });
                      //                                 } else {
                      //                                   btnController.error();
                      //                                   Future.delayed(
                      //                                           const Duration(
                      //                                               seconds: 1))
                      //                                       .then((value) {
                      //                                     btnController
                      //                                         .reset(); //reset
                      //                                   });
                      //                                 }
                      //                               }),
                      //                         ),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         });
                      //   },
                      //   label: const Text(
                      //     "Tambah Data Finishing",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   hoverElevation: 50,
                      //   hoverColor: Colors.black,
                      // )