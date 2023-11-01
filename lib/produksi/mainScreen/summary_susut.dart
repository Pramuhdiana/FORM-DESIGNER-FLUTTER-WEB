// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'dart:convert';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/produksi/modelProduksi/produksi_model.dart';
import 'package:form_designer/produksi/modelProduksi/produksi_model_sb.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';

class SummarySusutScreen extends StatefulWidget {
  const SummarySusutScreen({super.key});

  @override
  State<SummarySusutScreen> createState() => _SummarySusutScreenState();
}

@override
Widget _verticalDivider = const VerticalDivider(
  color: Colors.grey,
  thickness: 1,
);

class _SummarySusutScreenState extends State<SummarySusutScreen> {
  TextEditingController siklus = TextEditingController();
  String? updateSiklus = '';
  TextEditingController addSiklus = TextEditingController();

  double? resultFinishingDikdikMaulana = 0;
  double? resultFinishingMumahhadDeeko = 0;

  double? resultStellDikdikMaulana = 0;
  double? resultStellMumahhadDeeko = 0;

  String siklusDesigner = '';

  bool isSelected1 = false;
  TextEditingController controller = TextEditingController();
  bool sort = true;
  List<FormDesignerModel>? filterCrm;
  List<FormDesignerModel>? myCrm;
  final searchController = TextEditingController();
  bool isLoading = false;
  bool isJenisBarangView1 = false;
  bool isLoadingJenisBarang = false;
  var nowSiklus = '';

  //? variable Finishing
  List artistFinishing = [];
  List spkFinishing = [];
  List pointFinishing = [];
  List beratAsalFinishing = [];
  List beratAkhirFinishing = [];
  List beratAsalSBFinishing = [];
  List beratAkhirSBFinishing = [];
  List susutFinishing = [];
  List jatahSusutFinishing = [];
  List resultFinishing = [];
  int qtyNameFinishing = 0;
  //! end variable Finishing

  //? variable Poleshing1
  List artistPoleshing1 = [];
  List spkPoleshing1 = [];
  List pointPoleshing1 = [];
  List beratAsalPoleshing1 = [];
  List beratAkhirPoleshing1 = [];
  List beratAsalSBPoleshing1 = [];
  List beratAkhirSBPoleshing1 = [];
  List susutPoleshing1 = [];
  List jatahSusutPoleshing1 = [];
  List resultPoleshing1 = [];
  int qtyNamePoleshing1 = 0;
  //! end variable Poleshing1

  //? variable Stell1
  List artistStell1 = [];
  List spkStell1 = [];
  List pointStell1 = [];
  List beratAsalStell1 = [];
  List beratAkhirStell1 = [];
  List beratAsalSBStell1 = [];
  List beratAkhirSBStell1 = [];
  List susutStell1 = [];
  List jatahSusutStell1 = [];
  List resultStell1 = [];
  int qtyNameStell1 = 0;
  //! end variable Stell1

  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);
    siklusDesigner = month;
    nowSiklus = sharedPreferences!.getString('siklus')!;
    _getDataFinishing('all');
  }

// fungsi remove duplicate object
  List<ProduksiModel> removeDuplicates(List<ProduksiModel> items) {
    List<ProduksiModel> uniqueItems = []; // uniqueList
    var uniqueNames = items
        .map((e) => e.nama)
        .toSet(); //list if UniqueID to remove duplicates
    for (var e in uniqueNames) {
      uniqueItems.add(items.firstWhere((i) => i.nama == e));
    } // populate uniqueItems with equivalent original Batch items
    return uniqueItems; //send back the unique items list
  }

  void _getDataFinishing(month) async {
    setState(() {
      isLoading = true;
    });
    await _getName(month);
    await _getSpk(month);
    await _getPoint(month);
    await _getBeratAsal(month);
    setState(() {
      isLoading = false;
    });
  }

  _getName(month) async {
    artistFinishing = [];
    artistPoleshing1 = [];
    artistStell1 = [];
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data nama');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //* function Finishing
        //? filter by divisi Finishing
        var filterByDivisiFinishing = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing');
        var allDataFinishing = filterByDivisiFinishing.toList();
        //! jika suklis tidak di pilih
        allDataFinishing = removeDuplicates(allDataFinishing);
        //? ambil data nama
        for (var i = 0; i < allDataFinishing.length; i++) {
          artistFinishing.add(allDataFinishing[i].nama);
        }
        qtyNameFinishing = artistFinishing.length;

        //* function Poleshing1
        //? filter by divisi Poleshing1
        var filterByDivisiPoleshing1 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 1');
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();
        allDataPoleshing1 = removeDuplicates(allDataPoleshing1);
        //? ambil data nama
        for (var i = 0; i < allDataPoleshing1.length; i++) {
          artistPoleshing1.add(allDataPoleshing1[i].nama);
        }
        qtyNamePoleshing1 = artistPoleshing1.length;
        //! end function Poleshing1

        //* function Stell1
        //? filter by divisi Stell1
        var filterByDivisiStell1 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1');
        var allDataStell1 = filterByDivisiStell1.toList();
        allDataStell1 = removeDuplicates(allDataStell1);
        //? ambil data nama
        for (var i = 0; i < allDataStell1.length; i++) {
          artistStell1.add(allDataStell1[i].nama);
        }
        qtyNameStell1 = artistStell1.length;
        //! end function Stell1
      } else {
        //! jika siklus di pilih
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //? filter by divisi Finishing
        var filterByDivisiFinishing = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing');
        var allDataFinishing = filterByDivisiFinishing.toList();
        allDataFinishing = removeDuplicates(allDataFinishing);
        //? ambil data nama
        for (var i = 0; i < allDataFinishing.length; i++) {
          artistFinishing.add(allDataFinishing[i].nama);
        }
        qtyNameFinishing = artistFinishing.length;
        //! end function finishing

        //? filter by divisi Poleshing1
        var filterByDivisiPoleshing1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 1');
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();
        allDataPoleshing1 = removeDuplicates(allDataPoleshing1);
        //? ambil data nama
        for (var i = 0; i < allDataPoleshing1.length; i++) {
          artistPoleshing1.add(allDataPoleshing1[i].nama);
        }
        qtyNamePoleshing1 = artistPoleshing1.length;
        //! end function Poleshing1

        //? filter by divisi Stell1
        var filterByDivisiStell1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1');
        var allDataStell1 = filterByDivisiStell1.toList();
        allDataStell1 = removeDuplicates(allDataStell1);
        //? ambil data nama
        for (var i = 0; i < allDataStell1.length; i++) {
          artistStell1.add(allDataStell1[i].nama);
        }
        qtyNameStell1 = artistStell1.length;
        //! end function Stell1
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getSpk(month) async {
    spkFinishing = [];
    spkStell1 = [];
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data spk');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //! jika suklis tidak di pilih
        //* filter by finishing
        //? filter by divisi
        var filterByDivisiFinishing = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataFinishing = filterByDivisiFinishing.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameFinishing; i++) {
          var filterByNameFinishing = allDataFinishing.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistFinishing[i].toLowerCase());
          spkFinishing.add(filterByNameFinishing.length.toString());
        }
        //! end of divisi finishing

        //* filter by Stell1
        //? filter by divisi
        var filterByDivisiStell1 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataStell1 = filterByDivisiStell1.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameStell1; i++) {
          var filterByNameStell1 = allDataStell1.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistStell1[i].toLowerCase());
          spkStell1.add(filterByNameStell1.length.toString());
        }
        //! end of divisi Stell1
      } else {
        //! jika siklus di pilih
        //? filter by month
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //* start divisi finishing
        //? filter by divisi Finishing
        var filterByDivisiFinishing = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing' &&
            element.keterangan!.toLowerCase() != 'orul');

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameFinishing; i++) {
          var filterByName = filterByDivisiFinishing.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistFinishing[i].toLowerCase());
          spkFinishing.add(filterByName.length.toString());
        }
        //! end divisi finishing

        //* start divisi Stell1
        //? filter by divisi Stell1
        var filterByDivisiStell1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1' &&
            element.keterangan!.toLowerCase() != 'orul');

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameStell1; i++) {
          var filterByName = filterByDivisiStell1.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistStell1[i].toLowerCase());
          spkStell1.add(filterByName.length.toString());
        }
        //! end divisi Stell1
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getPoint(month) async {
    pointFinishing = [];
    pointStell1 = [];
    jatahSusutFinishing = [];
    jatahSusutStell1 = [];

    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data point');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //! jika suklis tidak di pilih

        //? divisi finishing
        //? filter by divisi
        var filterByDivisiFinishing = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing');
        var allDataFinishing = filterByDivisiFinishing.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameFinishing; i++) {
          double apiPointFinishing = 0;
          double apiJatahSusutFinishing = 0;
          var filterByNameFinishing = allDataFinishing
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistFinishing[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameFinishing.length; j++) {
            apiPointFinishing += filterByNameFinishing[j].point!;
            apiJatahSusutFinishing += filterByNameFinishing[j].jatahSusut!;
          }
          if (artistFinishing[i].toString().toLowerCase() == 'asrori' ||
              artistFinishing[i].toString().toLowerCase() == 'carkiyad' ||
              artistFinishing[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistFinishing[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistFinishing[i].toString().toLowerCase() == 'khoerul anwar') {
            pointFinishing.add(apiPointFinishing.toStringAsFixed(2));
            jatahSusutFinishing.add((apiJatahSusutFinishing + 0.075));
          } else {
            pointFinishing.add(apiPointFinishing.toStringAsFixed(2));
            jatahSusutFinishing.add(apiJatahSusutFinishing);
          }
        }
        //! end divisi finishing

        //? divisi Stell1
        //? filter by divisi
        var filterByDivisiStell1 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1');
        var allDataStell1 = filterByDivisiStell1.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameStell1; i++) {
          double apiPointStell1 = 0;
          double apiJatahSusutStell1 = 0;
          var filterByNameStell1 = allDataStell1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell1.length; j++) {
            apiPointStell1 += filterByNameStell1[j].point!;
            apiJatahSusutStell1 += filterByNameStell1[j].jatahSusut!;
          }
          if (artistStell1[i].toString().toLowerCase() == 'asrori' ||
              artistStell1[i].toString().toLowerCase() == 'carkiyad' ||
              artistStell1[i].toString().toLowerCase() == 'encup supriatna' ||
              artistStell1[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistStell1[i].toString().toLowerCase() == 'khoerul anwar') {
            pointStell1.add(apiPointStell1.toStringAsFixed(2));
            jatahSusutStell1.add((apiJatahSusutStell1 + 0.075));
          } else {
            pointStell1.add(apiPointStell1.toStringAsFixed(2));
            jatahSusutStell1.add(apiJatahSusutStell1);
          }
        }
        //! end divisi Stell1
      } else {
        //! jika siklus di pilih
        //? filter by month
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //? divisi finishing
        //? filter by divisi Finishing
        var filterByDivisiFinishing = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing');

        //? ambil data point by nama
        for (var i = 0; i < qtyNameFinishing; i++) {
          double apiPointFinishing = 0;
          double apiJatahSusutFinishing = 0;
          var filterByNameFinishing = filterByDivisiFinishing
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistFinishing[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameFinishing.length; j++) {
            apiPointFinishing += filterByNameFinishing[j].point!;
            apiJatahSusutFinishing += filterByNameFinishing[j].jatahSusut!;
          }
          if (artistFinishing[i].toString().toLowerCase() == 'asrori' ||
              artistFinishing[i].toString().toLowerCase() == 'carkiyad' ||
              artistFinishing[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistFinishing[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistFinishing[i].toString().toLowerCase() == 'khoerul anwar') {
            pointFinishing.add(apiPointFinishing.toStringAsFixed(2));
            jatahSusutFinishing.add((apiJatahSusutFinishing + 0.075));
          } else {
            pointFinishing.add(apiPointFinishing.toStringAsFixed(2));
            jatahSusutFinishing.add(apiJatahSusutFinishing);
          }
        }
        //! end divisi finishing

        //? divisi Stell1
        var filterByDivisiStell1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1');
        //? ambil data point by nama
        for (var i = 0; i < qtyNameStell1; i++) {
          double apiPointStell1 = 0;
          double apiJatahSusutStell1 = 0;
          var filterByNameStell1 = filterByDivisiStell1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell1.length; j++) {
            apiPointStell1 += filterByNameStell1[j].point!;
            apiJatahSusutStell1 += filterByNameStell1[j].jatahSusut!;
          }
          if (artistStell1[i].toString().toLowerCase() == 'asrori' ||
              artistStell1[i].toString().toLowerCase() == 'carkiyad' ||
              artistStell1[i].toString().toLowerCase() == 'encup supriatna' ||
              artistStell1[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistStell1[i].toString().toLowerCase() == 'khoerul anwar') {
            pointStell1.add(apiPointStell1.toStringAsFixed(2));
            jatahSusutStell1.add((apiJatahSusutStell1 + 0.075));
          } else {
            pointStell1.add(apiPointStell1.toStringAsFixed(2));
            jatahSusutStell1.add(apiJatahSusutStell1);
          }
        }
        //! end divisi Stell1
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getBeratAsal(month) async {
    //? variable finishing
    beratAsalFinishing = [];
    beratAkhirFinishing = [];
    beratAsalSBFinishing = [];
    beratAkhirSBFinishing = [];
    susutFinishing = [];
    resultFinishing = [];
    //!end variable finishing

    //? variable Stell1
    beratAsalStell1 = [];
    beratAkhirStell1 = [];
    beratAsalSBStell1 = [];
    beratAkhirSBStell1 = [];
    susutStell1 = [];
    resultStell1 = [];
    //!end variable Stell1

    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data beratAsal dan akhir');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

      if (month.toString().toLowerCase() == "all") {
        //! fungsi add debet dan kredit
        //? filter by divisi
        var filterByDivisiFinishing = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing');
        var allDataFinishing = filterByDivisiFinishing.toList();
        for (var i = 0; i < qtyNameFinishing; i++) {
          double apiBeratAsalFinishing = 0;
          double apiBeratAkirFinishing = 0;
          var filterByNameFinishing = allDataFinishing
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistFinishing[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameFinishing.length; j++) {
            apiBeratAsalFinishing += filterByNameFinishing[j].debet!;
            apiBeratAkirFinishing += filterByNameFinishing[j].kredit!;
          }
          beratAsalFinishing.add(apiBeratAsalFinishing);
          beratAkhirFinishing.add(apiBeratAkirFinishing);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBFinishing = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBFinishing.statusCode == 200) {
          print('get data beratAsal dan akhir SB');
          List jsonResponseSBFinishing = json.decode(responseSBFinishing.body);
          var allDataSBFinishing = jsonResponseSBFinishing
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBFinishing = allDataSBFinishing.where((element) =>
              element.divisi.toString().toLowerCase() == 'finishing');
          allDataSBFinishing = filterByDivisiSBFinishing.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameFinishing; i++) {
              double apiBeratAsalSBFinishing = 0;
              double apiBeratAkirSBFinishing = 0;
              var filterByNameSBFinishing = allDataSBFinishing
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistFinishing[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBFinishing.length; j++) {
                apiBeratAsalSBFinishing +=
                    filterByNameSBFinishing[j].debetKawat!;
                apiBeratAkirSBFinishing +=
                    filterByNameSBFinishing[j].kreditKawat!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sb!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sprue!;
              }
              beratAsalSBFinishing.add(apiBeratAsalSBFinishing);
              beratAkhirSBFinishing.add(apiBeratAkirSBFinishing);
            }
          } else {
            for (var i = 0; i < qtyNameFinishing; i++) {
              double apiBeratAsalSBFinishing = 0;
              double apiBeratAkirSBFinishing = 0;
              //? filter by month
              var filterBySiklusSBFinishing = allDataSBFinishing.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBFinishing = filterBySiklusSBFinishing.toList();
              var filterByNameSBFinishing = allDataSBFinishing
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistFinishing[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBFinishing.length; j++) {
                apiBeratAsalSBFinishing +=
                    filterByNameSBFinishing[j].debetKawat!;
                apiBeratAkirSBFinishing +=
                    filterByNameSBFinishing[j].kreditKawat!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sb!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sprue!;
              }
              beratAsalSBFinishing.add(apiBeratAsalSBFinishing);
              beratAkhirSBFinishing.add(apiBeratAkirSBFinishing);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalFinishing.length; i++) {
          beratAsalFinishing[i] += beratAsalSBFinishing[i];
          beratAkhirFinishing[i] += beratAkhirSBFinishing[i];
          susutFinishing.add(beratAsalFinishing[i] - beratAkhirFinishing[i]);
          resultFinishing.add(susutFinishing[i] - jatahSusutFinishing[i]);
        }
        //? end penggabungan
        //! end divisi finishing

        //? filter by divisi stell1
        var filterByDivisiStell1 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1');
        var allDataStell1 = filterByDivisiStell1.toList();
        for (var i = 0; i < qtyNameStell1; i++) {
          double apiBeratAsalStell1 = 0;
          double apiBeratAkirStell1 = 0;
          var filterByNameStell1 = allDataStell1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell1.length; j++) {
            apiBeratAsalStell1 += filterByNameStell1[j].debet!;
            apiBeratAkirStell1 += filterByNameStell1[j].kredit!;
          }
          beratAsalStell1.add(apiBeratAsalStell1);
          beratAkhirStell1.add(apiBeratAkirStell1);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBStell1 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBStell1.statusCode == 200) {
          print('get data beratAsal dan akhir SB');
          List jsonResponseSBStell1 = json.decode(responseSBStell1.body);
          var allDataSBStell1 = jsonResponseSBStell1
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBStell1 = allDataSBStell1.where((element) =>
              element.divisi.toString().toLowerCase() == 'stell rangka 1');
          allDataSBStell1 = filterByDivisiSBStell1.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameStell1; i++) {
              double apiBeratAsalSBStell1 = 0;
              double apiBeratAkirSBStell1 = 0;
              var filterByNameSBStell1 = allDataSBStell1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell1[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBStell1.length; j++) {
                apiBeratAsalSBStell1 += filterByNameSBStell1[j].debetKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].kreditKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sb!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sprue!;
              }
              beratAsalSBStell1.add(apiBeratAsalSBStell1);
              beratAkhirSBStell1.add(apiBeratAkirSBStell1);
            }
          } else {
            for (var i = 0; i < qtyNameStell1; i++) {
              double apiBeratAsalSBStell1 = 0;
              double apiBeratAkirSBStell1 = 0;
              //? filter by month
              var filterBySiklusSBStell1 = allDataSBStell1.where((element) =>
                  element.bulan.toString().toLowerCase() ==
                  month.toLowerCase());
              allDataSBStell1 = filterBySiklusSBStell1.toList();
              var filterByNameSBStell1 = allDataSBStell1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell1[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBStell1.length; j++) {
                apiBeratAsalSBStell1 += filterByNameSBStell1[j].debetKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].kreditKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sb!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sprue!;
              }
              beratAsalSBStell1.add(apiBeratAsalSBStell1);
              beratAkhirSBStell1.add(apiBeratAkirSBStell1);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalStell1.length; i++) {
          beratAsalStell1[i] += beratAsalSBStell1[i];
          beratAkhirStell1[i] += beratAkhirSBStell1[i];
          susutStell1.add(beratAsalStell1[i] - beratAkhirStell1[i]);
          resultStell1.add(susutStell1[i] - jatahSusutStell1[i]);
        }
        //? end penggabungan
        //! end divisi Stell1
      } else {
        //! jika siklus di pilih
        //? filter by month
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //? divisi finishing
        var allDataFinishing = filterBySiklus.toList();
        //! fungsi add debet dan kredit
        for (var i = 0; i < qtyNameFinishing; i++) {
          double apiBeratAsalFinishing = 0;
          double apiBeratAkirFinishing = 0;
          var filterByNameFinishing = allDataFinishing
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistFinishing[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameFinishing.length; j++) {
            apiBeratAsalFinishing += filterByNameFinishing[j].debet!;
            apiBeratAkirFinishing += filterByNameFinishing[j].kredit!;
          }
          beratAsalFinishing.add(apiBeratAsalFinishing);
          beratAkhirFinishing.add(apiBeratAkirFinishing);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBFinishing = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBFinishing.statusCode == 200) {
          print('get data beratAsal dan akhir SB');
          List jsonResponseSBFinishing = json.decode(responseSBFinishing.body);
          var allDataSBFinishing = jsonResponseSBFinishing
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBFinishing = allDataSBFinishing.where((element) =>
              element.divisi.toString().toLowerCase() == 'finishing');
          allDataSBFinishing = filterByDivisiSBFinishing.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameFinishing; i++) {
              double apiBeratAsalSBFinishing = 0;
              double apiBeratAkirSBFinishing = 0;
              var filterByNameSBFinishing = allDataSBFinishing
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistFinishing[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBFinishing.length; j++) {
                apiBeratAsalSBFinishing +=
                    filterByNameSBFinishing[j].debetKawat!;
                apiBeratAkirSBFinishing +=
                    filterByNameSBFinishing[j].kreditKawat!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sb!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sprue!;
              }
              beratAsalSBFinishing.add(apiBeratAsalSBFinishing);
              beratAkhirSBFinishing.add(apiBeratAkirSBFinishing);
            }
          } else {
            for (var i = 0; i < qtyNameFinishing; i++) {
              double apiBeratAsalSBFinishing = 0;
              double apiBeratAkirSBFinishing = 0;
              //? filter by month
              var filterBySiklusSBFinishing = allDataSBFinishing.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBFinishing = filterBySiklusSBFinishing.toList();
              var filterByNameSBFinishing = allDataSBFinishing
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistFinishing[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBFinishing.length; j++) {
                apiBeratAsalSBFinishing +=
                    filterByNameSBFinishing[j].debetKawat!;
                apiBeratAkirSBFinishing +=
                    filterByNameSBFinishing[j].kreditKawat!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sb!;
                apiBeratAkirSBFinishing += filterByNameSBFinishing[j].sprue!;
              }
              beratAsalSBFinishing.add(apiBeratAsalSBFinishing);
              beratAkhirSBFinishing.add(apiBeratAkirSBFinishing);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalFinishing.length; i++) {
          beratAsalFinishing[i] += beratAsalSBFinishing[i];
          beratAkhirFinishing[i] += beratAkhirSBFinishing[i];
          susutFinishing.add(beratAsalFinishing[i] - beratAkhirFinishing[i]);
          resultFinishing.add(susutFinishing[i] - jatahSusutFinishing[i]);
        }
        //? end penggabungan
        //! end divisi finishing

        //? divisi Stell1
        var filterByDivisiStell1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 1');
        var allDataStell1 = filterByDivisiStell1.toList();

        //! fungsi add debet dan kredit
        for (var i = 0; i < qtyNameStell1; i++) {
          double apiBeratAsalStell1 = 0;
          double apiBeratAkirStell1 = 0;
          var filterByNameStell1 = allDataStell1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell1.length; j++) {
            apiBeratAsalStell1 += filterByNameStell1[j].debet!;
            apiBeratAkirStell1 += filterByNameStell1[j].kredit!;
          }
          beratAsalStell1.add(apiBeratAsalStell1);
          beratAkhirStell1.add(apiBeratAkirStell1);
          print('berat asal : ${beratAsalStell1[0]}'); //! done
          print('berat akhir : ${beratAkhirStell1[0]}'); //! done
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBStell1 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBStell1.statusCode == 200) {
          print('get data beratAsal dan akhir SB');
          List jsonResponseSBStell1 = json.decode(responseSBStell1.body);
          var allDataSBStell1 = jsonResponseSBStell1
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBStell1 = allDataSBStell1.where((element) =>
              element.divisi.toString().toLowerCase() == 'stell rangka 1');
          allDataSBStell1 = filterByDivisiSBStell1.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameStell1; i++) {
              double apiBeratAsalSBStell1 = 0;
              double apiBeratAkirSBStell1 = 0;
              var filterByNameSBStell1 = allDataSBStell1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell1[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBStell1.length; j++) {
                apiBeratAsalSBStell1 += filterByNameSBStell1[j].debetKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].kreditKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sb!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sprue!;
              }
              beratAsalSBStell1.add(apiBeratAsalSBStell1);
              beratAkhirSBStell1.add(apiBeratAkirSBStell1);
              print('berat asal sb : ${beratAsalSBStell1[0]}'); //! done
              print('berat akhir sb : ${beratAkhirSBStell1[0]}'); //! done
            }
          } else {
            for (var i = 0; i < qtyNameStell1; i++) {
              double apiBeratAsalSBStell1 = 0;
              double apiBeratAkirSBStell1 = 0;
              //? filter by month
              var filterBySiklusSBStell1 = allDataSBStell1.where((element) =>
                  element.bulan.toString().toLowerCase() ==
                  month.toLowerCase());
              allDataSBStell1 = filterBySiklusSBStell1.toList();
              var filterByNameSBStell1 = allDataSBStell1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell1[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBStell1.length; j++) {
                apiBeratAsalSBStell1 += filterByNameSBStell1[j].debetKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].kreditKawat!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sb!;
                apiBeratAkirSBStell1 += filterByNameSBStell1[j].sprue!;
              }
              beratAsalSBStell1.add(apiBeratAsalSBStell1);
              beratAkhirSBStell1.add(apiBeratAkirSBStell1);
              print('berat asal sb : ${beratAsalSBStell1[0]}'); //! done
              print('berat akhir sb : ${beratAkhirSBStell1[0]}'); //! done
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalStell1.length; i++) {
          beratAsalStell1[i] += beratAsalSBStell1[i];
          beratAkhirStell1[i] += beratAkhirSBStell1[i];
          susutStell1.add(beratAsalStell1[i] - beratAkhirStell1[i]);
          resultStell1.add(susutStell1[i] - jatahSusutStell1[i]);
        }
        //? end penggabungan
        //! end divisi Stell1
      }

      //* save result finishing dikdik dan deko
      for (var i = 0; i < qtyNameFinishing; i++) {
        if (artistFinishing[i].toString().toLowerCase() == 'dikdik maulana') {
          resultFinishingDikdikMaulana = resultFinishing[i];
        }
        if (artistFinishing[i].toString().toLowerCase() == 'muhammad deeko') {
          resultFinishingMumahhadDeeko = resultFinishing[i];
        }
      }
      print(
          'dikdik : $resultFinishingDikdikMaulana\n m deko : $resultFinishingMumahhadDeeko');
      //! end save dikdik dand eko

      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  DataTable _dataTableStell1() {
    return DataTable(
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.blue),
        columnSpacing: 1,
        headingRowHeight: 50,
        dataRowMaxHeight: 50,
        columns: _createColumnsStell1(),
        rows: _createRowsStell1());
  }

  List<DataColumn> _createColumnsStell1() {
    return [
      DataColumn(label: Text('NAMA')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('SPK')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('TOTAL POINT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BERAT ASAL')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BERAT AKHIR')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('SUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('JATAH SUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('RESULT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('KETERANGAN')),
    ];
  }

//! data table finishing
  DataTable _dataTable(divisi) {
    return DataTable(
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.blue),
        columnSpacing: 1,
        headingRowHeight: 50,
        dataRowMaxHeight: 50,
        columns: _createColumnsFinishing(),
        rows: divisi == 'finishing'
            ? _createRowsFinishing()
            : _createRowsPoleshing1());
  }

  List<DataColumn> _createColumnsFinishing() {
    return [
      DataColumn(label: Text('NAMA')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('SPK')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('TOTAL POINT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BERAT ASAL')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('BERAT AKHIR')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('SUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('JATAH SUSUT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('RESULT')),
      DataColumn(label: _verticalDivider),
      DataColumn(label: Text('KETERANGAN')),
    ];
  }

  List<DataRow> _createRowsFinishing() {
    return [
      for (var i = 0; i < qtyNameFinishing; i++)
        DataRow(cells: [
          DataCell(Text(artistFinishing[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkFinishing[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointFinishing[i])),
          DataCell(_verticalDivider),
          DataCell(Text(beratAsalFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell((artistFinishing[i].toString().toLowerCase() ==
                      'muhammad deeko' ||
                  artistFinishing[i].toString().toLowerCase() ==
                      'dikdik maulana')
              ? Text(jatahSusutFinishing[i].toStringAsFixed(2))
              : Text(susutFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text((resultFinishing[i] * -1).toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultFinishing[i] * -1) < 0
                ? Text(
                    '(POTONGAN)',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '(BONUS)',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
          ),
        ]),
    ];
  }

  //! end data table finishing
  //? start row Poleshing1
  List<DataRow> _createRowsPoleshing1() {
    return [
      for (var i = 0; i < qtyNamePoleshing1; i++)
        DataRow(cells: [
          DataCell(Text(artistPoleshing1[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkFinishing[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointFinishing[i])),
          DataCell(_verticalDivider),
          DataCell(Text(beratAsalFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(susutFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(resultFinishing[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultFinishing[i] * -1) < 0
                ? Text(
                    '(POTONGAN)',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '(BONUS)',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
          ),
        ]),
    ];
  }
  //! end data table Poleshing1

  //? start row Stell1
  List<DataRow> _createRowsStell1() {
    return [
      for (var i = 0; i < qtyNameStell1; i++)
        DataRow(cells: [
          DataCell(Text(artistStell1[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkStell1[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointStell1[i])),
          DataCell(_verticalDivider),
          DataCell(artistStell1[i].toString().toLowerCase() == 'muhammad deeko'
              ? Text((beratAsalStell1[i] - (resultFinishingMumahhadDeeko! * -1))
                  .toStringAsFixed(2))
              : Text((beratAsalStell1[i] - (resultFinishingDikdikMaulana! * -1))
                  .toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirStell1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(susutStell1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutStell1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(resultStell1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultStell1[i] * -1) < 0
                ? Text(
                    '(POTONGAN)',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '(BONUS)',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
          ),
        ]),
    ];
  }
  //! end data table Poleshing1

  @override
  Widget build(BuildContext context) {
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

    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: Scaffold(

            // drawer: Drawer1(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              leadingWidth: 320,
              //change siklus
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Siklus Saat Ini : $nowSiklus",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                Text(
                  version,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            body: dashboardProduksi()));
  }

  //! dashboard produksi
  dashboardProduksi() {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width * 0.3,
            child: DropdownSearch<String>(
              items: const [
                "JANUARI",
                "FEBRUARI",
                "MARET",
                "APRIL",
                "MEI",
                "JUNI",
                "JULI",
                "AGUSTUS",
                "SEPTEMBER",
                "OKTOBER",
                "NOVEMBER",
                "DESEMBER"
              ],
              onChanged: (item) {
                setState(() {
                  siklus.text = item!;
                  siklusDesigner = siklus.text.toString();
                  _getDataFinishing(siklusDesigner);
                });
              },
              popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                showSelectedItems: true,
                showSearchBox: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                textAlign: TextAlign.center,
                baseStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                dropdownSearchDecoration: InputDecoration(
                    labelText: "Pilih Siklus",
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              ),
            ),
          ),
        ),
        isLoading == true
            ? Center(
                child: Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                height: 90,
                child: Lottie.asset("loadingJSON/loadingV1.json"),
              ))
            : Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            //? BARIS 1
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: [
                                        Text(
                                          'FINISHING',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        _dataTable('finishing'),
                                      ],
                                    ))),
                            SizedBox(height: 20),

                            // //? BARIS 2
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: [
                                        Text(
                                          'POLESHING 1',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        _dataTable('poleshing1'),
                                      ],
                                    ))),
                            SizedBox(height: 20),

                            //? BARIS 3
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: const [
                                        Text(
                                          'POLESHING 2',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))),
                            SizedBox(height: 20),

                            // //? BARIS 4
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: const [
                                        Text(
                                          'POLESHING 2 REPARASI',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))),
                            SizedBox(height: 20),

                            // //? BARIS 5
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: [
                                        Text(
                                          'STELL RANGKA 1',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        _dataTableStell1(),
                                      ],
                                    ))),
                            SizedBox(height: 20),

                            // //? BARIS 6
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: const [
                                        Text(
                                          'STELL 2',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))),
                            SizedBox(height: 20),

                            // //? BARIS 7
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: const [
                                        Text(
                                          'STELL 2 REP',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))),
                            SizedBox(height: 20),
                            // //? BARIS 8
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: const [
                                        Text(
                                          'CHROME',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))),
                            SizedBox(height: 20),
                            // //? BARIS 9
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    color: Colors.grey.shade200,
                                    child: Column(
                                      children: const [
                                        Text(
                                          'CHROME REPARASI',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))),
                          ]),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  postSiklus() async {
    Map<String, String> body = {
      'id': '1',
      'siklus': addSiklus.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addSiklus}'),
        body: body);
    print(response.body);
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
      //nama
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.nama)),
      ),
      DataCell(_verticalDivider),
      //tanggal in
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(DateFormat('dd/MMMM/yyyy hh:mm:ss')
                .format(DateTime.parse(data.tanggalIn.toString())))),
      ),
      DataCell(_verticalDivider),
      //tanggal out
      DataCell(
        Padding(padding: const EdgeInsets.all(0), child: Text(data.tanggalOut)),
      ),
      DataCell(_verticalDivider),
      //kode produksi
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0), child: Text(data.kodeProduksi)),
      ),
      DataCell(_verticalDivider),
      //debet
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.debet.toString())),
      ),
      DataCell(_verticalDivider),

      //kredit
      DataCell(
        Padding(
            padding: const EdgeInsets.all(0),
            child: Text(data.kredit.toString())),
      ),
      // sharedPreferences!.getString('level') != '1'
      //     ? const DataCell(SizedBox())
      //     : DataCell(_verticalDivider),
      // sharedPreferences!.getString('level') != '1'
      //     ? const DataCell(SizedBox())
      //     :
      //     //Aksi
      //     DataCell(Builder(builder: (context) {
      //         return sharedPreferences!.getString('level') != '1'
      //             ? const Row()
      //             : Row(
      //                 children: [
      //                   IconButton(
      //                     onPressed: () {
      //                       showDialog<String>(
      //                         context: context,
      //                         builder: (BuildContext context) => AlertDialog(
      //                           title: const Text(
      //                             'Perhatian',
      //                             textAlign: TextAlign.center,
      //                             style: TextStyle(
      //                                 color: Colors.black,
      //                                 fontWeight: FontWeight.bold),
      //                           ),
      //                           content: Row(
      //                             children: [
      //                               const Text(
      //                                 'Apakah anda yakin ingin menghapus data batu ',
      //                               ),
      //                               Text(
      //                                 '${data.size}  ?',
      //                                 style: const TextStyle(
      //                                     fontWeight: FontWeight.bold,
      //                                     color: Colors.black),
      //                               ),
      //                             ],
      //                           ),
      //                           actions: <Widget>[
      //                             TextButton(
      //                               onPressed: () => Navigator.pop(
      //                                 context,
      //                                 'Batal',
      //                               ),
      //                               child: const Text('Batal'),
      //                             ),
      //                             TextButton(
      //                               onPressed: () async {
      //                                 var id = data.id.toString();
      //                                 Map<String, String> body = {'id': id};
      //                                 final response = await http.post(
      //                                     Uri.parse(ApiConstants.baseUrl +
      //                                         ApiConstants.postDeleteBatuById),
      //                                     body: body);
      //                                 print(response.body);

      //                                 Navigator.push(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                         builder: (c) =>
      //                                             const MainViewBatu()));
      //                                 showDialog<String>(
      //                                     context: context,
      //                                     builder: (BuildContext context) =>
      //                                         const AlertDialog(
      //                                           title: Text(
      //                                             'Hapus Batu Berhasil',
      //                                           ),
      //                                         ));
      //                               },
      //                               child: const Text(
      //                                 'Hapus',
      //                                 style: TextStyle(color: Colors.red),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       );
      //                     },
      //                     icon: const Icon(
      //                       Icons.delete,
      //                       color: Colors.red,
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 25),
      //                     child: IconButton(
      //                       onPressed: () {
      //                         showDialog(
      //                             context: context,
      //                             builder: (BuildContext context) {
      //                               final _formKey = GlobalKey<FormState>();
      //                               TextEditingController lot =
      //                                   TextEditingController();
      //                               TextEditingController size =
      //                                   TextEditingController();
      //                               TextEditingController parcel =
      //                                   TextEditingController();
      //                               TextEditingController qty =
      //                                   TextEditingController();
      //                               String id;

      //                               id = data.id.toString();
      //                               lot.text = data.lot;
      //                               size.text = data.size;
      //                               parcel.text = data.parcel;
      //                               qty.text = data.qty.toString();
      //                               RoundedLoadingButtonController
      //                                   btnController =
      //                                   RoundedLoadingButtonController();
      //                               return AlertDialog(
      //                                 content: Stack(
      //                                   clipBehavior: Clip.none,
      //                                   children: <Widget>[
      //                                     Positioned(
      //                                       right: -47.0,
      //                                       top: -47.0,
      //                                       child: InkResponse(
      //                                         onTap: () {
      //                                           Navigator.of(context).pop();
      //                                         },
      //                                         child: const CircleAvatar(
      //                                           backgroundColor: Colors.red,
      //                                           child: Icon(Icons.close),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     Form(
      //                                       key: _formKey,
      //                                       child: Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           //lot
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: lot,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Lot",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }
      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           //size
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: size,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Ukuran",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }
      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: parcel,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Parcel",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }
      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: TextFormField(
      //                                               style: const TextStyle(
      //                                                   fontSize: 14,
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold),
      //                                               textInputAction:
      //                                                   TextInputAction.next,
      //                                               controller: qty,
      //                                               decoration: InputDecoration(
      //                                                 // hintText: "example: Cahaya Sanivokasi",
      //                                                 labelText: "Qty",
      //                                                 border:
      //                                                     OutlineInputBorder(
      //                                                         borderRadius:
      //                                                             BorderRadius
      //                                                                 .circular(
      //                                                                     5.0)),
      //                                               ),
      //                                               validator: (value) {
      //                                                 if (value!.isEmpty) {
      //                                                   return 'Wajib diisi *';
      //                                                 }

      //                                                 return null;
      //                                               },
      //                                             ),
      //                                           ),
      //                                           Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(8.0),
      //                                             child: SizedBox(
      //                                               width: 250,
      //                                               child: CustomLoadingButton(
      //                                                   controller:
      //                                                       btnController,
      //                                                   child: const Text(
      //                                                       "Update"),
      //                                                   onPressed: () async {
      //                                                     if (_formKey
      //                                                         .currentState!
      //                                                         .validate()) {
      //                                                       _formKey
      //                                                           .currentState!
      //                                                           .save();
      //                                                       Future.delayed(
      //                                                               const Duration(
      //                                                                   seconds:
      //                                                                       2))
      //                                                           .then(
      //                                                               (value) async {
      //                                                         btnController
      //                                                             .success();
      //                                                         Map<String,
      //                                                                 dynamic>
      //                                                             body = {
      //                                                           'id': id,
      //                                                           'lot': lot.text,
      //                                                           'size':
      //                                                               size.text,
      //                                                           'parcel':
      //                                                               parcel.text,
      //                                                           'qty': qty.text,
      //                                                         };
      //                                                         final response = await http.post(
      //                                                             Uri.parse(ApiConstants
      //                                                                     .baseUrl +
      //                                                                 ApiConstants
      //                                                                     .postUpdateListDataBatu),
      //                                                             body: body);
      //                                                         print(response
      //                                                             .body);
      //                                                         Future.delayed(
      //                                                                 const Duration(
      //                                                                     seconds:
      //                                                                         1))
      //                                                             .then(
      //                                                                 (value) {
      //                                                           btnController
      //                                                               .reset(); //reset
      //                                                           showDialog<
      //                                                                   String>(
      //                                                               context:
      //                                                                   context,
      //                                                               builder: (BuildContext
      //                                                                       context) =>
      //                                                                   const AlertDialog(
      //                                                                     title:
      //                                                                         Text(
      //                                                                       'Update Berhasil',
      //                                                                     ),
      //                                                                   ));
      //                                                         });
      //                                                         Navigator.push(
      //                                                             context,
      //                                                             MaterialPageRoute(
      //                                                                 builder:
      //                                                                     (c) =>
      //                                                                         const MainViewBatu()));
      //                                                       });
      //                                                     } else {
      //                                                       btnController
      //                                                           .error();
      //                                                       Future.delayed(
      //                                                               const Duration(
      //                                                                   seconds:
      //                                                                       1))
      //                                                           .then((value) {
      //                                                         btnController
      //                                                             .reset(); //reset
      //                                                       });
      //                                                     }
      //                                                   }),
      //                                             ),
      //                                           )
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               );
      //                             });
      //                       },
      //                       icon: const Icon(
      //                         Icons.edit,
      //                         color: Colors.green,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               );
      //       }))
    ]);
  }

  updateSiklusDesigner(id, siklus) async {
    Map<String, String> body = {
      'id': id.toString(),
      'siklus': siklus.toString(),
    };
    final response = await http.post(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.updateSiklusdesigner}'),
        body: body);
    print(response.body);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

//! tidak terpoakai

//   _getSpk(month, name) async {
//     totalPointAsrori = 0;
//     totalPointCarkiyad = 0;
//     totalPointEncupSupriatna = 0;
//     totalPointMuhammadAbdulKodir = 0;
//     final response = await http
//         .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

//     if (response.statusCode == 200) {
//       print('get data produksi berhasil');
//       List jsonResponse = json.decode(response.body);

//       var allData =
//           jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

//       if (month.toString().toLowerCase() == "all") {
//         //? asrori
//         var filterByAsrori = allData.where((element) =>
//             element.nama.toString().toLowerCase() == 'asrori' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkAsrori = filterByAsrori.toList().length;
//         //? carkiyad
//         var filterByCarkiyad = allData.where((element) =>
//             element.nama.toString().toLowerCase() == 'carkiyad' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkCarkiyad = filterByCarkiyad.toList().length;
//         //? encup
//         var filterByEncupSupriatna = allData.where((element) =>
//             element.nama.toString().toLowerCase() == 'encup supriatna' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkEncupSupriatna = filterByEncupSupriatna.toList().length;
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = allData.where((element) =>
//             element.nama.toString().toLowerCase() == 'muhammad abdul kodir' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkMuhammadAbdulKodir = filterByMuhammadAbdulKodir.toList().length;
//       } else {
//         var filterBySiklus = allData.where((element) =>
//             element.bulan.toString().toLowerCase() ==
//             month.toString().toLowerCase());
//         //? asrori
//         var filterByAsrori = filterBySiklus.where((element) =>
//             element.nama.toString().toLowerCase() == 'asrori' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkAsrori = filterByAsrori.toList().length;
//         //? carkiyad
//         var filterByCarkiyad = filterBySiklus.where((element) =>
//             element.nama.toString().toLowerCase() == 'carkiyad' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkCarkiyad = filterByCarkiyad.toList().length;
//         //? encup
//         var filterByEncupSupriatna = filterBySiklus.where((element) =>
//             element.nama.toString().toLowerCase() == 'encup supriatna' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkEncupSupriatna = filterByEncupSupriatna.toList().length;
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = filterBySiklus.where((element) =>
//             element.nama.toString().toLowerCase() == 'muhammad abdul kodir' &&
//             element.keterangan.toString().toLowerCase() != 'orul');
//         spkMuhammadAbdulKodir = filterByMuhammadAbdulKodir.toList().length;
//       }
//       setState(() {
//         print('refresh state get data produksi');
//         isLoading = true;
//       });
//       return allData;
//     } else {
//       print('get data produksi gagal');
//       throw Exception('Unexpected error occured!');
//     }
//   }

//   _getPoint(month, name) async {
//     final response = await http
//         .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

//     if (response.statusCode == 200) {
//       print('get data produksi berhasil');
//       List jsonResponse = json.decode(response.body);

//       var allData =
//           jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

//       if (month.toString().toLowerCase() == "all") {
//         //? asrori
//         var filterByAsrori = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'asrori' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByAsrori.length; i++) {
//           if (filterByAsrori[i].point! > 0) {
//             totalPointAsrori += filterByAsrori[i].point!;
//           }
//         }
//         //? carkiyad
//         var filterByCarkiyad = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'carkiyad' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByCarkiyad.length; i++) {
//           if (filterByCarkiyad[i].point! > 0) {
//             totalPointCarkiyad += filterByCarkiyad[i].point!;
//           }
//         }
//         //? encup
//         var filterByEncupSupriatna = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByEncupSupriatna.length; i++) {
//           if (filterByEncupSupriatna[i].point! > 0) {
//             totalPointEncupSupriatna += filterByEncupSupriatna[i].point!;
//           }
//         }
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() ==
//                     'muhammad abdul kodir' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
//           if (filterByMuhammadAbdulKodir[i].point! > 0) {
//             totalPointMuhammadAbdulKodir +=
//                 filterByMuhammadAbdulKodir[i].point!;
//           }
//         }
//       } else {
//         var filterBySiklus = allData.where((element) =>
//             element.bulan.toString().toLowerCase() ==
//             month.toString().toLowerCase());
//         //? asrori
//         var filterByAsrori = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'asrori' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByAsrori.length; i++) {
//           if (filterByAsrori[i].point! > 0) {
//             totalPointAsrori += filterByAsrori[i].point!;
//           }
//         }
//         //? carkiyad
//         var filterByCarkiyad = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'carkiyad' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByCarkiyad.length; i++) {
//           if (filterByCarkiyad[i].point! > 0) {
//             totalPointCarkiyad += filterByCarkiyad[i].point!;
//           }
//         }
//         //? encup
//         var filterByEncupSupriatna = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByEncupSupriatna.length; i++) {
//           if (filterByEncupSupriatna[i].point! > 0) {
//             totalPointEncupSupriatna += filterByEncupSupriatna[i].point!;
//           }
//         }
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
//           if (filterByMuhammadAbdulKodir[i].point! > 0) {
//             totalPointMuhammadAbdulKodir +=
//                 filterByMuhammadAbdulKodir[i].point!;
//           }
//         }
//       }

//       setState(() {
//         print('refresh state get data produksi point');
//         isLoading = true;
//       });
//       return allData;
//     } else {
//       print('get data produksi gagal');
//       throw Exception('Unexpected error occured!');
//     }
//   }

//   _getBeratAsal(month, name) async {
//     beratAsalAsrori = 0;
//     beratAsalCarkiyad = 0;
//     beratAsalEncupSupriatna = 0;
//     beratAsalMuhammadAbdulKodir = 0;

//     final response = await http
//         .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

//     if (response.statusCode == 200) {
//       print('get data produksi berhasil');
//       List jsonResponse = json.decode(response.body);

//       var allData =
//           jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

//       if (month.toString().toLowerCase() == "all") {
//         //? asrori
//         var filterByAsrori = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'asrori' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByAsrori.length; i++) {
//           if (filterByAsrori[i].debet! > 0) {
//             beratAsalAsrori += filterByAsrori[i].debet!;
//           }
//         }
//         //? carkiyad
//         var filterByCarkiyad = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'carkiyad' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByCarkiyad.length; i++) {
//           if (filterByCarkiyad[i].debet! > 0) {
//             beratAsalCarkiyad += filterByCarkiyad[i].debet!;
//           }
//         }
//         //? encup
//         var filterByEncupSupriatna = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByEncupSupriatna.length; i++) {
//           if (filterByEncupSupriatna[i].debet! > 0) {
//             beratAsalEncupSupriatna += filterByEncupSupriatna[i].debet!;
//           }
//         }
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() ==
//                     'muhammad abdul kodir' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
//           if (filterByMuhammadAbdulKodir[i].debet! > 0) {
//             beratAsalMuhammadAbdulKodir += filterByMuhammadAbdulKodir[i].debet!;
//           }
//         }
//         //! tambahkan point kawat
//         final response2 = await http
//             .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));

//         if (response2.statusCode == 200) {
//           print('get data produksi SB berhasil');
//           List jsonResponse = json.decode(response2.body);

//           var allDataSB = jsonResponse
//               .map((data) => ProduksiSBModel.fromJson(data))
//               .toList();
//           //? asrori
//           var filterByAsroriSB = allDataSB
//               .where((element) =>
//                   element.nama.toString().toLowerCase() == 'asrori' &&
//                   element.divisi.toString().toLowerCase() == 'finishing')
//               .toList();
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].debetKawat! > 0) {
//               beratAsalAsrori += filterByAsroriSB[i].debetKawat!;
//             }
//           }
//         } else {
//           print('get data produksi SB gagal');
//           throw Exception('Unexpected error occured!');
//         }
//       } else {
//         var filterBySiklus = allData.where((element) =>
//             element.bulan.toString().toLowerCase() ==
//             month.toString().toLowerCase());
//         //? asrori
//         var filterByAsrori = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'asrori' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByAsrori.length; i++) {
//           if (filterByAsrori[i].debet! > 0) {
//             beratAsalAsrori += filterByAsrori[i].debet!;
//           }
//         }
//         //? carkiyad
//         var filterByCarkiyad = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'carkiyad' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByCarkiyad.length; i++) {
//           if (filterByCarkiyad[i].debet! > 0) {
//             beratAsalCarkiyad += filterByCarkiyad[i].debet!;
//           }
//         }
//         //? encup
//         var filterByEncupSupriatna = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByEncupSupriatna.length; i++) {
//           if (filterByEncupSupriatna[i].debet! > 0) {
//             beratAsalEncupSupriatna += filterByEncupSupriatna[i].debet!;
//           }
//         }
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
//           if (filterByMuhammadAbdulKodir[i].debet! > 0) {
//             beratAsalMuhammadAbdulKodir += filterByMuhammadAbdulKodir[i].debet!;
//           }
//         }
// //! tambahkan point kawat
//         final response2 = await http
//             .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));

//         if (response2.statusCode == 200) {
//           print('get data produksi SB berhasil');
//           List jsonResponse = json.decode(response2.body);
//           var allDataSB = jsonResponse
//               .map((data) => ProduksiSBModel.fromJson(data))
//               .toList();
//           var filterBySiklusSB = allDataSB.where((element) =>
//               element.bulan.toString().toLowerCase() ==
//               month.toString().toLowerCase());
//           //? asrori
//           var filterByAsroriSB = filterBySiklusSB
//               .where((element) =>
//                   element.nama.toString().toLowerCase() == 'asrori' &&
//                   element.divisi.toString().toLowerCase() == 'finishing')
//               .toList();
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].debetKawat! > 0) {
//               print('get data produksi SB berhasil xxx');

//               beratAsalAsrori += filterByAsroriSB[i].debetKawat!;
//             }
//           }
//         } else {
//           print('get data produksi SB gagal');
//           throw Exception('Unexpected error occured!');
//         }
//       }
//       setState(() {
//         print('refresh state get data produksi point');
//         isLoading = true;
//       });
//       return allData;
//     } else {
//       print('get data produksi gagal');
//       throw Exception('Unexpected error occured!');
//     }
//   }

//   _getSusut(month, name) async {
//     beratAkhirAsrori = 0;
//     beratAkhirCakiyad = 0;
//     beratAkhirEncupSupriatna = 0;
//     beratAkhirMuhammadAbdulKodir = 0;

//     final response = await http
//         .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

//     if (response.statusCode == 200) {
//       print('get data produksi berhasil');
//       List jsonResponse = json.decode(response.body);

//       var allData =
//           jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

//       if (month.toString().toLowerCase() == "all") {
//         //? asrori
//         var filterByAsrori = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'asrori' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByAsrori.length; i++) {
//           if (filterByAsrori[i].kredit! > 0) {
//             beratAkhirAsrori += filterByAsrori[i].kredit!;
//           }
//         }
//         //? carkiyad
//         var filterByCarkiyad = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'carkiyad' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByCarkiyad.length; i++) {
//           if (filterByCarkiyad[i].debet! > 0) {
//             beratAsalCarkiyad += filterByCarkiyad[i].debet!;
//           }
//         }
//         //? encup
//         var filterByEncupSupriatna = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByEncupSupriatna.length; i++) {
//           if (filterByEncupSupriatna[i].debet! > 0) {
//             beratAsalEncupSupriatna += filterByEncupSupriatna[i].debet!;
//           }
//         }
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() ==
//                     'muhammad abdul kodir' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
//           if (filterByMuhammadAbdulKodir[i].debet! > 0) {
//             beratAsalMuhammadAbdulKodir += filterByMuhammadAbdulKodir[i].debet!;
//           }
//         }
//         //! tambahkan sb
//         final response2 = await http
//             .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));

//         if (response2.statusCode == 200) {
//           print('get data produksi SB berhasil');
//           List jsonResponse = json.decode(response2.body);

//           var allDataSB = jsonResponse
//               .map((data) => ProduksiSBModel.fromJson(data))
//               .toList();
//           //? asrori
//           var filterByAsroriSB = allDataSB
//               .where((element) =>
//                   element.nama.toString().toLowerCase() == 'asrori' &&
//                   element.divisi.toString().toLowerCase() == 'finishing')
//               .toList();
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].kreditKawat! > 0) {
//               beratAkhirAsrori += filterByAsroriSB[i].kreditKawat!;
//             }
//           }
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].sb! > 0) {
//               beratAkhirAsrori += filterByAsroriSB[i].sb!;
//             }
//           }
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].sprue! > 0) {
//               beratAkhirAsrori += filterByAsroriSB[i].sprue!;
//             }
//           }
//         } else {
//           print('get data produksi SB gagal');
//           throw Exception('Unexpected error occured!');
//         }
//       } else {
//         var filterBySiklus = allData.where((element) =>
//             element.bulan.toString().toLowerCase() ==
//             month.toString().toLowerCase());
//         //? asrori
//         var filterByAsrori = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'asrori' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByAsrori.length; i++) {
//           if (filterByAsrori[i].debet! > 0) {
//             beratAsalAsrori += filterByAsrori[i].debet!;
//           }
//         }
//         //? carkiyad
//         var filterByCarkiyad = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'carkiyad' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByCarkiyad.length; i++) {
//           if (filterByCarkiyad[i].debet! > 0) {
//             beratAsalCarkiyad += filterByCarkiyad[i].debet!;
//           }
//         }
//         //? encup
//         var filterByEncupSupriatna = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByEncupSupriatna.length; i++) {
//           if (filterByEncupSupriatna[i].debet! > 0) {
//             beratAsalEncupSupriatna += filterByEncupSupriatna[i].debet!;
//           }
//         }
//         //? m abdul kodir
//         var filterByMuhammadAbdulKodir = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() == 'encup supriatna' &&
//                 element.keterangan.toString().toLowerCase() != 'orul')
//             .toList();
//         for (var i = 0; i < filterByMuhammadAbdulKodir.length; i++) {
//           if (filterByMuhammadAbdulKodir[i].debet! > 0) {
//             beratAsalMuhammadAbdulKodir += filterByMuhammadAbdulKodir[i].debet!;
//           }
//         }
//         //! tambahkan sb
//         final response2 = await http
//             .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));

//         if (response2.statusCode == 200) {
//           print('get data produksi SB berhasil');
//           List jsonResponse = json.decode(response2.body);

//           var allDataSB = jsonResponse
//               .map((data) => ProduksiSBModel.fromJson(data))
//               .toList();
//           //? asrori
//           var filterByAsroriSB = allDataSB
//               .where((element) =>
//                   element.nama.toString().toLowerCase() == 'asrori' &&
//                   element.divisi.toString().toLowerCase() == 'finishing')
//               .toList();
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].kreditKawat! > 0) {
//               beratAkhirAsrori += filterByAsroriSB[i].kreditKawat!;
//             }
//           }
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].sb! > 0) {
//               beratAkhirAsrori += filterByAsroriSB[i].sb!;
//             }
//           }
//           for (var i = 0; i < filterByAsroriSB.length; i++) {
//             if (filterByAsroriSB[i].sprue! > 0) {
//               beratAkhirAsrori += filterByAsroriSB[i].sprue!;
//             }
//           }
//         } else {
//           print('get data produksi SB gagal');
//           throw Exception('Unexpected error occured!');
//         }
//       }
//       setState(() {
//         print('refresh state get data produksi point');
//         isLoading = true;
//       });
//       susutAsrori = beratAsalAsrori - beratAkhirAsrori;
//       return allData;
//     } else {
//       print('get data produksi gagal');
//       throw Exception('Unexpected error occured!');
//     }
//   }

//   _getBeratAsalByName(month, name) async {
//     double sumDebet = 0.0;

//     final response = await http
//         .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

//     if (response.statusCode == 200) {
//       print('get data produksi berhasil');
//       List jsonResponse = json.decode(response.body);

//       var allData =
//           jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

//       if (month.toString().toLowerCase() == "all") {
//         var filterByName = allData
//             .where((element) =>
//                 element.nama.toString().toLowerCase() ==
//                 name.toString().toLowerCase())
//             .toList();
//         for (var i = 0; i < filterByName.length; i++) {
//           if (filterByName[i].debet! > 0) {
//             sumDebet += filterByName[i].debet!;
//           }
//         }
//         // beratAsal = filterByName.toList().length;
//       } else {
//         var filterBySiklus = allData.where((element) =>
//             element.bulan.toString().toLowerCase() ==
//             month.toString().toLowerCase());
//         var filterByName = filterBySiklus
//             .where((element) =>
//                 element.nama.toString().toLowerCase() ==
//                 name.toString().toLowerCase())
//             .toList();
//         for (var i = 0; i < filterByName.length; i++) {
//           if (filterByName[i].debet! > 0) {
//             sumDebet += filterByName[i].debet!;
//           }
//         }
//       }
//       return sumDebet.toStringAsFixed(2);
//     } else {
//       print('get data produksi gagal');
//       throw Exception('Unexpected error occured!');
//     }
//   }

// _getSpkByName(month, name) async {
//   var spk;
//   final response = await http
//       .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));

//   if (response.statusCode == 200) {
//     print('get data produksi berhasil');
//     List jsonResponse = json.decode(response.body);

//     var allData =
//         jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();

//     if (month.toString().toLowerCase() == "all") {
//       var filterByName = allData.where((element) =>
//           element.nama.toString().toLowerCase() ==
//           name.toString().toLowerCase());
//       spk = filterByName.toList().length;
//     } else {
//       var filterBySiklus = allData.where((element) =>
//           element.bulan.toString().toLowerCase() ==
//           month.toString().toLowerCase());
//       var filterByName = filterBySiklus.where(
//           (element) => element.nama.toString().toLowerCase() == "asrori");
//       spk = filterByName.toList().length;
//     }

//     return spk;
//   } else {
//     print('get data produksi gagal');
//     throw Exception('Unexpected error occured!');
//   }
// }

// DataRow(cells: [
//   DataCell(Text('Carkiyad')),
//   DataCell(_verticalDivider),
//   //! versi get dahulu lalu simpan
//   DataCell(Text('$spkCarkiyad')),
//   //!versi langsung get
//   // DataCell(FutureBuilder(
//   //     future: _getSpkByName("all", "Carkiyad"),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.hasError) {
//   //         return const Text('Database Off');
//   //       }
//   //       if (snapshot.hasData) {
//   //         return Text(snapshot.data!.toString());
//   //       } else {
//   //         return const CircularProgressIndicator();
//   //       }
//   //     })),
//   DataCell(_verticalDivider),
//   DataCell(Text(totalPointCarkiyad.toStringAsFixed(2))),
//   DataCell(_verticalDivider),
//   DataCell(Text(beratAsalCarkiyad.toStringAsFixed(2))),
//   //! versi langsung get
//   // DataCell(FutureBuilder(
//   //     future: _getBeratAsalByName("all", "Carkiyad"),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.hasError) {
//   //         return const Text('Database Off');
//   //       }
//   //       if (snapshot.hasData) {
//   //         return Text(snapshot.data!.toString());
//   //       } else {
//   //         return const CircularProgressIndicator();
//   //       }
//   //     })),
//   DataCell(_verticalDivider),
//   DataCell(Text('1.82')),
//   DataCell(_verticalDivider),
//   DataCell(Text('1.60')),
//   DataCell(_verticalDivider),
//   DataCell(Text('13.31')),
//   DataCell(_verticalDivider),
//   DataCell(
//     Text('-0.22'),
//   ),
//   DataCell(_verticalDivider),
//   DataCell(
//     Text(
//       '(POTONGAN)',
//       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//     ),
//   ),
// ]),
// DataRow(cells: [
//   DataCell(Text('Encup Supriatna')),
//   DataCell(_verticalDivider),
//   //! versi get dahulu lalu simpan
//   DataCell(Text('$spkEncupSupriatna')),
//   //!versi langsung get
//   // DataCell(FutureBuilder(
//   //     future: _getSpkByName("all", "encup supriatna"),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.hasError) {
//   //         return const Text('Database Off');
//   //       }
//   //       if (snapshot.hasData) {
//   //         return Text(snapshot.data!.toString());
//   //       } else {
//   //         return const CircularProgressIndicator();
//   //       }
//   //     })),
//   DataCell(_verticalDivider),
//   DataCell(Text(totalPointEncupSupriatna.toStringAsFixed(2))),
//   DataCell(_verticalDivider),
//   DataCell(Text(beratAsalEncupSupriatna.toStringAsFixed(2))),
//   //! versi langsung get
//   // DataCell(FutureBuilder(
//   //     future: _getBeratAsalByName("all", "encup supriatna"),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.hasError) {
//   //         return const Text('Database Off');
//   //       }
//   //       if (snapshot.hasData) {
//   //         return Text(snapshot.data!.toString());
//   //       } else {
//   //         return const CircularProgressIndicator();
//   //       }
//   //     })),
//   DataCell(_verticalDivider),
//   DataCell(Text('1.82')),
//   DataCell(_verticalDivider),
//   DataCell(Text('1.60')),
//   DataCell(_verticalDivider),
//   DataCell(Text('13.31')),
//   DataCell(_verticalDivider),
//   DataCell(
//     Text('1.22'),
//   ),
//   DataCell(_verticalDivider),
//   DataCell(
//     Text(
//       '(BONUS)',
//       style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//     ),
//   ),
// ]),
// DataRow(cells: [
//   DataCell(Text('Muhammad Abdul Kodir')),
//   DataCell(_verticalDivider),
//   //! versi get dahulu lalu simpan
//   DataCell(Text('$spkMuhammadAbdulKodir')),
//   //!versi langsung get
//   // DataCell(FutureBuilder(
//   //     future: _getSpkByName("all", "Muhammad Abdul Kodir"),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.hasError) {
//   //         return const Text('Database Off');
//   //       }
//   //       if (snapshot.hasData) {
//   //         return Text(snapshot.data!.toString());
//   //       } else {
//   //         return const CircularProgressIndicator();
//   //       }
//   //     })),
//   DataCell(_verticalDivider),
//   DataCell(Text(totalPointMuhammadAbdulKodir.toStringAsFixed(2))),
//   DataCell(_verticalDivider),
//   DataCell(Text(beratAsalMuhammadAbdulKodir.toStringAsFixed(2))),
//   //! versi langsung get
//   // DataCell(FutureBuilder(
//   //     future: _getBeratAsalByName("all", "Muhammad Abdul Kodir"),
//   //     builder: (context, snapshot) {
//   //       if (snapshot.hasError) {
//   //         return const Text('Database Off');
//   //       }
//   //       if (snapshot.hasData) {
//   //         return Text(snapshot.data!.toString());
//   //       } else {
//   //         return const CircularProgressIndicator();
//   //       }
//   //     })),

//   DataCell(_verticalDivider),
//   DataCell(Text('1.82')),
//   DataCell(_verticalDivider),
//   DataCell(Text('1.60')),
//   DataCell(_verticalDivider),
//   DataCell(Text('13.31')),
//   DataCell(_verticalDivider),
//   DataCell(
//     Text('5.22'),
//   ),
//   DataCell(_verticalDivider),
//   DataCell(
//     Text(
//       '(BONUS)',
//       style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//     ),
//   ),
// ]),
