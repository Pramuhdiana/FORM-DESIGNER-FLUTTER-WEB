// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/form_view_screen.dart';
import 'package:form_designer/mainScreen/view_photo_mps.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/model/jenis_barang_model.dart';
import 'package:form_designer/model/list_mps_model.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RowSourceProduksi extends DataTableSource {
  @override
  final int rowCount;
  final int rowsPerPage;
  final int currentPageIndex;
  List<FormDesignerModel>? dataView;
  var getValueBulanDesigner;
  var getIdDataModeller;
  var getNoUrutDataModeller;
  var getNowSiklus;
  var getKodeBulan;
  var listDataMps;
  var siklus;
  final VoidCallback onRowPressed; //* menerima data untuk me refresh screen
  var listArtist;
  var listDivisi;
  var listSubDivisiArtistFinishing;
  var listSubDivisiArtistPolishing;
  var listSubDivisiArtistStell;
  var listSubDivisiArtistPasangBatu;
  List<String> listBulan;
  List<String> listSwitchBulan = [
    'CANCEL',
    'JANUARI',
    'FEBRUARI',
    'MARET',
    'APRIL',
    'MEI',
    'JUNI',
    'JULI',
    'AGUSTUS',
    'SEPTEMBER',
    'OKTOBER',
    'NOVEMBER',
    'DESEMBER'
  ];
  List<String> listCasting = ['W1', 'W2', 'W3', 'W4'];
  bool isBackPosisi = false;

  //kebutuhan add kode marketing
  String? kodeJenisBarang = '';
  String? kodeKualitasBarang = '';
  String? kodeWarna = '';
  String? kodeMarketing = '';
  String idKodeDesign = '';

  RowSourceProduksi({
    required this.getNowSiklus,
    required this.getKodeBulan,
    required this.getValueBulanDesigner,
    required this.getIdDataModeller,
    required this.getNoUrutDataModeller,
    required this.rowCount,
    required this.rowsPerPage,
    required this.currentPageIndex,
    required this.listDataMps,
    required this.siklus,
    required this.onRowPressed,
    required this.listArtist,
    required this.listDivisi,
    required this.listSubDivisiArtistFinishing,
    required this.listSubDivisiArtistPolishing,
    required this.listSubDivisiArtistStell,
    required this.listSubDivisiArtistPasangBatu,
    required this.listBulan,
  });

  @override
  DataRow getRow(int index) {
    double sizeFont = 14;
    double sizeIcon = 26;
    var data = listDataMps[index];
    // String susutPerBarang = (data.debet - data.kredit).toStringAsFixed(3);
    return DataRow(
        //HINTS merubah warna bg
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            // Set the background color to red when the row is selected
            if (data.isSend.toString() != '') {
              return Colors.red.withOpacity(0.4); // Adjust opacity as needed
            }
            // The default row color
            return null;
          },
        ),
        cells: [
          //nomor
          DataCell(Builder(builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (index + 1).toString(),
                    style: TextStyle(fontSize: sizeFont),
                  ),
                  sharedPreferences!.getString('divisi') == 'admin' ||
                          sharedPreferences!.getString('divisi') == 'scm'
                      ? IconButton(
                          onPressed: () {
                            goToVeiw(context, data.id);
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.blue,
                            size: sizeIcon,
                          ),
                        )
                      : const SizedBox(),
                  sharedPreferences!.getString('role') == '1' ||
                          sharedPreferences!.getString('role') == '2' ||
                          sharedPreferences!.getString('divisi') == 'admin'
                      ? data.posisi.toString().toLowerCase() == 'brj' ||
                              data.isSend.toString() != ''
                          ? Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: sizeIcon,
                            )
                          : IconButton(
                              onPressed: () {
                                formSwitchBulan(context, data.kodeDesignMdbc,
                                    index, data.id, data.idMps);
                                // formCancel(context, data.kodeDesignMdbc, i);
                              },
                              icon: Icon(
                                Icons.swap_horiz,
                                color: Colors.blue,
                                size: sizeIcon,
                              ),
                            )
                      : const SizedBox()
                ],
              ),
            );
          })),

          //minggu ke
          DataCell(Builder(builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.keteranganMinggu,
                    style: TextStyle(fontSize: sizeFont),
                  ),
                  sharedPreferences!.getString('role') == '1' ||
                          sharedPreferences!.getString('role') == '2' ||
                          sharedPreferences!.getString('divisi') == 'admin'
                      ? IconButton(
                          onPressed: () {
                            formSwitchWeek(context, data);
                          },
                          icon: Icon(
                            Icons.swap_horiz,
                            color: Colors.blue,
                            size: sizeIcon,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          })),
          //gambar
          DataCell(Builder(builder: (context) {
            return SizedBox(
              width: 300,
              height: 340,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => ViewPhotoMpsScreen(
                                modelMps: ListMpsModel(
                                    kodeDesignMdbc: data.kodeDesignMdbc,
                                    imageUrl: data.imageUrl),
                              )));
                },
                child: Image.network(
                  ApiConstants.baseUrlImage + data.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          })),
          //kode MDBC
          DataCell(
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  var copy = data.kodeDesignMdbc;
                  Clipboard.setData(ClipboardData(text: copy));
                  showSimpleNotification(
                    const Text(
                      'Text Berhasil Dicopy',
                    ),
                    background: Colors.green,
                    duration: const Duration(seconds: 2),
                  );
                },
                child: Text(data.kodeDesignMdbc,
                    style: TextStyle(fontSize: sizeFont)),
              );
            }),
          ),
          //kode marketintg
          DataCell(
            Builder(builder: (context) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        var copy = data.kodeMarketing;
                        Clipboard.setData(ClipboardData(text: copy));
                        showSimpleNotification(
                          const Text('Text Berhasil Dicopy'),
                          background: Colors.green,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: Text(data.kodeMarketing,
                          style: TextStyle(fontSize: sizeFont)),
                    ),
                    sharedPreferences!.getString('divisi') == 'admin' ||
                            sharedPreferences!.getString('divisi') == 'scm'
                        ? data.kodeMarketing == ''
                            ? ElevatedButton(
                                onPressed: (() {
                                  kodeJenisBarang = '';
                                  kodeWarna = '';
                                  kodeKualitasBarang = '';
                                  formInput(context, data.kodeDesignMdbc,
                                      data.idMps, data.id);
                                }),
                                child: const Text('Get Kode'))
                            : const SizedBox()
                        : const SizedBox()
                  ],
                ),
              );
            }),
          ),
          //posisi

          DataCell(Builder(builder: (context) {
            // String? posisi = '';
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${data.posisi}'),
                data.posisi.toString().toLowerCase() == 'brj' ||
                        data.posisi.toString().toLowerCase() ==
                            'out pasang batu'
                    ? const SizedBox()
                    : Text('${data.artist}'),
                data.isSend.toString() != ''
                    ? const SizedBox()
                    : sharedPreferences!.getString('nama') ==
                            'Tri Sartika Rahayu'
                        ? const SizedBox()
                        : sharedPreferences!.getString('divisi') ==
                                    'produksi' ||
                                sharedPreferences!.getString('divisi') ==
                                    'admin'
                            ? IconButton(
                                onPressed: () {
                                  print('tap ke : ${data.posisi}');
                                  int idPosisi = 0;
                                  if (sharedPreferences!.getString('role') ==
                                      '3') {
                                    data.posisi.toString().toLowerCase() ==
                                            'orul'
                                        ? idPosisi = 0
                                        : data.posisi
                                                    .toString()
                                                    .toLowerCase() ==
                                                'printing resin'
                                            ? idPosisi = 1
                                            : data.posisi
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'finishing resin'
                                                ? idPosisi = 2
                                                : data.posisi
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'casting'
                                                    ? idPosisi = 3
                                                    : idPosisi = 4;
                                  } else if (sharedPreferences!
                                          .getString('role') ==
                                      '4') {
                                    data.posisi.toString().toLowerCase() ==
                                            'stok finishing'
                                        ? idPosisi = 1
                                        : data.posisi
                                                    .toString()
                                                    .toLowerCase() ==
                                                'finishing'
                                            ? idPosisi = 1
                                            : data.posisi
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 1'
                                                ? idPosisi = 2
                                                : data.posisi
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 1'
                                                    ? idPosisi = 3
                                                    : data.posisi
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'stok pasang batu'
                                                        ? idPosisi = 4
                                                        : data.posisi
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'out pasang batu'
                                                            ? idPosisi = 5
                                                            : data.posisi
                                                                        .toString()
                                                                        .toLowerCase() ==
                                                                    'stell 2'
                                                                ? idPosisi = 5
                                                                : data.posisi
                                                                            .toString()
                                                                            .toLowerCase() ==
                                                                        'polishing 2'
                                                                    ? idPosisi =
                                                                        6
                                                                    : idPosisi =
                                                                        7;
                                  } else if (sharedPreferences!
                                          .getString('role') ==
                                      '5') {
                                    data.posisi.toString().toLowerCase() ==
                                            'stok pasang batu'
                                        ? idPosisi = 1
                                        : data.posisi
                                                    .toString()
                                                    .toLowerCase() ==
                                                'pasang batu'
                                            ? idPosisi = 2
                                            : idPosisi = 3;
                                  } else {
                                    idPosisi = -99;
                                  }

                                  showGeneralDialog(
                                      transitionDuration:
                                          const Duration(milliseconds: 200),
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      context: context,
                                      pageBuilder:
                                          (context, animation1, animation2) {
                                        return const Text('');
                                      },
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      transitionBuilder:
                                          (context, a1, a2, widget) {
                                        return Transform.scale(
                                            scale: a1.value,
                                            child: Opacity(
                                                opacity: a1.value,
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  content: SizedBox(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Pilih Posisi Divisi',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          for (var j = 0;
                                                              j <
                                                                  listDivisi
                                                                      .length;
                                                              j++)
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 15),
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: listDivisi[j].toString().toLowerCase() == 'orul'
                                                                              ? Colors
                                                                                  .red
                                                                              : Colors
                                                                                  .blue,
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50.0))),
                                                                      onPressed:
                                                                          () async {
                                                                        print(
                                                                            '$j kurang dari $idPosisi');
                                                                        Navigator.pop(
                                                                            context);
                                                                        if (j ==
                                                                            0) {
                                                                          //! pop up untuk keterangan atau alasan ORUL
                                                                          //! function back posisi
                                                                          orulReparasiPopup(
                                                                              context,
                                                                              data.idMps,
                                                                              j,
                                                                              data.kodeDesignMdbc,
                                                                              data.kodeMarketing,
                                                                              data.posisi,
                                                                              'orul',
                                                                              '');
                                                                        } else if (j <
                                                                            idPosisi) {
                                                                          isBackPosisi =
                                                                              true;

                                                                          //! function back posisi
                                                                          showSimpleNotification(
                                                                            const Text('Alert Back Posisi'),
                                                                            background:
                                                                                Colors.red,
                                                                            duration:
                                                                                const Duration(seconds: 1),
                                                                          );
                                                                          if (listDivisi[j].toString().toLowerCase() == 'printing resin' ||
                                                                              listDivisi[j].toString().toLowerCase() == 'finishing resin' ||
                                                                              listDivisi[j].toString().toLowerCase() == 'casting') {
                                                                            orulReparasiPopup(
                                                                                context,
                                                                                data.idMps,
                                                                                j,
                                                                                data.kodeDesignMdbc,
                                                                                data.kodeMarketing,
                                                                                data.posisi,
                                                                                'reparasi',
                                                                                '');
                                                                          } else {
                                                                            //! back posisi untuk role admin dan head
                                                                            artistPopup(
                                                                                context,
                                                                                data.idMps,
                                                                                j,
                                                                                data.kodeDesignMdbc,
                                                                                data.kodeMarketing,
                                                                                data.posisi,
                                                                                isBackPosisi);
                                                                          }
                                                                        } else {
                                                                          isBackPosisi =
                                                                              false;

                                                                          //? function pilih posisi
                                                                          if (sharedPreferences!.getString('role') == '1' ||
                                                                              sharedPreferences!.getString('nama') == 'Tri Sartika R' ||
                                                                              sharedPreferences!.getString('divisi') == 'admin') {
                                                                            //! admin dan head
                                                                            j == 1 || j == 2 || j == 10 || j == 11 || j == 12 || j == 13
                                                                                ? postDatabase(data.idMps, j, data.kodeDesignMdbc, data.kodeMarketing)
                                                                                : j == 3
                                                                                    ? castingPopup(context, data.id, j, data.kodeDesignMdbc, data.kodeMarketing)
                                                                                    : artistPopup(context, data.idMps, j, data.kodeDesignMdbc, data.kodeMarketing, data.posisi, isBackPosisi);
                                                                          }
                                                                          //  else if (sharedPreferences!
                                                                          //         .getString(
                                                                          //             'role') ==
                                                                          //     '2') {
                                                                          //   showSimpleNotification(
                                                                          //     const Text(
                                                                          //         'Tidak ada pilihan'),
                                                                          //     background:
                                                                          //         Colors
                                                                          //             .red,
                                                                          //     duration:
                                                                          //         const Duration(
                                                                          //             seconds:
                                                                          //                 1),
                                                                          //   );
                                                                          // }
                                                                          else if (sharedPreferences!.getString('role') ==
                                                                              '3') {
                                                                            j == 3
                                                                                ? castingPopup(context, data.id, j, data.kodeDesignMdbc, data.kodeMarketing)
                                                                                : postDatabase(data.idMps, j, data.kodeDesignMdbc, data.kodeMarketing);
                                                                          } else if (sharedPreferences!.getString('role') ==
                                                                              '4') {
                                                                            j == 4 || j == 7
                                                                                ? postDatabase(data.idMps, j, data.kodeDesignMdbc, data.kodeMarketing)
                                                                                : artistPopup(context, data.idMps, j, data.kodeDesignMdbc, data.kodeMarketing, data.posisi, isBackPosisi);
                                                                          } else if (sharedPreferences!.getString('role') ==
                                                                              '5') {
                                                                            j == 2
                                                                                ? postDatabase(data.idMps, j, data.kodeDesignMdbc, data.kodeMarketing)
                                                                                : artistPopup(context, data.idMps, j, data.kodeDesignMdbc, data.kodeMarketing, data.posisi, isBackPosisi);
                                                                          } else {
                                                                            showSimpleNotification(
                                                                              const Text('Tidak ada pilihan'),
                                                                              background: Colors.red,
                                                                              duration: const Duration(seconds: 1),
                                                                            );
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "${listDivisi[j]}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      )),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )));
                                      });
                                },
                                icon: const Icon(
                                  Icons.change_circle,
                                  color: Colors.green,
                                ))
                            : const SizedBox(),
              ],
            ));
          })),
          //status batu
          DataCell(
            Builder(builder: (context) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.keteranganStatusBatu,
                    style: TextStyle(fontSize: sizeFont),
                  ),
                  sharedPreferences!.getString('divisi') == 'scm' ||
                          sharedPreferences!.getString('divisi') == 'admin'
                      ? Stack(
                          clipBehavior:
                              Clip.none, //agar tidak menghalangi object
                          children: [
                            //tambahan icon ADD
                            sharedPreferences!.getString('role') == '1' ||
                                    sharedPreferences!.getString('role') ==
                                        '2' ||
                                    sharedPreferences!.getString('divisi') ==
                                        'admin' ||
                                    sharedPreferences!.getString('divisi') ==
                                        'scm'
                                ? Positioned(
                                    right: -5.0,
                                    top: -3.0,
                                    child: InkResponse(
                                      onTap: () {
                                        // Navigator.of(context).pop();
                                      },
                                      child: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            sharedPreferences!.getString('role') == '1' ||
                                    sharedPreferences!.getString('role') ==
                                        '2' ||
                                    sharedPreferences!.getString('divisi') ==
                                        'admin' ||
                                    sharedPreferences!.getString('divisi') ==
                                        'scm'
                                ? IconButton(
                                    onPressed: () {
                                      showGeneralDialog(
                                          transitionDuration:
                                              const Duration(milliseconds: 200),
                                          barrierDismissible: true,
                                          barrierLabel: '',
                                          context: context,
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return const Text('');
                                          },
                                          barrierColor:
                                              Colors.black.withOpacity(0.5),
                                          transitionBuilder:
                                              (context, a1, a2, widget) {
                                            return Transform.scale(
                                                scale: a1.value,
                                                child: Opacity(
                                                    opacity: a1.value,
                                                    child: AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        content: SizedBox(
                                                            child:
                                                                SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .vertical,
                                                                    child: Column(
                                                                        children: [
                                                                          const Text(
                                                                            'Pilih Status Batu',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusBatu(data.idMps, 'ECER');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Batu Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "ECER",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          sharedPreferences!.getString('divisi') == 'scm'
                                                                              ? Container(
                                                                                  padding: const EdgeInsets.only(top: 15),
                                                                                  child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                      onPressed: () async {
                                                                                        await postKeteranganStatusBatu(data.idMps, 'TRANSFER BATU');
                                                                                        onRowPressed();
                                                                                        Navigator.pop(context);
                                                                                        showSimpleNotification(
                                                                                          const Text('Pemilihan Status Batu Berhasil'),
                                                                                          background: Colors.green,
                                                                                          duration: const Duration(seconds: 1),
                                                                                        );
                                                                                      },
                                                                                      child: const Text(
                                                                                        "TRANSFER BATU",
                                                                                        style: TextStyle(
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                      )),
                                                                                )
                                                                              : Container(
                                                                                  padding: const EdgeInsets.only(top: 15),
                                                                                  child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                      onPressed: () async {
                                                                                        await postKeteranganStatusBatu(data.idMps, 'KOMPLIT BATU');
                                                                                        onRowPressed();
                                                                                        Navigator.pop(context);
                                                                                        showSimpleNotification(
                                                                                          const Text('Pemilihan Status Batu Berhasil'),
                                                                                          background: Colors.green,
                                                                                          duration: const Duration(seconds: 1),
                                                                                        );
                                                                                      },
                                                                                      child: const Text(
                                                                                        "KOMPLIT BATU",
                                                                                        style: TextStyle(
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                      )),
                                                                                ),
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusBatu(data.idMps, 'BELUM KOMPLIT BATU');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Batu Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "BELUM KOMPLIT BATU",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ]))))));
                                          });
                                    },
                                    icon: const Icon(
                                        Icons.chat_bubble_outline_rounded),
                                    color: Colors.green,
                                  )
                                : const SizedBox(),
                          ],
                        )
                      : const SizedBox()
                ],
              ));
            }),
          ),
          //status acc
          DataCell(
            Builder(builder: (context) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.keteranganStatusAcc,
                    style: TextStyle(fontSize: sizeFont),
                  ),
                  sharedPreferences!.getString('divisi') == 'scm' ||
                          sharedPreferences!.getString('divisi') == 'admin'
                      ? Stack(
                          clipBehavior:
                              Clip.none, //agar tidak menghalangi object
                          children: [
                            //tambahan icon ADD
                            sharedPreferences!.getString('role') == '1' ||
                                    sharedPreferences!.getString('role') ==
                                        '2' ||
                                    sharedPreferences!.getString('divisi') ==
                                        'admin'
                                ? Positioned(
                                    right: -5.0,
                                    top: -3.0,
                                    child: InkResponse(
                                      onTap: () {
                                        // Navigator.of(context).pop();
                                      },
                                      child: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            sharedPreferences!.getString('role') == '1' ||
                                    sharedPreferences!.getString('role') ==
                                        '2' ||
                                    sharedPreferences!.getString('divisi') ==
                                        'scm' ||
                                    sharedPreferences!.getString('divisi') ==
                                        'admin'
                                ? IconButton(
                                    onPressed: () {
                                      showGeneralDialog(
                                          transitionDuration:
                                              const Duration(milliseconds: 200),
                                          barrierDismissible: true,
                                          barrierLabel: '',
                                          context: context,
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return const Text('');
                                          },
                                          barrierColor:
                                              Colors.black.withOpacity(0.5),
                                          transitionBuilder:
                                              (context, a1, a2, widget) {
                                            return Transform.scale(
                                                scale: a1.value,
                                                child: Opacity(
                                                    opacity: a1.value,
                                                    child: AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        content: SizedBox(
                                                            child:
                                                                SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .vertical,
                                                                    child: Column(
                                                                        children: [
                                                                          const Text(
                                                                            'Pilih Status Acc',
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusAcc(data.idMps, 'Tidak Ada');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Batu Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "Tidak Ada",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                          sharedPreferences!.getString('divisi') == 'scm'
                                                                              ? Container(
                                                                                  padding: const EdgeInsets.only(top: 15),
                                                                                  child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                      onPressed: () async {
                                                                                        await postKeteranganStatusAcc(data.idMps, 'TRANSFER ACC');
                                                                                        onRowPressed();
                                                                                        Navigator.pop(context);
                                                                                        showSimpleNotification(
                                                                                          const Text('Pemilihan Status Acc Berhasil'),
                                                                                          background: Colors.green,
                                                                                          duration: const Duration(seconds: 1),
                                                                                        );
                                                                                      },
                                                                                      child: const Text(
                                                                                        "TRANSFER ACC",
                                                                                        style: TextStyle(
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                      )),
                                                                                )
                                                                              : Container(
                                                                                  padding: const EdgeInsets.only(top: 15),
                                                                                  child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                      onPressed: () async {
                                                                                        await postKeteranganStatusAcc(data.idMps, 'KOMPLIT ACC');
                                                                                        onRowPressed();
                                                                                        Navigator.pop(context);
                                                                                        showSimpleNotification(
                                                                                          const Text('Pemilihan Status Acc Berhasil'),
                                                                                          background: Colors.green,
                                                                                          duration: const Duration(seconds: 1),
                                                                                        );
                                                                                      },
                                                                                      child: const Text(
                                                                                        "KOMPLIT ACC",
                                                                                        style: TextStyle(
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                      )),
                                                                                ),
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15),
                                                                            child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                                                                onPressed: () async {
                                                                                  await postKeteranganStatusAcc(data.idMps, 'BELUM KOMPLIT ACC');
                                                                                  onRowPressed();
                                                                                  Navigator.pop(context);
                                                                                  showSimpleNotification(
                                                                                    const Text('Pemilihan Status Acc Berhasil'),
                                                                                    background: Colors.green,
                                                                                    duration: const Duration(seconds: 1),
                                                                                  );
                                                                                },
                                                                                child: const Text(
                                                                                  "BELUM KOMPLIT ACC",
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ]))))));
                                          });
                                    },
                                    icon: const Icon(Icons.toll_outlined),
                                    color: Colors.green,
                                  )
                                : const SizedBox()
                          ],
                        )
                      : const SizedBox()
                ],
              ));
            }),
          ),
          //keterangan batu
          DataCell(
            Text(
              data.keteranganBatu,
              style: TextStyle(fontSize: sizeFont),
            ),
          ),
          //tema
          DataCell(
            Text(
              data.tema,
              style: TextStyle(fontSize: sizeFont),
            ),
          ),
          //jenisBarang
          DataCell(
            Text(data.jenisBarang, style: TextStyle(fontSize: sizeFont)),
          ),
          //berat emas
          DataCell(
            Text(
              data.beratEmas.toString(),
              style: TextStyle(fontSize: sizeFont),
            ),
          ),
          //berat diamond
          DataCell(
            Text(
              data.totalCarat.toString(),
              style: TextStyle(fontSize: sizeFont),
            ),
          ),
          //brand
          DataCell(
            Text(
              data.brand,
              style: TextStyle(fontSize: sizeFont),
            ),
          ),
          //harga
          DataCell(sharedPreferences!.getString('divisi') == 'scm' ||
                  sharedPreferences!.getString('divisi') == 'admin'
              ? Center(
                  child: data.brand.toString().toLowerCase() == 'parva'
                      ? Text(
                          CurrencyFormat.convertToIdr(
                              ((data.estimasiHarga * 0.37) * 11500), 0),
                          maxLines: 2,
                          style: TextStyle(fontSize: sizeFont),
                        )
                      : Text(
                          CurrencyFormat.convertToIdr(
                              ((data.estimasiHarga)), 0),
                          maxLines: 2,
                          style: TextStyle(fontSize: sizeFont),
                        ))
              //? mode untuk produksi
              : sharedPreferences!.getString('role') == '1' ||
                      sharedPreferences!.getString('role') == '2'
                  ? Center(
                      child: data.brand.toString().toLowerCase() == 'parva'
                          ? Text(
                              CurrencyFormat.convertToIdr(
                                  ((data.estimasiHarga * 0.37) * 11500), 0),
                              maxLines: 2,
                              style: TextStyle(fontSize: sizeFont),
                            )
                          : Text(
                              CurrencyFormat.convertToIdr(
                                  ((data.estimasiHarga)), 0),
                              maxLines: 2,
                              style: TextStyle(fontSize: sizeFont),
                            ))
                  : const Text('Rp.***-***-***')),
          //kelas harga
          DataCell(
            Center(
                child: ((data.estimasiHarga * 0.37) * 11500) <= 5000000
                    ? Text(
                        "XS",
                        style: TextStyle(fontSize: sizeFont),
                      )
                    : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                        ? Text(
                            "S",
                            style: TextStyle(fontSize: sizeFont),
                          )
                        : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
                            ? Text(
                                "M",
                                style: TextStyle(fontSize: sizeFont),
                              )
                            : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
                                ? Text(
                                    "L",
                                    style: TextStyle(fontSize: sizeFont),
                                  )
                                : Text(
                                    "XL",
                                    style: TextStyle(fontSize: sizeFont),
                                  )),
          ),
          //tanggal in produksi
          DataCell(
            Center(
                child: Text(
              data.tanggalInProduksi,
              style: TextStyle(fontSize: sizeFont),
            )),
          ),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  //? kumpulan fnction

  simpanForm(
      context,
      apiIdFormDesigner,
      apiIdMps,
      apiIdKodeMarketing,
      apiKodeDesign,
      apiJenisBatu,
      apiSiklus,
      apiTema,
      apiKodeBulan,
      apiNoUrut,
      apiKodeMarketing,
      apiStatusSpk,
      apiMarketingData,
      apiBrand,
      apiNamaDesigner,
      apinamaModeller,
      apiKeterangan,
      apiJo) async {
    await addDataModeller(
        apiKodeDesign,
        apiJenisBatu,
        apiSiklus,
        apiTema,
        apiKodeBulan,
        apiNoUrut,
        apiKodeMarketing,
        apiStatusSpk,
        apiMarketingData,
        apiBrand,
        apiNamaDesigner,
        apinamaModeller,
        apiKeterangan,
        apiJo);
    await updateKodeMarketingFromDesigner(
        apiIdFormDesigner,
        apiKodeDesign,
        apiJenisBatu,
        apiSiklus,
        apiTema,
        apiKodeBulan,
        apiNoUrut,
        apiKodeMarketing,
        apiStatusSpk,
        apiMarketingData,
        apiBrand,
        apiNamaDesigner,
        apinamaModeller,
        apiKeterangan,
        apiJo);
    await updateKodeMarketingMPS(apiIdMps, apiKodeMarketing, apiJo);
    onRowPressed();
    Navigator.pop(context);
    showSimpleNotification(
      const Text('Pemilihan Waktu Berhasil'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  addDataModeller(
      apiKodeDesign,
      apiJenisBatu,
      apiSiklus,
      apiTema,
      apiKodeBulan,
      apiNoUrut,
      apiKodeMarketing,
      apiStatusSpk,
      apiMarketingData,
      apiBrand,
      apiNamaDesigner,
      apinamaModeller,
      apiKeterangan,
      apiJo) async {
    Map<String, dynamic> body = {
      'kodeDesign': apiKodeDesign,
      'jenisBatu': apiJenisBatu,
      'bulan': apiSiklus,
      'tema': apiTema,
      'kodeBulan': apiKodeBulan,
      'noUrutBulan': apiNoUrut,
      'kodeMarketing': apiKodeMarketing,
      'status': apiStatusSpk,
      'marketing': apiMarketingData,
      'brand': apiBrand,
      'designer': apiNamaDesigner,
      'modeller': apinamaModeller,
      'keterangan': apiKeterangan,
      'jo': apiJo
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postDataModeller),
        body: body);
    print(response.body);
  }

  updateKodeMarketingFromDesigner(
      apiIdKodeMarketing,
      apiKodeDesign,
      apiJenisBatu,
      apiSiklus,
      apiTema,
      apiKodeBulan,
      apiNoUrut,
      apiKodeMarketing,
      apiStatusSpk,
      apiMarketingData,
      apiBrand,
      apiNamaDesigner,
      apinamaModeller,
      apiKeterangan,
      apiJo) async {
    Map<String, dynamic> body = {
      'type': 'updateKodeMarketing',
      'id': apiIdKodeMarketing,
      'kodeMarketing': apiKodeMarketing,
      'namaModeller': apinamaModeller,
      'jo': apiJo
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.restFullApi),
        body: jsonEncode(body));
    print(response.body);
  }

  updateKodeMarketingMPS(apiIdMps, apiKodeMarketing, apiJo) async {
    Map<String, dynamic> body = {
      'type': 'updateKodeMarketingMPS',
      'idMps': apiIdMps,
      'kodeMarketing': apiKodeMarketing,
      'jo': apiJo
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.restFullApi),
        body: jsonEncode(body));
    print(response.body);
  }

  Future<List<JenisbarangModel>> getListJenisbarang(filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListJenisbarang,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return JenisbarangModel.fromJsonList(data);
    }
    return [];
  }

  formInput(context, getKodeDesign, getIdMps, getIdFormDesigner) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          String? jenisBatu;
          String? warnaEmas;
          String? pilihMarketing;
          String? statusSPK;
          String? brand;
          final formKey = GlobalKey<FormState>();
          TextEditingController temaDataModeller = TextEditingController();
          TextEditingController kodeDesignDataModeller =
              TextEditingController();
          kodeDesignDataModeller.text = getKodeDesign;
          TextEditingController idDataModeller = TextEditingController();
          TextEditingController noUrutDataModeller = TextEditingController();
          TextEditingController kodeMarketingDataModeller =
              TextEditingController();
          TextEditingController marketingDataModeller = TextEditingController();
          TextEditingController namaDesignerDataModeller =
              TextEditingController();
          TextEditingController namaModellerDataModeller =
              TextEditingController();
          TextEditingController keteranganDataModeller =
              TextEditingController();
          TextEditingController jo = TextEditingController();
          RoundedLoadingButtonController btnController =
              RoundedLoadingButtonController();
          TextEditingController jenisBarang = TextEditingController();
          idDataModeller.text = getIdDataModeller!;
          noUrutDataModeller.text = getNoUrutDataModeller!;
          print(statusSPK);

          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    readOnly: statusSPK == 'NO'
                                        ? true
                                        : statusSPK == null
                                            ? true
                                            : false,
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textInputAction: TextInputAction.next,
                                    controller: kodeMarketingDataModeller,
                                    decoration: InputDecoration(
                                      // hintText: "example: Cahaya Sanivokasi",
                                      labelText: "Kode Marketing",
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
                                  const Text(
                                    'Pilih terlebih dahulu NO atau RO',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      //! status memilih no atau ro
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: statusSPK != null
                                                    ? const Color.fromARGB(
                                                        255, 8, 209, 69)
                                                    : const Color.fromRGBO(
                                                        238,
                                                        240,
                                                        235,
                                                        1), //background color of dropdown button
                                                border: Border.all(
                                                  color: Colors.black38,
                                                  // width:
                                                  //     3
                                                ), //border of dropdown button
                                                borderRadius: BorderRadius.circular(
                                                    0), //border raiuds of dropdown button
                                                boxShadow: const <BoxShadow>[]),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DropdownButton(
                                                  value: statusSPK,
                                                  items: const [
                                                    //add items in the dropdown
                                                    DropdownMenuItem(
                                                      value: "NO",
                                                      child: Text("NO"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "RO",
                                                      child: Text("RO"),
                                                    ),
                                                  ],
                                                  hint:
                                                      const Text('NO Atau RO'),
                                                  onChanged: (value) {
                                                    statusSPK = value;
                                                    print(
                                                        "You have selected $value");
                                                    value == 'RO'
                                                        ? noUrutDataModeller
                                                            .text = ''
                                                        : noUrutDataModeller
                                                            .text = (int.parse(
                                                                    getNoUrutDataModeller!) +
                                                                1)
                                                            .toString()
                                                            .padLeft(3, '0');
                                                    value == 'NO'
                                                        ? kodeMarketingDataModeller
                                                                .text =
                                                            '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing'
                                                        : kodeMarketingDataModeller
                                                            .text = '';
                                                    setState(() => statusSPK);
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
                                                    color: Colors
                                                        .black, //Font color
                                                    // fontSize:
                                                    //     15 //font size on dropdown button
                                                  ),

                                                  dropdownColor: Colors
                                                      .white, //dropdown background color
                                                  underline:
                                                      Container(), //remove underline
                                                  isExpanded:
                                                      true, //make true to make width 100%
                                                ))),
                                      ),
                                      //? id
                                      Container(
                                        // width: MediaQuery.of(context).size.width *
                                        //     0.25,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: TextFormField(
                                                readOnly: true,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: idDataModeller,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "ID",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: TextFormField(
                                                readOnly: true,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: noUrutDataModeller,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "No Urut",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Kode Design
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                readOnly: true,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller:
                                                    kodeDesignDataModeller,
                                                decoration: InputDecoration(
                                                  // hintText: "example: Cahaya Sanivokasi",
                                                  labelText: "Kode Design",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //Jenis Batu
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: jenisBatu != null
                                                    ? const Color.fromARGB(
                                                        255, 8, 209, 69)
                                                    : const Color.fromRGBO(
                                                        238,
                                                        240,
                                                        235,
                                                        1), //background color of dropdown button
                                                border: Border.all(
                                                  color: Colors.black38,
                                                  // width:
                                                  //     3
                                                ), //border of dropdown button
                                                borderRadius: BorderRadius.circular(
                                                    0), //border raiuds of dropdown button
                                                boxShadow: const <BoxShadow>[
                                                  //apply shadow on Dropdown button
                                                  // BoxShadow(
                                                  //     color: Color.fromRGBO(
                                                  //         0,
                                                  //         0,
                                                  //         0,
                                                  //         0.57), //shadow for button
                                                  //     blurRadius:
                                                  //         5) //blur radius of shadow
                                                ]),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DropdownButton(
                                                  value: jenisBatu,
                                                  items: const [
                                                    //add items in the dropdown
                                                    DropdownMenuItem(
                                                      value: "VVS",
                                                      child: Text("VVS"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "VS",
                                                      child: Text("VS"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "SI",
                                                      child: Text("SI"),
                                                    )
                                                  ],
                                                  hint:
                                                      const Text('Jenis Batu'),
                                                  onChanged: (value) {
                                                    jenisBatu = value;
                                                    if (statusSPK == 'NO') {
                                                      jenisBatu == 'SI'
                                                          ? kodeKualitasBarang =
                                                              'I'
                                                          : jenisBatu == 'VS'
                                                              ? kodeKualitasBarang =
                                                                  'E'
                                                              : kodeKualitasBarang =
                                                                  'A';
                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                    } else {}

                                                    setState(() =>
                                                        kodeMarketingDataModeller);
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
                                                    color: Colors
                                                        .black, //Font color
                                                    // fontSize:
                                                    //     15 //font size on dropdown button
                                                  ),

                                                  dropdownColor: Colors
                                                      .white, //dropdown background color
                                                  underline:
                                                      Container(), //remove underline
                                                  isExpanded:
                                                      true, //make true to make width 100%
                                                ))),
                                      ),

                                      // warna emas
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 10, right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: warnaEmas != null
                                                  ? const Color.fromARGB(
                                                      255, 8, 209, 69)
                                                  : const Color.fromRGBO(
                                                      238,
                                                      240,
                                                      235,
                                                      1), //background color of dropdown button
                                              border: Border.all(
                                                color: Colors.black38,
                                                // width:
                                                //     3
                                              ), //border of dropdown button
                                              borderRadius: BorderRadius.circular(
                                                  0), //border raiuds of dropdown button
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DropdownButton(
                                                  value: warnaEmas,
                                                  items: const [
                                                    //add items in the dropdown
                                                    DropdownMenuItem(
                                                      value: "WG",
                                                      child: Text("WG"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "RG",
                                                      child: Text("RG"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "MIX",
                                                      child: Text("MIX"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "MIX WHITE,YELLOW",
                                                      child: Text(
                                                          "MIX WHITE,YELLOW"),
                                                    )
                                                  ],
                                                  hint:
                                                      const Text('Warna Emas'),
                                                  onChanged: (value) {
                                                    warnaEmas = value;
                                                    if (statusSPK == 'NO') {
                                                      warnaEmas == 'WG'
                                                          ? kodeWarna = '0'
                                                          : warnaEmas == 'RG'
                                                              ? kodeWarna = '2'
                                                              : warnaEmas ==
                                                                      'MIX'
                                                                  ? kodeWarna =
                                                                      '4'
                                                                  : warnaEmas ==
                                                                          'MIX WHITE,YELLOW'
                                                                      ? kodeWarna =
                                                                          '5'
                                                                      : kodeKualitasBarang =
                                                                          '0';

                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                    } else {}

                                                    setState(() =>
                                                        kodeMarketingDataModeller);
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
                                                    color: Colors
                                                        .black, //Font color
                                                    // fontSize:
                                                    //     15 //font size on dropdown button
                                                  ),

                                                  dropdownColor: Colors
                                                      .white, //dropdown background color
                                                  underline:
                                                      Container(), //remove underline
                                                  isExpanded:
                                                      true, //make true to make width 100%
                                                ))),
                                      ),

                                      statusSPK == null
                                          ? const SizedBox()
                                          : statusSPK != 'NO'
                                              ? const SizedBox()
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: DropdownSearch<
                                                      JenisbarangModel>(
                                                    asyncItems:
                                                        (String? filter) =>
                                                            getListJenisbarang(
                                                                filter),
                                                    popupProps:
                                                        PopupPropsMultiSelection
                                                            .modalBottomSheet(
                                                      showSelectedItems: true,
                                                      itemBuilder:
                                                          _listJenisbarang,
                                                      showSearchBox: true,
                                                    ),
                                                    compareFn: (item, sItem) =>
                                                        item.id == sItem.id,
                                                    onChanged: (item) {
                                                      // setState(() {
                                                      jenisBarang.text =
                                                          item!.nama;
                                                      kodeJenisBarang =
                                                          item.kodeBarang;
                                                      // });
                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';

                                                      setState(() =>
                                                          kodeMarketingDataModeller
                                                              .text);
                                                    },
                                                    dropdownDecoratorProps:
                                                        const DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        labelText:
                                                            "Jenis Barang",
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
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
                                          controller: temaDataModeller,
                                          decoration: InputDecoration(
                                            labelText: "Tema / Project",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                        ),
                                      ),

                                      // MARKETING
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            left: 10,
                                            right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: pilihMarketing != null
                                                  ? const Color.fromARGB(
                                                      255, 8, 209, 69)
                                                  : const Color.fromRGBO(
                                                      238,
                                                      240,
                                                      235,
                                                      1), //background color of dropdown button
                                              border: Border.all(
                                                color: Colors.black38,
                                                // width:
                                                //     3
                                              ), //border of dropdown button
                                              borderRadius: BorderRadius.circular(
                                                  0), //border raiuds of dropdown button
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DropdownButton(
                                                  value: pilihMarketing,
                                                  items: const [
                                                    //add items in the dropdown
                                                    DropdownMenuItem(
                                                      value: "N",
                                                      child: Text("JONATHAN"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "E",
                                                      child: Text("STEPHANIE"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "T",
                                                      child: Text("ADIT"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "K",
                                                      child: Text("ERICK"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "I",
                                                      child: Text(
                                                          "FEBRI / BHESTADI"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "O",
                                                      child: Text("RUDIANTO"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "A",
                                                      child: Text("RITA"),
                                                    ),
                                                  ],
                                                  hint: const Text('Marketing'),
                                                  onChanged: (value) {
                                                    pilihMarketing = value;
                                                    kodeMarketing = value;
                                                    if (statusSPK == 'NO') {
                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                    } else {}

                                                    setState(() =>
                                                        kodeMarketingDataModeller);
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
                                                    color: Colors
                                                        .black, //Font color
                                                    // fontSize:
                                                    //     15 //font size on dropdown button
                                                  ),

                                                  dropdownColor: Colors
                                                      .white, //dropdown background color
                                                  underline:
                                                      Container(), //remove underline
                                                  isExpanded:
                                                      true, //make true to make width 100%
                                                ))),
                                      ),

                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: brand != null
                                                    ? const Color.fromARGB(
                                                        255, 8, 209, 69)
                                                    : const Color.fromRGBO(
                                                        238,
                                                        240,
                                                        235,
                                                        1), //background color of dropdown button
                                                border: Border.all(
                                                  color: Colors.black38,
                                                  // width:
                                                  //     3
                                                ), //border of dropdown button
                                                borderRadius: BorderRadius.circular(
                                                    0), //border raiuds of dropdown button
                                                boxShadow: const <BoxShadow>[
                                                  //apply shadow on Dropdown button
                                                  // BoxShadow(
                                                  //     color: Color.fromRGBO(
                                                  //         0,
                                                  //         0,
                                                  //         0,
                                                  //         0.57), //shadow for button
                                                  //     blurRadius:
                                                  //         5) //blur radius of shadow
                                                ]),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: DropdownButton(
                                                  value: brand,
                                                  items: const [
                                                    //add items in the dropdown
                                                    DropdownMenuItem(
                                                      value: "PARVA",
                                                      child: Text("PARVA"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "METIER",
                                                      child: Text("METIER"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "BELI BERLIAN",
                                                      child:
                                                          Text("BELI BERLIAN"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "FINE",
                                                      child: Text("FINE"),
                                                    )
                                                  ],
                                                  hint: const Text('Brand'),
                                                  onChanged: (value) async {
                                                    brand = value;
                                                    var kodeBrand = '';
                                                    if (brand == 'PARVA') {
                                                      kodeBrand = '0';
                                                      kodeJenisBarang =
                                                          '$kodeJenisBarang$kodeBrand';
                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                    } else if (brand ==
                                                        'METIER') {
                                                      kodeBrand = 'M';
                                                      kodeJenisBarang =
                                                          '$kodeBrand$kodeJenisBarang';

                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                    } else if (brand ==
                                                        'BELI BERLIAN') {
                                                      kodeBrand = 'B';
                                                      kodeJenisBarang =
                                                          '$kodeBrand$kodeJenisBarang';

                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                    } else {
                                                      kodeBrand = '0';
                                                      kodeJenisBarang =
                                                          '$kodeJenisBarang$kodeBrand';
                                                      kodeMarketingDataModeller
                                                              .text =
                                                          '$kodeJenisBarang$getValueBulanDesigner${noUrutDataModeller.text}$kodeWarna${kodeKualitasBarang}01$kodeMarketing';
                                                    }

                                                    setState(() => brand);
                                                  },
                                                  icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Icon(Icons
                                                          .arrow_circle_down_sharp)),
                                                  iconEnabledColor:
                                                      Colors.black, //Icon color
                                                  style: const TextStyle(
                                                    color: Colors
                                                        .black, //Font color
                                                    // fontSize:
                                                    //     15 //font size on dropdown button
                                                  ),

                                                  dropdownColor: Colors
                                                      .white, //dropdown background color
                                                  underline:
                                                      Container(), //remove underline
                                                  isExpanded:
                                                      true, //make true to make width 100%
                                                ))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          textInputAction: TextInputAction.next,
                                          controller: namaDesignerDataModeller,
                                          decoration: InputDecoration(
                                            labelText: "Nama Designer",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
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
                                          controller: namaModellerDataModeller,
                                          decoration: InputDecoration(
                                            labelText: "Nama Modeller",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
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
                                          controller: keteranganDataModeller,
                                          decoration: InputDecoration(
                                            // hintText: "example: Cahaya Sanivokasi",
                                            labelText: "Keterangan",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
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
                                          controller: jo,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Wajib diisi *';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            // hintText: "example: Cahaya Sanivokasi",
                                            labelText: "JO",

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
                                              child: const Text("Simpan Data"),
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState!.save();
                                                  simpanForm(
                                                      context,
                                                      getIdFormDesigner,
                                                      getIdMps,
                                                      idKodeDesign,
                                                      kodeDesignDataModeller
                                                          .text,
                                                      jenisBatu,
                                                      getNowSiklus,
                                                      temaDataModeller.text,
                                                      getKodeBulan,
                                                      noUrutDataModeller.text,
                                                      kodeMarketingDataModeller
                                                          .text,
                                                      statusSPK,
                                                      marketingDataModeller
                                                          .text,
                                                      brand,
                                                      namaDesignerDataModeller
                                                          .text,
                                                      namaModellerDataModeller
                                                          .text,
                                                      keteranganDataModeller
                                                          .text,
                                                      jo.text);
                                                } else {
                                                  btnController.error();
                                                  Future.delayed(const Duration(
                                                          seconds: 1))
                                                      .then((value) {
                                                    btnController
                                                        .reset(); //reset
                                                  });
                                                }
                                              }),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      ],
                    ),
                  ));
        });
  }

  formSwitchWeek(context, data) {
    return showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('');
        },
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: SizedBox(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                const Text(
                                  'Pilih Waktu',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postKeteranganMinggu(
                                            data.idMps, 'WEEK 1');
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Waktu Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 1",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postKeteranganMinggu(
                                            data.idMps, 'WEEK 2');
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Waktu Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 2",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postKeteranganMinggu(
                                            data.idMps, 'WEEK 3');
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Waktu Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 3",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postKeteranganMinggu(
                                            data.idMps, 'WEEK 4');
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Waktu Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 4",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                              ]))))));
        });
  }

  goToVeiw(context, id) async {
    showSimpleNotification(
      const Text('Please Wait ...'),
      background: Colors.green,
      duration: const Duration(seconds: 2),
    );

    await _getDataDesignerById(id);
    var dataKode = dataView!.first;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => FormViewScreen(
                  modelDesigner: FormDesignerModel(
                    statusForm: dataKode.statusForm,
                    id: dataKode.id,
                    kodeDesignMdbc: dataKode.kodeDesignMdbc,
                    kodeMarketing: dataKode.kodeMarketing,
                    kodeProduksi: dataKode.kodeProduksi,
                    namaDesigner: dataKode.namaDesigner,
                    namaModeller: dataKode.namaModeller,
                    kodeDesign: dataKode.kodeDesign,
                    siklus: dataKode.siklus,
                    tema: dataKode.tema,
                    rantai: dataKode.rantai,
                    qtyRantai: dataKode.qtyRantai,
                    lain2: dataKode.lain2,
                    qtyLain2: dataKode.qtyLain2,
                    earnut: dataKode.earnut,
                    qtyEarnut: dataKode.qtyEarnut,
                    panjangRantai: dataKode.panjangRantai,
                    customKomponen: dataKode.customKomponen,
                    qtyCustomKomponen: dataKode.qtyCustomKomponen,
                    jenisBarang: dataKode.jenisBarang,
                    kategoriBarang: dataKode.kategoriBarang,
                    brand: dataKode.brand,
                    photoShoot: dataKode.photoShoot,
                    color: dataKode.color,
                    beratEmas: dataKode.beratEmas,
                    estimasiHarga: dataKode.estimasiHarga,
                    ringSize: dataKode.ringSize,
                    created_at: dataKode.created_at,
                    batu1: dataKode.batu1,
                    qtyBatu1: dataKode.qtyBatu1,
                    batu2: dataKode.batu2,
                    qtyBatu2: dataKode.qtyBatu2,
                    batu3: dataKode.batu3,
                    qtyBatu3: dataKode.qtyBatu3,
                    batu4: dataKode.batu4,
                    qtyBatu4: dataKode.qtyBatu4,
                    batu5: dataKode.batu5,
                    qtyBatu5: dataKode.qtyBatu5,
                    batu6: dataKode.batu6,
                    qtyBatu6: dataKode.qtyBatu6,
                    batu7: dataKode.batu7,
                    qtyBatu7: dataKode.qtyBatu7,
                    batu8: dataKode.batu8,
                    qtyBatu8: dataKode.qtyBatu8,
                    batu9: dataKode.batu9,
                    qtyBatu9: dataKode.qtyBatu9,
                    batu10: dataKode.batu10,
                    qtyBatu10: dataKode.qtyBatu10,
                    batu11: dataKode.batu11,
                    qtyBatu11: dataKode.qtyBatu11,
                    batu12: dataKode.batu12,
                    qtyBatu12: dataKode.qtyBatu12,
                    batu13: dataKode.batu13,
                    qtyBatu13: dataKode.qtyBatu13,
                    batu14: dataKode.batu14,
                    qtyBatu14: dataKode.qtyBatu14,
                    batu15: dataKode.batu15,
                    qtyBatu15: dataKode.qtyBatu15,
                    batu16: dataKode.batu16,
                    qtyBatu16: dataKode.qtyBatu16,
                    batu17: dataKode.batu17,
                    qtyBatu17: dataKode.qtyBatu17,
                    batu18: dataKode.batu18,
                    qtyBatu18: dataKode.qtyBatu18,
                    batu19: dataKode.batu19,
                    qtyBatu19: dataKode.qtyBatu19,
                    batu20: dataKode.batu20,
                    qtyBatu20: dataKode.qtyBatu20,
                    batu21: dataKode.batu21,
                    qtyBatu21: dataKode.qtyBatu21,
                    batu22: dataKode.batu22,
                    qtyBatu22: dataKode.qtyBatu22,
                    batu23: dataKode.batu23,
                    qtyBatu23: dataKode.qtyBatu23,
                    batu24: dataKode.batu24,
                    qtyBatu24: dataKode.qtyBatu24,
                    batu25: dataKode.batu25,
                    qtyBatu25: dataKode.qtyBatu25,
                    batu26: dataKode.batu26,
                    qtyBatu26: dataKode.qtyBatu26,
                    batu27: dataKode.batu27,
                    qtyBatu27: dataKode.qtyBatu27,
                    batu28: dataKode.batu28,
                    qtyBatu28: dataKode.qtyBatu28,
                    batu29: dataKode.batu29,
                    qtyBatu29: dataKode.qtyBatu29,
                    batu30: dataKode.batu30,
                    qtyBatu30: dataKode.qtyBatu30,
                    batu31: dataKode.batu31,
                    qtyBatu31: dataKode.qtyBatu31,
                    batu32: dataKode.batu32,
                    qtyBatu32: dataKode.qtyBatu32,
                    batu33: dataKode.batu33,
                    qtyBatu33: dataKode.qtyBatu33,
                    batu34: dataKode.batu34,
                    qtyBatu34: dataKode.qtyBatu34,
                    batu35: dataKode.batu35,
                    qtyBatu35: dataKode.qtyBatu35,
                    imageUrl: dataKode.imageUrl,
                    keteranganStatusBatu: dataKode.keteranganStatusBatu,
                    pointModeller: dataKode.pointModeller,
                    tanggalInModeller: dataKode.tanggalInModeller,
                    tanggalOutModeller: dataKode.tanggalOutModeller,
                    tanggalInProduksi: dataKode.tanggalInProduksi,
                    beratModeller: dataKode.beratModeller,
                    jo: dataKode.jo,
                  ),
                )));
  }

  formSwitchBulan(context, kodeDesignMdbc, i, idFormDesigner, idMps) {
    return showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('');
        },
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: SizedBox(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                const Text(
                                  'Pilih bulan release',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                for (var j = 0; j < listSwitchBulan.length; j++)
                                  Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  listSwitchBulan[j]
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'cancel'
                                                      ? Colors.red
                                                      : Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0))),
                                          onPressed: () {
                                            if (j == 0) {
                                              formCancel(
                                                  context, kodeDesignMdbc, i);
                                            }
                                            updateStatusFormDesigner(
                                                idFormDesigner,
                                                listSwitchBulan[j]);
                                            updateMps(context, idMps,
                                                listSwitchBulan[j]);
                                          },
                                          child: Text(
                                            listSwitchBulan[j],
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          )))
                              ]))))));
        });
  }

  updateStatusFormDesigner(id, release) async {
    //? menambahkan posisi release dan bulannya
    Map<String, String> body = {
      'id': id.toString(),
      'bulan': release.toString()
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addTanggalProduksi}'),
        body: body);
    print(response.body);
  }

  updateMps(context, idMps, bulanMps) async {
    Map<String, String> body = {
      'isUpdate': 'true',
      'id': idMps.toString(),
      'bulan': bulanMps.toString().toUpperCase(),
    };
    try {
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postDataMps}'),
          body: body);
      if (response.statusCode == 200) {
        showSimpleNotification(
          const Text('Data berhasil di release'),
          background: Colors.green,
          duration: const Duration(seconds: 1),
        );
        print(response.body);
      } else {
        //*HINTS Panggil fungsi showCustomDialog error
        showCustomDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Error send data CANCEL',
          description: response.body,
        );
      }
    } catch (c) {
      //*HINTS Panggil fungsi showCustomDialog error
      showCustomDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Error send data CANCEL',
        description: '$c',
      );
    }
  }

  formCancel(context, kodeDesignMdbc, i) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Perhatian',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Row(
          children: [
            const Text(
              'Apakah anda yakin ingin mengCANCEL - ',
            ),
            Text(
              '$kodeDesignMdbc  ?',
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
              await postDataMps(listDataMps, i, 'cancel', context, 'false');
              onRowPressed();
              Navigator.pop(context);
            },
            child: const Text(
              'YA',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  postDataMps(var dumData, index, bulan, context, isUpdate) async {
    var data = dumData[index];
    Map<String, String> body = {
      'id': data.idMps.toString(),
    };
    print(body);
    try {
      final response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postDataMpsIsSend}'),
          body: body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showSimpleNotification(
          const Text('Data berhasil di CANCEL'),
          background: Colors.green,
          duration: const Duration(seconds: 1),
        );
        print(response.body);
      } else {
        //*HINTS Panggil fungsi showCustomDialog error
        showCustomDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Error send data CANCEL',
          description: response.body,
        );
      }
    } catch (c) {
      //*HINTS Panggil fungsi showCustomDialog error
      showCustomDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Error send data CANCEL',
        description: '$c',
      );
    }
  }

  postPosisi(id, posisi, artist) async {
    print('post posisi on');
    Map<String, String> body = {
      'id': id.toString(),
      'posisi': posisi.toString(),
      'artist': artist.toString(),
    };
    print(body);
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  castingPopup(context, id, j, kodeDesignMdbc, kodeMarketing) {
    return showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('');
        },
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: SizedBox(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                const Text(
                                  'Pilih Minggu Ke -',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W1",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W1",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 1",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W2",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W2",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 2",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W3",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W3",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 3",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0))),
                                      onPressed: () async {
                                        await postPosisi(
                                          id,
                                          "${listDivisi[j]}",
                                          "W4",
                                        );
                                        onRowPressed();

                                        await postHistory(
                                          kodeDesignMdbc,
                                          kodeMarketing,
                                          "${listDivisi[j]}",
                                          "W4",
                                        );
                                        onRowPressed();
                                        Navigator.pop(context);
                                        showSimpleNotification(
                                          const Text(
                                              'Pemilihan Posisi Berhasil'),
                                          background: Colors.green,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: const Text(
                                        "WEEK 4",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ),
                              ]))))));
        });
  }

  postDatabase(id, j, kodeDesignMdbc, kodeMarketing) async {
    print(id);
    print(listDivisi[j]);
    await postPosisi(
      id,
      "${listDivisi[j]}",
      "${listDivisi[j]}",
    );
    onRowPressed();

    await postHistory(
      kodeDesignMdbc,
      kodeMarketing,
      "${listDivisi[j]}",
      "${listDivisi[j]}",
    );
    showSimpleNotification(
      const Text('Posisi berhasil di simpan'),
      background: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }

  artistPopup(
      context, id, j, kodeDesignMdbc, kodeMarketing, posisi, isBackPosisi) {
    print('total $j');
    return isBackPosisi == false
        ? showGeneralDialog(
            transitionDuration: const Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {
              return const Text('');
            },
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                      opacity: a1.value,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        content: SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                // SizedBox(
                                //   child: Lottie.asset(
                                //       "loadingJSON/backbutton.json",
                                //       fit: BoxFit
                                //           .cover),
                                // ),
                                Text(
                                  'Pilih Artist ${listDivisi[j]}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                                //! loopimg
                                for (var i = 0;
                                    listDivisi[j].toString().toLowerCase() ==
                                            'finishing'
                                        ? i <
                                            listSubDivisiArtistFinishing.length
                                        : listDivisi[j]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 1' ||
                                                listDivisi[j]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 2'
                                            ? i <
                                                listSubDivisiArtistPolishing
                                                    .length
                                            : listDivisi[j]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 1' ||
                                                    listDivisi[j]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 2'
                                                ? i <
                                                    listSubDivisiArtistStell
                                                        .length
                                                : listDivisi[j]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'casting'
                                                    ? i < listCasting.length
                                                    : i <
                                                        listSubDivisiArtistPasangBatu
                                                            .length;
                                    i++)
                                  Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                        // style: ElevatedButton.styleFrom(backgroundColor: colorDasar, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                // Saat tombol di-hover, atur warna latar belakang yang berbeda di sini
                                                return Colors
                                                    .red; // Ganti dengan warna yang diinginkan
                                              }
                                              // Warna latar belakang saat tidak di-hover
                                              return colorDasar; // Ganti dengan warna yang diinginkan
                                            },
                                          ),
                                        ),
                                        onPressed: () async {
                                          await postPosisi(
                                            id,
                                            "${listDivisi[j]}",
                                            listDivisi[j]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'finishing'
                                                ? listSubDivisiArtistFinishing[
                                                    i]
                                                : listDivisi[j]
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'polishing 1' ||
                                                        listDivisi[j]
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'polishing 2'
                                                    ? listSubDivisiArtistPolishing[
                                                        i]
                                                    : listDivisi[j]
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'stell 1' ||
                                                            listDivisi[j]
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'stell 2'
                                                        ? listSubDivisiArtistStell[
                                                            i]
                                                        : listDivisi[j]
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'casting'
                                                            ? listCasting[i]
                                                            : listSubDivisiArtistPasangBatu[
                                                                i],
                                          );
                                          onRowPressed();

                                          await postHistory(
                                            kodeDesignMdbc,
                                            kodeMarketing,
                                            "${listDivisi[j]}",
                                            posisi.toString().toLowerCase() ==
                                                    'finishing'
                                                ? listSubDivisiArtistFinishing[
                                                    i]
                                                : posisi
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'polishing 1' ||
                                                        posisi
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'polishing 2'
                                                    ? listSubDivisiArtistPolishing[
                                                        i]
                                                    : posisi
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'stell 1' ||
                                                            posisi
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'stell 2'
                                                        ? listSubDivisiArtistStell[
                                                            i]
                                                        : listDivisi[j]
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                'casting'
                                                            ? listCasting[i]
                                                            : listSubDivisiArtistPasangBatu[
                                                                i],
                                          );

                                          Navigator.pop(context);
                                          showSimpleNotification(
                                            const Text(
                                                'Menambahkan posisi dan artist berhasil'),
                                            background: Colors.green,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                        },
                                        child: Text(
                                          listDivisi[j]
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
                                              : listDivisi[j]
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 1' ||
                                                      listDivisi[j]
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 2'
                                                  ? listSubDivisiArtistPolishing[
                                                      i]
                                                  : listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 1' ||
                                                          listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 2'
                                                      ? listSubDivisiArtistStell[
                                                          i]
                                                      : listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'casting'
                                                          ? listCasting[i]
                                                          : listSubDivisiArtistPasangBatu[
                                                              i],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )));
            })
        :
        //! function untuk artistpop yang back posisi atau juga reparasi
        showGeneralDialog(
            transitionDuration: const Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {
              return const Text('');
            },
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                      opacity: a1.value,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        content: SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Text(
                                  'Pilih Artist ${listDivisi[j]}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                                //! loopimg
                                for (var i = 0;
                                    listDivisi[j].toString().toLowerCase() ==
                                            'finishing'
                                        ? i <
                                            listSubDivisiArtistFinishing.length
                                        : listDivisi[j]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 1' ||
                                                listDivisi[j]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 2'
                                            ? i <
                                                listSubDivisiArtistPolishing
                                                    .length
                                            : listDivisi[j]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 1' ||
                                                    listDivisi[j]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 2'
                                                ? i <
                                                    listSubDivisiArtistStell
                                                        .length
                                                : listDivisi[j]
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'casting'
                                                    ? i < listCasting.length
                                                    : i <
                                                        listSubDivisiArtistPasangBatu
                                                            .length;
                                    i++)
                                  Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                        // style: ElevatedButton.styleFrom(backgroundColor: colorDasar, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                // Saat tombol di-hover, atur warna latar belakang yang berbeda di sini
                                                return Colors
                                                    .red; // Ganti dengan warna yang diinginkan
                                              }
                                              // Warna latar belakang saat tidak di-hover
                                              return colorDasar; // Ganti dengan warna yang diinginkan
                                            },
                                          ),
                                        ),
                                        onPressed: () async {
                                          var artisOrulRep = '';
                                          artisOrulRep = listDivisi[j]
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
                                              : listDivisi[j]
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 1' ||
                                                      listDivisi[j]
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 2'
                                                  ? listSubDivisiArtistPolishing[
                                                      i]
                                                  : listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 1' ||
                                                          listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 2'
                                                      ? listSubDivisiArtistStell[
                                                          i]
                                                      : listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'casting'
                                                          ? listCasting[i]
                                                          : listSubDivisiArtistPasangBatu[
                                                              i];

                                          print(
                                              '$posisi -- $artisOrulRep orul/reparasi');
                                          orulReparasiPopup(
                                              context,
                                              id,
                                              j,
                                              kodeDesignMdbc,
                                              kodeMarketing,
                                              posisi,
                                              'reparasi',
                                              artisOrulRep);
                                          onRowPressed();
                                          await postHistory(
                                              kodeDesignMdbc,
                                              kodeMarketing,
                                              "${listDivisi[j]}",
                                              artisOrulRep);
                                          Navigator.pop(context);
                                          showSimpleNotification(
                                            const Text(
                                                'Data berhasil terkirim'),
                                            background: Colors.green,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                        },
                                        child: Text(
                                          listDivisi[j]
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
                                              : listDivisi[j]
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 1' ||
                                                      listDivisi[j]
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'polishing 2'
                                                  ? listSubDivisiArtistPolishing[
                                                      i]
                                                  : listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 1' ||
                                                          listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'stell 2'
                                                      ? listSubDivisiArtistStell[
                                                          i]
                                                      : listDivisi[j]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              'casting'
                                                          ? listCasting[i]
                                                          : listSubDivisiArtistPasangBatu[
                                                              i],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )));
            });
  }

  orulReparasiPopup(context, id, j, kodeDesignMdbc, kodeMarketing, posisi,
      statusBackPosisi, artis) {
    return showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('');
        },
        barrierColor: Colors.red.withOpacity(0.8),
        transitionBuilder: (context, a1, a2, widget) {
          TextEditingController keterangan = TextEditingController();
          RoundedLoadingButtonController btnController =
              RoundedLoadingButtonController();
          final formKey = GlobalKey<FormState>();

          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: SizedBox(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Form(
                                key: formKey,
                                child: Column(children: [
                                  Text(
                                    'Alasan / Keterangan $artis',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    width: 250,
                                    child: TextFormField(
                                      // textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (reportinput) {},
                                      maxLines: 5, //or null
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          labelText: "Keterangan",
                                          hintText: "Keterangan"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Wajib diisi *';
                                        }
                                        return null;
                                      },
                                      controller: keterangan,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: CustomLoadingButton(
                                        controller: btnController,
                                        child: const Text("Simpan"),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            Future.delayed(const Duration(
                                                    milliseconds: 10))
                                                .then((value) async {
                                              btnController.success();
                                              print(
                                                  '$posisi => ${listDivisi[j]} : ${keterangan.text}');
                                              await postOrulReparasi(
                                                  id,
                                                  "${listDivisi[j]}",
                                                  '$artis',
                                                  '$statusBackPosisi',
                                                  '$posisi => ${listDivisi[j]} : ${keterangan.text}');

                                              await postHistory(
                                                kodeDesignMdbc,
                                                kodeMarketing,
                                                "${listDivisi[j]}",
                                                "",
                                              );
                                              onRowPressed();
                                              Navigator.pop(context);
                                              showSimpleNotification(
                                                const Text(
                                                    'Pemilihan Posisi Berhasil'),
                                                background: Colors.green,
                                                duration:
                                                    const Duration(seconds: 1),
                                              );
                                              Future.delayed(const Duration(
                                                      milliseconds: 10))
                                                  .then((value) {
                                                btnController.reset(); //reset
                                              });
                                            });
                                          } else {
                                            print('validasi tidak');

                                            btnController.error();
                                            Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((value) {
                                              btnController.reset(); //reset
                                            });
                                          }
                                        }),
                                  ),
                                  Container(
                                    width: 250,
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0))),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Batal",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ),
                                ]),
                              ))))));
        });
  }

  postOrulReparasi(
      id, posisi, artist, statusBackPosisi, keteranganBackPosisi) async {
    Map<String, String> body = {
      'id': id.toString(),
      'posisi': posisi.toString(),
      'artist': artist.toString(),
      'statusBackPosisi': statusBackPosisi.toString(),
      'keteranganBackPosisi': keteranganBackPosisi.toString(),
    };
    print(body);
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postKeteranganMinggu(id, keteranganMinggu) async {
    Map<String, String> body = {
      'id': id.toString(),
      'keteranganMinggu': keteranganMinggu,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postKeteranganStatusBatu(id, keteranganStatusBatu) async {
    Map<String, String> body = {
      'id': id.toString(),
      'keteranganStatusBatu': keteranganStatusBatu,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postKeteranganStatusAcc(id, keteranganStatusAcc) async {
    Map<String, String> body = {
      'id': id.toString(),
      'keteranganStatusAcc': keteranganStatusAcc,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updatePosisidanWeek}'),
        body: body);
    print(response.body);
  }

  postHistory(kodeDesignMdbc, kodeMarketing, posisi, namaArtist) async {
    Map<String, String> body = {
      'kodeDesignMdbc': kodeDesignMdbc.toString(),
      'kodeMarketing': kodeMarketing.toString(),
      'posisi': posisi.toString(),
      'namaArtis': namaArtist.toString()
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addHistoryPosisi}'),
        body: body);
    print(response.body);
  }

  _getDataDesignerById(id) async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getListFormDesigner));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => FormDesignerModel.fromJson(data)).toList();
      var filterById = allData
          .where((element) => element.id.toString() == id.toString())
          .toList();
      dataView = filterById.toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Widget _listJenisbarang(
    BuildContext context,
    JenisbarangModel? item,
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
