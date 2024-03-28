// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/produksi/modelProduksi/produksi2024_model.dart';
import 'package:http/http.dart' as http;
import 'package:data_table_2/data_table_2.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class NewFinishingScreen extends StatefulWidget {
  var divisi = '';
  NewFinishingScreen({super.key, required this.divisi});
  @override
  State<NewFinishingScreen> createState() => _NewFinishingScreenState();
}

class _NewFinishingScreenState extends State<NewFinishingScreen> {
  int _rowsPerPage = 10; // Rows per page
  int _currentPageIndex = 0;
  bool isLoading = false;
  String chooseBulan = '';
  TextEditingController search = TextEditingController();
  List<ProduksiModel2024>? _listFinishing;
  List<ProduksiModel2024>? _filterListFinishing;
  List<String>? namaArtist;
  List<bool> selectedList = []; // List untuk menyimpan status pilihan
  List<String> selectedNama = [];

  @override
  void initState() {
    super.initState();
    // var now = DateTime.now();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    chooseBulan = month;
    loadData();
  }

  //*HINTS filter berdasarkan list<String> nama
  void filterByName() async {
    _listFinishing = _filterListFinishing!
        .where((element) =>
            selectedNama.any((listNama) => element.nama == listNama))
        .toList();

    setState(() {});
  }

  //*HINTS filter berdasarkan inputan
  void searchAnything(String value) {
    _listFinishing = _filterListFinishing!
        .where((element) =>
            element.nama!.toLowerCase().contains(value.toLowerCase()) ||
            element.kodeProduksi!.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  //*HINTS reset filter
  void resetFilter() {
    _listFinishing =
        List.of(_filterListFinishing!); // Mengembalikan ke semua data
  }

  void showCheckboxPopup(BuildContext context) {
    // Daftar item yang akan ditampilkan di popup
    List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

    // Daftar nilai yang dipilih, awalnya kosong
    List<bool> selectedValues = List.filled(items.length, false);

    // Tampilkan popup
    showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const Text('');
      },
      barrierColor: Colors.black.withOpacity(0.75),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  content: SizedBox(
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // List of checkboxes and names
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: namaArtist!.length,
                          itemBuilder: (context, index) {
                            // Membuat selectedList dengan panjang yang sesuai
                            return CheckboxListTile(
                              title: Text(namaArtist![index]),
                              value: selectedList[index],
                              onChanged: (isSelected) {
                                setState(() {
                                  selectedList[index] = isSelected ?? false;
                                });
                              },
                            );
                          },
                        ),
                        // Display button to submit selected items
                        ElevatedButton(
                          onPressed: () {
                            // Print selected items
                            selectedNama = [];
                            for (int i = 0; i < selectedList.length; i++) {
                              if (selectedList[i]) {
                                selectedNama.add(namaArtist![i]);
                              }
                            }
                            print('Selected Nama: $selectedNama');
                            if (selectedNama.isNotEmpty) {
                              filterByName();
                            }
                            Navigator.pop(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons
                                  .done_outline), // Menambahkan ikon Download
                              SizedBox(
                                  width:
                                      8), // Menambahkan jarak antara ikon dan teks
                              Text('Ok'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });
    await _getData();
    setState(() {
      isLoading = false;
    });
  }

  Future<List<ProduksiModel2024>> _getData() async {
    namaArtist = [];
    Map<String, String> body = {
      'Location': widget.divisi,
      'strindate': '2024-01-01',
      'stroutdate': '2024-01-30',
    };
    try {
      final response = await http
          .post(Uri.parse(ApiConstants.baseUrlDummySusut), body: body);
      print(response.body);
      // if response successful
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var allData;
        allData = jsonResponse
            .map((data) => ProduksiModel2024.fromJson(data))
            .toList();
        for (var data in allData) {
          namaArtist!.add(data.nama);
        }
        //* HINTS menghapus list duplikat
        namaArtist = namaArtist!.toSet().toList();
        selectedList = List.generate(namaArtist!.length, (index) => false);
        _listFinishing = allData;
        _filterListFinishing = allData;

        // var filterByDivisiBulan = g.where((element) =>
        //     element.divisi.toString().toLowerCase() == 'poleshing 1' &&
        //     element.bulan.toString().toLowerCase() == 'oktober');
        _filterListFinishing = allData;
        _listFinishing = allData;

        setState(() {});

        return allData;
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(
            context: context,
            dialogType: DialogType.error,
            title: 'ERROR get data MDBC',
            description: response.body,
            dissmiss: false);
        return throw Exception();
      }
    } catch (c) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'ERROR get data MDBC',
          description: '$c',
          dissmiss: false);
      return throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Atur ketinggian AppBar di sini
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        leadingWidth: 200,
        leading: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: 150,
                  child: DropdownSearch<String>(
                    items: namaBulan,
                    onChanged: (item) {
                      chooseBulan = item!;
                    },
                    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                      showSelectedItems: true,
                      showSearchBox: true,
                    ),
                    selectedItem: chooseBulan,
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      textAlign: TextAlign.center,
                      baseStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      dropdownSearchDecoration: InputDecoration(
                          labelText: "Pilih Bulan",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ),
                )),
            IconButton(
              onPressed: () {
                showCustomDialog(
                    context: context,
                    dialogType: DialogType.info,
                    title: 'INFO',
                    description:
                        'Data berdasarkan tanggal cut of yang berarti dari tanggal 1 s/d 21');
              },
              icon: const Icon(
                color: Colors.black,
                Icons.info,
                // size: 40.0,
              ),
            ),
          ],
        ),

        title: CupertinoSearchTextField(
          placeholder: 'Search Anything...',
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          itemColor: Colors.black,
          controller: search,
          backgroundColor: Colors.black12,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (value.isEmpty) {
              resetFilter(); // Jika tidak ada pencarian, reset filter
            } else {
              searchAnything(value); // Jika ada pencarian, lakukan pencarian
            }
            setState(() {});
          },
        ),
      ),
      body: isLoading == true
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(0),
                width: 90,
                height: 90,
                child: Lottie.asset("loadingJSON/loadingV1.json"),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: PaginatedDataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    rowsPerPage: _rowsPerPage,
                    availableRowsPerPage: const [5, 10, 50, 100],
                    minWidth: 600,
                    onRowsPerPageChanged: (value) {
                      setState(() {
                        isLoading == true;
                      });
                      _rowsPerPage = value!;
                      setState(() {
                        isLoading == false;
                      });
                    },
                    columns: [
                      DataColumn2(
                        label: Row(
                          children: [
                            const Text('NAMA'),
                            IconButton(
                              onPressed: () {
                                showCheckboxPopup(context);
                              },
                              icon: selectedNama.isEmpty
                                  ? const Icon(
                                      Icons.filter_alt_outlined,
                                      size: 24.0,
                                    )
                                  : const Icon(
                                      Icons.filter_alt_sharp,
                                      size: 24.0,
                                    ),
                            ),
                          ],
                        ),
                        size: ColumnSize.L,
                      ),
                      const DataColumn(
                        label: Text('TANGGAL IN'),
                      ),
                      const DataColumn(
                        label: Text('TANGGAL OUT'),
                      ),
                      const DataColumn(
                        label: Text('KODE PRODUKSI'),
                      ),
                      const DataColumn(
                        label: Text('DEBET'),
                        numeric: true,
                      ),
                      const DataColumn(
                        label: Text('KREDIT'),
                        numeric: true,
                      ),
                      const DataColumn(
                        label: Text('JATAH SUSUT'),
                        numeric: true,
                      ),
                      const DataColumn(
                        label: Text('SUSUT BARANG'),
                        numeric: true,
                      ),
                      const DataColumn(
                        label: Text('KETERANGAN'),
                      ),
                    ],
                    source: MyPaginatedDataTable2Source(
                      rowCount: _listFinishing!.length,
                      rowsPerPage: _rowsPerPage,
                      currentPageIndex: _currentPageIndex,
                      listFinishing: _listFinishing,
                    ),
                    onPageChanged: (pageIndex) {
                      setState(() {
                        _currentPageIndex = pageIndex;
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class MyPaginatedDataTable2Source extends DataTableSource {
  var listFinishing;
  @override
  final int rowCount;
  final int rowsPerPage;
  final int currentPageIndex;

  MyPaginatedDataTable2Source({
    required this.listFinishing,
    required this.rowCount,
    required this.rowsPerPage,
    required this.currentPageIndex,
  });

  @override
  DataRow getRow(int index) {
    var data = listFinishing[index];
    String susutPerBarang = (data.debet - data.kredit).toStringAsFixed(3);
    return DataRow(cells: [
      DataCell(Text(data.nama)),
      DataCell(Text(data.tanggalIn)),
      DataCell(Text(data.tanggalOut)),
      DataCell(Text(data.kodeProduksi)),
      DataCell(Text(data.debet.toString())),
      DataCell(Text(data.kredit.toString())),
      DataCell(
          Text('jatah susut ${(currentPageIndex * rowsPerPage) + index + 5}')),
      DataCell(Text(susutPerBarang)),
      DataCell(
          Text('keterangan ${(currentPageIndex * rowsPerPage) + index + 5}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
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