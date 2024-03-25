// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_final_fields, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
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
  double? bonusStell2DikdikMaulana = 0;
  double? bonusStell2RepDikdikMaulana = 0;
  double? susutStell2DikdikMaulana = 0;
  double? susutStell2RepDikdikMaulana = 0;
  double? resultFinishingMuhammadDeeko = 0;
  double? bonusStell2MuhammadDeeko = 0;
  double? bonusStell2RepMuhammadDeeko = 0;
  double? susutStell2MuhammadDeeko = 0;
  double? susutStell2RepMuhammadDeeko = 0;

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

  //? variable Poleshing2
  List artistPoleshing2 = [];
  List spkPoleshing2 = [];
  List pointPoleshing2 = [];
  List beratAsalPoleshing2 = [];
  List beratAkhirPoleshing2 = [];
  List beratAsalSBPoleshing2 = [];
  List beratAkhirSBPoleshing2 = [];
  List susutPoleshing2 = [];
  List jatahSusutPoleshing2 = [];
  List resultPoleshing2 = [];
  int qtyNamePoleshing2 = 0;
  //! end variable Poleshing2

  //? variable Poleshing2Rep
  List artistPoleshing2Rep = [];
  List spkPoleshing2Rep = [];
  List pointPoleshing2Rep = [];
  List beratAsalPoleshing2Rep = [];
  List beratAkhirPoleshing2Rep = [];
  List beratAsalSBPoleshing2Rep = [];
  List beratAkhirSBPoleshing2Rep = [];
  List susutPoleshing2Rep = [];
  List jatahSusutPoleshing2Rep = [];
  List resultPoleshing2Rep = [];
  int qtyNamePoleshing2Rep = 0;
  //! end variable Poleshing2Rep

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

  //? variable Stell2
  List artistStell2 = [];
  List spkStell2 = [];
  List pointStell2 = [];
  List beratAsalStell2 = [];
  List beratAkhirStell2 = [];
  List beratAsalSBStell2 = [];
  List beratAkhirSBStell2 = [];
  List susutStell2 = [];
  List jatahSusutStell2 = [];
  List resultStell2 = [];
  int qtyNameStell2 = 0;
  //! end variable Stell2

  //? variable Stell2Rep
  List artistStell2Rep = [];
  List spkStell2Rep = [];
  List pointStell2Rep = [];
  List beratAsalStell2Rep = [];
  List beratAkhirStell2Rep = [];
  List beratAsalSBStell2Rep = [];
  List beratAkhirSBStell2Rep = [];
  List susutStell2Rep = [];
  List jatahSusutStell2Rep = [];
  List resultStell2Rep = [];
  int qtyNameStell2Rep = 0;
  //! end variable Stell2Rep

  //? variable Chrome
  List artistChrome = [];
  List spkChrome = [];
  List pointChrome = [];
  List beratAsalChrome = [];
  List beratAkhirChrome = [];
  List beratAsalSBChrome = [];
  List beratAkhirSBChrome = [];
  List susutChrome = [];
  List jatahSusutChrome = [];
  List resultChrome = [];
  int qtyNameChrome = 0;
  //! end variable Chrome

  //? variable ChromeRep
  List artistChromeRep = [];
  List spkChromeRep = [];
  List pointChromeRep = [];
  List beratAsalChromeRep = [];
  List beratAkhirChromeRep = [];
  List beratAsalSBChromeRep = [];
  List beratAkhirSBChromeRep = [];
  List susutChromeRep = [];
  List jatahSusutChromeRep = [];
  List resultChromeRep = [];
  int qtyNameChromeRep = 0;
  //! end variable ChromeRep

  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    var now = DateTime.now();
    String month = DateFormat('MMMM', 'id').format(now);

    nowSiklus = month;
    // _getDataAll('all');
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

// fungsi remove duplicate object
  List<ProduksiModel> removeDuplicatesKode(List<ProduksiModel> items) {
    List<ProduksiModel> uniqueItems = []; // uniqueList
    var uniqueNames = items
        .map((e) => e.kodeProduksi)
        .toSet(); //list if UniqueID to remove duplicates
    for (var e in uniqueNames) {
      uniqueItems.add(items.firstWhere((i) => i.kodeProduksi == e));
    } // populate uniqueItems with equivalent original Batch items
    return uniqueItems; //send back the unique items list
  }

  void _getDataAll(month) async {
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
    artistPoleshing2 = [];
    artistStell2 = [];
    artistPoleshing2Rep = [];
    artistStell2Rep = [];
    artistChrome = [];
    artistChromeRep = [];
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksi));
    if (response.statusCode == 200) {
      print('get data nama');
      List jsonResponse = json.decode(response.body);
      var allData =
          jsonResponse.map((data) => ProduksiModel.fromJson(data)).toList();
      // if (month.toString().toLowerCase() == "all") {

      //   //* function Finishing
      //   //? filter by divisi Finishing
      //   var filterByDivisiFinishing = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'finishing');
      //   var allDataFinishing = filterByDivisiFinishing.toList();
      //   //! jika suklis tidak di pilih
      //   allDataFinishing = removeDuplicates(allDataFinishing);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataFinishing.length; i++) {
      //     artistFinishing.add(allDataFinishing[i].nama);
      //   }
      //   artistFinishing.sort((a, b) => a.compareTo(b));

      //   qtyNameFinishing = artistFinishing.length;

      //   //* function Poleshing1
      //   //? filter by divisi Poleshing1
      //   var filterByDivisiPoleshing1 = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'poleshing 1');
      //   var allDataPoleshing1 = filterByDivisiPoleshing1.toList();
      //   allDataPoleshing1 = removeDuplicates(allDataPoleshing1);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataPoleshing1.length; i++) {
      //     artistPoleshing1.add(allDataPoleshing1[i].nama);
      //   }
      //   qtyNamePoleshing1 = artistPoleshing1.length;
      //   //! end function Poleshing1

      //   //* function Poleshing2
      //   //? filter by divisi Poleshing2
      //   var filterByDivisiPoleshing2 = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'poleshing 2');
      //   var allDataPoleshing2 = filterByDivisiPoleshing2.toList();
      //   allDataPoleshing2 = removeDuplicates(allDataPoleshing2);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataPoleshing2.length; i++) {
      //     artistPoleshing2.add(allDataPoleshing2[i].nama);
      //   }
      //   qtyNamePoleshing2 = artistPoleshing2.length;
      //   //! end function Poleshing2

      //   //* function Poleshing2Rep
      //   //? filter by divisi Poleshing2Rep
      //   var filterByDivisiPoleshing2Rep = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
      //   var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();
      //   allDataPoleshing2Rep = removeDuplicates(allDataPoleshing2Rep);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataPoleshing2Rep.length; i++) {
      //     artistPoleshing2Rep.add(allDataPoleshing2Rep[i].nama);
      //   }
      //   qtyNamePoleshing2Rep = artistPoleshing2Rep.length;
      //   //! end function Poleshing2Rep

      //   //* function Stell1
      //   //? filter by divisi Stell1
      //   var filterByDivisiStell1 = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'stell rangka 1');
      //   var allDataStell1 = filterByDivisiStell1.toList();
      //   allDataStell1 = removeDuplicates(allDataStell1);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataStell1.length; i++) {
      //     artistStell1.add(allDataStell1[i].nama);
      //   }
      //   qtyNameStell1 = artistStell1.length;
      //   //! end function Stell1

      //   //* function Stell2
      //   //? filter by divisi Stell2
      //   var filterByDivisiStell2 = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'stell rangka 2');
      //   var allDataStell2 = filterByDivisiStell2.toList();
      //   allDataStell2 = removeDuplicates(allDataStell2);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataStell2.length; i++) {
      //     artistStell2.add(allDataStell2[i].nama);
      //   }
      //   qtyNameStell2 = artistStell2.length;
      //   //! end function Stell2

      //   //* function Stell2Rep
      //   //? filter by divisi Stell2Rep
      //   var filterByDivisiStell2Rep = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
      //   var allDataStell2Rep = filterByDivisiStell2Rep.toList();
      //   allDataStell2Rep = removeDuplicates(allDataStell2Rep);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataStell2Rep.length; i++) {
      //     artistStell2Rep.add(allDataStell2Rep[i].nama);
      //   }
      //   qtyNameStell2Rep = artistStell2Rep.length;
      //   //! end function Stell2Rep

      //   //* function Chrome
      //   //? filter by divisi Chrome
      //   var filterByDivisiChrome = allData.where(
      //       (element) => element.divisi.toString().toLowerCase() == 'chrome');
      //   var allDataChrome = filterByDivisiChrome.toList();
      //   allDataChrome = removeDuplicates(allDataChrome);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataChrome.length; i++) {
      //     artistChrome.add(allDataChrome[i].nama);
      //   }
      //   artistChrome.removeWhere((element) => element == '');
      //   qtyNameChrome = artistChrome.length;
      //   //! end function Chrome

      //   //* function ChromeRep
      //   //? filter by divisi ChromeRep
      //   var filterByDivisiChromeRep = allData.where((element) =>
      //       element.divisi.toString().toLowerCase() == 'chrome rep');
      //   var allDataChromeRep = filterByDivisiChromeRep.toList();
      //   allDataChromeRep = removeDuplicates(allDataChromeRep);
      //   //? ambil data nama
      //   for (var i = 0; i < allDataChromeRep.length; i++) {
      //     artistChromeRep.add(allDataChromeRep[i].nama);
      //   }
      //   artistChromeRep.removeWhere((element) => element == '');
      //   qtyNameChromeRep = artistChromeRep.length;
      //   //! end function ChromeRep
      // } else {

      //! jika siklus di pilih
      var filterBySiklus = allData.where((element) =>
          element.bulan.toString().toLowerCase() == month.toLowerCase());

      //* function Finishing
      //? filter by divisi Finishing
      var filterByDivisiFinishing = filterBySiklus.where(
          (element) => element.divisi.toString().toLowerCase() == 'finishing');
      var allDataFinishing = filterByDivisiFinishing.toList();
      //! jika suklis tidak di pilih
      allDataFinishing = removeDuplicates(allDataFinishing);
      //? ambil data nama
      for (var i = 0; i < allDataFinishing.length; i++) {
        artistFinishing.add(allDataFinishing[i].nama);
      }
      artistFinishing.sort((a, b) => a.compareTo(b));
      qtyNameFinishing = artistFinishing.length;

      //* function Poleshing1
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

      //* function Poleshing2
      //? filter by divisi Poleshing2
      var filterByDivisiPoleshing2 = filterBySiklus.where((element) =>
          element.divisi.toString().toLowerCase() == 'poleshing 2');
      var allDataPoleshing2 = filterByDivisiPoleshing2.toList();
      allDataPoleshing2 = removeDuplicates(allDataPoleshing2);
      //? ambil data nama
      for (var i = 0; i < allDataPoleshing2.length; i++) {
        artistPoleshing2.add(allDataPoleshing2[i].nama);
      }
      qtyNamePoleshing2 = artistPoleshing2.length;
      //! end function Poleshing2

      //* function Poleshing2Rep
      //? filter by divisi Poleshing2Rep
      var filterByDivisiPoleshing2Rep = filterBySiklus.where((element) =>
          element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
      var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();
      allDataPoleshing2Rep = removeDuplicates(allDataPoleshing2Rep);
      //? ambil data nama
      for (var i = 0; i < allDataPoleshing2Rep.length; i++) {
        artistPoleshing2Rep.add(allDataPoleshing2Rep[i].nama);
      }
      qtyNamePoleshing2Rep = artistPoleshing2Rep.length;
      //! end function Poleshing2Rep

      //* function Stell1
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

      //* function Stell2
      //? filter by divisi Stell2
      var filterByDivisiStell2 = filterBySiklus.where((element) =>
          element.divisi.toString().toLowerCase() == 'stell rangka 2');
      var allDataStell2 = filterByDivisiStell2.toList();
      allDataStell2 = removeDuplicates(allDataStell2);
      //? ambil data nama
      for (var i = 0; i < allDataStell2.length; i++) {
        artistStell2.add(allDataStell2[i].nama);
      }
      qtyNameStell2 = artistStell2.length;
      //! end function Stell2

      //* function Stell2Rep
      //? filter by divisi Stell2Rep
      var filterByDivisiStell2Rep = filterBySiklus.where((element) =>
          element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
      var allDataStell2Rep = filterByDivisiStell2Rep.toList();
      allDataStell2Rep = removeDuplicates(allDataStell2Rep);
      //? ambil data nama
      for (var i = 0; i < allDataStell2Rep.length; i++) {
        artistStell2Rep.add(allDataStell2Rep[i].nama);
      }
      qtyNameStell2Rep = artistStell2Rep.length;
      //! end function Stell2Rep

      //* function Chrome
      //? filter by divisi Chrome
      var filterByDivisiChrome = filterBySiklus.where(
          (element) => element.divisi.toString().toLowerCase() == 'chrome');
      var allDataChrome = filterByDivisiChrome.toList();
      allDataChrome = removeDuplicates(allDataChrome);
      //? ambil data nama
      for (var i = 0; i < allDataChrome.length; i++) {
        artistChrome.add(allDataChrome[i].nama);
      }
      artistChrome.removeWhere((element) => element == '');
      qtyNameChrome = artistChrome.length;
      //! end function Chrome

      //* function ChromeRep
      //? filter by divisi ChromeRep
      var filterByDivisiChromeRep = filterBySiklus.where(
          (element) => element.divisi.toString().toLowerCase() == 'chrome rep');
      var allDataChromeRep = filterByDivisiChromeRep.toList();
      allDataChromeRep = removeDuplicates(allDataChromeRep);
      //? ambil data nama
      for (var i = 0; i < allDataChromeRep.length; i++) {
        artistChromeRep.add(allDataChromeRep[i].nama);
      }
      artistChromeRep.removeWhere((element) => element == '');
      qtyNameChromeRep = artistChromeRep.length;
      //! end function ChromeRep
      // }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getSpk(month) async {
    spkFinishing = [];
    spkPoleshing1 = [];
    spkStell1 = [];
    spkPoleshing2 = [];
    spkStell2 = [];
    spkPoleshing2Rep = [];
    spkStell2Rep = [];
    spkChrome = [];
    spkChromeRep = [];

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
            element.keterangan!.toLowerCase() != 'ke bulan depan' &&
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

        //* filter by Poleshing1
        //? filter by divisi
        var filterByDivisiPoleshing1 = allData.where((element) =>
            (element.divisi.toString().toLowerCase() == 'poleshing 1' &&
                element.keterangan!.toLowerCase() != 'orul'));
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNamePoleshing1; i++) {
          var filterByNamePoleshing1 = allDataPoleshing1.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistPoleshing1[i].toLowerCase());
          spkPoleshing1.add(filterByNamePoleshing1.length.toString());
        }
        //! end of divisi Poleshing1

        //* filter by Poleshing2
        //? filter by divisi
        var filterByDivisiPoleshing2 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2' &&
            element.keterangan!.toLowerCase() != 'orul' &&
            element.point! > 0);

        var allDataPoleshing2 = filterByDivisiPoleshing2.toList();
        for (var i = 0; i < qtyNamePoleshing2; i++) {
          var filterByNamePoleshing2 = allDataPoleshing2.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistPoleshing2[i].toLowerCase());
          spkPoleshing2.add(filterByNamePoleshing2.length.toString());
        }
        //! end of divisi Poleshing2

        //* filter by Poleshing2Rep
        //? filter by divisi
        var filterByDivisiPoleshing2Rep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2 rep' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
          var filterByNamePoleshing2Rep = allDataPoleshing2Rep.where(
              (element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2Rep[i].toLowerCase());
          spkPoleshing2Rep.add(filterByNamePoleshing2Rep.length.toString());
        }
        //! end of divisi Poleshing2Rep

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

        //* filter by Stell2
        //? filter by divisi
        var filterByDivisiStell2 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2' &&
            element.keterangan!.toLowerCase() != 'orul' &&
            element.point! > 0);
        var allDataStell2 = filterByDivisiStell2.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameStell2; i++) {
          var filterByNameStell2 = allDataStell2.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistStell2[i].toLowerCase());
          spkStell2.add(filterByNameStell2.length.toString());
        }
        //! end of divisi Stell2

        //* filter by Stell2Rep
        //? filter by divisi
        var filterByDivisiStell2Rep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2 rep' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataStell2Rep = filterByDivisiStell2Rep.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameStell2Rep; i++) {
          var filterByNameStell2Rep = allDataStell2Rep.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistStell2Rep[i].toLowerCase());
          spkStell2Rep.add(filterByNameStell2Rep.length.toString());
        }
        //! end of divisi Stell2Rep

//* filter by Chrome
        //? filter by divisi
        var filterByDivisiChrome = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'chrome' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataChrome = filterByDivisiChrome.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameChrome; i++) {
          var filterByNameChrome = allDataChrome.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistChrome[i].toLowerCase());
          spkChrome.add(filterByNameChrome.length.toString());
        }
        //! end of divisi Chrome

        //* filter by ChromeRep
        //? filter by divisi
        var filterByDivisiChromeRep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'chrome rep' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataChromeRep = filterByDivisiChromeRep.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameChromeRep; i++) {
          var filterByNameChromeRep = allDataChromeRep.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistChromeRep[i].toLowerCase());
          spkChromeRep.add(filterByNameChromeRep.length.toString());
        }
        //! end of divisi ChromeRep
      } else {
        //! jika siklus di pilih
        //? filter by month
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //* filter by finishing
        //? filter by divisi
        var filterByDivisiFinishing = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'finishing' &&
            (element.keterangan!.toLowerCase() != 'orul' ||
                element.keterangan!.toLowerCase() != 'ke bulan depan'));

        var allDataFinishing = filterByDivisiFinishing.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameFinishing; i++) {
          var filterByNameFinishing = allDataFinishing.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistFinishing[i].toLowerCase());
          spkFinishing.add(filterByNameFinishing.length.toString());
        }
        //! end of divisi finishing

        //* filter by Poleshing1
        //? filter by divisi
        var filterByDivisiPoleshing1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 1' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNamePoleshing1; i++) {
          var filterByNamePoleshing1 = allDataPoleshing1.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistPoleshing1[i].toLowerCase());
          spkPoleshing1.add(filterByNamePoleshing1.length.toString());
        }
        //! end of divisi Poleshing1

        //* filter by Poleshing2
        //? filter by divisi
        var filterByDivisiPoleshing2 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2' &&
            element.keterangan!.toLowerCase() != 'orul' &&
            element.point! > 0);
        var allDataPoleshing2 = filterByDivisiPoleshing2.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNamePoleshing2; i++) {
          var filterByNamePoleshing2 = allDataPoleshing2.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistPoleshing2[i].toLowerCase());
          spkPoleshing2.add(filterByNamePoleshing2.length.toString());
        }
        //! end of divisi Poleshing2

        //* filter by Poleshing2Rep
        //? filter by divisi
        var filterByDivisiPoleshing2Rep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2 rep' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
          var filterByNamePoleshing2Rep = allDataPoleshing2Rep.where(
              (element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2Rep[i].toLowerCase());
          spkPoleshing2Rep.add(filterByNamePoleshing2Rep.length.toString());
        }
        //! end of divisi Poleshing2Rep

        //* filter by Stell1
        //? filter by divisi
        var filterByDivisiStell1 = filterBySiklus.where((element) =>
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

        //* filter by Stell2
        //? filter by divisi
        var filterByDivisiStell2 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataStell2 = filterByDivisiStell2.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameStell2; i++) {
          var filterByNameStell2 = allDataStell2.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistStell2[i].toLowerCase());
          spkStell2.add(filterByNameStell2.length.toString());
        }
        //! end of divisi Stell2

        //* filter by Stell2Rep
        //? filter by divisi
        var filterByDivisiStell2Rep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2 rep' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataStell2Rep = filterByDivisiStell2Rep.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameStell2Rep; i++) {
          var filterByNameStell2Rep = allDataStell2Rep.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistStell2Rep[i].toLowerCase());
          spkStell2Rep.add(filterByNameStell2Rep.length.toString());
        }
        //! end of divisi Stell2Rep

//* filter by Chrome
        //? filter by divisi
        var filterByDivisiChrome = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'chrome' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataChrome = filterByDivisiChrome.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameChrome; i++) {
          var filterByNameChrome = allDataChrome.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistChrome[i].toLowerCase());
          spkChrome.add(filterByNameChrome.length.toString());
        }
        //! end of divisi Chrome

        //* filter by ChromeRep
        //? filter by divisi
        var filterByDivisiChromeRep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'chrome rep' &&
            element.keterangan!.toLowerCase() != 'orul');
        var allDataChromeRep = filterByDivisiChromeRep.toList();

        //? ambil data spk by nama
        for (var i = 0; i < qtyNameChromeRep; i++) {
          var filterByNameChromeRep = allDataChromeRep.where((element) =>
              element.nama.toString().toLowerCase() ==
              artistChromeRep[i].toLowerCase());
          spkChromeRep.add(filterByNameChromeRep.length.toString());
        }
        //! end of divisi ChromeRep
      }
      return allData;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getPoint(month) async {
    pointFinishing = [];
    jatahSusutFinishing = [];
    pointPoleshing1 = [];
    jatahSusutPoleshing1 = [];
    pointPoleshing2 = [];
    jatahSusutPoleshing2 = [];
    pointPoleshing2Rep = [];
    jatahSusutPoleshing2Rep = [];
    pointStell1 = [];
    jatahSusutStell1 = [];
    pointStell2 = [];
    jatahSusutStell2 = [];
    pointStell2Rep = [];
    jatahSusutStell2Rep = [];
    pointChrome = [];
    jatahSusutChrome = [];
    pointChromeRep = [];
    jatahSusutChromeRep = [];

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
            pointFinishing.add(apiPointFinishing);
            jatahSusutFinishing.add((apiJatahSusutFinishing + 0.075));
          } else {
            pointFinishing.add(apiPointFinishing);
            jatahSusutFinishing.add(apiJatahSusutFinishing);
          }
        }
        //! end divisi finishing

        //? divisi Poleshing2Rep
        //? filter by divisi
        var filterByDivisiPoleshing2Rep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
        var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
          double apiPointPoleshing2Rep = 0;
          double apiJatahSusutPoleshing2Rep = 0;
          var filterByNamePoleshing2Rep = allDataPoleshing2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2Rep.length; j++) {
            apiPointPoleshing2Rep += filterByNamePoleshing2Rep[j].point!;
            apiJatahSusutPoleshing2Rep +=
                filterByNamePoleshing2Rep[j].jatahSusut!;
          }
          if (artistPoleshing2Rep[i].toString().toLowerCase() == 'asrori' ||
              artistPoleshing2Rep[i].toString().toLowerCase() == 'carkiyad' ||
              artistPoleshing2Rep[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistPoleshing2Rep[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistPoleshing2Rep[i].toString().toLowerCase() ==
                  'khoerul anwar') {
            pointPoleshing2Rep.add(apiPointPoleshing2Rep.toStringAsFixed(2));
            jatahSusutPoleshing2Rep.add((apiJatahSusutPoleshing2Rep + 0.075));
          } else {
            pointPoleshing2Rep.add(apiPointPoleshing2Rep.toStringAsFixed(2));
            jatahSusutPoleshing2Rep.add(apiJatahSusutPoleshing2Rep);
          }
        }
        //! end divisi Poleshing2Rep

        //? divisi Poleshing1
        //? filter by divisi
        var filterByDivisiPoleshing1 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 1');
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNamePoleshing1; i++) {
          double apiPointPoleshing1 = 0;
          double apiJatahSusutPoleshing1 = 0;
          var filterByNamePoleshing1 = allDataPoleshing1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing1.length; j++) {
            apiPointPoleshing1 += filterByNamePoleshing1[j].point!;
            apiJatahSusutPoleshing1 += filterByNamePoleshing1[j].jatahSusut!;
          }
          if (artistPoleshing1[i].toString().toLowerCase() == 'asrori' ||
              artistPoleshing1[i].toString().toLowerCase() == 'carkiyad' ||
              artistPoleshing1[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistPoleshing1[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistPoleshing1[i].toString().toLowerCase() == 'khoerul anwar') {
            pointPoleshing1.add(apiPointPoleshing1.toStringAsFixed(2));
            jatahSusutPoleshing1.add((apiJatahSusutPoleshing1 + 0.075));
          } else {
            pointPoleshing1.add(apiPointPoleshing1.toStringAsFixed(2));
            jatahSusutPoleshing1.add(apiJatahSusutPoleshing1);
          }
        }
        //! end divisi Poleshing1

        //? divisi Poleshing2
        //? filter by divisi
        var filterByDivisiPoleshing2 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2');
        var allDataPoleshing2 = filterByDivisiPoleshing2.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNamePoleshing2; i++) {
          double apiPointPoleshing2 = 0;
          double apiJatahSusutPoleshing2 = 0;
          var filterByNamePoleshing2 = allDataPoleshing2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2.length; j++) {
            apiPointPoleshing2 += filterByNamePoleshing2[j].point!;
            apiJatahSusutPoleshing2 += filterByNamePoleshing2[j].jatahSusut!;
          }
          if (artistPoleshing2[i].toString().toLowerCase() == 'asrori' ||
              artistPoleshing2[i].toString().toLowerCase() == 'carkiyad' ||
              artistPoleshing2[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistPoleshing2[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistPoleshing2[i].toString().toLowerCase() == 'khoerul anwar') {
            pointPoleshing2.add(apiPointPoleshing2.toStringAsFixed(2));
            jatahSusutPoleshing2.add((apiJatahSusutPoleshing2 + 0.075));
          } else {
            pointPoleshing2.add(apiPointPoleshing2.toStringAsFixed(2));
            jatahSusutPoleshing2.add(apiJatahSusutPoleshing2);
          }
        }
        //! end divisi Poleshing2

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

        //? divisi Stell2
        //? filter by divisi
        var filterByDivisiStell2 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2');
        var allDataStell2 = filterByDivisiStell2.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameStell2; i++) {
          double apiPointStell2 = 0;
          double apiJatahSusutStell2 = 0;
          var filterByNameStell2 = allDataStell2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2.length; j++) {
            apiPointStell2 += filterByNameStell2[j].point!;
            apiJatahSusutStell2 += filterByNameStell2[j].jatahSusut!;
          }
          if (artistStell2[i].toString().toLowerCase() == 'asrori' ||
              artistStell2[i].toString().toLowerCase() == 'carkiyad' ||
              artistStell2[i].toString().toLowerCase() == 'encup supriatna' ||
              artistStell2[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistStell2[i].toString().toLowerCase() == 'khoerul anwar') {
            pointStell2.add(apiPointStell2.toStringAsFixed(2));
            jatahSusutStell2.add((apiJatahSusutStell2 + 0.075));
          } else {
            pointStell2.add(apiPointStell2.toStringAsFixed(2));
            jatahSusutStell2.add(apiJatahSusutStell2);
          }
        }
        //! end divisi Stell2

        //? divisi Stell2Rep
        //? filter by divisi
        var filterByDivisiStell2Rep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
        var allDataStell2Rep = filterByDivisiStell2Rep.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameStell2Rep; i++) {
          double apiPointStell2Rep = 0;
          double apiJatahSusutStell2Rep = 0;
          var filterByNameStell2Rep = allDataStell2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2Rep.length; j++) {
            apiPointStell2Rep += filterByNameStell2Rep[j].point!;
            apiJatahSusutStell2Rep += filterByNameStell2Rep[j].jatahSusut!;
          }
          if (artistStell2Rep[i].toString().toLowerCase() == 'asrori' ||
              artistStell2Rep[i].toString().toLowerCase() == 'carkiyad' ||
              artistStell2Rep[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistStell2Rep[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistStell2Rep[i].toString().toLowerCase() == 'khoerul anwar') {
            pointStell2Rep.add(apiPointStell2Rep.toStringAsFixed(2));
            jatahSusutStell2Rep.add((apiJatahSusutStell2Rep + 0.075));
          } else {
            pointStell2Rep.add(apiPointStell2Rep.toStringAsFixed(2));
            jatahSusutStell2Rep.add(apiJatahSusutStell2Rep);
          }
        }
        //! end divisi Stell2Rep

        //? divisi Chrome
        //? filter by divisi
        var filterByDivisiChrome = allData.where(
            (element) => element.divisi.toString().toLowerCase() == 'chrome');
        var allDataChrome = filterByDivisiChrome.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameChrome; i++) {
          double apiPointChrome = 0;
          double apiJatahSusutChrome = 0;
          var filterByNameChrome = allDataChrome
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistChrome[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameChrome.length; j++) {
            apiPointChrome += filterByNameChrome[j].point!;
            apiJatahSusutChrome += filterByNameChrome[j].jatahSusut!;
          }
          if (artistChrome[i].toString().toLowerCase() == 'asrori' ||
              artistChrome[i].toString().toLowerCase() == 'carkiyad' ||
              artistChrome[i].toString().toLowerCase() == 'encup supriatna' ||
              artistChrome[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistChrome[i].toString().toLowerCase() == 'khoerul anwar') {
            pointChrome.add(apiPointChrome.toStringAsFixed(2));
            jatahSusutChrome.add((apiJatahSusutChrome + 0.075));
          } else {
            pointChrome.add(apiPointChrome.toStringAsFixed(2));
            jatahSusutChrome.add(apiJatahSusutChrome);
          }
        }
        //! end divisi Chrome

        //? divisi ChromeRep
        //? filter by divisi
        var filterByDivisiChromeRep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'chrome rep');
        var allDataChromeRep = filterByDivisiChromeRep.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameChromeRep; i++) {
          double apiPointChromeRep = 0;
          double apiJatahSusutChromeRep = 0;
          var filterByNameChromeRep = allDataChromeRep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistChromeRep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameChromeRep.length; j++) {
            apiPointChromeRep += filterByNameChromeRep[j].point!;
            apiJatahSusutChromeRep += filterByNameChromeRep[j].jatahSusut!;
          }
          if (artistChromeRep[i].toString().toLowerCase() == 'asrori' ||
              artistChromeRep[i].toString().toLowerCase() == 'carkiyad' ||
              artistChromeRep[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistChromeRep[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistChromeRep[i].toString().toLowerCase() == 'khoerul anwar') {
            pointChromeRep.add(apiPointChromeRep.toStringAsFixed(2));
            jatahSusutChromeRep.add((apiJatahSusutChromeRep + 0.075));
          } else {
            pointChromeRep.add(apiPointChromeRep.toStringAsFixed(2));
            jatahSusutChromeRep.add(apiJatahSusutChromeRep);
          }
        }
        //! end divisi ChromeRep
      } else {
        //! jika siklus di pilih

        //? filter by month
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //? divisi finishing
        //? filter by divisi
        var filterByDivisiFinishing = filterBySiklus.where((element) =>
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
            pointFinishing.add(apiPointFinishing);
            jatahSusutFinishing.add((apiJatahSusutFinishing + 0.075));
          } else {
            pointFinishing.add(apiPointFinishing);
            jatahSusutFinishing.add(apiJatahSusutFinishing);
          }
        }
        //! end divisi finishing

        //? divisi Poleshing2Rep
        //? filter by divisi
        var filterByDivisiPoleshing2Rep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
        var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
          double apiPointPoleshing2Rep = 0;
          double apiJatahSusutPoleshing2Rep = 0;
          var filterByNamePoleshing2Rep = allDataPoleshing2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2Rep.length; j++) {
            apiPointPoleshing2Rep += filterByNamePoleshing2Rep[j].point!;
            apiJatahSusutPoleshing2Rep +=
                filterByNamePoleshing2Rep[j].jatahSusut!;
          }
          if (artistPoleshing2Rep[i].toString().toLowerCase() == 'asrori' ||
              artistPoleshing2Rep[i].toString().toLowerCase() == 'carkiyad' ||
              artistPoleshing2Rep[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistPoleshing2Rep[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistPoleshing2Rep[i].toString().toLowerCase() ==
                  'khoerul anwar') {
            pointPoleshing2Rep.add(apiPointPoleshing2Rep.toStringAsFixed(2));
            jatahSusutPoleshing2Rep.add((apiJatahSusutPoleshing2Rep + 0.075));
          } else {
            pointPoleshing2Rep.add(apiPointPoleshing2Rep.toStringAsFixed(2));
            jatahSusutPoleshing2Rep.add(apiJatahSusutPoleshing2Rep);
          }
        }
        //! end divisi Poleshing2Rep

        //? divisi Poleshing1
        //? filter by divisi
        var filterByDivisiPoleshing1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 1');
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNamePoleshing1; i++) {
          double apiPointPoleshing1 = 0;
          double apiJatahSusutPoleshing1 = 0;
          var filterByNamePoleshing1 = allDataPoleshing1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing1.length; j++) {
            apiPointPoleshing1 += filterByNamePoleshing1[j].point!;
            apiJatahSusutPoleshing1 += filterByNamePoleshing1[j].jatahSusut!;
          }
          if (artistPoleshing1[i].toString().toLowerCase() == 'asrori' ||
              artistPoleshing1[i].toString().toLowerCase() == 'carkiyad' ||
              artistPoleshing1[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistPoleshing1[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistPoleshing1[i].toString().toLowerCase() == 'khoerul anwar') {
            pointPoleshing1.add(apiPointPoleshing1.toStringAsFixed(2));
            jatahSusutPoleshing1.add((apiJatahSusutPoleshing1 + 0.075));
          } else {
            pointPoleshing1.add(apiPointPoleshing1.toStringAsFixed(2));
            jatahSusutPoleshing1.add(apiJatahSusutPoleshing1);
          }
        }
        //! end divisi Poleshing1

        //? divisi Poleshing2
        //? filter by divisi
        var filterByDivisiPoleshing2 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2');
        var allDataPoleshing2 = filterByDivisiPoleshing2.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNamePoleshing2; i++) {
          double apiPointPoleshing2 = 0;
          double apiJatahSusutPoleshing2 = 0;
          var filterByNamePoleshing2 = allDataPoleshing2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2.length; j++) {
            apiPointPoleshing2 += filterByNamePoleshing2[j].point!;
            apiJatahSusutPoleshing2 += filterByNamePoleshing2[j].jatahSusut!;
          }
          if (artistPoleshing2[i].toString().toLowerCase() == 'asrori' ||
              artistPoleshing2[i].toString().toLowerCase() == 'carkiyad' ||
              artistPoleshing2[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistPoleshing2[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistPoleshing2[i].toString().toLowerCase() == 'khoerul anwar') {
            pointPoleshing2.add(apiPointPoleshing2.toStringAsFixed(2));
            jatahSusutPoleshing2.add((apiJatahSusutPoleshing2 + 0.075));
          } else {
            pointPoleshing2.add(apiPointPoleshing2.toStringAsFixed(2));
            jatahSusutPoleshing2.add(apiJatahSusutPoleshing2);
          }
        }
        //! end divisi Poleshing2

        //? divisi Stell1
        //? filter by divisi
        var filterByDivisiStell1 = filterBySiklus.where((element) =>
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

        //? divisi Stell2
        //? filter by divisi
        var filterByDivisiStell2 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2');
        var allDataStell2 = filterByDivisiStell2.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameStell2; i++) {
          double apiPointStell2 = 0;
          double apiJatahSusutStell2 = 0;
          var filterByNameStell2 = allDataStell2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2.length; j++) {
            apiPointStell2 += filterByNameStell2[j].point!;
            apiJatahSusutStell2 += filterByNameStell2[j].jatahSusut!;
          }
          if (artistStell2[i].toString().toLowerCase() == 'asrori' ||
              artistStell2[i].toString().toLowerCase() == 'carkiyad' ||
              artistStell2[i].toString().toLowerCase() == 'encup supriatna' ||
              artistStell2[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistStell2[i].toString().toLowerCase() == 'khoerul anwar') {
            pointStell2.add(apiPointStell2.toStringAsFixed(2));
            jatahSusutStell2.add((apiJatahSusutStell2 + 0.075));
          } else {
            pointStell2.add(apiPointStell2.toStringAsFixed(2));
            jatahSusutStell2.add(apiJatahSusutStell2);
          }
        }
        //! end divisi Stell2

        //? divisi Stell2Rep
        //? filter by divisi
        var filterByDivisiStell2Rep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
        var allDataStell2Rep = filterByDivisiStell2Rep.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameStell2Rep; i++) {
          double apiPointStell2Rep = 0;
          double apiJatahSusutStell2Rep = 0;
          var filterByNameStell2Rep = allDataStell2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2Rep.length; j++) {
            apiPointStell2Rep += filterByNameStell2Rep[j].point!;
            apiJatahSusutStell2Rep += filterByNameStell2Rep[j].jatahSusut!;
          }
          if (artistStell2Rep[i].toString().toLowerCase() == 'asrori' ||
              artistStell2Rep[i].toString().toLowerCase() == 'carkiyad' ||
              artistStell2Rep[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistStell2Rep[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistStell2Rep[i].toString().toLowerCase() == 'khoerul anwar') {
            pointStell2Rep.add(apiPointStell2Rep.toStringAsFixed(2));
            jatahSusutStell2Rep.add((apiJatahSusutStell2Rep + 0.075));
          } else {
            pointStell2Rep.add(apiPointStell2Rep.toStringAsFixed(2));
            jatahSusutStell2Rep.add(apiJatahSusutStell2Rep);
          }
        }
        //! end divisi Stell2Rep

        //? divisi Chrome
        //? filter by divisi
        var filterByDivisiChrome = filterBySiklus.where(
            (element) => element.divisi.toString().toLowerCase() == 'chrome');
        var allDataChrome = filterByDivisiChrome.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameChrome; i++) {
          double apiPointChrome = 0;
          double apiJatahSusutChrome = 0;
          var filterByNameChrome = allDataChrome
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistChrome[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameChrome.length; j++) {
            apiPointChrome += filterByNameChrome[j].point!;
            apiJatahSusutChrome += filterByNameChrome[j].jatahSusut!;
          }
          if (artistChrome[i].toString().toLowerCase() == 'asrori' ||
              artistChrome[i].toString().toLowerCase() == 'carkiyad' ||
              artistChrome[i].toString().toLowerCase() == 'encup supriatna' ||
              artistChrome[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistChrome[i].toString().toLowerCase() == 'khoerul anwar') {
            pointChrome.add(apiPointChrome.toStringAsFixed(2));
            jatahSusutChrome.add((apiJatahSusutChrome + 0.075));
          } else {
            pointChrome.add(apiPointChrome.toStringAsFixed(2));
            jatahSusutChrome.add(apiJatahSusutChrome);
          }
        }
        //! end divisi Chrome

        //? divisi ChromeRep
        //? filter by divisi
        var filterByDivisiChromeRep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'chrome rep');
        var allDataChromeRep = filterByDivisiChromeRep.toList();
        //? ambil data point by nama
        for (var i = 0; i < qtyNameChromeRep; i++) {
          double apiPointChromeRep = 0;
          double apiJatahSusutChromeRep = 0;
          var filterByNameChromeRep = allDataChromeRep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistChromeRep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameChromeRep.length; j++) {
            apiPointChromeRep += filterByNameChromeRep[j].point!;
            apiJatahSusutChromeRep += filterByNameChromeRep[j].jatahSusut!;
          }
          if (artistChromeRep[i].toString().toLowerCase() == 'asrori' ||
              artistChromeRep[i].toString().toLowerCase() == 'carkiyad' ||
              artistChromeRep[i].toString().toLowerCase() ==
                  'encup supriatna' ||
              artistChromeRep[i].toString().toLowerCase() ==
                  'muhammad abdul kodir' ||
              artistChromeRep[i].toString().toLowerCase() == 'khoerul anwar') {
            pointChromeRep.add(apiPointChromeRep.toStringAsFixed(2));
            jatahSusutChromeRep.add((apiJatahSusutChromeRep + 0.075));
          } else {
            pointChromeRep.add(apiPointChromeRep.toStringAsFixed(2));
            jatahSusutChromeRep.add(apiJatahSusutChromeRep);
          }
        }
        //! end divisi ChromeRep
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

    //? variable Poleshing1
    beratAsalPoleshing1 = [];
    beratAkhirPoleshing1 = [];
    beratAsalSBPoleshing1 = [];
    beratAkhirSBPoleshing1 = [];
    susutPoleshing1 = [];
    resultPoleshing1 = [];
    //!end variable Poleshing1

    //? variable Poleshing2
    beratAsalPoleshing2 = [];
    beratAkhirPoleshing2 = [];
    beratAsalSBPoleshing2 = [];
    beratAkhirSBPoleshing2 = [];
    susutPoleshing2 = [];
    resultPoleshing2 = [];
    //!end variable Poleshing2

    //? variable Poleshing2
    beratAsalPoleshing2 = [];
    beratAkhirPoleshing2 = [];
    beratAsalSBPoleshing2 = [];
    beratAkhirSBPoleshing2 = [];
    susutPoleshing2 = [];
    resultPoleshing2 = [];
    //!end variable Poleshing2

    //? variable Stell1
    beratAsalStell1 = [];
    beratAkhirStell1 = [];
    beratAsalSBStell1 = [];
    beratAkhirSBStell1 = [];
    susutStell1 = [];
    resultStell1 = [];
    //!end variable Stell1

    //? variable Stell2
    beratAsalStell2 = [];
    beratAkhirStell2 = [];
    beratAsalSBStell2 = [];
    beratAkhirSBStell2 = [];
    susutStell2 = [];
    resultStell2 = [];
    //!end variable Stell2

    //? variable Stell2Rep
    beratAsalStell2Rep = [];
    beratAkhirStell2Rep = [];
    beratAsalSBStell2Rep = [];
    beratAkhirSBStell2Rep = [];
    susutStell2Rep = [];
    resultStell2Rep = [];
    //!end variable Stell2Rep

    //? variable Chrome
    beratAsalChrome = [];
    beratAkhirChrome = [];
    beratAsalSBChrome = [];
    beratAkhirSBChrome = [];
    susutChrome = [];
    resultChrome = [];
    //!end variable Chrome

    //? variable ChromeRep
    beratAsalChromeRep = [];
    beratAkhirChromeRep = [];
    beratAsalSBChromeRep = [];
    beratAkhirSBChromeRep = [];
    susutChromeRep = [];
    resultChromeRep = [];
    //!end variable ChromeRep

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

        //? filter by divisi Poleshing1
        var filterByDivisiPoleshing1 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 1');
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();
        for (var i = 0; i < qtyNamePoleshing1; i++) {
          double apiBeratAsalPoleshing1 = 0;
          double apiBeratAkirPoleshing1 = 0;
          var filterByNamePoleshing1 = allDataPoleshing1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing1.length; j++) {
            apiBeratAsalPoleshing1 += filterByNamePoleshing1[j].debet!;
            apiBeratAkirPoleshing1 += filterByNamePoleshing1[j].kredit!;
          }
          beratAsalPoleshing1.add(apiBeratAsalPoleshing1);
          beratAkhirPoleshing1.add(apiBeratAkirPoleshing1);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBPoleshing1 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBPoleshing1.statusCode == 200) {
          List jsonResponseSBPoleshing1 =
              json.decode(responseSBPoleshing1.body);
          var allDataSBPoleshing1 = jsonResponseSBPoleshing1
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBPoleshing1 = allDataSBPoleshing1.where(
              (element) =>
                  element.divisi.toString().toLowerCase() == 'poleshing 1');
          allDataSBPoleshing1 = filterByDivisiSBPoleshing1.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNamePoleshing1; i++) {
              double apiBeratAsalSBPoleshing1 = 0;
              double apiBeratAkirSBPoleshing1 = 0;
              var filterByNameSBPoleshing1 = allDataSBPoleshing1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing1[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBPoleshing1.length; j++) {
                apiBeratAsalSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].debetKawat!;
                apiBeratAkirSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].kreditKawat!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sb!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sprue!;
              }
              beratAsalSBPoleshing1.add(apiBeratAsalSBPoleshing1);
              beratAkhirSBPoleshing1.add(apiBeratAkirSBPoleshing1);
            }
          } else {
            for (var i = 0; i < qtyNamePoleshing1; i++) {
              double apiBeratAsalSBPoleshing1 = 0;
              double apiBeratAkirSBPoleshing1 = 0;
              //? filter by month
              var filterBySiklusSBPoleshing1 = allDataSBPoleshing1.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBPoleshing1 = filterBySiklusSBPoleshing1.toList();
              var filterByNameSBPoleshing1 = allDataSBPoleshing1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing1[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBPoleshing1.length; j++) {
                apiBeratAsalSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].debetKawat!;
                apiBeratAkirSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].kreditKawat!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sb!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sprue!;
              }
              beratAsalSBPoleshing1.add(apiBeratAsalSBPoleshing1);
              beratAkhirSBPoleshing1.add(apiBeratAkirSBPoleshing1);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalPoleshing1.length; i++) {
          beratAsalPoleshing1[i] += beratAsalSBPoleshing1[i];
          beratAkhirPoleshing1[i] += beratAkhirSBPoleshing1[i];
          susutPoleshing1.add(beratAsalPoleshing1[i] - beratAkhirPoleshing1[i]);
          resultPoleshing1.add(susutPoleshing1[i] - jatahSusutPoleshing1[i]);
        }
        //? end penggabungan
        //! end divisi Poleshing1

        //? filter by divisi Poleshing2
        var filterByDivisiPoleshing2 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2');
        var allDataPoleshing2 = filterByDivisiPoleshing2.toList();
        for (var i = 0; i < qtyNamePoleshing2; i++) {
          double apiBeratAsalPoleshing2 = 0;
          double apiBeratAkirPoleshing2 = 0;
          var filterByNamePoleshing2 = allDataPoleshing2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2.length; j++) {
            apiBeratAsalPoleshing2 += filterByNamePoleshing2[j].debet!;
            apiBeratAkirPoleshing2 += filterByNamePoleshing2[j].kredit!;
          }
          beratAsalPoleshing2.add(apiBeratAsalPoleshing2);
          beratAkhirPoleshing2.add(apiBeratAkirPoleshing2);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBPoleshing2 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBPoleshing2.statusCode == 200) {
          List jsonResponseSBPoleshing2 =
              json.decode(responseSBPoleshing2.body);
          var allDataSBPoleshing2 = jsonResponseSBPoleshing2
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBPoleshing2 = allDataSBPoleshing2.where(
              (element) =>
                  element.divisi.toString().toLowerCase() == 'poleshing 2');
          allDataSBPoleshing2 = filterByDivisiSBPoleshing2.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNamePoleshing2; i++) {
              double apiBeratAsalSBPoleshing2 = 0;
              double apiBeratAkirSBPoleshing2 = 0;
              var filterByNameSBPoleshing2 = allDataSBPoleshing2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBPoleshing2.length; j++) {
                apiBeratAsalSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].debetKawat!;
                apiBeratAkirSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].kreditKawat!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sb!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sprue!;
              }
              beratAsalSBPoleshing2.add(apiBeratAsalSBPoleshing2);
              beratAkhirSBPoleshing2.add(apiBeratAkirSBPoleshing2);
            }
          } else {
            for (var i = 0; i < qtyNamePoleshing2; i++) {
              double apiBeratAsalSBPoleshing2 = 0;
              double apiBeratAkirSBPoleshing2 = 0;
              //? filter by month
              var filterBySiklusSBPoleshing2 = allDataSBPoleshing2.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBPoleshing2 = filterBySiklusSBPoleshing2.toList();
              var filterByNameSBPoleshing2 = allDataSBPoleshing2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBPoleshing2.length; j++) {
                apiBeratAsalSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].debetKawat!;
                apiBeratAkirSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].kreditKawat!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sb!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sprue!;
              }
              beratAsalSBPoleshing2.add(apiBeratAsalSBPoleshing2);
              beratAkhirSBPoleshing2.add(apiBeratAkirSBPoleshing2);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalPoleshing2.length; i++) {
          beratAsalPoleshing2[i] += beratAsalSBPoleshing2[i];
          beratAkhirPoleshing2[i] += beratAkhirSBPoleshing2[i];
          susutPoleshing2.add(beratAsalPoleshing2[i] - beratAkhirPoleshing2[i]);
          resultPoleshing2.add(susutPoleshing2[i] - jatahSusutPoleshing2[i]);
        }
        //? end penggabungan
        //! end divisi Poleshing2

        //? filter by divisi Poleshing2Rep
        var filterByDivisiPoleshing2Rep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
        var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();
        for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
          double apiBeratAsalPoleshing2Rep = 0;
          double apiBeratAkirPoleshing2Rep = 0;
          var filterByNamePoleshing2Rep = allDataPoleshing2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2Rep.length; j++) {
            apiBeratAsalPoleshing2Rep += filterByNamePoleshing2Rep[j].debet!;
            apiBeratAkirPoleshing2Rep += filterByNamePoleshing2Rep[j].kredit!;
          }
          beratAsalPoleshing2Rep.add(apiBeratAsalPoleshing2Rep);
          beratAkhirPoleshing2Rep.add(apiBeratAkirPoleshing2Rep);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBPoleshing2Rep = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBPoleshing2Rep.statusCode == 200) {
          List jsonResponseSBPoleshing2Rep =
              json.decode(responseSBPoleshing2Rep.body);
          var allDataSBPoleshing2Rep = jsonResponseSBPoleshing2Rep
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBPoleshing2Rep = allDataSBPoleshing2Rep.where(
              (element) =>
                  element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
          allDataSBPoleshing2Rep = filterByDivisiSBPoleshing2Rep.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
              double apiBeratAsalSBPoleshing2Rep = 0;
              double apiBeratAkirSBPoleshing2Rep = 0;
              var filterByNameSBPoleshing2Rep = allDataSBPoleshing2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2Rep[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBPoleshing2Rep.length; j++) {
                apiBeratAsalSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].debetKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].kreditKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sb!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sprue!;
              }
              beratAsalSBPoleshing2Rep.add(apiBeratAsalSBPoleshing2Rep);
              beratAkhirSBPoleshing2Rep.add(apiBeratAkirSBPoleshing2Rep);
            }
          } else {
            for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
              double apiBeratAsalSBPoleshing2Rep = 0;
              double apiBeratAkirSBPoleshing2Rep = 0;
              //? filter by month
              var filterBySiklusSBPoleshing2Rep = allDataSBPoleshing2Rep.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBPoleshing2Rep = filterBySiklusSBPoleshing2Rep.toList();
              var filterByNameSBPoleshing2Rep = allDataSBPoleshing2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2Rep[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBPoleshing2Rep.length; j++) {
                apiBeratAsalSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].debetKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].kreditKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sb!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sprue!;
              }
              beratAsalSBPoleshing2Rep.add(apiBeratAsalSBPoleshing2Rep);
              beratAkhirSBPoleshing2Rep.add(apiBeratAkirSBPoleshing2Rep);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalPoleshing2Rep.length; i++) {
          beratAsalPoleshing2Rep[i] += beratAsalSBPoleshing2Rep[i];
          beratAkhirPoleshing2Rep[i] += beratAkhirSBPoleshing2Rep[i];
          susutPoleshing2Rep
              .add(beratAsalPoleshing2Rep[i] - beratAkhirPoleshing2Rep[i]);
          resultPoleshing2Rep
              .add(susutPoleshing2Rep[i] - jatahSusutPoleshing2Rep[i]);
        }
        //? end penggabungan
        //! end divisi Poleshing2Rep

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

        //? filter by divisi stell2
        var filterByDivisiStell2 = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2');
        var allDataStell2 = filterByDivisiStell2.toList();
        for (var i = 0; i < qtyNameStell2; i++) {
          double apiBeratAsalStell2 = 0;
          double apiBeratAkirStell2 = 0;
          var filterByNameStell2 = allDataStell2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2.length; j++) {
            apiBeratAsalStell2 += filterByNameStell2[j].debet!;
            apiBeratAkirStell2 += filterByNameStell2[j].kredit!;
          }
          beratAsalStell2.add(apiBeratAsalStell2);
          beratAkhirStell2.add(apiBeratAkirStell2);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBStell2 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBStell2.statusCode == 200) {
          List jsonResponseSBStell2 = json.decode(responseSBStell2.body);
          var allDataSBStell2 = jsonResponseSBStell2
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBStell2 = allDataSBStell2.where((element) =>
              element.divisi.toString().toLowerCase() == 'stell rangka 2');
          allDataSBStell2 = filterByDivisiSBStell2.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameStell2; i++) {
              double apiBeratAsalSBStell2 = 0;
              double apiBeratAkirSBStell2 = 0;
              var filterByNameSBStell2 = allDataSBStell2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBStell2.length; j++) {
                apiBeratAsalSBStell2 += filterByNameSBStell2[j].debetKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].kreditKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sb!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sprue!;
              }
              beratAsalSBStell2.add(apiBeratAsalSBStell2);
              beratAkhirSBStell2.add(apiBeratAkirSBStell2);
            }
          } else {
            for (var i = 0; i < qtyNameStell2; i++) {
              double apiBeratAsalSBStell2 = 0;
              double apiBeratAkirSBStell2 = 0;
              //? filter by month
              var filterBySiklusSBStell2 = allDataSBStell2.where((element) =>
                  element.bulan.toString().toLowerCase() ==
                  month.toLowerCase());
              allDataSBStell2 = filterBySiklusSBStell2.toList();
              var filterByNameSBStell2 = allDataSBStell2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBStell2.length; j++) {
                apiBeratAsalSBStell2 += filterByNameSBStell2[j].debetKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].kreditKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sb!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sprue!;
              }
              beratAsalSBStell2.add(apiBeratAsalSBStell2);
              beratAkhirSBStell2.add(apiBeratAkirSBStell2);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalStell2.length; i++) {
          beratAsalStell2[i] += beratAsalSBStell2[i];
          beratAkhirStell2[i] += beratAkhirSBStell2[i];
          susutStell2.add(beratAsalStell2[i] - beratAkhirStell2[i]);
          resultStell2.add(susutStell2[i] - jatahSusutStell2[i]);
        }
        //? end penggabungan
        //! end divisi Stell2

        //? filter by divisi stell2Rep
        var filterByDivisiStell2Rep = allData.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
        var allDataStell2Rep = filterByDivisiStell2Rep.toList();
        for (var i = 0; i < qtyNameStell2Rep; i++) {
          double apiBeratAsalStell2Rep = 0;
          double apiBeratAkirStell2Rep = 0;
          var filterByNameStell2Rep = allDataStell2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2Rep.length; j++) {
            apiBeratAsalStell2Rep += filterByNameStell2Rep[j].debet!;
            apiBeratAkirStell2Rep += filterByNameStell2Rep[j].kredit!;
          }
          beratAsalStell2Rep.add(apiBeratAsalStell2Rep);
          beratAkhirStell2Rep.add(apiBeratAkirStell2Rep);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBStell2Rep = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBStell2Rep.statusCode == 200) {
          List jsonResponseSBStell2Rep = json.decode(responseSBStell2Rep.body);
          var allDataSBStell2Rep = jsonResponseSBStell2Rep
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBStell2Rep = allDataSBStell2Rep.where((element) =>
              element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
          allDataSBStell2Rep = filterByDivisiSBStell2Rep.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameStell2Rep; i++) {
              double apiBeratAsalSBStell2Rep = 0;
              double apiBeratAkirSBStell2Rep = 0;
              var filterByNameSBStell2Rep = allDataSBStell2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2Rep[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBStell2Rep.length; j++) {
                apiBeratAsalSBStell2Rep +=
                    filterByNameSBStell2Rep[j].debetKawat!;
                apiBeratAkirSBStell2Rep +=
                    filterByNameSBStell2Rep[j].kreditKawat!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sb!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sprue!;
              }
              beratAsalSBStell2Rep.add(apiBeratAsalSBStell2Rep);
              beratAkhirSBStell2Rep.add(apiBeratAkirSBStell2Rep);
            }
          } else {
            for (var i = 0; i < qtyNameStell2Rep; i++) {
              double apiBeratAsalSBStell2Rep = 0;
              double apiBeratAkirSBStell2Rep = 0;
              //? filter by month
              var filterBySiklusSBStell2Rep = allDataSBStell2Rep.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBStell2Rep = filterBySiklusSBStell2Rep.toList();
              var filterByNameSBStell2Rep = allDataSBStell2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2Rep[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBStell2Rep.length; j++) {
                apiBeratAsalSBStell2Rep +=
                    filterByNameSBStell2Rep[j].debetKawat!;
                apiBeratAkirSBStell2Rep +=
                    filterByNameSBStell2Rep[j].kreditKawat!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sb!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sprue!;
              }
              beratAsalSBStell2Rep.add(apiBeratAsalSBStell2Rep);
              beratAkhirSBStell2Rep.add(apiBeratAkirSBStell2Rep);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalStell2Rep.length; i++) {
          beratAsalStell2Rep[i] += beratAsalSBStell2Rep[i];
          beratAkhirStell2Rep[i] += beratAkhirSBStell2Rep[i];
          susutStell2Rep.add(beratAsalStell2Rep[i] - beratAkhirStell2Rep[i]);
          resultStell2Rep.add(susutStell2Rep[i] - jatahSusutStell2Rep[i]);
        }
        //? end penggabungan
        //! end divisi Stell2Rep

        // //? filter by divisi Chrome
        // var filterByDivisiChrome = allData.where(
        //     (element) => element.divisi.toString().toLowerCase() == 'chrome');
        // var allDataChrome = filterByDivisiChrome.toList();
        // for (var i = 0; i < qtyNameChrome; i++) {
        //   double apiBeratAsalChrome = 0;
        //   double apiBeratAkirChrome = 0;
        //   var filterByNameChrome = allDataChrome
        //       .where((element) =>
        //           element.nama.toString().toLowerCase() ==
        //           artistChrome[i].toLowerCase())
        //       .toList();
        //   for (var j = 0; j < filterByNameChrome.length; j++) {
        //     apiBeratAsalChrome += filterByNameChrome[j].debet!;
        //     apiBeratAkirChrome += filterByNameChrome[j].kredit!;
        //   }
        //   beratAsalChrome.add(apiBeratAsalChrome);
        //   beratAkhirChrome.add(apiBeratAkirChrome);
        // }
        // //! fungsi add debet dan kredit dan SB
        // final responseSBChrome = await http
        //     .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        // if (responseSBChrome.statusCode == 200) {
        //   print('get data beratAsal dan akhir SB');
        //   List jsonResponseSBChrome = json.decode(responseSBChrome.body);
        //   var allDataSBChrome = jsonResponseSBChrome
        //       .map((data) => ProduksiSBModel.fromJson(data))
        //       .toList();
        //   //? filter by divisi
        //   var filterByDivisiSBChrome = allDataSBChrome.where(
        //       (element) => element.divisi.toString().toLowerCase() == 'chrome');
        //   allDataSBChrome = filterByDivisiSBChrome.toList();
        //   if (month.toString().toLowerCase() == "all") {
        //     for (var i = 0; i < qtyNameChrome; i++) {
        //       double apiBeratAsalSBChrome = 0;
        //       double apiBeratAkirSBChrome = 0;
        //       var filterByNameSBChrome = allDataSBChrome
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChrome[i].toLowerCase())
        //           .toList();
        //       for (var j = 0; j < filterByNameSBChrome.length; j++) {
        //         apiBeratAsalSBChrome += filterByNameSBChrome[j].debetKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].kreditKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sb!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sprue!;
        //       }
        //       beratAsalSBChrome.add(apiBeratAsalSBChrome);
        //       beratAkhirSBChrome.add(apiBeratAkirSBChrome);
        //     }
        //   } else {
        //     for (var i = 0; i < qtyNameChrome; i++) {
        //       double apiBeratAsalSBChrome = 0;
        //       double apiBeratAkirSBChrome = 0;
        //       //? filter by month
        //       var filterBySiklusSBChrome = allDataSBChrome.where((element) =>
        //           element.bulan.toString().toLowerCase() ==
        //           month.toLowerCase());
        //       allDataSBChrome = filterBySiklusSBChrome.toList();
        //       var filterByNameSBChrome = allDataSBChrome
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChrome[i].toLowerCase())
        //           .toList();

        //       for (var j = 0; j < filterByNameSBChrome.length; j++) {
        //         apiBeratAsalSBChrome += filterByNameSBChrome[j].debetKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].kreditKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sb!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sprue!;
        //       }
        //       beratAsalSBChrome.add(apiBeratAsalSBChrome);
        //       beratAkhirSBChrome.add(apiBeratAkirSBChrome);
        //     }
        //   }
        // } else {
        //   throw Exception('Unexpected error occured!');
        // }
        // //? end fungsi add debet dan kredit dan sb

        // //! fungsi penggabungan
        // for (var i = 0; i < beratAsalChrome.length; i++) {
        //   beratAsalChrome[i] += beratAsalSBChrome[i];
        //   beratAkhirChrome[i] += beratAkhirSBChrome[i];
        //   susutChrome.add(beratAsalChrome[i] - beratAkhirChrome[i]);
        //   resultChrome.add(susutChrome[i] - jatahSusutChrome[i]);
        // }
        // //? end penggabungan
        // //! end divisi Chrome

        // //? filter by divisi ChromeRep
        // var filterByDivisiChromeRep = allData.where((element) =>
        //     element.divisi.toString().toLowerCase() == 'chrome rep');
        // var allDataChromeRep = filterByDivisiChromeRep.toList();
        // for (var i = 0; i < qtyNameChromeRep; i++) {
        //   double apiBeratAsalChromeRep = 0;
        //   double apiBeratAkirChromeRep = 0;
        //   var filterByNameChromeRep = allDataChromeRep
        //       .where((element) =>
        //           element.nama.toString().toLowerCase() ==
        //           artistChromeRep[i].toLowerCase())
        //       .toList();
        //   for (var j = 0; j < filterByNameChromeRep.length; j++) {
        //     apiBeratAsalChromeRep += filterByNameChromeRep[j].debet!;
        //     apiBeratAkirChromeRep += filterByNameChromeRep[j].kredit!;
        //   }
        //   beratAsalChromeRep.add(apiBeratAsalChromeRep);
        //   beratAkhirChromeRep.add(apiBeratAkirChromeRep);
        // }
        // //! fungsi add debet dan kredit dan SB
        // final responseSBChromeRep = await http
        //     .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        // if (responseSBChromeRep.statusCode == 200) {
        //   print('get data beratAsal dan akhir SB');
        //   List jsonResponseSBChromeRep = json.decode(responseSBChromeRep.body);
        //   var allDataSBChromeRep = jsonResponseSBChromeRep
        //       .map((data) => ProduksiSBModel.fromJson(data))
        //       .toList();
        //   //? filter by divisi
        //   var filterByDivisiSBChromeRep = allDataSBChromeRep.where((element) =>
        //       element.divisi.toString().toLowerCase() == 'chrome rep');
        //   allDataSBChromeRep = filterByDivisiSBChromeRep.toList();
        //   if (month.toString().toLowerCase() == "all") {
        //     for (var i = 0; i < qtyNameChromeRep; i++) {
        //       double apiBeratAsalSBChromeRep = 0;
        //       double apiBeratAkirSBChromeRep = 0;
        //       var filterByNameSBChromeRep = allDataSBChromeRep
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChromeRep[i].toLowerCase())
        //           .toList();
        //       for (var j = 0; j < filterByNameSBChromeRep.length; j++) {
        //         apiBeratAsalSBChromeRep +=
        //             filterByNameSBChromeRep[j].debetKawat!;
        //         apiBeratAkirSBChromeRep +=
        //             filterByNameSBChromeRep[j].kreditKawat!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sb!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sprue!;
        //       }
        //       beratAsalSBChromeRep.add(apiBeratAsalSBChromeRep);
        //       beratAkhirSBChromeRep.add(apiBeratAkirSBChromeRep);
        //     }
        //   } else {
        //     for (var i = 0; i < qtyNameChromeRep; i++) {
        //       double apiBeratAsalSBChromeRep = 0;
        //       double apiBeratAkirSBChromeRep = 0;
        //       //? filter by month
        //       var filterBySiklusSBChromeRep = allDataSBChromeRep.where(
        //           (element) =>
        //               element.bulan.toString().toLowerCase() ==
        //               month.toLowerCase());
        //       allDataSBChromeRep = filterBySiklusSBChromeRep.toList();
        //       var filterByNameSBChromeRep = allDataSBChromeRep
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChromeRep[i].toLowerCase())
        //           .toList();

        //       for (var j = 0; j < filterByNameSBChromeRep.length; j++) {
        //         apiBeratAsalSBChromeRep +=
        //             filterByNameSBChromeRep[j].debetKawat!;
        //         apiBeratAkirSBChromeRep +=
        //             filterByNameSBChromeRep[j].kreditKawat!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sb!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sprue!;
        //       }
        //       beratAsalSBChromeRep.add(apiBeratAsalSBChromeRep);
        //       beratAkhirSBChromeRep.add(apiBeratAkirSBChromeRep);
        //     }
        //   }
        // } else {
        //   throw Exception('Unexpected error occured!');
        // }
        // //? end fungsi add debet dan kredit dan sb

        // //! fungsi penggabungan
        // for (var i = 0; i < beratAsalChromeRep.length; i++) {
        //   beratAsalChromeRep[i] += beratAsalSBChromeRep[i];
        //   beratAkhirChromeRep[i] += beratAkhirSBChromeRep[i];
        //   susutChromeRep.add(beratAsalChromeRep[i] - beratAkhirChromeRep[i]);
        //   resultChromeRep.add(susutChromeRep[i] - jatahSusutChromeRep[i]);
        // }
        // //? end penggabungan
        // //! end divisi ChromeRep
      } else {
        //! jika siklus di pilih
        //? filter by month
        var filterBySiklus = allData.where((element) =>
            element.bulan.toString().toLowerCase() == month.toLowerCase());

        //? filter by divisi
        var filterByDivisiFinishing = filterBySiklus.where((element) =>
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

        //? filter by divisi Poleshing1
        var filterByDivisiPoleshing1 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 1');
        var allDataPoleshing1 = filterByDivisiPoleshing1.toList();
        for (var i = 0; i < qtyNamePoleshing1; i++) {
          double apiBeratAsalPoleshing1 = 0;
          double apiBeratAkirPoleshing1 = 0;
          var filterByNamePoleshing1 = allDataPoleshing1
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing1[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing1.length; j++) {
            apiBeratAsalPoleshing1 += filterByNamePoleshing1[j].debet!;
            apiBeratAkirPoleshing1 += filterByNamePoleshing1[j].kredit!;
          }
          beratAsalPoleshing1.add(apiBeratAsalPoleshing1);
          beratAkhirPoleshing1.add(apiBeratAkirPoleshing1);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBPoleshing1 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBPoleshing1.statusCode == 200) {
          List jsonResponseSBPoleshing1 =
              json.decode(responseSBPoleshing1.body);
          var allDataSBPoleshing1 = jsonResponseSBPoleshing1
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBPoleshing1 = allDataSBPoleshing1.where(
              (element) =>
                  element.divisi.toString().toLowerCase() == 'poleshing 1');
          allDataSBPoleshing1 = filterByDivisiSBPoleshing1.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNamePoleshing1; i++) {
              double apiBeratAsalSBPoleshing1 = 0;
              double apiBeratAkirSBPoleshing1 = 0;
              var filterByNameSBPoleshing1 = allDataSBPoleshing1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing1[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBPoleshing1.length; j++) {
                apiBeratAsalSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].debetKawat!;
                apiBeratAkirSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].kreditKawat!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sb!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sprue!;
              }
              beratAsalSBPoleshing1.add(apiBeratAsalSBPoleshing1);
              beratAkhirSBPoleshing1.add(apiBeratAkirSBPoleshing1);
            }
          } else {
            for (var i = 0; i < qtyNamePoleshing1; i++) {
              double apiBeratAsalSBPoleshing1 = 0;
              double apiBeratAkirSBPoleshing1 = 0;
              //? filter by month
              var filterBySiklusSBPoleshing1 = allDataSBPoleshing1.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBPoleshing1 = filterBySiklusSBPoleshing1.toList();
              var filterByNameSBPoleshing1 = allDataSBPoleshing1
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing1[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBPoleshing1.length; j++) {
                apiBeratAsalSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].debetKawat!;
                apiBeratAkirSBPoleshing1 +=
                    filterByNameSBPoleshing1[j].kreditKawat!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sb!;
                apiBeratAkirSBPoleshing1 += filterByNameSBPoleshing1[j].sprue!;
              }
              beratAsalSBPoleshing1.add(apiBeratAsalSBPoleshing1);
              beratAkhirSBPoleshing1.add(apiBeratAkirSBPoleshing1);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalPoleshing1.length; i++) {
          beratAsalPoleshing1[i] += beratAsalSBPoleshing1[i];
          beratAkhirPoleshing1[i] += beratAkhirSBPoleshing1[i];
          susutPoleshing1.add(beratAsalPoleshing1[i] - beratAkhirPoleshing1[i]);
          resultPoleshing1.add(susutPoleshing1[i] - jatahSusutPoleshing1[i]);
        }
        //? end penggabungan
        //! end divisi Poleshing1

        //? filter by divisi Poleshing2
        var filterByDivisiPoleshing2 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2');
        var allDataPoleshing2 = filterByDivisiPoleshing2.toList();
        for (var i = 0; i < qtyNamePoleshing2; i++) {
          double apiBeratAsalPoleshing2 = 0;
          double apiBeratAkirPoleshing2 = 0;
          var filterByNamePoleshing2 = allDataPoleshing2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2.length; j++) {
            apiBeratAsalPoleshing2 += filterByNamePoleshing2[j].debet!;
            apiBeratAkirPoleshing2 += filterByNamePoleshing2[j].kredit!;
          }
          beratAsalPoleshing2.add(apiBeratAsalPoleshing2);
          beratAkhirPoleshing2.add(apiBeratAkirPoleshing2);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBPoleshing2 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBPoleshing2.statusCode == 200) {
          List jsonResponseSBPoleshing2 =
              json.decode(responseSBPoleshing2.body);
          var allDataSBPoleshing2 = jsonResponseSBPoleshing2
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBPoleshing2 = allDataSBPoleshing2.where(
              (element) =>
                  element.divisi.toString().toLowerCase() == 'poleshing 2');
          allDataSBPoleshing2 = filterByDivisiSBPoleshing2.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNamePoleshing2; i++) {
              double apiBeratAsalSBPoleshing2 = 0;
              double apiBeratAkirSBPoleshing2 = 0;
              var filterByNameSBPoleshing2 = allDataSBPoleshing2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBPoleshing2.length; j++) {
                apiBeratAsalSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].debetKawat!;
                apiBeratAkirSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].kreditKawat!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sb!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sprue!;
              }
              beratAsalSBPoleshing2.add(apiBeratAsalSBPoleshing2);
              beratAkhirSBPoleshing2.add(apiBeratAkirSBPoleshing2);
            }
          } else {
            for (var i = 0; i < qtyNamePoleshing2; i++) {
              double apiBeratAsalSBPoleshing2 = 0;
              double apiBeratAkirSBPoleshing2 = 0;
              //? filter by month
              var filterBySiklusSBPoleshing2 = allDataSBPoleshing2.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBPoleshing2 = filterBySiklusSBPoleshing2.toList();
              var filterByNameSBPoleshing2 = allDataSBPoleshing2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBPoleshing2.length; j++) {
                apiBeratAsalSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].debetKawat!;
                apiBeratAkirSBPoleshing2 +=
                    filterByNameSBPoleshing2[j].kreditKawat!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sb!;
                apiBeratAkirSBPoleshing2 += filterByNameSBPoleshing2[j].sprue!;
              }
              beratAsalSBPoleshing2.add(apiBeratAsalSBPoleshing2);
              beratAkhirSBPoleshing2.add(apiBeratAkirSBPoleshing2);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalPoleshing2.length; i++) {
          beratAsalPoleshing2[i] += beratAsalSBPoleshing2[i];
          beratAkhirPoleshing2[i] += beratAkhirSBPoleshing2[i];
          susutPoleshing2.add(beratAsalPoleshing2[i] - beratAkhirPoleshing2[i]);
          resultPoleshing2.add(susutPoleshing2[i] - jatahSusutPoleshing2[i]);
        }
        //? end penggabungan
        //! end divisi Poleshing2

        //? filter by divisi Poleshing2Rep
        var filterByDivisiPoleshing2Rep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
        var allDataPoleshing2Rep = filterByDivisiPoleshing2Rep.toList();
        for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
          double apiBeratAsalPoleshing2Rep = 0;
          double apiBeratAkirPoleshing2Rep = 0;
          var filterByNamePoleshing2Rep = allDataPoleshing2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistPoleshing2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNamePoleshing2Rep.length; j++) {
            apiBeratAsalPoleshing2Rep += filterByNamePoleshing2Rep[j].debet!;
            apiBeratAkirPoleshing2Rep += filterByNamePoleshing2Rep[j].kredit!;
          }
          beratAsalPoleshing2Rep.add(apiBeratAsalPoleshing2Rep);
          beratAkhirPoleshing2Rep.add(apiBeratAkirPoleshing2Rep);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBPoleshing2Rep = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBPoleshing2Rep.statusCode == 200) {
          List jsonResponseSBPoleshing2Rep =
              json.decode(responseSBPoleshing2Rep.body);
          var allDataSBPoleshing2Rep = jsonResponseSBPoleshing2Rep
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBPoleshing2Rep = allDataSBPoleshing2Rep.where(
              (element) =>
                  element.divisi.toString().toLowerCase() == 'poleshing 2 rep');
          allDataSBPoleshing2Rep = filterByDivisiSBPoleshing2Rep.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
              double apiBeratAsalSBPoleshing2Rep = 0;
              double apiBeratAkirSBPoleshing2Rep = 0;
              var filterByNameSBPoleshing2Rep = allDataSBPoleshing2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2Rep[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBPoleshing2Rep.length; j++) {
                apiBeratAsalSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].debetKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].kreditKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sb!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sprue!;
              }
              beratAsalSBPoleshing2Rep.add(apiBeratAsalSBPoleshing2Rep);
              beratAkhirSBPoleshing2Rep.add(apiBeratAkirSBPoleshing2Rep);
            }
          } else {
            for (var i = 0; i < qtyNamePoleshing2Rep; i++) {
              double apiBeratAsalSBPoleshing2Rep = 0;
              double apiBeratAkirSBPoleshing2Rep = 0;
              //? filter by month
              var filterBySiklusSBPoleshing2Rep = allDataSBPoleshing2Rep.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBPoleshing2Rep = filterBySiklusSBPoleshing2Rep.toList();
              var filterByNameSBPoleshing2Rep = allDataSBPoleshing2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistPoleshing2Rep[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBPoleshing2Rep.length; j++) {
                apiBeratAsalSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].debetKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].kreditKawat!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sb!;
                apiBeratAkirSBPoleshing2Rep +=
                    filterByNameSBPoleshing2Rep[j].sprue!;
              }
              beratAsalSBPoleshing2Rep.add(apiBeratAsalSBPoleshing2Rep);
              beratAkhirSBPoleshing2Rep.add(apiBeratAkirSBPoleshing2Rep);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalPoleshing2Rep.length; i++) {
          beratAsalPoleshing2Rep[i] += beratAsalSBPoleshing2Rep[i];
          beratAkhirPoleshing2Rep[i] += beratAkhirSBPoleshing2Rep[i];
          susutPoleshing2Rep
              .add(beratAsalPoleshing2Rep[i] - beratAkhirPoleshing2Rep[i]);
          resultPoleshing2Rep
              .add(susutPoleshing2Rep[i] - jatahSusutPoleshing2Rep[i]);
        }
        //? end penggabungan
        //! end divisi Poleshing2Rep

        //? filter by divisi stell1
        var filterByDivisiStell1 = filterBySiklus.where((element) =>
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

        //? filter by divisi stell2
        var filterByDivisiStell2 = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2');
        var allDataStell2 = filterByDivisiStell2.toList();
        for (var i = 0; i < qtyNameStell2; i++) {
          double apiBeratAsalStell2 = 0;
          double apiBeratAkirStell2 = 0;
          var filterByNameStell2 = allDataStell2
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2.length; j++) {
            apiBeratAsalStell2 += filterByNameStell2[j].debet!;
            apiBeratAkirStell2 += filterByNameStell2[j].kredit!;
          }
          beratAsalStell2.add(apiBeratAsalStell2);
          beratAkhirStell2.add(apiBeratAkirStell2);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBStell2 = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBStell2.statusCode == 200) {
          List jsonResponseSBStell2 = json.decode(responseSBStell2.body);
          var allDataSBStell2 = jsonResponseSBStell2
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBStell2 = allDataSBStell2.where((element) =>
              element.divisi.toString().toLowerCase() == 'stell rangka 2');
          allDataSBStell2 = filterByDivisiSBStell2.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameStell2; i++) {
              double apiBeratAsalSBStell2 = 0;
              double apiBeratAkirSBStell2 = 0;
              var filterByNameSBStell2 = allDataSBStell2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBStell2.length; j++) {
                apiBeratAsalSBStell2 += filterByNameSBStell2[j].debetKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].kreditKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sb!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sprue!;
              }
              beratAsalSBStell2.add(apiBeratAsalSBStell2);
              beratAkhirSBStell2.add(apiBeratAkirSBStell2);
            }
          } else {
            for (var i = 0; i < qtyNameStell2; i++) {
              double apiBeratAsalSBStell2 = 0;
              double apiBeratAkirSBStell2 = 0;
              //? filter by month
              var filterBySiklusSBStell2 = allDataSBStell2.where((element) =>
                  element.bulan.toString().toLowerCase() ==
                  month.toLowerCase());
              allDataSBStell2 = filterBySiklusSBStell2.toList();
              var filterByNameSBStell2 = allDataSBStell2
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBStell2.length; j++) {
                apiBeratAsalSBStell2 += filterByNameSBStell2[j].debetKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].kreditKawat!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sb!;
                apiBeratAkirSBStell2 += filterByNameSBStell2[j].sprue!;
              }
              beratAsalSBStell2.add(apiBeratAsalSBStell2);
              beratAkhirSBStell2.add(apiBeratAkirSBStell2);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalStell2.length; i++) {
          beratAsalStell2[i] += beratAsalSBStell2[i];
          beratAkhirStell2[i] += beratAkhirSBStell2[i];
          susutStell2.add(beratAsalStell2[i] - beratAkhirStell2[i]);
          resultStell2.add(susutStell2[i] - jatahSusutStell2[i]);
        }
        //? end penggabungan
        //! end divisi Stell2

        //? filter by divisi stell2Rep
        var filterByDivisiStell2Rep = filterBySiklus.where((element) =>
            element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
        var allDataStell2Rep = filterByDivisiStell2Rep.toList();
        for (var i = 0; i < qtyNameStell2Rep; i++) {
          double apiBeratAsalStell2Rep = 0;
          double apiBeratAkirStell2Rep = 0;
          var filterByNameStell2Rep = allDataStell2Rep
              .where((element) =>
                  element.nama.toString().toLowerCase() ==
                  artistStell2Rep[i].toLowerCase())
              .toList();
          for (var j = 0; j < filterByNameStell2Rep.length; j++) {
            apiBeratAsalStell2Rep += filterByNameStell2Rep[j].debet!;
            apiBeratAkirStell2Rep += filterByNameStell2Rep[j].kredit!;
          }
          beratAsalStell2Rep.add(apiBeratAsalStell2Rep);
          beratAkhirStell2Rep.add(apiBeratAkirStell2Rep);
        }
        //! fungsi add debet dan kredit dan SB
        final responseSBStell2Rep = await http
            .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        if (responseSBStell2Rep.statusCode == 200) {
          List jsonResponseSBStell2Rep = json.decode(responseSBStell2Rep.body);
          var allDataSBStell2Rep = jsonResponseSBStell2Rep
              .map((data) => ProduksiSBModel.fromJson(data))
              .toList();
          //? filter by divisi
          var filterByDivisiSBStell2Rep = allDataSBStell2Rep.where((element) =>
              element.divisi.toString().toLowerCase() == 'stell rangka 2 rep');
          allDataSBStell2Rep = filterByDivisiSBStell2Rep.toList();
          if (month.toString().toLowerCase() == "all") {
            for (var i = 0; i < qtyNameStell2Rep; i++) {
              double apiBeratAsalSBStell2Rep = 0;
              double apiBeratAkirSBStell2Rep = 0;
              var filterByNameSBStell2Rep = allDataSBStell2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2Rep[i].toLowerCase())
                  .toList();
              for (var j = 0; j < filterByNameSBStell2Rep.length; j++) {
                apiBeratAsalSBStell2Rep +=
                    filterByNameSBStell2Rep[j].debetKawat!;
                apiBeratAkirSBStell2Rep +=
                    filterByNameSBStell2Rep[j].kreditKawat!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sb!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sprue!;
              }
              beratAsalSBStell2Rep.add(apiBeratAsalSBStell2Rep);
              beratAkhirSBStell2Rep.add(apiBeratAkirSBStell2Rep);
            }
          } else {
            for (var i = 0; i < qtyNameStell2Rep; i++) {
              double apiBeratAsalSBStell2Rep = 0;
              double apiBeratAkirSBStell2Rep = 0;
              //? filter by month
              var filterBySiklusSBStell2Rep = allDataSBStell2Rep.where(
                  (element) =>
                      element.bulan.toString().toLowerCase() ==
                      month.toLowerCase());
              allDataSBStell2Rep = filterBySiklusSBStell2Rep.toList();
              var filterByNameSBStell2Rep = allDataSBStell2Rep
                  .where((element) =>
                      element.nama.toString().toLowerCase() ==
                      artistStell2Rep[i].toLowerCase())
                  .toList();

              for (var j = 0; j < filterByNameSBStell2Rep.length; j++) {
                apiBeratAsalSBStell2Rep +=
                    filterByNameSBStell2Rep[j].debetKawat!;
                apiBeratAkirSBStell2Rep +=
                    filterByNameSBStell2Rep[j].kreditKawat!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sb!;
                apiBeratAkirSBStell2Rep += filterByNameSBStell2Rep[j].sprue!;
              }
              beratAsalSBStell2Rep.add(apiBeratAsalSBStell2Rep);
              beratAkhirSBStell2Rep.add(apiBeratAkirSBStell2Rep);
            }
          }
        } else {
          throw Exception('Unexpected error occured!');
        }
        //? end fungsi add debet dan kredit dan sb

        //! fungsi penggabungan
        for (var i = 0; i < beratAsalStell2Rep.length; i++) {
          beratAsalStell2Rep[i] += beratAsalSBStell2Rep[i];
          beratAkhirStell2Rep[i] += beratAkhirSBStell2Rep[i];
          susutStell2Rep.add(beratAsalStell2Rep[i] - beratAkhirStell2Rep[i]);
          resultStell2Rep.add(susutStell2Rep[i] - jatahSusutStell2Rep[i]);
        }
        //? end penggabungan
        //! end divisi Stell2Rep

        // //? filter by divisi Chrome
        // var filterByDivisiChrome = filterBySiklus.where(
        //     (element) => element.divisi.toString().toLowerCase() == 'chrome');
        // var allDataChrome = filterByDivisiChrome.toList();
        // for (var i = 0; i < qtyNameChrome; i++) {
        //   double apiBeratAsalChrome = 0;
        //   double apiBeratAkirChrome = 0;
        //   var filterByNameChrome = allDataChrome
        //       .where((element) =>
        //           element.nama.toString().toLowerCase() ==
        //           artistChrome[i].toLowerCase())
        //       .toList();
        //   for (var j = 0; j < filterByNameChrome.length; j++) {
        //     apiBeratAsalChrome += filterByNameChrome[j].debet!;
        //     apiBeratAkirChrome += filterByNameChrome[j].kredit!;
        //   }
        //   beratAsalChrome.add(apiBeratAsalChrome);
        //   beratAkhirChrome.add(apiBeratAkirChrome);
        // }
        // //! fungsi add debet dan kredit dan SB
        // final responseSBChrome = await http
        //     .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        // if (responseSBChrome.statusCode == 200) {
        //   print('get data beratAsal dan akhir SB');
        //   List jsonResponseSBChrome = json.decode(responseSBChrome.body);
        //   var allDataSBChrome = jsonResponseSBChrome
        //       .map((data) => ProduksiSBModel.fromJson(data))
        //       .toList();
        //   //? filter by divisi
        //   var filterByDivisiSBChrome = allDataSBChrome.where(
        //       (element) => element.divisi.toString().toLowerCase() == 'chrome');
        //   allDataSBChrome = filterByDivisiSBChrome.toList();
        //   if (month.toString().toLowerCase() == "all") {
        //     for (var i = 0; i < qtyNameChrome; i++) {
        //       double apiBeratAsalSBChrome = 0;
        //       double apiBeratAkirSBChrome = 0;
        //       var filterByNameSBChrome = allDataSBChrome
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChrome[i].toLowerCase())
        //           .toList();
        //       for (var j = 0; j < filterByNameSBChrome.length; j++) {
        //         apiBeratAsalSBChrome += filterByNameSBChrome[j].debetKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].kreditKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sb!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sprue!;
        //       }
        //       beratAsalSBChrome.add(apiBeratAsalSBChrome);
        //       beratAkhirSBChrome.add(apiBeratAkirSBChrome);
        //     }
        //   } else {
        //     for (var i = 0; i < qtyNameChrome; i++) {
        //       double apiBeratAsalSBChrome = 0;
        //       double apiBeratAkirSBChrome = 0;
        //       //? filter by month
        //       var filterBySiklusSBChrome = allDataSBChrome.where((element) =>
        //           element.bulan.toString().toLowerCase() ==
        //           month.toLowerCase());
        //       allDataSBChrome = filterBySiklusSBChrome.toList();
        //       var filterByNameSBChrome = allDataSBChrome
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChrome[i].toLowerCase())
        //           .toList();

        //       for (var j = 0; j < filterByNameSBChrome.length; j++) {
        //         apiBeratAsalSBChrome += filterByNameSBChrome[j].debetKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].kreditKawat!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sb!;
        //         apiBeratAkirSBChrome += filterByNameSBChrome[j].sprue!;
        //       }
        //       beratAsalSBChrome.add(apiBeratAsalSBChrome);
        //       beratAkhirSBChrome.add(apiBeratAkirSBChrome);
        //     }
        //   }
        // } else {
        //   throw Exception('Unexpected error occured!');
        // }
        // //? end fungsi add debet dan kredit dan sb

        // //! fungsi penggabungan
        // for (var i = 0; i < beratAsalChrome.length; i++) {
        //   beratAsalChrome[i] += beratAsalSBChrome[i];
        //   beratAkhirChrome[i] += beratAkhirSBChrome[i];
        //   susutChrome.add(beratAsalChrome[i] - beratAkhirChrome[i]);
        //   resultChrome.add(susutChrome[i] - jatahSusutChrome[i]);
        // }
        // //? end penggabungan
        // //! end divisi Chrome

        // //? filter by divisi ChromeRep
        // var filterByDivisiChromeRep = filterBySiklus.where((element) =>
        //     element.divisi.toString().toLowerCase() == 'chrome rep');
        // var allDataChromeRep = filterByDivisiChromeRep.toList();
        // for (var i = 0; i < qtyNameChromeRep; i++) {
        //   double apiBeratAsalChromeRep = 0;
        //   double apiBeratAkirChromeRep = 0;
        //   var filterByNameChromeRep = allDataChromeRep
        //       .where((element) =>
        //           element.nama.toString().toLowerCase() ==
        //           artistChromeRep[i].toLowerCase())
        //       .toList();
        //   for (var j = 0; j < filterByNameChromeRep.length; j++) {
        //     apiBeratAsalChromeRep += filterByNameChromeRep[j].debet!;
        //     apiBeratAkirChromeRep += filterByNameChromeRep[j].kredit!;
        //   }
        //   beratAsalChromeRep.add(apiBeratAsalChromeRep);
        //   beratAkhirChromeRep.add(apiBeratAkirChromeRep);
        // }
        // //! fungsi add debet dan kredit dan SB
        // final responseSBChromeRep = await http
        //     .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProduksiSB));
        // if (responseSBChromeRep.statusCode == 200) {
        //   print('get data beratAsal dan akhir SB');
        //   List jsonResponseSBChromeRep = json.decode(responseSBChromeRep.body);
        //   var allDataSBChromeRep = jsonResponseSBChromeRep
        //       .map((data) => ProduksiSBModel.fromJson(data))
        //       .toList();
        //   //? filter by divisi
        //   var filterByDivisiSBChromeRep = allDataSBChromeRep.where((element) =>
        //       element.divisi.toString().toLowerCase() == 'chrome rep');
        //   allDataSBChromeRep = filterByDivisiSBChromeRep.toList();
        //   if (month.toString().toLowerCase() == "all") {
        //     for (var i = 0; i < qtyNameChromeRep; i++) {
        //       double apiBeratAsalSBChromeRep = 0;
        //       double apiBeratAkirSBChromeRep = 0;
        //       var filterByNameSBChromeRep = allDataSBChromeRep
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChromeRep[i].toLowerCase())
        //           .toList();
        //       for (var j = 0; j < filterByNameSBChromeRep.length; j++) {
        //         apiBeratAsalSBChromeRep +=
        //             filterByNameSBChromeRep[j].debetKawat!;
        //         apiBeratAkirSBChromeRep +=
        //             filterByNameSBChromeRep[j].kreditKawat!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sb!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sprue!;
        //       }
        //       beratAsalSBChromeRep.add(apiBeratAsalSBChromeRep);
        //       beratAkhirSBChromeRep.add(apiBeratAkirSBChromeRep);
        //     }
        //   } else {
        //     for (var i = 0; i < qtyNameChromeRep; i++) {
        //       double apiBeratAsalSBChromeRep = 0;
        //       double apiBeratAkirSBChromeRep = 0;
        //       //? filter by month
        //       var filterBySiklusSBChromeRep = allDataSBChromeRep.where(
        //           (element) =>
        //               element.bulan.toString().toLowerCase() ==
        //               month.toLowerCase());
        //       allDataSBChromeRep = filterBySiklusSBChromeRep.toList();
        //       var filterByNameSBChromeRep = allDataSBChromeRep
        //           .where((element) =>
        //               element.nama.toString().toLowerCase() ==
        //               artistChromeRep[i].toLowerCase())
        //           .toList();

        //       for (var j = 0; j < filterByNameSBChromeRep.length; j++) {
        //         apiBeratAsalSBChromeRep +=
        //             filterByNameSBChromeRep[j].debetKawat!;
        //         apiBeratAkirSBChromeRep +=
        //             filterByNameSBChromeRep[j].kreditKawat!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sb!;
        //         apiBeratAkirSBChromeRep += filterByNameSBChromeRep[j].sprue!;
        //       }
        //       beratAsalSBChromeRep.add(apiBeratAsalSBChromeRep);
        //       beratAkhirSBChromeRep.add(apiBeratAkirSBChromeRep);
        //     }
        //   }
        // } else {
        //   throw Exception('Unexpected error occured!');
        // }
        // //? end fungsi add debet dan kredit dan sb

        // //! fungsi penggabungan
        // for (var i = 0; i < beratAsalChromeRep.length; i++) {
        //   beratAsalChromeRep[i] += beratAsalSBChromeRep[i];
        //   beratAkhirChromeRep[i] += beratAkhirSBChromeRep[i];
        //   susutChromeRep.add(beratAsalChromeRep[i] - beratAkhirChromeRep[i]);
        //   resultChromeRep.add(susutChromeRep[i] - jatahSusutChromeRep[i]);
        // }
        // //? end penggabungan
        // //! end divisi ChromeRep
      }

      //* save result finishing dikdik dan deko
      for (var i = 0; i < qtyNameFinishing; i++) {
        if (artistFinishing[i].toString().toLowerCase() == 'dikdik maulana') {
          resultFinishingDikdikMaulana = resultFinishing[i];
        }
        if (artistFinishing[i].toString().toLowerCase() == 'muhammad deeko') {
          resultFinishingMuhammadDeeko = resultFinishing[i];
        }
      }
      for (var i = 0; i < qtyNameStell2; i++) {
        if (artistStell1[i].toString().toLowerCase() == 'dikdik maulana') {
          if (resultStell2[i] < 0) {
            bonusStell2DikdikMaulana = resultStell2[i] * -1;
          } else {
            susutStell2DikdikMaulana = resultStell2[i];
          }
          if (resultStell2Rep[i] < 0) {
            bonusStell2RepDikdikMaulana = resultStell2Rep[i] * -1;
          } else {
            susutStell2RepDikdikMaulana = resultStell2Rep[i];
          }
        }
        if (artistStell1[i].toString().toLowerCase() == 'muhammad deeko') {
          if (resultStell2[i] < 0) {
            bonusStell2MuhammadDeeko = resultStell2[i] * -1;
          } else {
            susutStell2MuhammadDeeko = resultStell2[i];
          }
          if (resultStell2Rep[i] < 0) {
            bonusStell2RepMuhammadDeeko = resultStell2Rep[i] * -1;
          } else {
            susutStell2RepMuhammadDeeko = resultStell2Rep[i];
          }
        }
      }
      //! end save dikdik dand eko
      // print(
      //     'dikdik\n Fin : $resultFinishingDikdikMaulana, s2 bon : $bonusStell2DikdikMaulana, s2 sut : $susutStell2DikdikMaulana, s2 Rep bon : $bonusStell2RepDikdikMaulana, s2 Rep sut : $susutStell2RepDikdikMaulana');

      // print(
      //     'm deeko\n Fin : $resultFinishingMuhammadDeeko, s2 bon : $bonusStell2MuhammadDeeko, s2 sut : $susutStell2MuhammadDeeko, s2 Rep bon : $bonusStell2RepMuhammadDeeko, s2 Rep sut : $susutStell2RepMuhammadDeeko');

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
            : divisi == 'poleshing 1'
                ? _createRowsPoleshing1()
                : divisi == 'poleshing 2'
                    ? _createRowsPoleshing2()
                    : divisi == 'poleshing 2 rep'
                        ? _createRowsPoleshing2Rep()
                        : divisi == 'stell 1'
                            ? _createRowsStell1()
                            : divisi == 'stell 2'
                                ? _createRowsStell2()
                                : divisi == 'stell 2 rep'
                                    ? _createRowsStell2Rep()
                                    : divisi == 'chrome'
                                        ? _createRowsChrome()
                                        : divisi == 'chrome rep'
                                            ? _createRowsChromeRep()
                                            : defaultRows());
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

//? start row default
  List<DataRow> defaultRows() {
    return [
      for (var i = 0; i < qtyNameFinishing; i++)
        DataRow(cells: [
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
        ]),
    ];
  }
  //! end data table finishing

  //? start row Finishing
  List<DataRow> _createRowsFinishing() {
    return [
      for (var i = 0; i < qtyNameFinishing; i++)
        DataRow(cells: [
          DataCell(Text(artistFinishing[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkFinishing[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointFinishing[i].toStringAsFixed(3))),
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
          // DataCell(Text((resultFinishing[i] * -1).toStringAsFixed(2))),
          DataCell((artistFinishing[i].toString().toLowerCase() ==
                      'muhammad deeko' ||
                  artistFinishing[i].toString().toLowerCase() ==
                      'dikdik maulana')
              ? Text('0')
              : Text((resultFinishing[i] * -1).toStringAsFixed(2))),
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
          DataCell(Text(spkPoleshing1[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointPoleshing1[i])),
          DataCell(_verticalDivider),
          DataCell(Text(beratAsalPoleshing1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirPoleshing1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(susutPoleshing1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutPoleshing1[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text((resultPoleshing1[i] * -1).toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultPoleshing1[i] * -1) < 0
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

  //? start row Poleshing2
  List<DataRow> _createRowsPoleshing2() {
    return [
      for (var i = 0; i < qtyNamePoleshing2; i++)
        DataRow(cells: [
          DataCell(Text(artistPoleshing2[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkPoleshing2[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointPoleshing2[i])),
          DataCell(_verticalDivider),
          DataCell(Text(beratAsalPoleshing2[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirPoleshing2[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(susutPoleshing2[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutPoleshing2[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text((resultPoleshing2[i] * -1).toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultPoleshing2[i] * -1) < 0
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
  //! end data table Poleshing2

  //? start row Poleshing2Rep
  List<DataRow> _createRowsPoleshing2Rep() {
    return [
      for (var i = 0; i < qtyNamePoleshing2Rep; i++)
        DataRow(cells: [
          DataCell(Text(artistPoleshing2Rep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkPoleshing2Rep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointPoleshing2Rep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(beratAsalPoleshing2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirPoleshing2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(susutPoleshing2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutPoleshing2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text((resultPoleshing2Rep[i] * -1).toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultPoleshing2Rep[i] * -1) < 0
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
  //! end data table Poleshing2Rep

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
              ? Text((beratAsalStell1[i] - (resultFinishingMuhammadDeeko! * -1))
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
          DataCell(Text((resultStell1[i] * -1).toStringAsFixed(2))),
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
  //! end data table Stell1

  //? start row Stell2
  List<DataRow> _createRowsStell2() {
    return [
      for (var i = 0; i < qtyNameStell2; i++)
        DataRow(cells: [
          DataCell(Text(artistStell2[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkStell2[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointStell2[i])),
          DataCell(_verticalDivider),
          DataCell(Text((beratAsalStell2[i]).toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirStell2[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(susutStell2[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutStell2[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text((resultStell2[i] * -1).toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultStell2[i] * -1) < 0
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
  //! end data table Stell2

  //? start row Stell2Rep
  List<DataRow> _createRowsStell2Rep() {
    return [
      for (var i = 0; i < qtyNameStell2Rep; i++)
        DataRow(cells: [
          DataCell(Text(artistStell2Rep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkStell2Rep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointStell2Rep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(beratAsalStell2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(beratAkhirStell2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(susutStell2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text(jatahSusutStell2Rep[i].toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(Text((resultStell2Rep[i] * -1).toStringAsFixed(2))),
          DataCell(_verticalDivider),
          DataCell(
            (resultStell2Rep[i] * -1) < 0
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
  //! end data table Stell2Rep

//? start row Chrome
  List<DataRow> _createRowsChrome() {
    return [
      for (var i = 0; i < qtyNameChrome; i++)
        DataRow(cells: [
          DataCell(Text(artistChrome[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkChrome[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointChrome[i])),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
        ]),
    ];
  }
  //! end data table Chrome

  //? start row ChromeRep
  List<DataRow> _createRowsChromeRep() {
    return [
      for (var i = 0; i < qtyNameChromeRep; i++)
        DataRow(cells: [
          DataCell(Text(artistChromeRep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(spkChromeRep[i])),
          DataCell(_verticalDivider),
          DataCell(Text(pointChromeRep[i])),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
          DataCell(_verticalDivider),
          DataCell(Text('')),
        ]),
    ];
  }
  //! end data table ChromeRep

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
              backgroundColor: Colors.white,
              leadingWidth: 320,
              //change siklus
              leading: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Bulan Saat Ini : $nowSiklus",
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: dashboardProduksi()));
  }

  //! dashboard produksi
  dashboardProduksi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 26),
          child: const Text(
            'Summary Susut',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: 350,
          child: DropdownSearch<String>(
            items: namaBulan,
            onChanged: (item) {
              setState(() {
                siklus.text = item!;
                siklusDesigner = siklus.text.toString();
                _getDataAll(siklusDesigner);
              });
            },
            popupProps: const PopupPropsMultiSelection.modalBottomSheet(
              showSelectedItems: true,
              showSearchBox: true,
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              textAlign: TextAlign.center,
              baseStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              dropdownSearchDecoration: InputDecoration(
                  labelText: "Pilih Bulan",
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
          ),
        ),
        siklusDesigner.isEmpty
            ? Center(
                child: Column(
                children: [
                  SizedBox(
                    width: 250,
                    height: 210,
                    child: Lottie.asset("loadingJSON/selectDate.json"),
                  ),
                  const Text(
                    'Pilih bulan terlebih dahulu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Acne',
                        letterSpacing: 1.5),
                  ),
                ],
              ))
            : isLoading == true
                ? Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 90,
                        height: 90,
                        child: Lottie.asset("loadingJSON/loadingV1.json"),
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 1,
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
                                            _dataTable('poleshing 1'),
                                          ],
                                        ))),
                                SizedBox(height: 20),

                                //? BARIS 3
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        child: Column(
                                          children: [
                                            Text(
                                              'POLESHING 2',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            _dataTable('poleshing 2'),
                                          ],
                                        ))),
                                SizedBox(height: 20),

                                // //? BARIS 4
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        child: Column(
                                          children: [
                                            Text(
                                              'POLESHING 2 REPARASI',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            _dataTable('poleshing 2 rep'),
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
                                            // _dataTableStell1(),
                                            _dataTable('stell 1'),
                                          ],
                                        ))),
                                SizedBox(height: 20),

                                // //? BARIS 6
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        child: Column(
                                          children: [
                                            Text(
                                              'STELL 2',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            _dataTable('stell 2'),
                                          ],
                                        ))),
                                SizedBox(height: 20),

                                // //? BARIS 7
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        child: Column(
                                          children: [
                                            Text(
                                              'STELL 2 REP',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            _dataTable('stell 2 rep'),
                                          ],
                                        ))),
                                SizedBox(height: 20),
                                //? BARIS 8
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        child: Column(
                                          children: [
                                            Text(
                                              'CHROME',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            _dataTable('chrome'),
                                          ],
                                        ))),
                                SizedBox(height: 20),
                                // //? BARIS 9
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                        color: Colors.grey.shade200,
                                        child: Column(
                                          children: [
                                            Text(
                                              'CHROME REPARASI',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            _dataTable('chrome rep'),
                                          ],
                                        ))),
                                SizedBox(height: 20),
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

  @override
  void dispose() {
    super.dispose();
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
