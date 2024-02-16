
// //  : sharedPreferences!.getString('divisi') == 'adminnn'
// //                       //? masih on proses
// //                       ? Expanded(
// //                           child: Container(
// //                             width: double.infinity,
// //                             // width: MediaQuery.of(context).size.width,
// //                             color: Colors.amber,
// //                             padding: const EdgeInsets.all(0),
// //                             child: DataTable2(
// //                                 columnSpacing: 12,
// //                                 minWidth: 50,
// //                                 columns: [
// //                                   // no
// //                                   const DataColumn2(
// //                                     fixedWidth:
// //                                         100, // Atur lebar kolom sesuai kebutuhan
// //                                     label: Text(
// //                                       "No",
// //                                       style: TextStyle(
// //                                         fontSize: 15,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   DataColumn(label: _verticalDivider),
// //                                   // keterangan minggu
// //                                   const DataColumn2(
// //                                     fixedWidth:
// //                                         100, // Atur lebar kolom sesuai kebutuhan

// //                                     label: Text(
// //                                       "Minggu Ke -",
// //                                       style: TextStyle(
// //                                           fontSize: 15,
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //gambar
// //                                   const DataColumn2(
// //                                     fixedWidth:
// //                                         100, // Atur lebar kolom sesuai kebutuhan

// //                                     label: Text(
// //                                       "Gambar",
// //                                       style: TextStyle(
// //                                           fontSize: 15,
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   DataColumn(label: _verticalDivider),
// //                                   // kode mdbc
// //                                   DataColumn2(
// //                                       fixedWidth:
// //                                           100, // Atur lebar kolom sesuai kebutuhan

// //                                       label: Text(
// //                                         "Kode\nMDBC",
// //                                         style: TextStyle(
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       onSort: (columnIndex, _) {
// //                                         setState(() {
// //                                           _currentSortColumn = columnIndex;
// //                                           if (sort == true) {
// //                                             sort = false;
// //                                             filterDataProduksi!.sort((a, b) => a
// //                                                 .kodeDesignMdbc!
// //                                                 .toLowerCase()
// //                                                 .compareTo(b.kodeDesignMdbc!
// //                                                     .toLowerCase()));
// //                                           } else {
// //                                             sort = true;
// //                                             filterDataProduksi!.sort((a, b) => b
// //                                                 .kodeDesignMdbc!
// //                                                 .toLowerCase()
// //                                                 .compareTo(a.kodeDesignMdbc!
// //                                                     .toLowerCase()));
// //                                           }
// //                                         });
// //                                       }),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //kode marketing
// //                                   DataColumn2(
// //                                       fixedWidth:
// //                                           100, // Atur lebar kolom sesuai kebutuhan

// //                                       label: Text(
// //                                         "Kode Marketing",
// //                                         style: TextStyle(
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       onSort: (columnIndex, _) {
// //                                         setState(() {
// //                                           _currentSortColumn = columnIndex;

// //                                           if (sort == true) {
// //                                             sort = false;
// //                                             filterDataProduksi!.sort((a, b) => a
// //                                                 .kodeMarketing!
// //                                                 .toLowerCase()
// //                                                 .compareTo(b.kodeMarketing!
// //                                                     .toLowerCase()));
// //                                           } else {
// //                                             sort = true;
// //                                             filterDataProduksi!.sort((a, b) => b
// //                                                 .kodeMarketing!
// //                                                 .toLowerCase()
// //                                                 .compareTo(a.kodeMarketing!
// //                                                     .toLowerCase()));
// //                                           }
// //                                         });
// //                                       }),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //posisi
// //                                   DataColumn2(
// //                                       fixedWidth:
// //                                           100, // Atur lebar kolom sesuai kebutuhan

// //                                       label: Text(
// //                                         "Posisi",
// //                                         maxLines: 2,
// //                                         style: TextStyle(
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       onSort: (columnIndex, _) {
// //                                         setState(() {
// //                                           _currentSortColumn = columnIndex;
// //                                           if (sort == true) {
// //                                             sort = false;
// //                                             myDataProduksi!.sort((a, b) =>
// //                                                 a.posisi!.compareTo(b.posisi!));
// //                                           } else {
// //                                             sort = true;
// //                                             myDataProduksi!.sort((a, b) =>
// //                                                 b.posisi!.compareTo(a.posisi!));
// //                                           }
// //                                         });
// //                                       }),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //status batu
// //                                   DataColumn2(
// //                                       fixedWidth:
// //                                           100, // Atur lebar kolom sesuai kebutuhan

// //                                       label: Text(
// //                                         "Status Batu",
// //                                         style: TextStyle(
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       onSort: (columnIndex, _) {
// //                                         setState(() {
// //                                           _currentSortColumn = columnIndex;

// //                                           if (sort == true) {
// //                                             sort = false;
// //                                             filterDataProduksi!.sort((a, b) => a
// //                                                 .keteranganStatusBatu!
// //                                                 .toLowerCase()
// //                                                 .compareTo(b
// //                                                     .keteranganStatusBatu!
// //                                                     .toLowerCase()));
// //                                           } else {
// //                                             sort = true;
// //                                             filterDataProduksi!.sort((a, b) => b
// //                                                 .keteranganStatusBatu!
// //                                                 .toLowerCase()
// //                                                 .compareTo(a
// //                                                     .keteranganStatusBatu!
// //                                                     .toLowerCase()));
// //                                           }
// //                                         });
// //                                       }),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //status acc
// //                                   DataColumn2(
// //                                       fixedWidth:
// //                                           100, // Atur lebar kolom sesuai kebutuhan

// //                                       label: Text(
// //                                         "Status ACC",
// //                                         style: TextStyle(
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       onSort: (columnIndex, _) {
// //                                         setState(() {
// //                                           _currentSortColumn = columnIndex;

// //                                           if (sort == true) {
// //                                             sort = false;
// //                                             filterDataProduksi!.sort((a, b) => a
// //                                                 .keteranganStatusAcc!
// //                                                 .toLowerCase()
// //                                                 .compareTo(b
// //                                                     .keteranganStatusAcc!
// //                                                     .toLowerCase()));
// //                                           } else {
// //                                             sort = true;
// //                                             filterDataProduksi!.sort((a, b) => b
// //                                                 .keteranganStatusAcc!
// //                                                 .toLowerCase()
// //                                                 .compareTo(a
// //                                                     .keteranganStatusAcc!
// //                                                     .toLowerCase()));
// //                                           }
// //                                         });
// //                                       }),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //ketrangan batu
// //                                   const DataColumn2(
// //                                     fixedWidth:
// //                                         100, // Atur lebar kolom sesuai kebutuhan

// //                                     label: Text(
// //                                       "Keterangan\nBatu",
// //                                       style: TextStyle(
// //                                           fontSize: 15,
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //tema
// //                                   DataColumn2(
// //                                       fixedWidth:
// //                                           100, // Atur lebar kolom sesuai kebutuhan

// //                                       label: Text(
// //                                         "Tema",
// //                                         style: TextStyle(
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       onSort: (columnIndex, _) {
// //                                         setState(() {
// //                                           _currentSortColumn = columnIndex;
// //                                           if (sort == true) {
// //                                             sort = false;
// //                                             filterDataProduksi!.sort((a, b) =>
// //                                                 a.tema!.toLowerCase().compareTo(
// //                                                     b.tema!.toLowerCase()));
// //                                           } else {
// //                                             sort = true;
// //                                             filterDataProduksi!.sort((a, b) =>
// //                                                 b.tema!.toLowerCase().compareTo(
// //                                                     a.tema!.toLowerCase()));
// //                                           }
// //                                         });
// //                                       }),
// //                                   DataColumn(label: _verticalDivider),
// //                                   //jenis barang
// //                                   DataColumn2(
// //                                       fixedWidth:
// //                                           100, // Atur lebar kolom sesuai kebutuhan

// //                                       label: Text(
// //                                         "Jenis Barang",
// //                                         style: TextStyle(
// //                                             fontSize: 15,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       onSort: (columnIndex, _) {
// //                                         print('tap jenis barnag');
// //                                         setState(() {
// //                                           _currentSortColumn = columnIndex;
// //                                           if (sort == true) {
// //                                             sort = false;
// //                                             myDataProduksi!.sort((a, b) => a
// //                                                 .jenisBarang!
// //                                                 .toLowerCase()
// //                                                 .compareTo(b.jenisBarang!
// //                                                     .toLowerCase()));
// //                                           } else {
// //                                             sort = true;
// //                                             myDataProduksi!.sort((a, b) => b
// //                                                 .jenisBarang!
// //                                                 .toLowerCase()
// //                                                 .compareTo(a.jenisBarang!
// //                                                     .toLowerCase()));
// //                                           }
// //                                         });
// //                                       }),
// //                                   // DataColumn(label: _verticalDivider),
// //                                   // // //berat emas
// //                                   // // const DataColumn(
// //                                   // //   label: SizedBox(
// //                                   // //       child: Text(
// //                                   // //     "Berat Emas",
// //                                   // //     style: TextStyle(
// //                                   // //         fontSize: 15,
// //                                   // //         fontWeight: FontWeight.bold),
// //                                   // //   )),
// //                                   // // ),
// //                                   // // DataColumn(label: _verticalDivider),
// //                                   // // //berat diamond
// //                                   // // const DataColumn(
// //                                   // //   label: SizedBox(
// //                                   // //       child: Text(
// //                                   // //     "Berat Diamond",
// //                                   // //     style: TextStyle(
// //                                   // //         fontSize: 15,
// //                                   // //         fontWeight: FontWeight.bold),
// //                                   // //   )),
// //                                   // // ),
// //                                   // // DataColumn(label: _verticalDivider),
// //                                   // //brand
// //                                   // DataColumn2(
// //                                   //     label: const SizedBox(
// //                                   //         child: Text(
// //                                   //       "Brand",
// //                                   //       maxLines: 2,
// //                                   //       style: TextStyle(
// //                                   //           fontSize: 15,
// //                                   //           fontWeight: FontWeight.bold),
// //                                   //     )),
// //                                   //     onSort: (columnIndex, _) {
// //                                   //       setState(() {
// //                                   //         _currentSortColumn = columnIndex;
// //                                   //         if (sort == true) {
// //                                   //           // myCrm.sort((a, b) => a['estimasiHarga'].)
// //                                   //           sort = false;
// //                                   //           filterDataProduksi!.sort((a, b) =>
// //                                   //               a.brand!.compareTo(b.brand!));
// //                                   //           // onsortColum(columnIndex, ascending);
// //                                   //         } else {
// //                                   //           sort = true;
// //                                   //           filterDataProduksi!.sort((a, b) =>
// //                                   //               b.brand!.compareTo(a.brand!));
// //                                   //         }
// //                                   //       });
// //                                   //     }),
// //                                   // DataColumn(label: _verticalDivider),
// //                                   // // harga
// //                                   // const DataColumn2(
// //                                   //   label: SizedBox(
// //                                   //       child: Text(
// //                                   //     "Harga",
// //                                   //     maxLines: 2,
// //                                   //     style: TextStyle(
// //                                   //         fontSize: 15,
// //                                   //         fontWeight: FontWeight.bold),
// //                                   //   )),
// //                                   // ),
// //                                   // DataColumn(label: _verticalDivider),
// //                                   // //kelas harga
// //                                   // const DataColumn2(
// //                                   //   label: SizedBox(
// //                                   //       child: Text(
// //                                   //     "Kelas\nHarga",
// //                                   //     maxLines: 2,
// //                                   //     style: TextStyle(
// //                                   //         fontSize: 15,
// //                                   //         fontWeight: FontWeight.bold),
// //                                   //   )),
// //                                   // ),
// //                                   // DataColumn(label: _verticalDivider),
// //                                   // //tanggal in release
// //                                   // DataColumn2(
// //                                   //     label: const SizedBox(
// //                                   //         child: Text(
// //                                   //       "Tanggal In\nRelease",
// //                                   //       style: TextStyle(
// //                                   //           fontSize: 15,
// //                                   //           fontWeight: FontWeight.bold),
// //                                   //     )),
// //                                   //     onSort: (columnIndex, _) {
// //                                   //       setState(() {
// //                                   //         _currentSortColumn = columnIndex;
// //                                   //         if (sort == true) {
// //                                   //           sort = false;
// //                                   //           filterDataProduksi!.sort((a, b) => a
// //                                   //               .tanggalInProduksi!
// //                                   //               .toLowerCase()
// //                                   //               .compareTo(b.tanggalInProduksi!
// //                                   //                   .toLowerCase()));
// //                                   //         } else {
// //                                   //           sort = true;
// //                                   //           filterDataProduksi!.sort((a, b) => b
// //                                   //               .tanggalInProduksi!
// //                                   //               .toLowerCase()
// //                                   //               .compareTo(a.tanggalInProduksi!
// //                                   //                   .toLowerCase()));
// //                                   //         }
// //                                   //       });
// //                                   //     }),
// //                                 ],
// //                                 rows: List<DataRow>.generate(
// //                                     myDataProduksi!.length,
// //                                     (i) => DataRow(cells: [
// //                                           DataCell(
// //                                             Builder(builder: (context) {
// //                                               return Expanded(
// //                                                   child: Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment
// //                                                         .spaceBetween,
// //                                                 children: [
// //                                                   Text((i + 1).toString()),
// //                                                   Stack(
// //                                                     clipBehavior: Clip
// //                                                         .none, //agar tidak menghalangi object
// //                                                     children: [
// //                                                       myDataProduksi![i]
// //                                                                   .isSend
// //                                                                   .toString() !=
// //                                                               ''
// //                                                           ? const Icon(
// //                                                               Icons.verified,
// //                                                               color: Colors.red,
// //                                                             )
// //                                                           : sharedPreferences!
// //                                                                           .getString(
// //                                                                               'role') ==
// //                                                                       '1' ||
// //                                                                   sharedPreferences!
// //                                                                           .getString(
// //                                                                               'role') ==
// //                                                                       '2' ||
// //                                                                   sharedPreferences!
// //                                                                           .getString(
// //                                                                               'divisi') ==
// //                                                                       'admin'
// //                                                               ? myDataProduksi![
// //                                                                               i]
// //                                                                           .posisi
// //                                                                           .toString()
// //                                                                           .toLowerCase() ==
// //                                                                       'brj'
// //                                                                   ? const SizedBox()
// //                                                                   : IconButton(
// //                                                                       onPressed:
// //                                                                           () {
// //                                                                         showDialog<
// //                                                                             String>(
// //                                                                           barrierDismissible:
// //                                                                               false,
// //                                                                           context:
// //                                                                               context,
// //                                                                           builder: (BuildContext context) =>
// //                                                                               AlertDialog(
// //                                                                             title:
// //                                                                                 const Text(
// //                                                                               'Perhatian',
// //                                                                               textAlign: TextAlign.center,
// //                                                                               style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
// //                                                                             ),
// //                                                                             content:
// //                                                                                 Row(
// //                                                                               children: [
// //                                                                                 const Text(
// //                                                                                   'Apakah anda yakin ingin mengCANCEL - ',
// //                                                                                 ),
// //                                                                                 Text(
// //                                                                                   '${myDataProduksi![i].kodeDesignMdbc}  ?',
// //                                                                                   style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
// //                                                                                 ),
// //                                                                               ],
// //                                                                             ),
// //                                                                             actions: <Widget>[
// //                                                                               TextButton(
// //                                                                                 onPressed: () => Navigator.pop(
// //                                                                                   context,
// //                                                                                   'Batal',
// //                                                                                 ),
// //                                                                                 child: const Text('Batal'),
// //                                                                               ),
// //                                                                               TextButton(
// //                                                                                 onPressed: () async {
// //                                                                                   // await postDataMps(
// //                                                                                   //     myData,
// //                                                                                   //     i,
// //                                                                                   //     'cancel',
// //                                                                                   //     context,
// //                                                                                   //     'false');
// //                                                                                   // onRowPressed();
// //                                                                                 },
// //                                                                                 child: const Text(
// //                                                                                   'YA',
// //                                                                                   style: TextStyle(color: Colors.red),
// //                                                                                 ),
// //                                                                               ),
// //                                                                             ],
// //                                                                           ),
// //                                                                         );
// //                                                                       },
// //                                                                       icon: const Icon(
// //                                                                           Icons
// //                                                                               .cancel_schedule_send_sharp),
// //                                                                       color: Colors
// //                                                                           .red,
// //                                                                     )
// //                                                               : const SizedBox(),
// //                                                     ],
// //                                                   )
// //                                                 ],
// //                                               ));
// //                                             }),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //keterangan minggu
// //                                           DataCell(
// //                                             Builder(builder: (context) {
// //                                               return Expanded(
// //                                                   child: Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment
// //                                                         .spaceBetween,
// //                                                 children: [
// //                                                   Text(myDataProduksi![i]
// //                                                       .keteranganMinggu!),
// //                                                   Stack(
// //                                                     clipBehavior: Clip
// //                                                         .none, //agar tidak menghalangi object
// //                                                     children: [
// //                                                       //tambahan icon ADD
// //                                                       sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '1' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '2' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'admin'
// //                                                           ? Positioned(
// //                                                               right: -5.0,
// //                                                               top: -3.0,
// //                                                               child:
// //                                                                   InkResponse(
// //                                                                 onTap: () {
// //                                                                   // Navigator.of(context).pop();
// //                                                                 },
// //                                                                 child:
// //                                                                     const Icon(
// //                                                                   Icons
// //                                                                       .add_circle_outline,
// //                                                                   color: Colors
// //                                                                       .green,
// //                                                                   size: 20,
// //                                                                 ),
// //                                                               ),
// //                                                             )
// //                                                           : const SizedBox(),
// //                                                       sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '1' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '2' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'admin'
// //                                                           ? IconButton(
// //                                                               onPressed: () {
// //                                                                 showGeneralDialog(
// //                                                                     transitionDuration: const Duration(
// //                                                                         milliseconds:
// //                                                                             200),
// //                                                                     barrierDismissible:
// //                                                                         true,
// //                                                                     barrierLabel:
// //                                                                         '',
// //                                                                     context:
// //                                                                         context,
// //                                                                     pageBuilder: (context,
// //                                                                         animation1,
// //                                                                         animation2) {
// //                                                                       return const Text(
// //                                                                           '');
// //                                                                     },
// //                                                                     barrierColor: Colors
// //                                                                         .black
// //                                                                         .withOpacity(
// //                                                                             0.5),
// //                                                                     transitionBuilder:
// //                                                                         (context,
// //                                                                             a1,
// //                                                                             a2,
// //                                                                             widget) {
// //                                                                       return Transform.scale(
// //                                                                           scale: a1.value,
// //                                                                           child: Opacity(
// //                                                                               opacity: a1.value,
// //                                                                               child: AlertDialog(
// //                                                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //                                                                                   content: SizedBox(
// //                                                                                       child: SingleChildScrollView(
// //                                                                                           scrollDirection: Axis.vertical,
// //                                                                                           child: Column(children: [
// //                                                                                             const Text(
// //                                                                                               'Pilih Waktu',
// //                                                                                               style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
// //                                                                                             ),
// //                                                                                             Container(
// //                                                                                               padding: const EdgeInsets.only(top: 15),
// //                                                                                               child: ElevatedButton(
// //                                                                                                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
// //                                                                                                   onPressed: () async {
// //                                                                                                     // await postKeteranganMinggu(myDataProduksi![i].id,
// //                                                                                                     //     'WEEK 1');
// //                                                                                                     // onRowPressed();
// //                                                                                                     Navigator.pop(context);
// //                                                                                                     showSimpleNotification(
// //                                                                                                       const Text('Pemilihan Waktu Berhasil'),
// //                                                                                                       background: Colors.green,
// //                                                                                                       duration: const Duration(seconds: 1),
// //                                                                                                     );
// //                                                                                                   },
// //                                                                                                   child: const Text(
// //                                                                                                     "WEEK 1",
// //                                                                                                     style: TextStyle(
// //                                                                                                       fontSize: 16,
// //                                                                                                     ),
// //                                                                                                   )),
// //                                                                                             ),
// //                                                                                             Container(
// //                                                                                               padding: const EdgeInsets.only(top: 15),
// //                                                                                               child: ElevatedButton(
// //                                                                                                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
// //                                                                                                   onPressed: () async {
// //                                                                                                     // await postKeteranganMinggu(myDataProduksi![i].id,
// //                                                                                                     //     'WEEK 2');
// //                                                                                                     // onRowPressed();
// //                                                                                                     Navigator.pop(context);
// //                                                                                                     showSimpleNotification(
// //                                                                                                       const Text('Pemilihan Waktu Berhasil'),
// //                                                                                                       background: Colors.green,
// //                                                                                                       duration: const Duration(seconds: 1),
// //                                                                                                     );
// //                                                                                                   },
// //                                                                                                   child: const Text(
// //                                                                                                     "WEEK 2",
// //                                                                                                     style: TextStyle(
// //                                                                                                       fontSize: 16,
// //                                                                                                     ),
// //                                                                                                   )),
// //                                                                                             ),
// //                                                                                             Container(
// //                                                                                               padding: const EdgeInsets.only(top: 15),
// //                                                                                               child: ElevatedButton(
// //                                                                                                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
// //                                                                                                   onPressed: () async {
// //                                                                                                     // await postKeteranganMinggu(myDataProduksi![i].id,
// //                                                                                                     //     'WEEK 3');
// //                                                                                                     // onRowPressed();
// //                                                                                                     Navigator.pop(context);
// //                                                                                                     showSimpleNotification(
// //                                                                                                       const Text('Pemilihan Waktu Berhasil'),
// //                                                                                                       background: Colors.green,
// //                                                                                                       duration: const Duration(seconds: 1),
// //                                                                                                     );
// //                                                                                                   },
// //                                                                                                   child: const Text(
// //                                                                                                     "WEEK 3",
// //                                                                                                     style: TextStyle(
// //                                                                                                       fontSize: 16,
// //                                                                                                     ),
// //                                                                                                   )),
// //                                                                                             ),
// //                                                                                             Container(
// //                                                                                               padding: const EdgeInsets.only(top: 15),
// //                                                                                               child: ElevatedButton(
// //                                                                                                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
// //                                                                                                   onPressed: () async {
// //                                                                                                     // await postKeteranganMinggu(myDataProduksi![i].id,
// //                                                                                                     //     'WEEK 4');
// //                                                                                                     // onRowPressed();
// //                                                                                                     Navigator.pop(context);
// //                                                                                                     showSimpleNotification(
// //                                                                                                       const Text('Pemilihan Waktu Berhasil'),
// //                                                                                                       background: Colors.green,
// //                                                                                                       duration: const Duration(seconds: 1),
// //                                                                                                     );
// //                                                                                                   },
// //                                                                                                   child: const Text(
// //                                                                                                     "WEEK 4",
// //                                                                                                     style: TextStyle(
// //                                                                                                       fontSize: 16,
// //                                                                                                     ),
// //                                                                                                   )),
// //                                                                                             ),
// //                                                                                           ]))))));
// //                                                                     });
// //                                                               },
// //                                                               icon: const Icon(Icons
// //                                                                   .calendar_today_outlined),
// //                                                               color:
// //                                                                   Colors.green,
// //                                                             )
// //                                                           : const SizedBox(),
// //                                                     ],
// //                                                   )
// //                                                 ],
// //                                               ));
// //                                             }),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //gambar
// //                                           DataCell(Builder(builder: (context) {
// //                                             return Expanded(
// //                                                 child: SizedBox(
// //                                               width: 100,
// //                                               height: 140,
// //                                               child: InkWell(
// //                                                 onTap: () {
// //                                                   Navigator.push(
// //                                                       context,
// //                                                       MaterialPageRoute(
// //                                                           builder: (c) =>
// //                                                               ViewPhotoMpsScreen(
// //                                                                 modelMps: ListMpsModel(
// //                                                                     kodeDesignMdbc:
// //                                                                         myDataProduksi![i]
// //                                                                             .kodeDesignMdbc,
// //                                                                     imageUrl:
// //                                                                         myDataProduksi![i]
// //                                                                             .imageUrl),
// //                                                               )));
// //                                                 },
// //                                                 child: Image.network(
// //                                                   ApiConstants.baseUrlImage +
// //                                                       myDataProduksi![i]
// //                                                           .imageUrl!,
// //                                                   fit: BoxFit.cover,
// //                                                 ),
// //                                               ),
// //                                             ));
// //                                           })),

// //                                           DataCell(_verticalDivider),
// //                                           //kode mdbc
// //                                           DataCell(
// //                                             Builder(builder: (context) {
// //                                               return Expanded(
// //                                                   child: Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment
// //                                                         .spaceAround,
// //                                                 children: [
// //                                                   Text(myDataProduksi![i]
// //                                                       .kodeDesignMdbc!),
// //                                                 ],
// //                                               ));
// //                                             }),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //kode marketing
// //                                           DataCell(
// //                                             Builder(builder: (context) {
// //                                               return Expanded(
// //                                                   child: Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment
// //                                                         .spaceBetween,
// //                                                 children: [
// //                                                   Text(myDataProduksi![i]
// //                                                       .kodeMarketing!),
// //                                                 ],
// //                                               ));
// //                                             }),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //posisi
// //                                           DataCell(Builder(builder: (context) {
// //                                             // String? posisi = '';
// //                                             return Expanded(
// //                                               child: Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment.start,
// //                                                 children: [
// //                                                   Padding(
// //                                                     padding:
// //                                                         const EdgeInsets.only(
// //                                                             top: 0),
// //                                                     child: Column(
// //                                                       children: [
// //                                                         Text(
// //                                                             '${myDataProduksi![i].posisi}'),
// //                                                         myDataProduksi![i]
// //                                                                         .posisi
// //                                                                         .toString()
// //                                                                         .toLowerCase() ==
// //                                                                     'brj' ||
// //                                                                 myDataProduksi![
// //                                                                             i]
// //                                                                         .posisi
// //                                                                         .toString()
// //                                                                         .toLowerCase() ==
// //                                                                     'out pasang batu'
// //                                                             ? const SizedBox()
// //                                                             : Text(
// //                                                                 '${myDataProduksi![i].artist}'),
// //                                                       ],
// //                                                     ),
// //                                                   ),
// //                                                   const SizedBox()
// //                                                 ],
// //                                               ),
// //                                             );
// //                                           })),
// //                                           DataCell(_verticalDivider),
// //                                           //status batu
// //                                           DataCell(
// //                                             Builder(builder: (context) {
// //                                               return Expanded(
// //                                                   child: Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment
// //                                                         .spaceBetween,
// //                                                 children: [
// //                                                   Text(myDataProduksi![i]
// //                                                       .keteranganStatusBatu!),
// //                                                   Stack(
// //                                                     clipBehavior: Clip
// //                                                         .none, //agar tidak menghalangi object
// //                                                     children: [
// //                                                       //tambahan icon ADD
// //                                                       sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '1' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '2' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'admin' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'scm'
// //                                                           ? Positioned(
// //                                                               right: -5.0,
// //                                                               top: -3.0,
// //                                                               child:
// //                                                                   InkResponse(
// //                                                                 onTap: () {
// //                                                                   // Navigator.of(context).pop();
// //                                                                 },
// //                                                                 child:
// //                                                                     const Icon(
// //                                                                   Icons
// //                                                                       .add_circle_outline,
// //                                                                   color: Colors
// //                                                                       .green,
// //                                                                   size: 20,
// //                                                                 ),
// //                                                               ),
// //                                                             )
// //                                                           : const SizedBox(),
// //                                                       sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '1' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '2' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'admin' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'scm'
// //                                                           ? IconButton(
// //                                                               onPressed: () {},
// //                                                               icon: const Icon(Icons
// //                                                                   .chat_bubble_outline_rounded),
// //                                                               color:
// //                                                                   Colors.green,
// //                                                             )
// //                                                           : const SizedBox(),
// //                                                     ],
// //                                                   )
// //                                                 ],
// //                                               ));
// //                                             }),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //status acc
// //                                           DataCell(
// //                                             Builder(builder: (context) {
// //                                               return Expanded(
// //                                                   child: Row(
// //                                                 mainAxisAlignment:
// //                                                     MainAxisAlignment
// //                                                         .spaceBetween,
// //                                                 children: [
// //                                                   Text(myDataProduksi![i]
// //                                                       .keteranganStatusAcc!),
// //                                                   Stack(
// //                                                     clipBehavior: Clip
// //                                                         .none, //agar tidak menghalangi object
// //                                                     children: [
// //                                                       //tambahan icon ADD
// //                                                       sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '1' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '2' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'admin'
// //                                                           ? Positioned(
// //                                                               right: -5.0,
// //                                                               top: -3.0,
// //                                                               child:
// //                                                                   InkResponse(
// //                                                                 onTap: () {
// //                                                                   // Navigator.of(context).pop();
// //                                                                 },
// //                                                                 child:
// //                                                                     const Icon(
// //                                                                   Icons
// //                                                                       .add_circle_outline,
// //                                                                   color: Colors
// //                                                                       .green,
// //                                                                   size: 20,
// //                                                                 ),
// //                                                               ),
// //                                                             )
// //                                                           : const SizedBox(),
// //                                                       sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '1' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'role') ==
// //                                                                   '2' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'scm' ||
// //                                                               sharedPreferences!
// //                                                                       .getString(
// //                                                                           'divisi') ==
// //                                                                   'admin'
// //                                                           ? IconButton(
// //                                                               onPressed: () {},
// //                                                               icon: const Icon(Icons
// //                                                                   .toll_outlined),
// //                                                               color:
// //                                                                   Colors.green,
// //                                                             )
// //                                                           : const SizedBox()
// //                                                     ],
// //                                                   )
// //                                                 ],
// //                                               ));
// //                                             }),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //keterangan batu
// //                                           DataCell(
// //                                             Expanded(
// //                                                 child: Text(myDataProduksi![i]
// //                                                     .keteranganBatu!)),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //tema
// //                                           DataCell(
// //                                             Expanded(
// //                                                 child: Text(
// //                                                     myDataProduksi![i].tema!)),
// //                                           ),
// //                                           DataCell(_verticalDivider),
// //                                           //jenisBarang
// //                                           DataCell(
// //                                             Expanded(
// //                                                 child: Text(myDataProduksi![i]
// //                                                     .jenisBarang!)),
// //                                           ),
// //                                           // DataCell(_verticalDivider),
// //                                           // //brand
// //                                           // DataCell(
// //                                           //   Padding(
// //                                           //       padding: const EdgeInsets.all(0),
// //                                           //       child: Text(
// //                                           //           myDataProduksi![i].brand!)),
// //                                           // ),
// //                                           // sharedPreferences!.getString('role') ==
// //                                           //             '1' ||
// //                                           //         sharedPreferences!
// //                                           //                 .getString('role') ==
// //                                           //             '2' ||
// //                                           //         sharedPreferences!
// //                                           //                 .getString('divisi') ==
// //                                           //             'admin'
// //                                           //     ? DataCell(_verticalDivider)
// //                                           //     : const DataCell(SizedBox()),
// //                                           // //harga
// //                                           // sharedPreferences!.getString('role') ==
// //                                           //             '1' ||
// //                                           //         sharedPreferences!
// //                                           //                 .getString('role') ==
// //                                           //             '2' ||
// //                                           //         sharedPreferences!
// //                                           //                 .getString('divisi') ==
// //                                           //             'admin'
// //                                           //     ? DataCell(
// //                                           //         Container(
// //                                           //             padding:
// //                                           //                 const EdgeInsets.all(0),
// //                                           //             child: myDataProduksi![i]
// //                                           //                         .brand
// //                                           //                         .toString()
// //                                           //                         .toLowerCase() ==
// //                                           //                     'parva'
// //                                           //                 ? Text(
// //                                           //                     CurrencyFormat.convertToIdr(
// //                                           //                         ((myDataProduksi![i]
// //                                           //                                     .estimasiHarga! *
// //                                           //                                 0.37) *
// //                                           //                             11500),
// //                                           //                         0),
// //                                           //                     maxLines: 2,
// //                                           //                   )
// //                                           //                 : Text(
// //                                           //                     CurrencyFormat.convertToIdr(
// //                                           //                         ((myDataProduksi![
// //                                           //                                 i]
// //                                           //                             .estimasiHarga!)),
// //                                           //                         0),
// //                                           //                     maxLines: 2,
// //                                           //                   )),
// //                                           //       )
// //                                           //     : const DataCell(SizedBox()),
// //                                           // sharedPreferences!.getString('role') ==
// //                                           //             '1' ||
// //                                           //         sharedPreferences!
// //                                           //                 .getString('role') ==
// //                                           //             '2' ||
// //                                           //         sharedPreferences!
// //                                           //                 .getString('divisi') ==
// //                                           //             'admin'
// //                                           //     ? DataCell(_verticalDivider)
// //                                           //     : const DataCell(SizedBox()),
// //                                           // //kelas harga
// //                                           // DataCell(
// //                                           //   Container(
// //                                           //       padding: const EdgeInsets.all(0),
// //                                           //       child: ((myDataProduksi![i]
// //                                           //                           .estimasiHarga! *
// //                                           //                       0.37) *
// //                                           //                   11500) <=
// //                                           //               5000000
// //                                           //           ? const Text(
// //                                           //               "XS",
// //                                           //               maxLines: 2,
// //                                           //             )
// //                                           //           : ((myDataProduksi![i]
// //                                           //                               .estimasiHarga! *
// //                                           //                           0.37) *
// //                                           //                       11500) <=
// //                                           //                   10000000
// //                                           //               ? const Text(
// //                                           //                   "S",
// //                                           //                   maxLines: 2,
// //                                           //                 )
// //                                           //               : ((myDataProduksi![i]
// //                                           //                                   .estimasiHarga! *
// //                                           //                               0.37) *
// //                                           //                           11500) <=
// //                                           //                       20000000
// //                                           //                   ? const Text(
// //                                           //                       "M",
// //                                           //                       maxLines: 2,
// //                                           //                     )
// //                                           //                   : ((myDataProduksi![i]
// //                                           //                                       .estimasiHarga! *
// //                                           //                                   0.37) *
// //                                           //                               11500) <=
// //                                           //                           35000000
// //                                           //                       ? const Text(
// //                                           //                           "L",
// //                                           //                           maxLines: 2,
// //                                           //                         )
// //                                           //                       : const Text(
// //                                           //                           "XL",
// //                                           //                           maxLines: 2,
// //                                           //                         )),
// //                                           // ),
// //                                           // DataCell(_verticalDivider),
// //                                           // //tanggal in produksi
// //                                           // DataCell(
// //                                           //   Padding(
// //                                           //       padding: const EdgeInsets.all(0),
// //                                           //       child: Text(myDataProduksi![i]
// //                                           //           .tanggalInProduksi!)),
// //                                           // ),
// //                                         ]))),
// //                           ),
// //                         )
                     











//                        ListView(children: [
//             Container(
//               padding: const EdgeInsets.all(15),
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: Theme(
//                 data: ThemeData().copyWith(
//                     // cardColor: Theme.of(context).canvasColor),
//                     cardColor: Colors.white,
//                     hoverColor: Colors.grey.shade400,
//                     dividerColor: Colors.grey),
//                 child: PaginatedDataTable(
//                     showCheckboxColumn: false,
//                     availableRowsPerPage: const [10, 50, 100],
//                     rowsPerPage: _rowsPerPage,
//                     dataRowMaxHeight: 150,
//                     onRowsPerPageChanged: (value) {
//                       setState(() {
//                         isLoading == true;
//                       });
//                       _rowsPerPage = value!;
//                       setState(() {
//                         isLoading == false;
//                       });
//                     },
//                     sortColumnIndex: _currentSortColumn,
//                     sortAscending: sort,
//                     // rowsPerPage: 25,
//                     columnSpacing: 0,
//                     columns: sharedPreferences!.getString('divisi') ==
//                                 'produksi' ||
//                             sharedPreferences!.getString('divisi') == 'admin'
//                         ? [
//                             // no
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "No",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             // keterangan minggu
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Minggu Ke -",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //gambar
//                             DataColumn(
//                               label: Container(
//                                   padding: const EdgeInsets.only(left: 30),
//                                   child: const Text(
//                                     "Gambar",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold),
//                                   )),
//                             ),
//                             DataColumn(label: _verticalDivider),

//                             // kode mdbc
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Kode\nMDBC",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .kodeDesignMdbc!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               b.kodeDesignMdbc!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .kodeDesignMdbc!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               a.kodeDesignMdbc!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //kode marketing
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Kode Marketing",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;

//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .kodeMarketing!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               b.kodeMarketing!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .kodeMarketing!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               a.kodeMarketing!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //posisi
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Posisi",
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       myDataProduksi!.sort((a, b) =>
//                                           a.posisi!.compareTo(b.posisi!));
//                                     } else {
//                                       sort = true;
//                                       myDataProduksi!.sort((a, b) =>
//                                           b.posisi!.compareTo(a.posisi!));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),

//                             //status batu
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Status Batu",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;

//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .keteranganStatusBatu!
//                                           .toLowerCase()
//                                           .compareTo(b.keteranganStatusBatu!
//                                               .toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .keteranganStatusBatu!
//                                           .toLowerCase()
//                                           .compareTo(a.keteranganStatusBatu!
//                                               .toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //status acc
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Status ACC",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;

//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .keteranganStatusAcc!
//                                           .toLowerCase()
//                                           .compareTo(b.keteranganStatusAcc!
//                                               .toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .keteranganStatusAcc!
//                                           .toLowerCase()
//                                           .compareTo(a.keteranganStatusAcc!
//                                               .toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //ketrangan batu
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Keterangan\nBatu",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                               // onSort: (columnIndex, _) {
//                               //   setState(() {
//                               //     _currentSortColumn = columnIndex;

//                               //     if (sort == true) {
//                               //       sort = false;
//                               //       filterDataProduksi!.sort((a, b) => a
//                               //           .keteranganStatusBatu!
//                               //           .toLowerCase()
//                               //           .compareTo(b
//                               //               .keteranganStatusBatu!
//                               //               .toLowerCase()));
//                               //     } else {
//                               //       sort = true;
//                               //       filterDataProduksi!.sort((a, b) => b
//                               //           .keteranganStatusBatu!
//                               //           .toLowerCase()
//                               //           .compareTo(a
//                               //               .keteranganStatusBatu!
//                               //               .toLowerCase()));
//                               //     }
//                               //   });
//                               // }
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //tema
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Tema",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a.tema!
//                                           .toLowerCase()
//                                           .compareTo(b.tema!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b.tema!
//                                           .toLowerCase()
//                                           .compareTo(a.tema!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //jenis barang
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Jenis Barang",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   print('tap jenis barnag');
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       myDataProduksi!.sort((a, b) => a
//                                           .jenisBarang!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               b.jenisBarang!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       myDataProduksi!.sort((a, b) => b
//                                           .jenisBarang!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               a.jenisBarang!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //brand
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Brand",
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       // myCrm.sort((a, b) => a['estimasiHarga'].)
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) =>
//                                           a.brand!.compareTo(b.brand!));
//                                       // onsortColum(columnIndex, ascending);
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) =>
//                                           b.brand!.compareTo(a.brand!));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             // harga
//                             sharedPreferences!.getString('role') == '1' ||
//                                     sharedPreferences!.getString('role') ==
//                                         '2' ||
//                                     sharedPreferences!.getString('divisi') ==
//                                         'admin'
//                                 ? const DataColumn(
//                                     label: SizedBox(
//                                         child: Text(
//                                       "Harga",
//                                       maxLines: 2,
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     )),
//                                   )
//                                 : const DataColumn(label: SizedBox()),
//                             DataColumn(label: _verticalDivider),
//                             //kelas harga
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Kelas\nHarga",
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       // myCrm.sort((a, b) => a['estimasiHarga'].)
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .estimasiHarga!
//                                           .compareTo(b.estimasiHarga!));
//                                       // onsortColum(columnIndex, ascending);
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .estimasiHarga!
//                                           .compareTo(a.estimasiHarga!));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //tanggal in produksi
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Tanggal In\nRelease",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .tanggalInProduksi!
//                                           .toLowerCase()
//                                           .compareTo(b.tanggalInProduksi!
//                                               .toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .tanggalInProduksi!
//                                           .toLowerCase()
//                                           .compareTo(a.tanggalInProduksi!
//                                               .toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                           ]
//                         : [
//                             // no
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "No",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             // keterangan minggu
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Minggu Ke -",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //gambar
//                             DataColumn(
//                               label: Container(
//                                   padding: const EdgeInsets.only(left: 30),
//                                   child: const Text(
//                                     "Gambar",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold),
//                                   )),
//                             ),
//                             DataColumn(label: _verticalDivider),

//                             // kode mdbc
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Kode\nMDBC",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .kodeDesignMdbc!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               b.kodeDesignMdbc!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .kodeDesignMdbc!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               a.kodeDesignMdbc!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //kode marketing
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Kode Marketing",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;

//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .kodeMarketing!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               b.kodeMarketing!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .kodeMarketing!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               a.kodeMarketing!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //posisi
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Posisi",
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       myDataProduksi!.sort((a, b) =>
//                                           a.posisi!.compareTo(b.posisi!));
//                                     } else {
//                                       sort = true;
//                                       myDataProduksi!.sort((a, b) =>
//                                           b.posisi!.compareTo(a.posisi!));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),

//                             //status batu
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Status Batu",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;

//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .keteranganStatusBatu!
//                                           .toLowerCase()
//                                           .compareTo(b.keteranganStatusBatu!
//                                               .toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .keteranganStatusBatu!
//                                           .toLowerCase()
//                                           .compareTo(a.keteranganStatusBatu!
//                                               .toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //status acc
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Status ACC",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;

//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .keteranganStatusAcc!
//                                           .toLowerCase()
//                                           .compareTo(b.keteranganStatusAcc!
//                                               .toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .keteranganStatusAcc!
//                                           .toLowerCase()
//                                           .compareTo(a.keteranganStatusAcc!
//                                               .toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //ketrangan batu
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Keterangan\nBatu",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //tema
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Tema",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a.tema!
//                                           .toLowerCase()
//                                           .compareTo(b.tema!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b.tema!
//                                           .toLowerCase()
//                                           .compareTo(a.tema!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //jenis barang
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Jenis Barang",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   print('tap jenis barnag');
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       myDataProduksi!.sort((a, b) => a
//                                           .jenisBarang!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               b.jenisBarang!.toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       myDataProduksi!.sort((a, b) => b
//                                           .jenisBarang!
//                                           .toLowerCase()
//                                           .compareTo(
//                                               a.jenisBarang!.toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //berat emas
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Berat Emas",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //berat diamond
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Berat Diamond",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //brand
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Brand",
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       // myCrm.sort((a, b) => a['estimasiHarga'].)
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) =>
//                                           a.brand!.compareTo(b.brand!));
//                                       // onsortColum(columnIndex, ascending);
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) =>
//                                           b.brand!.compareTo(a.brand!));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             // harga
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Harga",
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //kelas harga
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Kelas\nHarga",
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             DataColumn(label: _verticalDivider),
//                             //tanggal in release
//                             DataColumn(
//                                 label: const SizedBox(
//                                     child: Text(
//                                   "Tanggal In\nRelease",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                                 onSort: (columnIndex, _) {
//                                   setState(() {
//                                     _currentSortColumn = columnIndex;
//                                     if (sort == true) {
//                                       sort = false;
//                                       filterDataProduksi!.sort((a, b) => a
//                                           .tanggalInProduksi!
//                                           .toLowerCase()
//                                           .compareTo(b.tanggalInProduksi!
//                                               .toLowerCase()));
//                                     } else {
//                                       sort = true;
//                                       filterDataProduksi!.sort((a, b) => b
//                                           .tanggalInProduksi!
//                                           .toLowerCase()
//                                           .compareTo(a.tanggalInProduksi!
//                                               .toLowerCase()));
//                                     }
//                                   });
//                                 }),
//                             DataColumn(label: _verticalDivider),
//                             //tanggal in release
//                             const DataColumn(
//                               label: SizedBox(
//                                   child: Text(
//                                 "Tanggal In\nModeller",
//                                 style: TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                           ],
//                     source: sharedPreferences!.getString('divisi') ==
//                                 'produksi' ||
//                             sharedPreferences!.getString('divisi') == 'admin'
//                         ? RowSourceProduksi(
//                             onRowPressed: () {
//                               refresh();
//                             }, //! mengirim data untuk me refresh state
//                             listBulan: listBulan,
//                             listArtist: listArtist,
//                             listDivisi: listDivisi,
//                             myData: myDataProduksi,
//                             count: myDataProduksi!.length,
//                             listSubDivisiArtistFinishing:
//                                 listSubDivisiArtistFinishing,
//                             listSubDivisiArtistPolishing:
//                                 listSubDivisiArtistPolishing,
//                             listSubDivisiArtistStell: listSubDivisiArtistStell,
//                             listSubDivisiArtistPasangBatu:
//                                 listSubDivisiArtistPasangBatu,
//                             siklus: siklusDesigner)
//                         : RowSourceScm(
//                             onRowPressed: () {
//                               refresh();
//                             }, //! mengirim data untuk me refresh state
//                             listArtist: listArtist,
//                             listDivisi: listDivisi,
//                             myData: myDataProduksi,
//                             count: myDataProduksi!.length,
//                             listSubDivisiArtistFinishing:
//                                 listSubDivisiArtistFinishing,
//                             listSubDivisiArtistPolishing:
//                                 listSubDivisiArtistPolishing,
//                             listSubDivisiArtistStell: listSubDivisiArtistStell,
//                             listSubDivisiArtistPasangBatu:
//                                 listSubDivisiArtistPasangBatu,
//                             siklus: siklusDesigner)),
//               ),
//             ),
//           ]),