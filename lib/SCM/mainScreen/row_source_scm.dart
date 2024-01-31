// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/form_view_screen.dart';
import 'package:form_designer/mainScreen/view_photo_mps.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/model/list_mps_model.dart';
import 'package:form_designer/widgets/custom_loading.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class RowSourceScm extends DataTableSource {
  Widget _verticalDivider = const VerticalDivider(
    color: Colors.grey,
    thickness: 1,
  );
  List<FormDesignerModel>? dataView;

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  var myData;
  final count;
  var siklus;
  final VoidCallback onRowPressed; //* menerima data untuk me refresh screen
  var listArtist;
  var listDivisi;
  var listSubDivisiArtistFinishing;
  var listSubDivisiArtistPolishing;
  var listSubDivisiArtistStell;
  var listSubDivisiArtistPasangBatu;

  RowSourceScm({
    required this.myData,
    required this.count,
    required this.siklus,
    required this.onRowPressed,
    required this.listArtist,
    required this.listDivisi,
    required this.listSubDivisiArtistFinishing,
    required this.listSubDivisiArtistPolishing,
    required this.listSubDivisiArtistStell,
    required this.listSubDivisiArtistPasangBatu,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(
          myData![index],
          index,
          siklus,
          listArtist,
          listDivisi,
          listSubDivisiArtistFinishing,
          listSubDivisiArtistPolishing,
          listSubDivisiArtistStell,
          listSubDivisiArtistPasangBatu);
    } else {
      return null;
    }
  }

  DataRow recentFileDataRow(
      var data,
      var i,
      var siklus,
      var listArtist,
      var listDivisi,
      var listSubDivisiArtistFinishing,
      var listSubDivisiArtistPolishing,
      var listSubDivisiArtistStell,
      var listSubDivisiArtistPasangBatu) {
    // ignore: prefer_interpolation_to_compose_strings

    return DataRow(cells: [
      //No
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((i + 1).toString()),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //keterangan minggu
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.keteranganMinggu),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //gambar
      DataCell(Builder(builder: (context) {
        return Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              width: 100,
              height: 140,
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
            ));
      })),

      DataCell(_verticalDivider),
      //kode mdbc
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.kodeDesignMdbc),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //kode marketing
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  data.kodeMarketing == ''
                      ? Center(
                          child: ElevatedButton(
                              // width: 150,
                              // controller: btnController,
                              onPressed: (() async {
                                showSimpleNotification(
                                  const Text('Please Wait ...'),
                                  background: Colors.green,
                                  duration: const Duration(seconds: 2),
                                );

                                await _getDataDesignerById(data.id);
                                var dataKode = dataView!.first;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => FormViewScreen(
                                              modelDesigner: FormDesignerModel(
                                                statusForm: dataKode.statusForm,
                                                id: dataKode.id,
                                                kodeDesignMdbc:
                                                    dataKode.kodeDesignMdbc,
                                                kodeMarketing:
                                                    dataKode.kodeMarketing,
                                                kodeProduksi:
                                                    dataKode.kodeProduksi,
                                                namaDesigner:
                                                    dataKode.namaDesigner,
                                                namaModeller:
                                                    dataKode.namaModeller,
                                                kodeDesign: dataKode.kodeDesign,
                                                siklus: dataKode.siklus,
                                                tema: dataKode.tema,
                                                rantai: dataKode.rantai,
                                                qtyRantai: dataKode.qtyRantai,
                                                lain2: dataKode.lain2,
                                                qtyLain2: dataKode.qtyLain2,
                                                earnut: dataKode.earnut,
                                                qtyEarnut: dataKode.qtyEarnut,
                                                panjangRantai:
                                                    dataKode.panjangRantai,
                                                customKomponen:
                                                    dataKode.customKomponen,
                                                qtyCustomKomponen:
                                                    dataKode.qtyCustomKomponen,
                                                jenisBarang:
                                                    dataKode.jenisBarang,
                                                kategoriBarang:
                                                    dataKode.kategoriBarang,
                                                brand: dataKode.brand,
                                                photoShoot: dataKode.photoShoot,
                                                color: dataKode.color,
                                                beratEmas: dataKode.beratEmas,
                                                estimasiHarga:
                                                    dataKode.estimasiHarga,
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
                                                keteranganStatusBatu: dataKode
                                                    .keteranganStatusBatu,
                                                pointModeller:
                                                    dataKode.pointModeller,
                                                tanggalInModeller:
                                                    dataKode.tanggalInModeller,
                                                tanggalOutModeller:
                                                    dataKode.tanggalOutModeller,
                                                tanggalInProduksi:
                                                    dataKode.tanggalInProduksi,
                                                beratModeller:
                                                    dataKode.beratModeller,
                                                    jo:
                                                    dataKode.jo,
                                              ),
                                            )));
                              }),
                              child: const Text('Get Kode')),
                        )
                      : Text(data.kodeMarketing),
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //posisi
      DataCell(Builder(builder: (context) {
        // String? posisi = '';
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 63),
              child: Column(
                children: [
                  Text('${data.posisi}'),
                  Text('${data.artist}'),
                ],
              ),
            ),
          ],
        );
      })),
      DataCell(_verticalDivider),
      //status batu
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.keteranganStatusBatu),
                  Stack(
                    clipBehavior: Clip.none, //agar tidak menghalangi object
                    children: [
                      //tambahan icon ADD
                      Positioned(
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
                      ),
                      IconButton(
                        onPressed: () {
                          showGeneralDialog(
                              transitionDuration:
                                  const Duration(milliseconds: 200),
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
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            content: SizedBox(
                                                child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Column(children: [
                                                      const Text(
                                                        'Pilih Status Batu',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0))),
                                                            onPressed:
                                                                () async {
                                                              await postKeteranganStatusBatu(
                                                                  data.id,
                                                                  'ECER');
                                                              onRowPressed();
                                                              Navigator.pop(
                                                                  context);
                                                              showSimpleNotification(
                                                                const Text(
                                                                    'Pemilihan Status Batu Berhasil'),
                                                                background:
                                                                    Colors
                                                                        .green,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                              );
                                                            },
                                                            child: const Text(
                                                              "ECER",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            )),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0))),
                                                            onPressed:
                                                                () async {
                                                              await postKeteranganStatusBatu(
                                                                  data.id,
                                                                  'TRANSFER BATU');
                                                              onRowPressed();
                                                              Navigator.pop(
                                                                  context);
                                                              showSimpleNotification(
                                                                const Text(
                                                                    'Pemilihan Status Batu Berhasil'),
                                                                background:
                                                                    Colors
                                                                        .green,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                              );
                                                            },
                                                            child: const Text(
                                                              "TRANSFER BATU",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            )),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0))),
                                                            onPressed:
                                                                () async {
                                                              await postKeteranganStatusBatu(
                                                                  data.id,
                                                                  'BELUM KOMPLIT BATU');
                                                              onRowPressed();
                                                              Navigator.pop(
                                                                  context);
                                                              showSimpleNotification(
                                                                const Text(
                                                                    'Pemilihan Status Batu Berhasil'),
                                                                background:
                                                                    Colors
                                                                        .green,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
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
                        icon: const Icon(Icons.chat_bubble_outline_rounded),
                        color: Colors.green,
                      ),
                    ],
                  )
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //status acc
      DataCell(
        Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.keteranganStatusAcc),
                  Stack(
                    clipBehavior: Clip.none, //agar tidak menghalangi object
                    children: [
                      Positioned(
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
                      ),
                      IconButton(
                        onPressed: () {
                          showGeneralDialog(
                              transitionDuration:
                                  const Duration(milliseconds: 200),
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
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            content: SizedBox(
                                                child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Column(children: [
                                                      const Text(
                                                        'Pilih Status Acc',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0))),
                                                            onPressed:
                                                                () async {
                                                              await postKeteranganStatusAcc(
                                                                  data.id,
                                                                  'Tidak Ada');
                                                              onRowPressed();
                                                              Navigator.pop(
                                                                  context);
                                                              showSimpleNotification(
                                                                const Text(
                                                                    'Pemilihan Status Batu Berhasil'),
                                                                background:
                                                                    Colors
                                                                        .green,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                              );
                                                            },
                                                            child: const Text(
                                                              "Tidak Ada",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            )),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0))),
                                                            onPressed:
                                                                () async {
                                                              await postKeteranganStatusAcc(
                                                                  data.id,
                                                                  'TRANSFER ACC');
                                                              onRowPressed();
                                                              Navigator.pop(
                                                                  context);
                                                              showSimpleNotification(
                                                                const Text(
                                                                    'Pemilihan Status Acc Berhasil'),
                                                                background:
                                                                    Colors
                                                                        .green,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                              );
                                                            },
                                                            child: const Text(
                                                              "TRANSFER ACC",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            )),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0))),
                                                            onPressed:
                                                                () async {
                                                              await postKeteranganStatusAcc(
                                                                  data.id,
                                                                  'BELUM KOMPLIT ACC');
                                                              onRowPressed();
                                                              Navigator.pop(
                                                                  context);
                                                              showSimpleNotification(
                                                                const Text(
                                                                    'Pemilihan Status Acc Berhasil'),
                                                                background:
                                                                    Colors
                                                                        .green,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
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
                    ],
                  )
                ],
              ));
        }),
      ),
      DataCell(_verticalDivider),
      //keterangan batu
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.keteranganBatu)),
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
      //berat emas
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.beratEmas.toString())),
      ),
      DataCell(_verticalDivider),
      //berat diamond
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.totalCarat.toString())),
      ),
      DataCell(_verticalDivider),
      //brand
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.brand)),
      ),
      DataCell(_verticalDivider),
      //harga
      DataCell(
        Container(
            padding: const EdgeInsets.all(0),
            child: data.brand.toString().toLowerCase() == 'parva'
                ? Text(
                    CurrencyFormat.convertToIdr(
                        ((data.estimasiHarga * 0.37) * 11500), 0),
                    maxLines: 2,
                  )
                : Text(
                    CurrencyFormat.convertToIdr(((data.estimasiHarga)), 0),
                    maxLines: 2,
                  )),
      ),
      DataCell(_verticalDivider),
      //kelas harga
      DataCell(
        Container(
            padding: const EdgeInsets.all(0),
            child: ((data.estimasiHarga * 0.37) * 11500) <= 5000000
                ? const Text(
                    "XS",
                    maxLines: 2,
                  )
                : ((data.estimasiHarga * 0.37) * 11500) <= 10000000
                    ? const Text(
                        "S",
                        maxLines: 2,
                      )
                    : ((data.estimasiHarga * 0.37) * 11500) <= 20000000
                        ? const Text(
                            "M",
                            maxLines: 2,
                          )
                        : ((data.estimasiHarga * 0.37) * 11500) <= 35000000
                            ? const Text(
                                "L",
                                maxLines: 2,
                              )
                            : const Text(
                                "XL",
                                maxLines: 2,
                              )),
      ),
      DataCell(_verticalDivider),
      //tanggal in produksi
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.tanggalInProduksi)),
      ),
      DataCell(_verticalDivider),
      //tanggal in modeller
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.tanggalInModeller)),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;

  postPosisi(id, posisi, artist) async {
    Map<String, String> body = {
      'id': id.toString(),
      'posisi': posisi.toString(),
      'artist': artist.toString(),
    };
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
    posisi = listDivisi[j];

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
                                    posisi.toString().toLowerCase() ==
                                            'finishing'
                                        ? i <
                                            listSubDivisiArtistFinishing.length
                                        : posisi.toString().toLowerCase() ==
                                                    'polishing 1' ||
                                                posisi
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 2'
                                            ? i <
                                                listSubDivisiArtistPolishing
                                                    .length
                                            : posisi.toString().toLowerCase() ==
                                                        'stell 1' ||
                                                    posisi
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 2'
                                                ? i <
                                                    listSubDivisiArtistStell
                                                        .length
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
                                          posisi.toString().toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
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
                                    posisi.toString().toLowerCase() ==
                                            'finishing'
                                        ? i <
                                            listSubDivisiArtistFinishing.length
                                        : posisi.toString().toLowerCase() ==
                                                    'polishing 1' ||
                                                posisi
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'polishing 2'
                                            ? i <
                                                listSubDivisiArtistPolishing
                                                    .length
                                            : posisi.toString().toLowerCase() ==
                                                        'stell 1' ||
                                                    posisi
                                                            .toString()
                                                            .toLowerCase() ==
                                                        'stell 2'
                                                ? i <
                                                    listSubDivisiArtistStell
                                                        .length
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
                                          orulReparasiPopup(
                                              context,
                                              id,
                                              j,
                                              kodeDesignMdbc,
                                              kodeMarketing,
                                              posisi,
                                              'reparasi');
                                          //   await postPosisi(
                                          //     id,
                                          //     "${listDivisi[j]}",
                                          //     posisi.toString().toLowerCase() == 'finishing'
                                          //         ? listSubDivisiArtistFinishing[i]
                                          // : posisi.toString().toLowerCase() == 'polishing 1' || posisi.toString().toLowerCase() == 'polishing 2'
                                          //             ? listSubDivisiArtistPolishing[i]
                                          // : posisi.toString().toLowerCase() == 'stell 1' || posisi.toString().toLowerCase() == 'stell 2'
                                          //                 ? listSubDivisiArtistStell[i]
                                          //                 : listSubDivisiArtistPasangBatu[i],
                                          //   );
                                          //   onRowPressed();

                                          //   await postHistory(
                                          //    kodeDesignMdbc,
                                          //    kodeMarketing,
                                          //     "${listDivisi[j]}",
                                          //     posisi.toString().toLowerCase() == 'finishing'

                                          //         ? listSubDivisiArtistFinishing[i]
                                          // : posisi.toString().toLowerCase() == 'polishing 1' || posisi.toString().toLowerCase() == 'polishing 2'
                                          //             ? listSubDivisiArtistPolishing[i]
                                          // : posisi.toString().toLowerCase() == 'stell 1' || posisi.toString().toLowerCase() == 'stell 2'
                                          //                 ? listSubDivisiArtistStell[i]
                                          //                 : listSubDivisiArtistPasangBatu[i],
                                          //   );
                                          //   Navigator.pop(context);
                                          //   showSimpleNotification(
                                          //     const Text('Menambahkan posisi dan artist berhasil'),
                                          //     background: Colors.green,
                                          //     duration: const Duration(seconds: 1),
                                          //   );
                                        },
                                        child: Text(
                                          posisi.toString().toLowerCase() ==
                                                  'finishing'
                                              ? listSubDivisiArtistFinishing[i]
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

  orulReparasiPopup(
      context, id, j, kodeDesignMdbc, kodeMarketing, posisi, statusBackPosisi) {
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
                                  const Text(
                                    'Alasan / Keterangan',
                                    style: TextStyle(
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
                                            print('validasi ok');
                                            formKey.currentState!.save();
                                            Future.delayed(const Duration(
                                                    milliseconds: 10))
                                                .then((value) async {
                                              btnController.success();
                                              await postOrulReparasi(
                                                  id,
                                                  "${listDivisi[j]}",
                                                  '',
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
}
