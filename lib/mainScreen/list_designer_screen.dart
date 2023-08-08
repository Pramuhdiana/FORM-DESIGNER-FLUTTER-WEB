// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/widgets/drawer_1.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';

class ListDesignerScreen extends StatefulWidget {
  const ListDesignerScreen({super.key});
  @override
  State<ListDesignerScreen> createState() => _ListDesignerScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _ListDesignerScreenState extends State<ListDesignerScreen> {
  List<dynamic> filteredData = [];
  TextEditingController controller = TextEditingController();
  bool sort = true;
  int _currentSortColumn = 0;
  List<FormDesignerModel>? filterCrm;
  List<FormDesignerModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterCrm!.sort((a, b) => a.kodeDesignMdbc!
            .toLowerCase()
            .compareTo(b.kodeDesignMdbc!.toLowerCase()));
      } else {
        filterCrm!.sort((a, b) => b.kodeDesignMdbc!
            .toLowerCase()
            .compareTo(a.kodeDesignMdbc!.toLowerCase()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<List<FormDesignerModel>> _getData() async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    // final response = await http.get(Uri.parse(
    //     '${ApiConstants.baseUrl}${ApiConstants.getListJenisBarangById}?nama=${'sandy'}'));
    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var g =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      setState(() {
        filterCrm = g;
        myCrm = g;
        print(myCrm!.length);
        isLoading = true;
      });
      return g;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: null_check_always_fails
      onWillPop: () async => null!,
      child: MaterialApp(
          home: Scaffold(
        drawer: Drawer1(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          flexibleSpace: Container(
            color: Colors.blue,
          ),
          title: const Text(
            "LIST FORM DESIGNER",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: isLoading == false
            ? const Center(child: CircularProgressIndicator())
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
                            myCrm = filterCrm!
                                .where((element) =>
                                    element.kodeDesignMdbc!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.kodeMarketing!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.kodeDesign!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.tema!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.jenisBarang!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.estimasiHarga!
                                        .toString()
                                        .contains(value.toLowerCase()))
                                .toList();

                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Expanded(
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
                                  rowsPerPage: 10,
                                  columnSpacing: 0,
                                  columns: [
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Kode MDBC",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .kodeDesignMdbc!
                                                  .toLowerCase()
                                                  .compareTo(b.kodeDesignMdbc!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .kodeDesignMdbc!
                                                  .toLowerCase()
                                                  .compareTo(a.kodeDesignMdbc!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
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
                                              filterCrm!.sort((a, b) => a
                                                  .kodeMarketing!
                                                  .toLowerCase()
                                                  .compareTo(b.kodeMarketing!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .kodeMarketing!
                                                  .toLowerCase()
                                                  .compareTo(a.kodeMarketing!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
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
                                              filterCrm!.sort((a, b) => a
                                                  .kodeDesign!
                                                  .toLowerCase()
                                                  .compareTo(b.kodeDesign!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .kodeDesign!
                                                  .toLowerCase()
                                                  .compareTo(a.kodeDesign!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Tema",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a.tema!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      b.tema!.toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b.tema!
                                                  .toLowerCase()
                                                  .compareTo(
                                                      a.tema!.toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Jenis Barang",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .jenisBarang!
                                                  .toLowerCase()
                                                  .compareTo(b.jenisBarang!
                                                      .toLowerCase()));
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .jenisBarang!
                                                  .toLowerCase()
                                                  .compareTo(a.jenisBarang!
                                                      .toLowerCase()));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                        label: const SizedBox(
                                            width: 120,
                                            child: Text(
                                              "Estimasi Harga",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        onSort: (columnIndex, _) {
                                          setState(() {
                                            _currentSortColumn = columnIndex;
                                            if (sort == true) {
                                              // myCrm.sort((a, b) => a['estimasiHarga'].)
                                              sort = false;
                                              filterCrm!.sort((a, b) => a
                                                  .estimasiHarga!
                                                  .compareTo(b.estimasiHarga!));
                                              // onsortColum(columnIndex, ascending);
                                            } else {
                                              sort = true;
                                              filterCrm!.sort((a, b) => b
                                                  .estimasiHarga!
                                                  .compareTo(a.estimasiHarga!));
                                            }
                                          });
                                        }),
                                    DataColumn(label: _verticalDivider),
                                    const DataColumn(
                                      label: SizedBox(
                                          width: 120,
                                          child: Text(
                                            "Gambar",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                      label: Container(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          width: 120,
                                          child: const Text(
                                            "Aksi",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ],
                                  source:
                                      // UserDataTableSource(userData: filterCrm!)),
                                      RowSource(
                                          myData: myCrm, count: myCrm!.length)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      )),
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
      //kodeDesignMdbc
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.kodeDesignMdbc)),
      ),
      DataCell(_verticalDivider),
      //kodemarketing
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.kodeMarketing)),
      ),
      DataCell(_verticalDivider),

      //kodeDesign
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.kodeDesign)),
      ),
      DataCell(_verticalDivider),

      //tema
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.tema)),
      ),
      DataCell(_verticalDivider),

      //jenisBarang
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.jenisBarang)),
      ),
      DataCell(_verticalDivider),

      //estimasiHarga
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.estimasiHarga.toString(),
                textAlign: TextAlign.center,
              ),
            )),
      ),
      DataCell(_verticalDivider),

      //imageUrl
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.imageUrl)),
      ),
      DataCell(_verticalDivider),

      //Aksi
      // DataCell(Builder(builder: (context) {
      //   return IconButton(
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (c) => const FormScreenById()));
      //     },
      //     icon: const Icon(
      //       Icons.remove_red_eye,
      //       color: Colors.green,
      //     ),
      //   );
      // }
      DataCell(Builder(builder: (context) {
        return Row(
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    content: Row(
                      children: [
                        const Text(
                          'Apakah anda yakin ingin menghapus data ',
                        ),
                        Text(
                          '${data.kodeDesignMdbc}  ?',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
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
                                  ApiConstants.postDeleteFormDesignerById),
                              body: body);
                          print(response.body);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const ListDesignerScreen()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => FormScreenById(
                                modelDesigner: FormDesignerModel(
                                    id: data.id,
                                    kodeDesignMdbc: data.kodeDesignMdbc,
                                    kodeMarketing: data.kodeMarketing,
                                    kodeProduksi: data.kodeProduksi,
                                    namaDesigner: data.namaDesigner,
                                    namaModeller: data.namaModeller,
                                    kodeDesign: data.kodeDesign,
                                    tema: data.tema,
                                    rantai: data.rantai,
                                    qtyRantai: data.qtyRantai,
                                    lain2: data.lain2,
                                    qtyLain2: data.qtyLain2,
                                    earnut: data.earnut,
                                    qtyEarnut: data.qtyEarnut,
                                    panjangRantai: data.panjangRantai,
                                    customKomponen: data.customKomponen,
                                    qtyCustomKomponen: data.qtyCustomKomponen,
                                    jenisBarang: data.jenisBarang,
                                    kategoriBarang: data.kategoriBarang,
                                    brand: data.brand,
                                    photoShoot: data.photoShoot,
                                    color: data.color,
                                    beratEmas: data.beratEmas,
                                    estimasiHarga: data.estimasiHarga,
                                    ringSize: data.ringSize,
                                    created_at: data.created_at,
                                    batu1: data.batu1,
                                    qtyBatu1: data.qtyBatu1,
                                    batu2: data.batu2,
                                    qtyBatu2: data.qtyBatu2,
                                    batu3: data.batu3,
                                    qtyBatu3: data.qtyBatu3,
                                    batu4: data.batu4,
                                    qtyBatu4: data.qtyBatu4,
                                    batu5: data.batu5,
                                    qtyBatu5: data.qtyBatu5,
                                    batu6: data.batu6,
                                    qtyBatu6: data.qtyBatu6,
                                    batu7: data.batu7,
                                    qtyBatu7: data.qtyBatu7,
                                    batu8: data.batu8,
                                    qtyBatu8: data.qtyBatu8,
                                    batu9: data.batu9,
                                    qtyBatu9: data.qtyBatu9,
                                    batu10: data.batu10,
                                    qtyBatu10: data.qtyBatu10,
                                    batu11: data.batu11,
                                    qtyBatu11: data.qtyBatu11,
                                    batu12: data.batu12,
                                    qtyBatu12: data.qtyBatu12,
                                    batu13: data.batu13,
                                    qtyBatu13: data.qtyBatu13,
                                    batu14: data.batu14,
                                    qtyBatu14: data.qtyBatu14,
                                    batu15: data.batu15,
                                    qtyBatu15: data.qtyBatu15,
                                    batu16: data.batu16,
                                    qtyBatu16: data.qtyBatu16,
                                    batu17: data.batu17,
                                    qtyBatu17: data.qtyBatu17,
                                    batu18: data.batu18,
                                    qtyBatu18: data.qtyBatu18,
                                    batu19: data.batu19,
                                    qtyBatu19: data.qtyBatu19,
                                    batu20: data.batu20,
                                    qtyBatu20: data.qtyBatu20,
                                    batu21: data.batu21,
                                    qtyBatu21: data.qtyBatu21,
                                    batu22: data.batu22,
                                    qtyBatu22: data.qtyBatu22,
                                    batu23: data.batu23,
                                    qtyBatu23: data.qtyBatu23,
                                    batu24: data.batu24,
                                    qtyBatu24: data.qtyBatu24,
                                    batu25: data.batu25,
                                    qtyBatu25: data.qtyBatu25,
                                    batu26: data.batu26,
                                    qtyBatu26: data.qtyBatu26,
                                    batu27: data.batu27,
                                    qtyBatu27: data.qtyBatu27,
                                    batu28: data.batu28,
                                    qtyBatu28: data.qtyBatu28,
                                    batu29: data.batu29,
                                    qtyBatu29: data.qtyBatu29,
                                    batu30: data.batu30,
                                    qtyBatu30: data.qtyBatu30,
                                    batu31: data.batu31,
                                    qtyBatu31: data.qtyBatu31,
                                    batu32: data.batu32,
                                    qtyBatu32: data.qtyBatu32,
                                    batu33: data.batu33,
                                    qtyBatu33: data.qtyBatu33,
                                    batu34: data.batu34,
                                    qtyBatu34: data.qtyBatu34,
                                    batu35: data.batu35,
                                    qtyBatu35: data.qtyBatu35,
                                    imageUrl: data.imageUrl),
                              )));
                },
                icon: const Icon(
                  Icons.remove_red_eye,
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

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    required List<FormDesignerModel> userData,
  }) : _userData = userData;
  final List<FormDesignerModel> _userData;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    // ignore: no_leading_underscores_for_local_identifiers
    final _user = _userData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${_user.kodeDesignMdbc}')),
        DataCell(Text('${_user.kodeMarketing}')),
        DataCell(Text('${_user.kodeDesign}')),
        DataCell(Text('${_user.tema}')),
        DataCell(Text('${_user.jenisBarang}')),
        DataCell(Text('${_user.estimasiHarga}')),
        DataCell(Text('${_user.imageUrl}')),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                // Text('${_user.id}');
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.green,
              ),
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  void sort<T>(
      Comparable<T> Function(FormDesignerModel d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
