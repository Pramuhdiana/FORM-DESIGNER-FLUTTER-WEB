// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/produksi/modelProduksi/produksi2024_model.dart';
import 'package:http/http.dart' as http;
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewFinishingScreen extends StatefulWidget {
  var input = '';
  NewFinishingScreen({super.key, required this.input});
  @override
  State<NewFinishingScreen> createState() => _NewFinishingScreenState();
}

class _NewFinishingScreenState extends State<NewFinishingScreen> {
  final int _rowCount = 100; // Total number of rows
  int _rowsPerPage = 10; // Rows per page
  int _currentPageIndex = 0;
  bool isLoading = false;
  String chooseBulan = '';
  TextEditingController search = TextEditingController();
  List<ProduksiModel2024>? _listFinishing;
  List<ProduksiModel2024>? _filterListFinishing;

  @override
  void initState() {
    super.initState();
    // var now = DateTime.now();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    chooseBulan = month;
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                size: 40.0,
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
            setState(() {});
          },
        ),
      ),
      body: Column(
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
              columns: const [
                DataColumn2(
                  label: Text('NAMA'),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('TANGGAL IN'),
                ),
                DataColumn(
                  label: Text('TANGGAL OUT'),
                ),
                DataColumn(
                  label: Text('KODE PRODUKSI'),
                ),
                DataColumn(
                  label: Text('DEBET'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('KREDIT'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('JATAH SUSUT'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('SUSUT BARANG'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('KETERANGAN'),
                ),
              ],
              source: MyPaginatedDataTable2Source(
                rowCount: _rowCount,
                rowsPerPage: _rowsPerPage,
                currentPageIndex: _currentPageIndex,
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
  final int rowCount;
  final int rowsPerPage;
  final int currentPageIndex;

  MyPaginatedDataTable2Source({
    required this.rowCount,
    required this.rowsPerPage,
    required this.currentPageIndex,
  });

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('nama ${(currentPageIndex * rowsPerPage) + index + 1}')),
      DataCell(
          Text('tanggal i ${(currentPageIndex * rowsPerPage) + index + 2}')),
      DataCell(
          Text('tanggal o ${(currentPageIndex * rowsPerPage) + index + 3}')),
      DataCell(Text(
          'kode produksi ${(currentPageIndex * rowsPerPage) + index + 4}')),
      DataCell(Text('debet ${(currentPageIndex * rowsPerPage) + index + 5}')),
      DataCell(Text('kredit ${(currentPageIndex * rowsPerPage) + index + 5}')),
      DataCell(
          Text('jatah susut ${(currentPageIndex * rowsPerPage) + index + 5}')),
      DataCell(
          Text('susut barang ${(currentPageIndex * rowsPerPage) + index + 5}')),
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