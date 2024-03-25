// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:convert';
import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/model/batu_model.dart';
import 'package:form_designer/model/earnut_model.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/model/jenis_barang_model.dart';
import 'package:form_designer/model/lain2_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
// import "package:async/async.dart";

// import 'package:path/path.dart';

import '../api/api_constant.dart';
import '../dev/network.dart';
import '../global/currency_format.dart';
import '../model/rantai_model.dart';
import '../widgets/custom_loading.dart';

// ignore: must_be_immutable
class FormROScreen extends StatefulWidget {
  FormDesignerModel? modelDesigner;

  FormROScreen({
    super.key,
    this.modelDesigner,
    FormDesignerModel? models,
  });
  @override
  State<FormROScreen> createState() => _FormROScreenState();
}

String generateImageName() {
  var uuid = const Uuid();
  return 'image_${uuid.v4()}'; // Prefix 'image_' followed by a unique identifier
}

class _FormROScreenState extends State<FormROScreen> {
  bool isLoading = false;

  // ignore: unused_field, prefer_final_fields
  List _get = [];
  List<XFile>? imagefiles;
  // ignore: unused_field
  PlatformFile? _imageFile;

  TextEditingController ukuranBatu1 = TextEditingController();
  TextEditingController ukuranBatu2 = TextEditingController();
  TextEditingController ukuranBatu3 = TextEditingController();
  TextEditingController ukuranBatu4 = TextEditingController();
  TextEditingController ukuranBatu5 = TextEditingController();
  TextEditingController ukuranBatu6 = TextEditingController();
  TextEditingController ukuranBatu7 = TextEditingController();
  TextEditingController ukuranBatu8 = TextEditingController();
  TextEditingController ukuranBatu9 = TextEditingController();
  TextEditingController ukuranBatu10 = TextEditingController();
  TextEditingController ukuranBatu11 = TextEditingController();
  TextEditingController ukuranBatu12 = TextEditingController();
  TextEditingController ukuranBatu13 = TextEditingController();
  TextEditingController ukuranBatu14 = TextEditingController();
  TextEditingController ukuranBatu15 = TextEditingController();
  TextEditingController ukuranBatu16 = TextEditingController();
  TextEditingController ukuranBatu17 = TextEditingController();
  TextEditingController ukuranBatu18 = TextEditingController();
  TextEditingController ukuranBatu19 = TextEditingController();
  TextEditingController ukuranBatu20 = TextEditingController();
  TextEditingController ukuranBatu21 = TextEditingController();
  TextEditingController ukuranBatu22 = TextEditingController();
  TextEditingController ukuranBatu23 = TextEditingController();
  TextEditingController ukuranBatu24 = TextEditingController();
  TextEditingController ukuranBatu25 = TextEditingController();
  TextEditingController ukuranBatu26 = TextEditingController();
  TextEditingController ukuranBatu27 = TextEditingController();
  TextEditingController ukuranBatu28 = TextEditingController();
  TextEditingController ukuranBatu29 = TextEditingController();
  TextEditingController ukuranBatu30 = TextEditingController();
  TextEditingController ukuranBatu31 = TextEditingController();
  TextEditingController ukuranBatu32 = TextEditingController();
  TextEditingController ukuranBatu33 = TextEditingController();
  TextEditingController ukuranBatu34 = TextEditingController();
  TextEditingController ukuranBatu35 = TextEditingController();

  TextEditingController crtPcsBatu1 = TextEditingController();
  TextEditingController crtPcsBatu2 = TextEditingController();
  TextEditingController crtPcsBatu3 = TextEditingController();
  TextEditingController crtPcsBatu4 = TextEditingController();
  TextEditingController crtPcsBatu5 = TextEditingController();
  TextEditingController crtPcsBatu6 = TextEditingController();
  TextEditingController crtPcsBatu7 = TextEditingController();
  TextEditingController crtPcsBatu8 = TextEditingController();
  TextEditingController crtPcsBatu9 = TextEditingController();
  TextEditingController crtPcsBatu10 = TextEditingController();
  TextEditingController crtPcsBatu11 = TextEditingController();
  TextEditingController crtPcsBatu12 = TextEditingController();
  TextEditingController crtPcsBatu13 = TextEditingController();
  TextEditingController crtPcsBatu14 = TextEditingController();
  TextEditingController crtPcsBatu15 = TextEditingController();
  TextEditingController crtPcsBatu16 = TextEditingController();
  TextEditingController crtPcsBatu17 = TextEditingController();
  TextEditingController crtPcsBatu18 = TextEditingController();
  TextEditingController crtPcsBatu19 = TextEditingController();
  TextEditingController crtPcsBatu20 = TextEditingController();
  TextEditingController crtPcsBatu21 = TextEditingController();
  TextEditingController crtPcsBatu22 = TextEditingController();
  TextEditingController crtPcsBatu23 = TextEditingController();
  TextEditingController crtPcsBatu24 = TextEditingController();
  TextEditingController crtPcsBatu25 = TextEditingController();
  TextEditingController crtPcsBatu26 = TextEditingController();
  TextEditingController crtPcsBatu27 = TextEditingController();
  TextEditingController crtPcsBatu28 = TextEditingController();
  TextEditingController crtPcsBatu29 = TextEditingController();
  TextEditingController crtPcsBatu30 = TextEditingController();
  TextEditingController crtPcsBatu31 = TextEditingController();
  TextEditingController crtPcsBatu32 = TextEditingController();
  TextEditingController crtPcsBatu33 = TextEditingController();
  TextEditingController crtPcsBatu34 = TextEditingController();
  TextEditingController crtPcsBatu35 = TextEditingController();

  double? customGol1 = 15112500;
  double? customGol2 = 18600000;
  double? customGol3 = 20615000;
  double? customGol4 = 23870000;
  double? customGol5 = 28210000;
  double? customGol6 = 34255000;
  double? customGol7 = 40300000;
  double? customGol8 = 45337500;
  double? customGol9 = 48437500;
  double? customGol10 = 52312500;
  double? customGol11 = 56187500;
  double? customGol12 = 60062500;
  double? customGol13 = 63937500;
  double? customGol14 = 67812500;

  int? idStone1 = -1;
  int? idStone2 = -1;
  int? idStone3 = -1;
  int? idStone4 = -1;
  int? idStone5 = -1;
  int? idStone6 = -1;
  int? idStone7 = -1;
  int? idStone8 = -1;
  int? idStone9 = -1;
  int? idStone10 = -1;
  int? idStone11 = -1;
  int? idStone12 = -1;
  int? idStone13 = -1;
  int? idStone14 = -1;
  int? idStone15 = -1;
  int? idStone16 = -1;
  int? idStone17 = -1;
  int? idStone18 = -1;
  int? idStone19 = -1;
  int? idStone20 = -1;
  int? idStone21 = -1;
  int? idStone22 = -1;
  int? idStone23 = -1;
  int? idStone24 = -1;
  int? idStone25 = -1;
  int? idStone26 = -1;
  int? idStone27 = -1;
  int? idStone28 = -1;
  int? idStone29 = -1;
  int? idStone30 = -1;
  int? idStone31 = -1;
  int? idStone32 = -1;
  int? idStone33 = -1;
  int? idStone34 = -1;
  int? idStone35 = -1;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int beforeStokBatu1 = 0;
  int beforeStokBatu2 = 0;
  int beforeStokBatu3 = 0;
  int beforeStokBatu4 = 0;
  int beforeStokBatu5 = 0;
  int beforeStokBatu6 = 0;
  int beforeStokBatu7 = 0;
  int beforeStokBatu8 = 0;
  int beforeStokBatu9 = 0;
  int beforeStokBatu10 = 0;
  int beforeStokBatu11 = 0;
  int beforeStokBatu12 = 0;
  int beforeStokBatu13 = 0;
  int beforeStokBatu14 = 0;
  int beforeStokBatu15 = 0;
  int beforeStokBatu16 = 0;
  int beforeStokBatu17 = 0;
  int beforeStokBatu18 = 0;
  int beforeStokBatu19 = 0;
  int beforeStokBatu20 = 0;
  int beforeStokBatu21 = 0;
  int beforeStokBatu22 = 0;
  int beforeStokBatu23 = 0;
  int beforeStokBatu24 = 0;
  int beforeStokBatu25 = 0;
  int beforeStokBatu26 = 0;
  int beforeStokBatu27 = 0;
  int beforeStokBatu28 = 0;
  int beforeStokBatu29 = 0;
  int beforeStokBatu30 = 0;
  int beforeStokBatu31 = 0;
  int beforeStokBatu32 = 0;
  int beforeStokBatu33 = 0;
  int beforeStokBatu34 = 0;
  int beforeStokBatu35 = 0;

  int beforeIdBatu1 = 0;
  int beforeIdBatu2 = 0;
  int beforeIdBatu3 = 0;
  int beforeIdBatu4 = 0;
  int beforeIdBatu5 = 0;
  int beforeIdBatu6 = 0;
  int beforeIdBatu7 = 0;
  int beforeIdBatu8 = 0;
  int beforeIdBatu9 = 0;
  int beforeIdBatu10 = 0;
  int beforeIdBatu11 = 0;
  int beforeIdBatu12 = 0;
  int beforeIdBatu13 = 0;
  int beforeIdBatu14 = 0;
  int beforeIdBatu15 = 0;
  int beforeIdBatu16 = 0;
  int beforeIdBatu17 = 0;
  int beforeIdBatu18 = 0;
  int beforeIdBatu19 = 0;
  int beforeIdBatu20 = 0;
  int beforeIdBatu21 = 0;
  int beforeIdBatu22 = 0;
  int beforeIdBatu23 = 0;
  int beforeIdBatu24 = 0;
  int beforeIdBatu25 = 0;
  int beforeIdBatu26 = 0;
  int beforeIdBatu27 = 0;
  int beforeIdBatu28 = 0;
  int beforeIdBatu29 = 0;
  int beforeIdBatu30 = 0;
  int beforeIdBatu31 = 0;
  int beforeIdBatu32 = 0;
  int beforeIdBatu33 = 0;
  int beforeIdBatu34 = 0;
  int beforeIdBatu35 = 0;

  bool editkodeDesignMdbc = false;
  bool isBatu1 = false;
  bool isBatu2 = false;
  bool isBatu3 = false;
  bool isBatu4 = false;
  bool isBatu5 = false;
  bool isBatu6 = false;
  bool isBatu7 = false;
  bool isBatu8 = false;
  bool isBatu9 = false;
  bool isBatu10 = false;
  bool isBatu11 = false;
  bool isBatu12 = false;
  bool isBatu13 = false;
  bool isBatu14 = false;
  bool isBatu15 = false;
  bool isBatu16 = false;
  bool isBatu17 = false;
  bool isBatu18 = false;
  bool isBatu19 = false;
  bool isBatu20 = false;
  bool isBatu21 = false;
  bool isBatu22 = false;
  bool isBatu23 = false;
  bool isBatu24 = false;
  bool isBatu25 = false;
  bool isBatu26 = false;
  bool isBatu27 = false;
  bool isBatu28 = false;
  bool isBatu29 = false;
  bool isBatu30 = false;
  bool isBatu31 = false;
  bool isBatu32 = false;
  bool isBatu33 = false;
  bool isBatu34 = false;
  bool isBatu35 = false;

  int? idBatu1 = 0;
  int? idBatu2 = 0;
  int? idBatu3 = 0;
  int? idBatu4 = 0;
  int? idBatu5 = 0;
  int? idBatu6 = 0;
  int? idBatu7 = 0;
  int? idBatu8 = 0;
  int? idBatu9 = 0;
  int? idBatu10 = 0;
  int? idBatu11 = 0;
  int? idBatu12 = 0;
  int? idBatu13 = 0;
  int? idBatu14 = 0;
  int? idBatu15 = 0;
  int? idBatu16 = 0;
  int? idBatu17 = 0;
  int? idBatu18 = 0;
  int? idBatu19 = 0;
  int? idBatu20 = 0;
  int? idBatu21 = 0;
  int? idBatu22 = 0;
  int? idBatu23 = 0;
  int? idBatu24 = 0;
  int? idBatu25 = 0;
  int? idBatu26 = 0;
  int? idBatu27 = 0;
  int? idBatu28 = 0;
  int? idBatu29 = 0;
  int? idBatu30 = 0;
  int? idBatu31 = 0;
  int? idBatu32 = 0;
  int? idBatu33 = 0;
  int? idBatu34 = 0;
  int? idBatu35 = 0;

  TextEditingController kodeDesignMdbc = TextEditingController();
  TextEditingController siklus = TextEditingController();
  TextEditingController statusForm = TextEditingController();
  TextEditingController kodeMarketing = TextEditingController();
  TextEditingController kodeProduksi = TextEditingController();
  TextEditingController namaDesigner = TextEditingController();
  TextEditingController namaModeller = TextEditingController();
  TextEditingController kodeDesign = TextEditingController();
  TextEditingController tema = TextEditingController();
  TextEditingController rantai = TextEditingController();
  TextEditingController qtyRantai = TextEditingController();
  TextEditingController stokRantai = TextEditingController();
  TextEditingController lain2 = TextEditingController();
  TextEditingController qtyLain2 = TextEditingController();
  TextEditingController stokLain2 = TextEditingController();

  TextEditingController earnut = TextEditingController();
  TextEditingController qtyEarnut = TextEditingController();
  TextEditingController stokEarnut = TextEditingController();

  TextEditingController panjangRantai = TextEditingController();
  TextEditingController customKomponen = TextEditingController();
  TextEditingController qtyCustomKomponen = TextEditingController();
  TextEditingController stokCustomKomponen = TextEditingController();

  TextEditingController beratEmas = TextEditingController();
  TextEditingController estimasiHarga = TextEditingController();
  TextEditingController jenisBarang = TextEditingController();
  TextEditingController kategoriBarang = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController photoShoot = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController ringSize = TextEditingController();
  TextEditingController qtyBatu1 = TextEditingController();
  TextEditingController stokBatu1 = TextEditingController();
  TextEditingController qtyBatu2 = TextEditingController();
  TextEditingController stokBatu2 = TextEditingController();
  TextEditingController qtyBatu3 = TextEditingController();
  TextEditingController stokBatu3 = TextEditingController();
  TextEditingController qtyBatu4 = TextEditingController();
  TextEditingController stokBatu4 = TextEditingController();
  TextEditingController qtyBatu5 = TextEditingController();
  TextEditingController stokBatu5 = TextEditingController();
  TextEditingController qtyBatu6 = TextEditingController();
  TextEditingController stokBatu6 = TextEditingController();
  TextEditingController qtyBatu7 = TextEditingController();
  TextEditingController stokBatu7 = TextEditingController();
  TextEditingController qtyBatu8 = TextEditingController();
  TextEditingController stokBatu8 = TextEditingController();
  TextEditingController qtyBatu9 = TextEditingController();
  TextEditingController stokBatu9 = TextEditingController();
  TextEditingController qtyBatu10 = TextEditingController();
  TextEditingController stokBatu10 = TextEditingController();
  TextEditingController qtyBatu11 = TextEditingController();
  TextEditingController stokBatu11 = TextEditingController();
  TextEditingController qtyBatu12 = TextEditingController();
  TextEditingController stokBatu12 = TextEditingController();
  TextEditingController qtyBatu13 = TextEditingController();
  TextEditingController stokBatu13 = TextEditingController();
  TextEditingController qtyBatu14 = TextEditingController();
  TextEditingController stokBatu14 = TextEditingController();
  TextEditingController qtyBatu15 = TextEditingController();
  TextEditingController stokBatu15 = TextEditingController();
  TextEditingController qtyBatu16 = TextEditingController();
  TextEditingController stokBatu16 = TextEditingController();
  TextEditingController qtyBatu17 = TextEditingController();
  TextEditingController stokBatu17 = TextEditingController();
  TextEditingController qtyBatu18 = TextEditingController();
  TextEditingController stokBatu18 = TextEditingController();
  TextEditingController qtyBatu19 = TextEditingController();
  TextEditingController stokBatu19 = TextEditingController();
  TextEditingController qtyBatu20 = TextEditingController();
  TextEditingController stokBatu20 = TextEditingController();
  TextEditingController qtyBatu21 = TextEditingController();
  TextEditingController stokBatu21 = TextEditingController();
  TextEditingController qtyBatu22 = TextEditingController();
  TextEditingController stokBatu22 = TextEditingController();
  TextEditingController qtyBatu23 = TextEditingController();
  TextEditingController stokBatu23 = TextEditingController();
  TextEditingController qtyBatu24 = TextEditingController();
  TextEditingController stokBatu24 = TextEditingController();
  TextEditingController qtyBatu25 = TextEditingController();
  TextEditingController stokBatu25 = TextEditingController();
  TextEditingController qtyBatu26 = TextEditingController();
  TextEditingController stokBatu26 = TextEditingController();
  TextEditingController qtyBatu27 = TextEditingController();
  TextEditingController stokBatu27 = TextEditingController();
  TextEditingController qtyBatu28 = TextEditingController();
  TextEditingController stokBatu28 = TextEditingController();
  TextEditingController qtyBatu29 = TextEditingController();
  TextEditingController stokBatu29 = TextEditingController();
  TextEditingController qtyBatu30 = TextEditingController();
  TextEditingController stokBatu30 = TextEditingController();
  TextEditingController qtyBatu31 = TextEditingController();
  TextEditingController stokBatu31 = TextEditingController();
  TextEditingController qtyBatu32 = TextEditingController();
  TextEditingController stokBatu32 = TextEditingController();
  TextEditingController qtyBatu33 = TextEditingController();
  TextEditingController stokBatu33 = TextEditingController();
  TextEditingController qtyBatu34 = TextEditingController();
  TextEditingController stokBatu34 = TextEditingController();
  TextEditingController qtyBatu35 = TextEditingController();
  TextEditingController stokBatu35 = TextEditingController();

  String? batu1 = '';
  String? batu2 = '';
  String? batu3 = '';
  String? batu4 = '';
  String? batu5 = '';
  String? batu6 = '';
  String? batu7 = '';
  String? batu8 = '';
  String? batu9 = '';
  String? batu10 = '';
  String? batu11 = '';
  String? batu12 = '';
  String? batu13 = '';
  String? batu14 = '';
  String? batu15 = '';
  String? batu16 = '';
  String? batu17 = '';
  String? batu18 = '';
  String? batu19 = '';
  String? batu20 = '';
  String? batu21 = '';
  String? batu22 = '';
  String? batu23 = '';
  String? batu24 = '';
  String? batu25 = '';
  String? batu26 = '';
  String? batu27 = '';
  String? batu28 = '';
  String? batu29 = '';
  String? batu30 = '';
  String? batu31 = '';
  String? batu32 = '';
  String? batu33 = '';
  String? batu34 = '';
  String? batu35 = '';

  double hargaBatu1 = 0;
  double hargaBatu2 = 0;
  double hargaBatu3 = 0;
  double hargaBatu4 = 0;
  double hargaBatu5 = 0;
  double hargaBatu6 = 0;
  double hargaBatu7 = 0;
  double hargaBatu8 = 0;
  double hargaBatu9 = 0;
  double hargaBatu10 = 0;
  double hargaBatu11 = 0;
  double hargaBatu12 = 0;
  double hargaBatu13 = 0;
  double hargaBatu14 = 0;
  double hargaBatu15 = 0;
  double hargaBatu16 = 0;
  double hargaBatu17 = 0;
  double hargaBatu18 = 0;
  double hargaBatu19 = 0;
  double hargaBatu20 = 0;
  double hargaBatu21 = 0;
  double hargaBatu22 = 0;
  double hargaBatu23 = 0;
  double hargaBatu24 = 0;
  double hargaBatu25 = 0;
  double hargaBatu26 = 0;
  double hargaBatu27 = 0;
  double hargaBatu28 = 0;
  double hargaBatu29 = 0;
  double hargaBatu30 = 0;
  double hargaBatu31 = 0;
  double hargaBatu32 = 0;
  double hargaBatu33 = 0;
  double hargaBatu34 = 0;
  double hargaBatu35 = 0;

  double caratPcsBatu1 = 0;
  double caratPcsBatu2 = 0;
  double caratPcsBatu3 = 0;
  double caratPcsBatu4 = 0;
  double caratPcsBatu5 = 0;
  double caratPcsBatu6 = 0;
  double caratPcsBatu7 = 0;
  double caratPcsBatu8 = 0;
  double caratPcsBatu9 = 0;
  double caratPcsBatu10 = 0;
  double caratPcsBatu11 = 0;
  double caratPcsBatu12 = 0;
  double caratPcsBatu13 = 0;
  double caratPcsBatu14 = 0;
  double caratPcsBatu15 = 0;
  double caratPcsBatu16 = 0;
  double caratPcsBatu17 = 0;
  double caratPcsBatu18 = 0;
  double caratPcsBatu19 = 0;
  double caratPcsBatu20 = 0;
  double caratPcsBatu21 = 0;
  double caratPcsBatu22 = 0;
  double caratPcsBatu23 = 0;
  double caratPcsBatu24 = 0;
  double caratPcsBatu25 = 0;
  double caratPcsBatu26 = 0;
  double caratPcsBatu27 = 0;
  double caratPcsBatu28 = 0;
  double caratPcsBatu29 = 0;
  double caratPcsBatu30 = 0;
  double caratPcsBatu31 = 0;
  double caratPcsBatu32 = 0;
  double caratPcsBatu33 = 0;
  double caratPcsBatu34 = 0;
  double caratPcsBatu35 = 0;

  int? qtyIntBatu1 = 0;
  int? qtyIntBatu2 = 0;
  int? qtyIntBatu3 = 0;
  int? qtyIntBatu4 = 0;
  int? qtyIntBatu5 = 0;
  int? qtyIntBatu6 = 0;
  int? qtyIntBatu7 = 0;
  int? qtyIntBatu8 = 0;
  int? qtyIntBatu9 = 0;
  int? qtyIntBatu10 = 0;
  int? qtyIntBatu11 = 0;
  int? qtyIntBatu12 = 0;
  int? qtyIntBatu13 = 0;
  int? qtyIntBatu14 = 0;
  int? qtyIntBatu15 = 0;
  int? qtyIntBatu16 = 0;
  int? qtyIntBatu17 = 0;
  int? qtyIntBatu18 = 0;
  int? qtyIntBatu19 = 0;
  int? qtyIntBatu20 = 0;
  int? qtyIntBatu21 = 0;
  int? qtyIntBatu22 = 0;
  int? qtyIntBatu23 = 0;
  int? qtyIntBatu24 = 0;
  int? qtyIntBatu25 = 0;
  int? qtyIntBatu26 = 0;
  int? qtyIntBatu27 = 0;
  int? qtyIntBatu28 = 0;
  int? qtyIntBatu29 = 0;
  int? qtyIntBatu30 = 0;
  int? qtyIntBatu31 = 0;
  int? qtyIntBatu32 = 0;
  int? qtyIntBatu33 = 0;
  int? qtyIntBatu34 = 0;
  int? qtyIntBatu35 = 0;

  int? labour = 0;
  double doubleBeratEmas = 0;
  double doubleBeratEmasDariCustomer = 0;
  int emas = 0;
  double upEmas = 0;
  double upEmasMetier = 1.3;
  double upDiamondMetier = 1.1;
  double upLabour = 0;
  double upBatu = 0;
  double upFinal = 0;
  int kurs = 0;
  int others1 = 0;
  int others2 = 0;
  int others3 = 0;
  String? imageUrl = '';
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  int count = 0;
  List<PlatformFile>? _paths;
  String? lastIdForm = '0';

  @override
  void initState() {
    super.initState();
    kodeDesignMdbc.text = widget.modelDesigner!.kodeDesignMdbc!.toString();
    kodeMarketing.text = widget.modelDesigner!.kodeMarketing!.toString();
    kodeProduksi.text = widget.modelDesigner!.kodeProduksi!.toString();
    namaDesigner.text = widget.modelDesigner!.namaDesigner!.toString();
    namaModeller.text = widget.modelDesigner!.namaModeller!.toString();
    siklus.text = widget.modelDesigner!.siklus!.toString();
    statusForm.text = widget.modelDesigner!.statusForm!.toString();
    kodeDesign.text = widget.modelDesigner!.kodeDesign!.toString();
    tema.text = widget.modelDesigner!.tema!.toString();
    rantai.text = widget.modelDesigner!.rantai!.toString();
    qtyRantai.text = widget.modelDesigner!.qtyRantai!.toString();
    lain2.text = widget.modelDesigner!.lain2!.toString();
    qtyLain2.text = widget.modelDesigner!.qtyLain2!.toString();
    earnut.text = widget.modelDesigner!.earnut!.toString();
    qtyEarnut.text = widget.modelDesigner!.qtyEarnut!.toString();
    panjangRantai.text = widget.modelDesigner!.panjangRantai!.toString();
    customKomponen.text = widget.modelDesigner!.customKomponen!.toString();
    qtyCustomKomponen.text =
        widget.modelDesigner!.qtyCustomKomponen!.toString();
    jenisBarang.text = widget.modelDesigner!.jenisBarang!.toString();
    kategoriBarang.text = widget.modelDesigner!.kategoriBarang!.toString();
    brand.text = widget.modelDesigner!.brand!.toString();
    photoShoot.text = widget.modelDesigner!.photoShoot!.toString();
    color.text = widget.modelDesigner!.color!.toString();
    beratEmas.text = widget.modelDesigner!.beratEmas!.toString();
    doubleBeratEmas = widget.modelDesigner!.beratEmas!;
    estimasiHarga.text = widget.modelDesigner!.estimasiHarga!.toString();
    ringSize.text = widget.modelDesigner!.ringSize!.toString();
    batu1 = widget.modelDesigner!.batu1!.toString();
    qtyBatu1.text = widget.modelDesigner!.qtyBatu1!.toString();
    batu2 = widget.modelDesigner!.batu2!.toString();
    qtyBatu2.text = widget.modelDesigner!.qtyBatu2!.toString();
    batu3 = widget.modelDesigner!.batu3!.toString();
    qtyBatu3.text = widget.modelDesigner!.qtyBatu3!.toString();
    batu4 = widget.modelDesigner!.batu4!.toString();
    qtyBatu4.text = widget.modelDesigner!.qtyBatu4!.toString();
    batu5 = widget.modelDesigner!.batu5!.toString();
    qtyBatu5.text = widget.modelDesigner!.qtyBatu5!.toString();
    batu6 = widget.modelDesigner!.batu6!.toString();
    qtyBatu6.text = widget.modelDesigner!.qtyBatu6!.toString();
    batu7 = widget.modelDesigner!.batu7!.toString();
    qtyBatu7.text = widget.modelDesigner!.qtyBatu7!.toString();
    batu8 = widget.modelDesigner!.batu8!.toString();
    qtyBatu8.text = widget.modelDesigner!.qtyBatu8!.toString();
    batu9 = widget.modelDesigner!.batu9!.toString();
    qtyBatu9.text = widget.modelDesigner!.qtyBatu9!.toString();
    batu10 = widget.modelDesigner!.batu10!.toString();
    qtyBatu10.text = widget.modelDesigner!.qtyBatu10!.toString();
    batu11 = widget.modelDesigner!.batu11!.toString();
    qtyBatu11.text = widget.modelDesigner!.qtyBatu11!.toString();
    batu12 = widget.modelDesigner!.batu12!.toString();
    qtyBatu12.text = widget.modelDesigner!.qtyBatu12!.toString();
    batu13 = widget.modelDesigner!.batu13!.toString();
    qtyBatu13.text = widget.modelDesigner!.qtyBatu13!.toString();
    batu14 = widget.modelDesigner!.batu14!.toString();
    qtyBatu14.text = widget.modelDesigner!.qtyBatu14!.toString();
    batu15 = widget.modelDesigner!.batu15!.toString();
    qtyBatu15.text = widget.modelDesigner!.qtyBatu15!.toString();
    batu16 = widget.modelDesigner!.batu16!.toString();
    qtyBatu16.text = widget.modelDesigner!.qtyBatu16!.toString();
    batu17 = widget.modelDesigner!.batu17!.toString();
    qtyBatu17.text = widget.modelDesigner!.qtyBatu17!.toString();
    batu18 = widget.modelDesigner!.batu18!.toString();
    qtyBatu18.text = widget.modelDesigner!.qtyBatu18!.toString();
    batu19 = widget.modelDesigner!.batu19!.toString();
    qtyBatu19.text = widget.modelDesigner!.qtyBatu19!.toString();
    batu20 = widget.modelDesigner!.batu20!.toString();
    qtyBatu20.text = widget.modelDesigner!.qtyBatu20!.toString();
    batu21 = widget.modelDesigner!.batu21!.toString();
    qtyBatu21.text = widget.modelDesigner!.qtyBatu21!.toString();
    batu22 = widget.modelDesigner!.batu22!.toString();
    qtyBatu22.text = widget.modelDesigner!.qtyBatu22!.toString();
    batu23 = widget.modelDesigner!.batu23!.toString();
    qtyBatu23.text = widget.modelDesigner!.qtyBatu23!.toString();
    batu24 = widget.modelDesigner!.batu24!.toString();
    qtyBatu24.text = widget.modelDesigner!.qtyBatu24!.toString();
    batu25 = widget.modelDesigner!.batu25!.toString();
    qtyBatu25.text = widget.modelDesigner!.qtyBatu25!.toString();
    batu26 = widget.modelDesigner!.batu26!.toString();
    qtyBatu26.text = widget.modelDesigner!.qtyBatu26!.toString();
    batu27 = widget.modelDesigner!.batu27!.toString();
    qtyBatu27.text = widget.modelDesigner!.qtyBatu27!.toString();
    batu28 = widget.modelDesigner!.batu28!.toString();
    qtyBatu28.text = widget.modelDesigner!.qtyBatu28!.toString();
    batu29 = widget.modelDesigner!.batu29!.toString();
    qtyBatu29.text = widget.modelDesigner!.qtyBatu29!.toString();
    batu30 = widget.modelDesigner!.batu30!.toString();
    qtyBatu30.text = widget.modelDesigner!.qtyBatu30!.toString();
    batu31 = widget.modelDesigner!.batu31!.toString();
    qtyBatu31.text = widget.modelDesigner!.qtyBatu31!.toString();
    batu32 = widget.modelDesigner!.batu32!.toString();
    qtyBatu32.text = widget.modelDesigner!.qtyBatu32!.toString();
    batu33 = widget.modelDesigner!.batu33!.toString();
    qtyBatu33.text = widget.modelDesigner!.qtyBatu33!.toString();
    batu34 = widget.modelDesigner!.batu34!.toString();
    qtyBatu34.text = widget.modelDesigner!.qtyBatu34!.toString();
    batu35 = widget.modelDesigner!.batu35!.toString();
    qtyBatu35.text = widget.modelDesigner!.qtyBatu35!.toString();
    imageUrl = widget.modelDesigner!.imageUrl!.toString();
    qtyIntBatu1 = int.parse(qtyBatu1.text);
    qtyIntBatu2 = int.parse(qtyBatu2.text);
    qtyIntBatu3 = int.parse(qtyBatu3.text);
    qtyIntBatu4 = int.parse(qtyBatu4.text);
    qtyIntBatu5 = int.parse(qtyBatu5.text);
    qtyIntBatu6 = int.parse(qtyBatu6.text);
    qtyIntBatu7 = int.parse(qtyBatu7.text);
    qtyIntBatu8 = int.parse(qtyBatu8.text);
    qtyIntBatu9 = int.parse(qtyBatu9.text);
    qtyIntBatu10 = int.parse(qtyBatu10.text);
    qtyIntBatu11 = int.parse(qtyBatu11.text);
    qtyIntBatu12 = int.parse(qtyBatu12.text);
    qtyIntBatu13 = int.parse(qtyBatu13.text);
    qtyIntBatu14 = int.parse(qtyBatu14.text);
    qtyIntBatu15 = int.parse(qtyBatu15.text);
    qtyIntBatu16 = int.parse(qtyBatu16.text);
    qtyIntBatu17 = int.parse(qtyBatu17.text);
    qtyIntBatu18 = int.parse(qtyBatu18.text);
    qtyIntBatu19 = int.parse(qtyBatu19.text);
    qtyIntBatu20 = int.parse(qtyBatu20.text);
    qtyIntBatu21 = int.parse(qtyBatu21.text);
    qtyIntBatu22 = int.parse(qtyBatu22.text);
    qtyIntBatu23 = int.parse(qtyBatu23.text);
    qtyIntBatu24 = int.parse(qtyBatu24.text);
    qtyIntBatu25 = int.parse(qtyBatu25.text);
    qtyIntBatu26 = int.parse(qtyBatu26.text);
    qtyIntBatu27 = int.parse(qtyBatu27.text);
    qtyIntBatu28 = int.parse(qtyBatu28.text);
    qtyIntBatu29 = int.parse(qtyBatu29.text);
    qtyIntBatu30 = int.parse(qtyBatu30.text);
    qtyIntBatu31 = int.parse(qtyBatu31.text);
    qtyIntBatu32 = int.parse(qtyBatu32.text);
    qtyIntBatu33 = int.parse(qtyBatu33.text);
    qtyIntBatu34 = int.parse(qtyBatu34.text);
    qtyIntBatu35 = int.parse(qtyBatu35.text);

    _getDataBatu();
    _getData();
    getHargaJenisBarang(jenisBarang.text);
  }

  //start image
  XFile? image;
  final ImagePicker picker = ImagePicker();

  //end image
  // start image multi
  final ImagePicker imgpicker = ImagePicker();
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      // ignore: unnecessary_null_comparison
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  Future<void> _pickImage(id) async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      log('Unsupported operation$e');
    } catch (e) {
      log(e.toString());
    }
    setState(() {
      if (_paths != null) {
        if (_paths != null) {
          _imageFile = _paths!.first;
          imageUrl = _paths!.first.name;
          //passing file bytes and file name for API call
          ApiClient.uploadFile(_paths!.first.bytes!, _paths!.first.name, id);
        }
      }
    });
  }

  _getDataBatu() async {
    print('masuk get batu');
    //batu1
    if (qtyBatu1.text.toString() != '0') {
      print('masuk get batu 1');
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu1"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu1.text = data[0]['caratPcs'].toString();
          idStone1 = data[0]['idStone'];
          idBatu1 = data[0]['id'];
          stokBatu1.text = data[0]['qty'].toString();
          beforeStokBatu1 = data[0]['qty'];
          beforeIdBatu1 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu1 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu1"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu1.text = '';
          hargaBatu1 = data[0]['unitCost'];
          caratPcsBatu1 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu2
    if (qtyBatu2.text.toString() != '0') {
      print('masuk get batu 2');

      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu2"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu2.text = data[0]['caratPcs'].toString();
          idStone2 = data[0]['idStone'];
          idBatu2 = data[0]['id'];
          stokBatu2.text = data[0]['qty'].toString();
          beforeStokBatu2 = data[0]['qty'];
          beforeIdBatu2 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu2 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu2"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu2.text = '';
          hargaBatu2 = data[0]['unitCost'];
          caratPcsBatu2 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu3
    if (qtyBatu3.text.toString() != '0') {
      print('masuk get batu 3');

      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu3"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu3.text = data[0]['caratPcs'].toString();
          idStone3 = data[0]['idStone'];
          idBatu3 = data[0]['id'];
          stokBatu3.text = data[0]['qty'].toString();
          beforeStokBatu3 = data[0]['qty'];
          beforeIdBatu3 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu3 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu3"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu3.text = '';
          hargaBatu3 = data[0]['unitCost'];
          caratPcsBatu3 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

//batu4
    if (qtyBatu4.text.toString() != '0') {
      print('masuk get batu 4');

      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu4"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu4.text = data[0]['caratPcs'].toString();
          idStone4 = data[0]['idStone'];
          idBatu4 = data[0]['id'];
          stokBatu4.text = data[0]['qty'].toString();
          beforeStokBatu4 = data[0]['qty'];
          beforeIdBatu4 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu4 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu4"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu4.text = '';
          hargaBatu4 = data[0]['unitCost'];
          caratPcsBatu4 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

//batu5
    if (qtyBatu5.text.toString() != '0') {
      print('masuk get batu 5');

      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu5"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu5.text = data[0]['caratPcs'].toString();
          idStone5 = data[0]['idStone'];
          idBatu5 = data[0]['id'];
          stokBatu5.text = data[0]['qty'].toString();
          beforeStokBatu5 = data[0]['qty'];
          beforeIdBatu5 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu5 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu5"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu5.text = '';
          hargaBatu5 = data[0]['unitCost'];
          caratPcsBatu5 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu6
    if (qtyBatu6.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu6"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu6.text = data[0]['caratPcs'].toString();
          idStone6 = data[0]['idStone'];
          idBatu6 = data[0]['id'];
          stokBatu6.text = data[0]['qty'].toString();
          beforeStokBatu6 = data[0]['qty'];
          beforeIdBatu6 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu6 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu6"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu6.text = '';
          hargaBatu6 = data[0]['unitCost'];
          caratPcsBatu6 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

//batu7
    if (qtyBatu7.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu7"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu7.text = data[0]['caratPcs'].toString();
          idStone7 = data[0]['idStone'];
          idBatu7 = data[0]['id'];
          stokBatu7.text = data[0]['qty'].toString();
          beforeStokBatu7 = data[0]['qty'];
          beforeIdBatu7 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu7 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu7"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu7.text = '';
          hargaBatu7 = data[0]['unitCost'];
          caratPcsBatu7 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

//batu8
    if (qtyBatu8.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu8"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu8.text = data[0]['caratPcs'].toString();
          idStone8 = data[0]['idStone'];
          idBatu8 = data[0]['id'];
          stokBatu8.text = data[0]['qty'].toString();
          beforeStokBatu8 = data[0]['qty'];
          beforeIdBatu8 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu8 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu8"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu8.text = '';
          hargaBatu8 = data[0]['unitCost'];
          caratPcsBatu8 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

//batu9
    if (qtyBatu9.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu9"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu9.text = data[0]['caratPcs'].toString();
          idStone9 = data[0]['idStone'];
          idBatu9 = data[0]['id'];
          stokBatu9.text = data[0]['qty'].toString();
          beforeStokBatu9 = data[0]['qty'];
          beforeIdBatu9 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu9 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu9"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu9.text = '';
          hargaBatu9 = data[0]['unitCost'];
          caratPcsBatu9 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu10
    if (qtyBatu10.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu10"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu10.text = data[0]['caratPcs'].toString();
          idStone10 = data[0]['idStone'];
          idBatu10 = data[0]['id'];
          stokBatu10.text = data[0]['qty'].toString();
          beforeStokBatu10 = data[0]['qty'];
          beforeIdBatu10 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu10 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu10"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu10.text = '';
          hargaBatu10 = data[0]['unitCost'];
          caratPcsBatu10 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu11
    if (qtyBatu11.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu11"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu11.text = data[0]['caratPcs'].toString();
          idStone11 = data[0]['idStone'];
          idBatu11 = data[0]['id'];
          stokBatu11.text = data[0]['qty'].toString();
          beforeStokBatu11 = data[0]['qty'];
          beforeIdBatu11 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu11 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu11"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu11.text = '';
          hargaBatu11 = data[0]['unitCost'];
          caratPcsBatu11 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu12
    if (qtyBatu12.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu12"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu12.text = data[0]['caratPcs'].toString();
          idStone12 = data[0]['idStone'];
          idBatu12 = data[0]['id'];
          stokBatu12.text = data[0]['qty'].toString();
          beforeStokBatu12 = data[0]['qty'];
          beforeIdBatu12 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu12 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu12"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu12.text = '';
          hargaBatu12 = data[0]['unitCost'];
          caratPcsBatu12 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu13
    if (qtyBatu13.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu13"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu13.text = data[0]['caratPcs'].toString();
          idStone13 = data[0]['idStone'];
          idBatu13 = data[0]['id'];
          stokBatu13.text = data[0]['qty'].toString();
          beforeStokBatu13 = data[0]['qty'];
          beforeIdBatu13 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu13 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu13"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu13.text = '';
          hargaBatu13 = data[0]['unitCost'];
          caratPcsBatu13 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu14
    if (qtyBatu14.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu14"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu14.text = data[0]['caratPcs'].toString();
          idStone14 = data[0]['idStone'];
          idBatu14 = data[0]['id'];
          stokBatu14.text = data[0]['qty'].toString();
          beforeStokBatu14 = data[0]['qty'];
          beforeIdBatu14 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu14 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu14"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu14.text = '';
          hargaBatu14 = data[0]['unitCost'];
          caratPcsBatu14 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu15
    if (qtyBatu15.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu15"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu15.text = data[0]['caratPcs'].toString();
          idStone15 = data[0]['idStone'];
          idBatu15 = data[0]['id'];
          stokBatu15.text = data[0]['qty'].toString();
          beforeStokBatu15 = data[0]['qty'];
          beforeIdBatu15 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu15 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu15"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu15.text = '';
          hargaBatu15 = data[0]['unitCost'];
          caratPcsBatu15 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
//batu16
    if (qtyBatu16.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu16"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu16.text = data[0]['caratPcs'].toString();
          idStone16 = data[0]['idStone'];
          idBatu16 = data[0]['id'];
          stokBatu16.text = data[0]['qty'].toString();
          beforeStokBatu16 = data[0]['qty'];
          beforeIdBatu16 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu16 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu16"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu16.text = '';
          hargaBatu16 = data[0]['unitCost'];
          caratPcsBatu16 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu17
    if (qtyBatu17.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu17"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu17.text = data[0]['caratPcs'].toString();
          idStone17 = data[0]['idStone'];
          idBatu17 = data[0]['id'];
          stokBatu17.text = data[0]['qty'].toString();
          beforeStokBatu17 = data[0]['qty'];
          beforeIdBatu17 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu17 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu17"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu17.text = '';
          hargaBatu17 = data[0]['unitCost'];
          caratPcsBatu17 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
//batu18
    if (qtyBatu18.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu18"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu18.text = data[0]['caratPcs'].toString();
          idStone18 = data[0]['idStone'];
          idBatu18 = data[0]['id'];
          stokBatu18.text = data[0]['qty'].toString();
          beforeStokBatu18 = data[0]['qty'];
          beforeIdBatu18 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu18 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu18"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu18.text = '';
          hargaBatu18 = data[0]['unitCost'];
          caratPcsBatu18 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

//batu19
    if (qtyBatu19.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu19"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu19.text = data[0]['caratPcs'].toString();
          idStone19 = data[0]['idStone'];
          idBatu19 = data[0]['id'];
          stokBatu19.text = data[0]['qty'].toString();
          beforeStokBatu19 = data[0]['qty'];
          beforeIdBatu19 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu19 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu19"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu19.text = '';
          hargaBatu19 = data[0]['unitCost'];
          caratPcsBatu19 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
    //batu20
    if (qtyBatu20.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu20"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu20.text = data[0]['caratPcs'].toString();
          idStone20 = data[0]['idStone'];
          idBatu20 = data[0]['id'];
          stokBatu20.text = data[0]['qty'].toString();
          beforeStokBatu20 = data[0]['qty'];
          beforeIdBatu20 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu20 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu20"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu20.text = '';
          hargaBatu20 = data[0]['unitCost'];
          caratPcsBatu20 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
//batu21
    if (qtyBatu21.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu21"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu21.text = data[0]['caratPcs'].toString();
          idStone21 = data[0]['idStone'];
          idBatu21 = data[0]['id'];
          stokBatu21.text = data[0]['qty'].toString();
          beforeStokBatu21 = data[0]['qty'];
          beforeIdBatu21 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu21 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu21"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu21.text = '';
          hargaBatu21 = data[0]['unitCost'];
          caratPcsBatu21 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu22
    if (qtyBatu22.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu22"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu22.text = data[0]['caratPcs'].toString();
          idStone22 = data[0]['idStone'];
          idBatu22 = data[0]['id'];
          stokBatu22.text = data[0]['qty'].toString();
          beforeStokBatu22 = data[0]['qty'];
          beforeIdBatu22 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu22 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu22"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu22.text = '';
          hargaBatu22 = data[0]['unitCost'];
          caratPcsBatu22 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu23
    if (qtyBatu23.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu23"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu23.text = data[0]['caratPcs'].toString();
          idStone23 = data[0]['idStone'];
          idBatu23 = data[0]['id'];
          stokBatu23.text = data[0]['qty'].toString();
          beforeStokBatu23 = data[0]['qty'];
          beforeIdBatu23 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu23 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu23"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu23.text = '';
          hargaBatu23 = data[0]['unitCost'];
          caratPcsBatu23 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu24
    if (qtyBatu24.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu24"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu24.text = data[0]['caratPcs'].toString();
          idStone24 = data[0]['idStone'];
          idBatu24 = data[0]['id'];
          stokBatu24.text = data[0]['qty'].toString();
          beforeStokBatu24 = data[0]['qty'];
          beforeIdBatu24 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu24 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu24"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu24.text = '';
          hargaBatu24 = data[0]['unitCost'];
          caratPcsBatu24 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu25
    if (qtyBatu25.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu25"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu25.text = data[0]['caratPcs'].toString();
          idStone25 = data[0]['idStone'];
          idBatu25 = data[0]['id'];
          stokBatu25.text = data[0]['qty'].toString();
          beforeStokBatu25 = data[0]['qty'];
          beforeIdBatu25 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu25 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu25"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu25.text = '';
          hargaBatu25 = data[0]['unitCost'];
          caratPcsBatu25 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
//batu26
    if (qtyBatu26.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu26"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu26.text = data[0]['caratPcs'].toString();
          idStone26 = data[0]['idStone'];
          idBatu26 = data[0]['id'];
          stokBatu26.text = data[0]['qty'].toString();
          beforeStokBatu26 = data[0]['qty'];
          beforeIdBatu26 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu26 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu26"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu26.text = '';
          hargaBatu26 = data[0]['unitCost'];
          caratPcsBatu26 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu27
    if (qtyBatu27.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu27"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu27.text = data[0]['caratPcs'].toString();
          idStone27 = data[0]['idStone'];
          idBatu27 = data[0]['id'];
          stokBatu27.text = data[0]['qty'].toString();
          beforeStokBatu27 = data[0]['qty'];
          beforeIdBatu27 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu27 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu27"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu27.text = '';
          hargaBatu27 = data[0]['unitCost'];
          caratPcsBatu27 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
//batu28
    if (qtyBatu28.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu28"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu28.text = data[0]['caratPcs'].toString();
          idStone28 = data[0]['idStone'];
          idBatu28 = data[0]['id'];
          stokBatu28.text = data[0]['qty'].toString();
          beforeStokBatu28 = data[0]['qty'];
          beforeIdBatu28 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu28 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu28"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu28.text = '';
          hargaBatu28 = data[0]['unitCost'];
          caratPcsBatu28 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

//batu29
    if (qtyBatu29.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu29"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu29.text = data[0]['caratPcs'].toString();
          idStone29 = data[0]['idStone'];
          idBatu29 = data[0]['id'];
          stokBatu29.text = data[0]['qty'].toString();
          beforeStokBatu29 = data[0]['qty'];
          beforeIdBatu29 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu29 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu29"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu29.text = '';
          hargaBatu29 = data[0]['unitCost'];
          caratPcsBatu29 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu30
    if (qtyBatu30.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu30"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu30.text = data[0]['caratPcs'].toString();
          idStone30 = data[0]['idStone'];
          idBatu30 = data[0]['id'];
          stokBatu30.text = data[0]['qty'].toString();
          beforeStokBatu30 = data[0]['qty'];
          beforeIdBatu30 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu30 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu30"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu30.text = '';
          hargaBatu30 = data[0]['unitCost'];
          caratPcsBatu30 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
    //batu31
    if (qtyBatu31.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu31"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu31.text = data[0]['caratPcs'].toString();
          idStone31 = data[0]['idStone'];
          idBatu31 = data[0]['id'];
          stokBatu31.text = data[0]['qty'].toString();
          beforeStokBatu31 = data[0]['qty'];
          beforeIdBatu31 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu31 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu31"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu31.text = '';
          hargaBatu31 = data[0]['unitCost'];
          caratPcsBatu31 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu32
    if (qtyBatu32.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu32"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu32.text = data[0]['caratPcs'].toString();
          idStone32 = data[0]['idStone'];
          idBatu32 = data[0]['id'];
          stokBatu32.text = data[0]['qty'].toString();
          beforeStokBatu32 = data[0]['qty'];
          beforeIdBatu32 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu32 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu32"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu32.text = '';
          hargaBatu32 = data[0]['unitCost'];
          caratPcsBatu32 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu33
    if (qtyBatu33.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu33"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu33.text = data[0]['caratPcs'].toString();
          idStone33 = data[0]['idStone'];
          idBatu33 = data[0]['id'];
          stokBatu33.text = data[0]['qty'].toString();
          beforeStokBatu33 = data[0]['qty'];
          beforeIdBatu33 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu33 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu33"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu33.text = '';
          hargaBatu33 = data[0]['unitCost'];
          caratPcsBatu33 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu34
    if (qtyBatu34.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu34"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu34.text = data[0]['caratPcs'].toString();
          idStone34 = data[0]['idStone'];
          idBatu34 = data[0]['id'];
          stokBatu34.text = data[0]['qty'].toString();
          beforeStokBatu34 = data[0]['qty'];
          beforeIdBatu34 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu34 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu34"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu34.text = '';
          hargaBatu34 = data[0]['unitCost'];
          caratPcsBatu34 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }

    //batu35
    if (qtyBatu35.text.toString() != '0') {
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu35"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          crtPcsBatu35.text = data[0]['caratPcs'].toString();
          idStone35 = data[0]['idStone'];
          idBatu35 = data[0]['id'];
          stokBatu35.text = data[0]['qty'].toString();
          beforeStokBatu35 = data[0]['qty'];
          beforeIdBatu35 = data[0]['id'];
        }
      } catch (e) {
        print('Error get data batu');
      }
      //batu35 mdbc
      try {
        final response = await http.get(
          Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.getBatuMdbcByKeyword}?size="$batu35"'),
        );
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          ukuranBatu35.text = '';
          hargaBatu35 = data[0]['unitCost'];
          caratPcsBatu35 = data[0]['caratPcs'];
        }
      } catch (e) {
        print('Error get data batu mdbc');
      }
    }
  }

  getHargaJenisBarang(jenisBarang) async {
    print('masuk get harga labour');
    print(jenisBarang);
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getListJenisBarangById}?nama=$jenisBarang'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        labour = data[0]['harga'];
      }
    } catch (e) {
      print('Error get data batu');
    }
    Future.delayed(const Duration(seconds: 5)).then((value) {
      //! lalu eksekusi fungsi ini
      setState(() {
        isLoading = true;
      });
    });
  }

  _getData() async {
    print('masuk get data');
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getNilaiData));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          emas = data[0]['emas'];
          upEmas = data[0]['upEmas'];
          upBatu = data[0]['upBatu'];
          upLabour = data[0]['upLabour'];
          upFinal = data[0]['upFinal'];
          kurs = data[0]['kurs'];
          others1 = data[0]['others1'];
          others2 = data[0]['others2'];
          others3 = data[0]['others3'];
        });
      }
    } catch (e) {
      print('Error get data batu');
    }
  }

  double get totalPriceParva {
    var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
        (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
        (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
        (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
        (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
        (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
        (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
        (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
        (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
        (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
        (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
        (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
        (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
        (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
        (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
        (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
        (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
        (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
        (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
        (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
        (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
        (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
        (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
        (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
        (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
        (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
        (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
        (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
        (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
        (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
        (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
        (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
        (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
        (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
        (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));
    var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                (caratPcsBatu2 * qtyIntBatu2!) +
                (caratPcsBatu3 * qtyIntBatu3!) +
                (caratPcsBatu4 * qtyIntBatu4!) +
                (caratPcsBatu5 * qtyIntBatu5!) +
                (caratPcsBatu6 * qtyIntBatu6!) +
                (caratPcsBatu7 * qtyIntBatu7!) +
                (caratPcsBatu8 * qtyIntBatu8!) +
                (caratPcsBatu9 * qtyIntBatu9!) +
                (caratPcsBatu10 * qtyIntBatu10!) +
                (caratPcsBatu11 * qtyIntBatu11!) +
                (caratPcsBatu12 * qtyIntBatu12!) +
                (caratPcsBatu13 * qtyIntBatu13!) +
                (caratPcsBatu14 * qtyIntBatu14!) +
                (caratPcsBatu15 * qtyIntBatu15!) +
                (caratPcsBatu16 * qtyIntBatu16!) +
                (caratPcsBatu17 * qtyIntBatu17!) +
                (caratPcsBatu18 * qtyIntBatu18!) +
                (caratPcsBatu19 * qtyIntBatu19!) +
                (caratPcsBatu20 * qtyIntBatu20!) +
                (caratPcsBatu21 * qtyIntBatu21!) +
                (caratPcsBatu22 * qtyIntBatu22!) +
                (caratPcsBatu23 * qtyIntBatu23!) +
                (caratPcsBatu24 * qtyIntBatu24!) +
                (caratPcsBatu25 * qtyIntBatu25!) +
                (caratPcsBatu26 * qtyIntBatu26!) +
                (caratPcsBatu27 * qtyIntBatu27!) +
                (caratPcsBatu28 * qtyIntBatu28!) +
                (caratPcsBatu29 * qtyIntBatu29!) +
                (caratPcsBatu30 * qtyIntBatu30!) +
                (caratPcsBatu31 * qtyIntBatu31!) +
                (caratPcsBatu32 * qtyIntBatu32!) +
                (caratPcsBatu33 * qtyIntBatu33!) +
                (caratPcsBatu34 * qtyIntBatu34!) +
                (caratPcsBatu35 * qtyIntBatu35!)) +
            doubleBeratEmasDariCustomer) /
        5);
    double totalEmas;
    totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);
    var totalLabour = ((labour! + 0) * upLabour);
    double total;
    total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;

    if (total.toString() == 'NaN') {
      return 0;
    } else if (total < 1500) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));
      print(totalDiamond);

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);
      print(totalEmas);
      var totalLabour = ((labour!) * upLabour);
      print(totalLabour);
      double total;
      total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;
      var output =
          total.round().toString()[total.round().toString().length - 1];

      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('parva/fine others1 a');
          total = (total + (5 - int.parse(output)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('parva/fine others1 b');

          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('parva/fine others1 ori');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else if (total <= 2251) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));
      print(totalDiamond);

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);
      print(totalEmas);

      var totalLabour = ((labour! + others1) * upLabour);
      print(totalLabour);

      double total;
      total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;
      var output =
          total.round().toString()[total.round().toString().length - 1];

      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('parva/fine others1 a');

          total = (total + (5 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('parva/fine others1 b');

          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('parva/fine others1 ori');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else if (total <= 4000) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));
      print(totalDiamond);

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);

      var totalLabour = ((labour! + others2) * upLabour);
      double total;
      total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;

      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others2');
          total = (total + (5 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others2');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others2');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);

      var totalLabour = ((labour! + others3) * upLabour);
      double total;
      total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;

      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others3');
          total = (total + (5 - int.parse(output)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others3');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others3');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    }
  }

  double get totalPriceBeliBerlian {
    var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
        (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
        (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
        (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
        (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
        (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
        (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
        (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
        (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
        (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
        (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
        (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
        (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
        (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
        (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
        (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
        (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
        (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
        (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
        (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
        (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
        (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
        (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
        (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
        (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
        (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
        (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
        (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
        (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
        (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
        (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
        (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
        (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
        (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
        (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));
    print('Diamond $totalDiamond');
    var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                (caratPcsBatu2 * qtyIntBatu2!) +
                (caratPcsBatu3 * qtyIntBatu3!) +
                (caratPcsBatu4 * qtyIntBatu4!) +
                (caratPcsBatu5 * qtyIntBatu5!) +
                (caratPcsBatu6 * qtyIntBatu6!) +
                (caratPcsBatu7 * qtyIntBatu7!) +
                (caratPcsBatu8 * qtyIntBatu8!) +
                (caratPcsBatu9 * qtyIntBatu9!) +
                (caratPcsBatu10 * qtyIntBatu10!) +
                (caratPcsBatu11 * qtyIntBatu11!) +
                (caratPcsBatu12 * qtyIntBatu12!) +
                (caratPcsBatu13 * qtyIntBatu13!) +
                (caratPcsBatu14 * qtyIntBatu14!) +
                (caratPcsBatu15 * qtyIntBatu15!) +
                (caratPcsBatu16 * qtyIntBatu16!) +
                (caratPcsBatu17 * qtyIntBatu17!) +
                (caratPcsBatu18 * qtyIntBatu18!) +
                (caratPcsBatu19 * qtyIntBatu19!) +
                (caratPcsBatu20 * qtyIntBatu20!) +
                (caratPcsBatu21 * qtyIntBatu21!) +
                (caratPcsBatu22 * qtyIntBatu22!) +
                (caratPcsBatu23 * qtyIntBatu23!) +
                (caratPcsBatu24 * qtyIntBatu24!) +
                (caratPcsBatu25 * qtyIntBatu25!) +
                (caratPcsBatu26 * qtyIntBatu26!) +
                (caratPcsBatu27 * qtyIntBatu27!) +
                (caratPcsBatu28 * qtyIntBatu28!) +
                (caratPcsBatu29 * qtyIntBatu29!) +
                (caratPcsBatu30 * qtyIntBatu30!) +
                (caratPcsBatu31 * qtyIntBatu31!) +
                (caratPcsBatu32 * qtyIntBatu32!) +
                (caratPcsBatu33 * qtyIntBatu33!) +
                (caratPcsBatu34 * qtyIntBatu34!) +
                (caratPcsBatu35 * qtyIntBatu35!)) +
            doubleBeratEmasDariCustomer) /
        5);
    double totalEmas;
    totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
    var totalLabour = ((labour! + 0) * upLabour);
    double total;
    total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
            upFinal) /
        kurs;

    if (total.toString() == 'NaN') {
      return 0;
    } else if (total < 1500) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      var totalLabour = ((labour!) * upLabour);
      double total;
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour));
      total = ((total * 1.2) * 1.33);
      var output =
          total.round().toString()[total.round().toString().length - 1];

      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('tanpa others');

          total = (total + (5 - int.parse(output)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('tanpa others');

          total = (total + (10 - int.parse(output)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('tanpa others');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else if (total <= 2251) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      var totalLabour = ((labour! + others1) * upLabour);
      double total;
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour));
      total = ((total * 1.2) * 1.33);
      var output =
          total.round().toString()[total.round().toString().length - 1];

      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others1');
          total = (total + (5 - int.parse(output)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others1');
          total = (total + (10 - int.parse(output)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others1');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else if (total <= 4000) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      var totalLabour = ((labour! + others2) * upLabour);
      double total;
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour));
      total = ((total * 1.2) * 1.33);
      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others2');
          total = (total + (5 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others2');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others2');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      var totalLabour = ((labour! + others3) * upLabour);
      double total;
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour));
      total = ((total * 1.2) * 1.33);
      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others3');
          total = (total + (5 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others3');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others3');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    }
  }

  double get totalPriceMetier {
    var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
        (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
        (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
        (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
        (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
        (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
        (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
        (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
        (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
        (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
        (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
        (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
        (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
        (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
        (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
        (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
        (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
        (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
        (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
        (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
        (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
        (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
        (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
        (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
        (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
        (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
        (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
        (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
        (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
        (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
        (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
        (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
        (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
        (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
        (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));
    print('Diamond $totalDiamond');
    var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                (caratPcsBatu2 * qtyIntBatu2!) +
                (caratPcsBatu3 * qtyIntBatu3!) +
                (caratPcsBatu4 * qtyIntBatu4!) +
                (caratPcsBatu5 * qtyIntBatu5!) +
                (caratPcsBatu6 * qtyIntBatu6!) +
                (caratPcsBatu7 * qtyIntBatu7!) +
                (caratPcsBatu8 * qtyIntBatu8!) +
                (caratPcsBatu9 * qtyIntBatu9!) +
                (caratPcsBatu10 * qtyIntBatu10!) +
                (caratPcsBatu11 * qtyIntBatu11!) +
                (caratPcsBatu12 * qtyIntBatu12!) +
                (caratPcsBatu13 * qtyIntBatu13!) +
                (caratPcsBatu14 * qtyIntBatu14!) +
                (caratPcsBatu15 * qtyIntBatu15!) +
                (caratPcsBatu16 * qtyIntBatu16!) +
                (caratPcsBatu17 * qtyIntBatu17!) +
                (caratPcsBatu18 * qtyIntBatu18!) +
                (caratPcsBatu19 * qtyIntBatu19!) +
                (caratPcsBatu20 * qtyIntBatu20!) +
                (caratPcsBatu21 * qtyIntBatu21!) +
                (caratPcsBatu22 * qtyIntBatu22!) +
                (caratPcsBatu23 * qtyIntBatu23!) +
                (caratPcsBatu24 * qtyIntBatu24!) +
                (caratPcsBatu25 * qtyIntBatu25!) +
                (caratPcsBatu26 * qtyIntBatu26!) +
                (caratPcsBatu27 * qtyIntBatu27!) +
                (caratPcsBatu28 * qtyIntBatu28!) +
                (caratPcsBatu29 * qtyIntBatu29!) +
                (caratPcsBatu30 * qtyIntBatu30!) +
                (caratPcsBatu31 * qtyIntBatu31!) +
                (caratPcsBatu32 * qtyIntBatu32!) +
                (caratPcsBatu33 * qtyIntBatu33!) +
                (caratPcsBatu34 * qtyIntBatu34!) +
                (caratPcsBatu35 * qtyIntBatu35!)) +
            doubleBeratEmasDariCustomer) /
        5);

    double totalEmas;
    totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
    var totalLabour = ((labour! + 0) * upLabour);
    double total;
    total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
            upFinal) /
        kurs;

    if (total.toString() == 'NaN') {
      return 0;
    } else if (total < 1500) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      print('ini diamond : $totalDiamond * $upDiamondMetier');
      print('ini emas : $totalEmas');
      var totalLabour = ((labour!) * upLabour);
      print('ini labour : $totalLabour');
      print('$labour! & $upLabour');

      double total;
      total = (((totalDiamond * upDiamondMetier) +
          totalEmas +
          totalLabour)); //final
      var totalwholesale = (((total.round()) * 1.2)); //wholesale
      total = (((total.round()) * 1.2) * 1.65); //retail
      print(totalwholesale);
      var output =
          total.round().toString()[total.round().toString().length - 5];
      var result = total.round().toString().lastChars(5); // 'World'
      if (int.parse(output) >= 0 && int.parse(output) <= 4) {
        setState(() {
          print('tanpa others');

          total = (total + (50000 - int.parse(result)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('tanpa others');

          total = (total + (100000 - int.parse(result)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('tanpa others');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else if (total <= 2251) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      print('ini diamond : $totalDiamond * $upDiamondMetier');
      print('ini emas : $totalEmas');
      var totalLabour = ((labour! + others1) * upLabour);
      print('ini labour : $totalLabour');
      print('$labour! & $others1 & $upLabour');

      double total;
      total = (((totalDiamond * upDiamondMetier) +
          totalEmas +
          totalLabour)); //final
      var totalwholesale = (((total.round()) * 1.2)); //wholesale
      total = (((total.round()) * 1.2) * 1.65); //retail
      print(totalwholesale);
      var output =
          total.round().toString()[total.round().toString().length - 5];
      var result = total.round().toString().lastChars(5); // 'World'
      if (int.parse(output) >= 0 && int.parse(output) <= 4) {
        setState(() {
          print('others1');
          total = (total + (50000 - int.parse(result)));
          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others1');
          total = (total + (100000 - int.parse(result)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others1');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else if (total <= 4000) {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
                  (caratPcsBatu2 * qtyIntBatu2!) +
                  (caratPcsBatu3 * qtyIntBatu3!) +
                  (caratPcsBatu4 * qtyIntBatu4!) +
                  (caratPcsBatu5 * qtyIntBatu5!) +
                  (caratPcsBatu6 * qtyIntBatu6!) +
                  (caratPcsBatu7 * qtyIntBatu7!) +
                  (caratPcsBatu8 * qtyIntBatu8!) +
                  (caratPcsBatu9 * qtyIntBatu9!) +
                  (caratPcsBatu10 * qtyIntBatu10!) +
                  (caratPcsBatu11 * qtyIntBatu11!) +
                  (caratPcsBatu12 * qtyIntBatu12!) +
                  (caratPcsBatu13 * qtyIntBatu13!) +
                  (caratPcsBatu14 * qtyIntBatu14!) +
                  (caratPcsBatu15 * qtyIntBatu15!) +
                  (caratPcsBatu16 * qtyIntBatu16!) +
                  (caratPcsBatu17 * qtyIntBatu17!) +
                  (caratPcsBatu18 * qtyIntBatu18!) +
                  (caratPcsBatu19 * qtyIntBatu19!) +
                  (caratPcsBatu20 * qtyIntBatu20!) +
                  (caratPcsBatu21 * qtyIntBatu21!) +
                  (caratPcsBatu22 * qtyIntBatu22!) +
                  (caratPcsBatu23 * qtyIntBatu23!) +
                  (caratPcsBatu24 * qtyIntBatu24!) +
                  (caratPcsBatu25 * qtyIntBatu25!) +
                  (caratPcsBatu26 * qtyIntBatu26!) +
                  (caratPcsBatu27 * qtyIntBatu27!) +
                  (caratPcsBatu28 * qtyIntBatu28!) +
                  (caratPcsBatu29 * qtyIntBatu29!) +
                  (caratPcsBatu30 * qtyIntBatu30!) +
                  (caratPcsBatu31 * qtyIntBatu31!) +
                  (caratPcsBatu32 * qtyIntBatu32!) +
                  (caratPcsBatu33 * qtyIntBatu33!) +
                  (caratPcsBatu34 * qtyIntBatu34!) +
                  (caratPcsBatu35 * qtyIntBatu35!)) +
              doubleBeratEmasDariCustomer) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      print('ini emas : $totalEmas');
      print('ini diamond : $totalDiamond * $upDiamondMetier');

      var totalLabour = ((labour! + others2) * upLabour);
      double total;
      print('$labour! & $others2 & $upLabour');
      print('ini labour : $totalLabour');
      total = (((totalDiamond * upDiamondMetier) +
          totalEmas +
          totalLabour)); //final
      var totalwholesale = (((total.round()) * 1.2)); //wholesale
      total = (((total.round()) * 1.2) * 1.65); //retail
      print(totalwholesale);
      var output =
          total.round().toString()[total.round().toString().length - 5];
      var result = total.round().toString().lastChars(5); // 'World'
      print(result);
      if (int.parse(output) >= 0 && int.parse(output) <= 4) {
        setState(() {
          print('others2');
          total = (total + (50000 - int.parse(result)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others2');
          total = (total + (100000 - int.parse(result)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others2');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    } else {
      var totalDiamond = (hargaBatu1 * (caratPcsBatu1 * qtyIntBatu1!)) +
          (hargaBatu2 * (caratPcsBatu2 * qtyIntBatu2!)) +
          (hargaBatu3 * (caratPcsBatu3 * qtyIntBatu3!)) +
          (hargaBatu4 * (caratPcsBatu4 * qtyIntBatu4!)) +
          (hargaBatu5 * (caratPcsBatu5 * qtyIntBatu5!)) +
          (hargaBatu6 * (caratPcsBatu6 * qtyIntBatu6!)) +
          (hargaBatu7 * (caratPcsBatu7 * qtyIntBatu7!)) +
          (hargaBatu8 * (caratPcsBatu8 * qtyIntBatu8!)) +
          (hargaBatu9 * (caratPcsBatu9 * qtyIntBatu9!)) +
          (hargaBatu10 * (caratPcsBatu10 * qtyIntBatu10!)) +
          (hargaBatu11 * (caratPcsBatu11 * qtyIntBatu11!)) +
          (hargaBatu12 * (caratPcsBatu12 * qtyIntBatu12!)) +
          (hargaBatu13 * (caratPcsBatu13 * qtyIntBatu13!)) +
          (hargaBatu14 * (caratPcsBatu14 * qtyIntBatu14!)) +
          (hargaBatu15 * (caratPcsBatu15 * qtyIntBatu15!)) +
          (hargaBatu16 * (caratPcsBatu16 * qtyIntBatu16!)) +
          (hargaBatu17 * (caratPcsBatu17 * qtyIntBatu17!)) +
          (hargaBatu18 * (caratPcsBatu18 * qtyIntBatu18!)) +
          (hargaBatu19 * (caratPcsBatu19 * qtyIntBatu19!)) +
          (hargaBatu20 * (caratPcsBatu20 * qtyIntBatu20!)) +
          (hargaBatu21 * (caratPcsBatu21 * qtyIntBatu21!)) +
          (hargaBatu22 * (caratPcsBatu22 * qtyIntBatu22!)) +
          (hargaBatu23 * (caratPcsBatu23 * qtyIntBatu23!)) +
          (hargaBatu24 * (caratPcsBatu24 * qtyIntBatu24!)) +
          (hargaBatu25 * (caratPcsBatu25 * qtyIntBatu25!)) +
          (hargaBatu26 * (caratPcsBatu26 * qtyIntBatu26!)) +
          (hargaBatu27 * (caratPcsBatu27 * qtyIntBatu27!)) +
          (hargaBatu28 * (caratPcsBatu28 * qtyIntBatu28!)) +
          (hargaBatu29 * (caratPcsBatu29 * qtyIntBatu29!)) +
          (hargaBatu30 * (caratPcsBatu30 * qtyIntBatu30!)) +
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = ((((caratPcsBatu1 * qtyIntBatu1!) +
              (caratPcsBatu2 * qtyIntBatu2!) +
              (caratPcsBatu3 * qtyIntBatu3!) +
              (caratPcsBatu4 * qtyIntBatu4!) +
              (caratPcsBatu5 * qtyIntBatu5!) +
              (caratPcsBatu6 * qtyIntBatu6!) +
              (caratPcsBatu7 * qtyIntBatu7!) +
              (caratPcsBatu8 * qtyIntBatu8!) +
              (caratPcsBatu9 * qtyIntBatu9!) +
              (caratPcsBatu10 * qtyIntBatu10!) +
              (caratPcsBatu11 * qtyIntBatu11!) +
              (caratPcsBatu12 * qtyIntBatu12!) +
              (caratPcsBatu13 * qtyIntBatu13!) +
              (caratPcsBatu14 * qtyIntBatu14!) +
              (caratPcsBatu15 * qtyIntBatu15!) +
              (caratPcsBatu16 * qtyIntBatu16!) +
              (caratPcsBatu17 * qtyIntBatu17!) +
              (caratPcsBatu18 * qtyIntBatu18!) +
              (caratPcsBatu19 * qtyIntBatu19!) +
              (caratPcsBatu20 * qtyIntBatu20!) +
              (caratPcsBatu21 * qtyIntBatu21!) +
              (caratPcsBatu22 * qtyIntBatu22!) +
              (caratPcsBatu23 * qtyIntBatu23!) +
              (caratPcsBatu24 * qtyIntBatu24!) +
              (caratPcsBatu25 * qtyIntBatu25!) +
              (caratPcsBatu26 * qtyIntBatu26!) +
              (caratPcsBatu27 * qtyIntBatu27!) +
              (caratPcsBatu28 * qtyIntBatu28!) +
              (caratPcsBatu29 * qtyIntBatu29!) +
              (caratPcsBatu30 * qtyIntBatu30!) +
              (caratPcsBatu31 * qtyIntBatu31!) +
              (caratPcsBatu32 * qtyIntBatu32!) +
              (caratPcsBatu33 * qtyIntBatu33!) +
              (caratPcsBatu34 * qtyIntBatu34!) +
              (caratPcsBatu35 * qtyIntBatu35!))) /
          5);
      double totalEmas;
      totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmasMetier);
      print('ini emas : $totalEmas');
      print('ini diamond : $totalDiamond * $upDiamondMetier');

      var totalLabour = ((labour! + others3) * upLabour);
      double total;
      total = (((totalDiamond * upDiamondMetier) +
          totalEmas +
          totalLabour)); //final
      var totalwholesale = (((total.round()) * 1.2)); //wholesale
      total = (((total.round()) * 1.2) * 1.65); //retail
      print(totalwholesale);
      print('ini labour : $totalLabour');
      print('$labour! & $others3 & $upLabour');

      var output =
          total.round().toString()[total.round().toString().length - 5];
      var result = total.round().toString().lastChars(5); // 'World'
      print(result);
      if (int.parse(output) >= 0 && int.parse(output) <= 4) {
        setState(() {
          print('others3');
          total = (total + (50000 - int.parse(result)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others3');
          total = (total + (100000 - int.parse(result)));

          estimasiHarga.text = total.round().toString();
        });
        return total;
      } else {
        setState(() {
          print('others3');

          estimasiHarga.text = total.round().toString();
        });
        return total;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Form RO Designer (${widget.modelDesigner!.kodeDesignMdbc})',
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _getData();
                  _getDataBatu();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: isLoading == false
          ? Center(
              child: Container(
              padding: const EdgeInsets.all(5),
              width: 90,
              height: 90,
              child: Lottie.asset("loadingJSON/loadingV1.json"),
            ))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 2000,
                    padding:
                        const EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _bagianKiri(),
                        _bagianTengah(),
                      ],
                    ),
                  )),
            ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: CustomLoadingButton(
            controller: btnController,
            onPressed: () {
              final isValid = formKey.currentState?.validate();
              if (!isValid!) {
                btnController.error();
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  btnController.reset(); //reset
                });
                return;
              }
              Future.delayed(const Duration(seconds: 1)).then((value) async {
                btnController.success();
                postAPI();
                postApiQtyBatu1();
                postApiQtyBatu2();
                postApiQtyBatu3();
                postApiQtyBatu4();
                postApiQtyBatu5();
                postApiQtyBatu6();
                postApiQtyBatu7();
                postApiQtyBatu8();
                postApiQtyBatu9();
                postApiQtyBatu10();
                postApiQtyBatu11();
                postApiQtyBatu12();
                postApiQtyBatu13();
                postApiQtyBatu14();
                postApiQtyBatu15();
                postApiQtyBatu16();
                postApiQtyBatu17();
                postApiQtyBatu18();
                postApiQtyBatu19();
                postApiQtyBatu20();
                postApiQtyBatu21();
                postApiQtyBatu22();
                postApiQtyBatu23();
                postApiQtyBatu24();
                postApiQtyBatu25();
                postApiQtyBatu26();
                postApiQtyBatu27();
                postApiQtyBatu28();
                postApiQtyBatu29();
                postApiQtyBatu30();
                postApiQtyBatu31();
                postApiQtyBatu32();
                postApiQtyBatu33();
                postApiQtyBatu34();
                postApiQtyBatu35();

                Future.delayed(const Duration(seconds: 1)).then((value) {
                  btnController.reset(); //reset
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => const AlertDialog(
                            title: Text(
                              'RO Berhasil Disimpan',
                            ),
                          ));
                  setState(() {});
                });
              });
            },
            child: const Text(
              "Simpan RO",
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          )),
    );
  }

  Widget _bagianKiri() {
    return Container(
        width: 700,
        child: Form(
          key: formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //kode design mdbc
                SizedBox(
                  width: 200,
                  height: 65,
                  child: TextFormField(
                    readOnly: sharedPreferences!.getString('level') == '3'
                        ? true
                        : false,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.next,
                    controller: kodeDesignMdbc,
                    decoration: InputDecoration(
                      labelText: "Kode Design MDBC",
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

                //nama deisner
                SizedBox(
                  height: 65,
                  width: 200,
                  child: TextFormField(
                    readOnly: true,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.next,
                    controller: namaDesigner,
                    onChanged: (value) {
                      // setState(() {
                      //   _getData();
                      // });
                    },
                    decoration: InputDecoration(
                      // hintText: "example: Cahaya Sanivokasi",
                      labelText: "Nama Designer",
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
                //nama modeller
                SizedBox(
                  height: 65,
                  width: 200,
                  child: TextFormField(
                    readOnly: sharedPreferences!.getString('level') == '3'
                        ? true
                        : false,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.next,
                    controller: namaModeller,
                    decoration: InputDecoration(
                      labelText: "Nama Modeller",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //kode marketing
                  SizedBox(
                    height: 65,
                    width: 200,
                    child: TextFormField(
                      readOnly: sharedPreferences!.getString('level') == '3'
                          ? true
                          : false,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: kodeMarketing,
                      decoration: InputDecoration(
                        labelText: "Kode Marketing",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),

                  //Siklus
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: 65,
                    width: 200,
                    child: DropdownSearch<String>(
                      items: namaBulan,
                      onChanged: (item) {
                        setState(() {
                          siklus.text = item!;
                          print(siklus.text);
                        });
                      },
                      popupProps:
                          const PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(
                            siklus.text.isEmpty ? "Siklus" : siklus.text,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  //kode deisgn
                  SizedBox(
                    height: 65,
                    width: 200,
                    child: TextFormField(
                      readOnly: sharedPreferences!.getString('level') == '3'
                          ? true
                          : false,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: kodeDesign,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Kode Design",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //kode produksi
                  SizedBox(
                    height: 65,
                    width: 200,
                    child: TextFormField(
                      readOnly: sharedPreferences!.getString('level') == '3'
                          ? true
                          : false,
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
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  //statusForm
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: 65,
                    width: 200,
                    child: DropdownSearch<String>(
                      items: const [
                        "NO",
                        "RO",
                      ],
                      onChanged: (item) {
                        setState(() {
                          statusForm.text = item!;
                        });
                      },
                      popupProps:
                          const PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(
                            'Status NO/RO',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  //tema
                  SizedBox(
                    height: 65,
                    width: 200,
                    child: TextFormField(
                      readOnly: sharedPreferences!.getString('level') == '3'
                          ? true
                          : false,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: tema,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Tema",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 18, bottom: 10),
              child: ElevatedButton(
                  onPressed: () {
                    lastIdForm = generateImageName();
                    _pickImage(lastIdForm);
                    DropdownSearch<BatuModel>(
                      asyncItems: (String? filter) => getData(filter),
                      popupProps:
                          const PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        itemBuilder: _listBatu,
                        showSearchBox: true,
                      ),
                      compareFn: (item, sItem) => item.id == sItem.id,
                      onChanged: (item) {
                        setState(() {});
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(
                            rantai.text.isEmpty ? "Rantai" : rantai.text,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    );
                  },
                  child: const Text('Gambar Design')),
            ),
            lastIdForm != '0'
                ? Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 350,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.memory(
                      Uint8List.fromList(_imageFile!.bytes!),
                      fit: BoxFit.scaleDown,
                    ),
                  )
                : imageUrl != null
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 350,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(
                          ApiConstants.baseUrlImage + imageUrl!,
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 350,
                        padding: const EdgeInsets.only(top: 18),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                      ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 65,
                          width: 230,
                          child: DropdownSearch<RantaiModel>(
                            asyncItems: (String? filter) =>
                                getListRantai(filter),
                            popupProps:
                                const PopupPropsMultiSelection.modalBottomSheet(
                              showSelectedItems: true,
                              itemBuilder: _listRantai,
                              showSearchBox: true,
                            ),
                            compareFn: (item, sItem) => item.id == sItem.id,
                            onChanged: (item) {
                              setState(() {
                                rantai.text = item!.nama;
                                stokRantai.text = item.qty!.toString();
                              });
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                label: Text(
                                  rantai.text.isEmpty ? "Rantai" : rantai.text,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            readOnly:
                                sharedPreferences!.getString('level') == '3'
                                    ? true
                                    : false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: qtyRantai,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Qty",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: stokRantai,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Stok",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: 65,
                    width: 230,
                    child: DropdownSearch<JenisbarangModel>(
                      asyncItems: (String? filter) =>
                          getListJenisbarang(filter),
                      popupProps:
                          const PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        itemBuilder: _listJenisbarang,
                        showSearchBox: true,
                      ),
                      compareFn: (item, sItem) => item.id == sItem.id,
                      onChanged: (item) {
                        setState(() {
                          jenisBarang.text = item!.nama;
                          labour = item.harga;
                        });
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(
                            jenisBarang.text,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 65,
                          width: 230,
                          child: DropdownSearch<Lain2Model>(
                            asyncItems: (String? filter) =>
                                getListLain2(filter),
                            popupProps:
                                const PopupPropsMultiSelection.modalBottomSheet(
                              showSelectedItems: true,
                              itemBuilder: _listLain2,
                              showSearchBox: true,
                            ),
                            compareFn: (item, sItem) => item.id == sItem.id,
                            onChanged: (item) {
                              setState(() {
                                lain2.text = item!.nama;
                                stokLain2.text = item.qty!.toString();
                              });
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                label: Text(
                                  lain2.text.isEmpty ? "Lain-Lain" : lain2.text,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            readOnly:
                                sharedPreferences!.getString('level') == '3'
                                    ? true
                                    : false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: qtyLain2,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Qty",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: stokLain2,
                            decoration: InputDecoration(
                              labelText: "Stok",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: 65,
                    width: 230,
                    child: DropdownSearch<String>(
                      items: const ["CLASSIC", "FASHION"],
                      onChanged: (item) {
                        setState(() {
                          kategoriBarang.text = item!;
                        });
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(
                            kategoriBarang.text.isEmpty
                                ? "Kategori Barang"
                                : kategoriBarang.text,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 65,
                          width: 230,
                          child: DropdownSearch<EarnutModel>(
                            asyncItems: (String? filter) =>
                                getListEarnut(filter),
                            popupProps:
                                const PopupPropsMultiSelection.modalBottomSheet(
                              showSelectedItems: true,
                              itemBuilder: _listEarnut,
                              showSearchBox: true,
                            ),
                            compareFn: (item, sItem) => item.id == sItem.id,
                            onChanged: (item) {
                              setState(() {
                                earnut.text = item!.nama;
                                stokEarnut.text = item.qty!.toString();
                              });
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                label: Text(
                                  earnut.text.isEmpty ? "Earnut" : earnut.text,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            readOnly:
                                sharedPreferences!.getString('level') == '3'
                                    ? true
                                    : false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: qtyEarnut,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Qty",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: stokEarnut,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Stok",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: 65,
                    width: 230,
                    child: DropdownSearch<String>(
                      items: const ["PARVA", "SIORAI", "METIER"],
                      onChanged: (item) {
                        setState(() {
                          brand.text = item!;
                        });
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(
                            brand.text.isEmpty ? "Brand" : brand.text,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 65,
                          width: 230,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: panjangRantai,
                            decoration: InputDecoration(
                              labelText: "Panjang Rantai",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: 65,
                    width: 230,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: photoShoot,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Photo Shoot",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 65,
                          width: 230,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: customKomponen,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Custom Komponen",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: qtyCustomKomponen,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Qty",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          height: 65,
                          width: 100,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: stokCustomKomponen,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Stok",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: 65,
                    width: 230,
                    child: DropdownSearch<String>(
                      items: const ["WG", "RG", "MIX"],
                      onChanged: (item) {
                        setState(() {
                          color.text = item!;
                        });
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(color.text.isEmpty ? "Color" : color.text,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 65,
                    width: 230,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: beratEmas,
                      onChanged: (value) {
                        setState(() {
                          doubleBeratEmas = double.parse(value);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Berat Emas",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 0),
                    height: 65,
                    width: 200,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      // controller: estimasiHarga,
                      decoration: InputDecoration(
                        label: Text(
                          brand.text == "BELI BERLIAN"
                              ? 'Rp. ${CurrencyFormat.convertToDollar(totalPriceBeliBerlian, 0)}'
                              : brand.text == "METIER"
                                  ? 'Rp. ${CurrencyFormat.convertToDollar(totalPriceMetier, 0)}'
                                  : '\$ ${CurrencyFormat.convertToDollar(totalPriceParva, 0)}',
                        ),
                        // hintText: "example: Cahaya Sanivokasi",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    width: 230,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: ringSize,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Ring Size",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget _bagianTengah() {
    //bagian tengah
    return Container(
        padding: const EdgeInsets.only(left: 5, top: 0),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 0),
                    child: const Text(
                      'Ukuran / Size Batu Sebelumnya',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // for (var i = 0; i <= 35; i++)
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //size batu1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu1.text = '';
                                        crtPcsBatu1.text = '';
                                        idStone1 = item.idStone;
                                        idBatu1 = item.id;
                                        hargaBatu1 = data[0]['unitCost'];
                                        caratPcsBatu1 = data[0]['caratPcs'];
                                        batu1 = item.keyWord.toString();
                                        stokBatu1.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu1!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu1
                            idStone1 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu1,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu1
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu1 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu1,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu1 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu1
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu1,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu1
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu1,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu1!.toLowerCase() == "custom emerald" ||
                                        batu1!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu1!.toLowerCase() ==
                                            "custom heart" ||
                                        batu1!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu1!.toLowerCase() == "custom oval" ||
                                        batu1!.toLowerCase() == "custom pear" ||
                                        batu1!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu1!.toLowerCase() == "custom ruby" ||
                                        batu1!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu1 = customGol1!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu1 = customGol2!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu1 = customGol3!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu1 = customGol4!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu1 = customGol5!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu1 = customGol6!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu1 = customGol7!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu1 = customGol8!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu1 = customGol9!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu1 = customGol10!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu1 = customGol11!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu1 = customGol12!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu1 = customGol13!;
                                        caratPcsBatu1 = double.parse(value);
                                      } else {
                                        hargaBatu1 = customGol14!;
                                        caratPcsBatu1 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu1.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu1.text = '0';
                                            stokBatu1.text = '';
                                            crtPcsBatu1.text = '';
                                            ukuranBatu1.text = '';
                                            stokBatu1.text = '';
                                            batu1 = '';
                                            hargaBatu1 = 0;
                                            caratPcsBatu1 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
                        // end row batu1

                        //size batu2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu2.text = '';
                                        crtPcsBatu2.text = '';
                                        idStone2 = item.idStone;
                                        idBatu2 = item.id;
                                        hargaBatu2 = data[0]['unitCost'];
                                        caratPcsBatu2 = data[0]['caratPcs'];
                                        batu2 = item.keyWord.toString();
                                        stokBatu2.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu2!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu2
                            idStone2 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu2,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu2
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu2 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu2,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu2 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu2
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu2,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu2
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu2,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu2!.toLowerCase() == "custom emerald" ||
                                        batu2!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu2!.toLowerCase() ==
                                            "custom heart" ||
                                        batu2!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu2!.toLowerCase() == "custom oval" ||
                                        batu2!.toLowerCase() == "custom pear" ||
                                        batu2!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu2!.toLowerCase() == "custom ruby" ||
                                        batu2!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu2 = customGol1!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu2 = customGol2!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu2 = customGol3!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu2 = customGol4!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu2 = customGol5!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu2 = customGol6!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu2 = customGol7!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu2 = customGol8!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu2 = customGol9!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu2 = customGol10!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu2 = customGol11!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu2 = customGol12!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu2 = customGol13!;
                                        caratPcsBatu2 = double.parse(value);
                                      } else {
                                        hargaBatu2 = customGol14!;
                                        caratPcsBatu2 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu2.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu2.text = '0';
                                            stokBatu2.text = '';
                                            crtPcsBatu2.text = '';
                                            ukuranBatu2.text = '';
                                            stokBatu2.text = '';
                                            batu2 = '';
                                            hargaBatu2 = 0;
                                            caratPcsBatu2 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu2

                        //size batu3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu3.text = '';
                                        crtPcsBatu3.text = '';
                                        idStone3 = item.idStone;
                                        idBatu3 = item.id;
                                        hargaBatu3 = data[0]['unitCost'];
                                        caratPcsBatu3 = data[0]['caratPcs'];
                                        batu3 = item.keyWord.toString();
                                        stokBatu3.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu3!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu3
                            idStone3 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu3,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu3
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu3 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu3,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu3 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu3
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu3,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu3
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu3,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu3!.toLowerCase() == "custom emerald" ||
                                        batu3!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu3!.toLowerCase() ==
                                            "custom heart" ||
                                        batu3!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu3!.toLowerCase() == "custom oval" ||
                                        batu3!.toLowerCase() == "custom pear" ||
                                        batu3!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu3!.toLowerCase() == "custom ruby" ||
                                        batu3!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu3 = customGol1!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu3 = customGol2!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu3 = customGol3!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu3 = customGol4!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu3 = customGol5!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu3 = customGol6!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu3 = customGol7!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu3 = customGol8!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu3 = customGol9!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu3 = customGol10!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu3 = customGol11!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu3 = customGol12!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu3 = customGol13!;
                                        caratPcsBatu3 = double.parse(value);
                                      } else {
                                        hargaBatu3 = customGol14!;
                                        caratPcsBatu3 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu3.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu3.text = '0';
                                            stokBatu3.text = '';
                                            crtPcsBatu3.text = '';
                                            ukuranBatu3.text = '';
                                            stokBatu3.text = '';
                                            batu3 = '';
                                            hargaBatu3 = 0;
                                            caratPcsBatu3 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu3

                        //size batu4
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu4.text = '';
                                        crtPcsBatu4.text = '';
                                        idStone4 = item.idStone;
                                        idBatu4 = item.id;
                                        hargaBatu4 = data[0]['unitCost'];
                                        caratPcsBatu4 = data[0]['caratPcs'];
                                        batu4 = item.keyWord.toString();
                                        stokBatu4.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu4!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu4
                            idStone4 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu4,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu4
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu4 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu4,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu4 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu4
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu4,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu4
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu4,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu4!.toLowerCase() == "custom emerald" ||
                                        batu4!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu4!.toLowerCase() ==
                                            "custom heart" ||
                                        batu4!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu4!.toLowerCase() == "custom oval" ||
                                        batu4!.toLowerCase() == "custom pear" ||
                                        batu4!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu4!.toLowerCase() == "custom ruby" ||
                                        batu4!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu4 = customGol1!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu4 = customGol2!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu4 = customGol3!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu4 = customGol4!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu4 = customGol5!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu4 = customGol6!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu4 = customGol7!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu4 = customGol8!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu4 = customGol9!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu4 = customGol10!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu4 = customGol11!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu4 = customGol12!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu4 = customGol13!;
                                        caratPcsBatu4 = double.parse(value);
                                      } else {
                                        hargaBatu4 = customGol14!;
                                        caratPcsBatu4 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu4.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu4.text = '0';
                                            stokBatu4.text = '';
                                            crtPcsBatu4.text = '';
                                            ukuranBatu4.text = '';
                                            stokBatu4.text = '';
                                            batu4 = '';
                                            hargaBatu4 = 0;
                                            caratPcsBatu4 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu4

                        //size batu5
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu5.text = '';
                                        crtPcsBatu5.text = '';
                                        idStone5 = item.idStone;
                                        idBatu5 = item.id;
                                        hargaBatu5 = data[0]['unitCost'];
                                        caratPcsBatu5 = data[0]['caratPcs'];
                                        batu5 = item.keyWord.toString();
                                        stokBatu5.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu5!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu5
                            idStone5 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu5,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu5
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu5 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu5,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu5 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu5
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu5,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu5
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu5,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu5!.toLowerCase() == "custom emerald" ||
                                        batu5!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu5!.toLowerCase() ==
                                            "custom heart" ||
                                        batu5!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu5!.toLowerCase() == "custom oval" ||
                                        batu5!.toLowerCase() == "custom pear" ||
                                        batu5!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu5!.toLowerCase() == "custom ruby" ||
                                        batu5!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu5 = customGol1!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu5 = customGol2!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu5 = customGol3!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu5 = customGol4!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu5 = customGol5!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu5 = customGol6!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu5 = customGol7!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu5 = customGol8!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu5 = customGol9!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu5 = customGol10!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu5 = customGol11!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu5 = customGol12!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu5 = customGol13!;
                                        caratPcsBatu5 = double.parse(value);
                                      } else {
                                        hargaBatu5 = customGol14!;
                                        caratPcsBatu5 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu5.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu5.text = '0';
                                            stokBatu5.text = '';
                                            crtPcsBatu5.text = '';
                                            ukuranBatu5.text = '';
                                            stokBatu5.text = '';
                                            batu5 = '';
                                            hargaBatu5 = 0;
                                            caratPcsBatu5 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu5

                        //size batu6
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu6.text = '';
                                        crtPcsBatu6.text = '';
                                        idStone6 = item.idStone;
                                        idBatu6 = item.id;
                                        hargaBatu6 = data[0]['unitCost'];
                                        caratPcsBatu6 = data[0]['caratPcs'];
                                        batu6 = item.keyWord.toString();
                                        stokBatu6.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu6!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu6
                            idStone6 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu6,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu6
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu6 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu6,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu6 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu6
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu6,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu6
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu6,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu6!.toLowerCase() == "custom emerald" ||
                                        batu6!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu6!.toLowerCase() ==
                                            "custom heart" ||
                                        batu6!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu6!.toLowerCase() == "custom oval" ||
                                        batu6!.toLowerCase() == "custom pear" ||
                                        batu6!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu6!.toLowerCase() == "custom ruby" ||
                                        batu6!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu6 = customGol1!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu6 = customGol2!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu6 = customGol3!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu6 = customGol4!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu6 = customGol5!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu6 = customGol6!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu6 = customGol7!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu6 = customGol8!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu6 = customGol9!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu6 = customGol10!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu6 = customGol11!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu6 = customGol12!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu6 = customGol13!;
                                        caratPcsBatu6 = double.parse(value);
                                      } else {
                                        hargaBatu6 = customGol14!;
                                        caratPcsBatu6 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu6.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu6.text = '0';
                                            stokBatu6.text = '';
                                            crtPcsBatu6.text = '';
                                            ukuranBatu6.text = '';
                                            stokBatu6.text = '';
                                            batu6 = '';
                                            hargaBatu6 = 0;
                                            caratPcsBatu6 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu6

                        //size batu7
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu7.text = '';
                                        crtPcsBatu7.text = '';
                                        idStone7 = item.idStone;
                                        idBatu7 = item.id;
                                        hargaBatu7 = data[0]['unitCost'];
                                        caratPcsBatu7 = data[0]['caratPcs'];
                                        batu7 = item.keyWord.toString();
                                        stokBatu7.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu7!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu7
                            idStone7 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu7,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu7
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu7 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu7,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu7 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu7
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu7,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu7
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu7,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu7!.toLowerCase() == "custom emerald" ||
                                        batu7!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu7!.toLowerCase() ==
                                            "custom heart" ||
                                        batu7!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu7!.toLowerCase() == "custom oval" ||
                                        batu7!.toLowerCase() == "custom pear" ||
                                        batu7!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu7!.toLowerCase() == "custom ruby" ||
                                        batu7!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu7 = customGol1!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu7 = customGol2!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu7 = customGol3!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu7 = customGol4!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu7 = customGol5!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu7 = customGol6!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu7 = customGol7!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu7 = customGol8!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu7 = customGol9!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu7 = customGol10!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu7 = customGol11!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu7 = customGol12!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu7 = customGol13!;
                                        caratPcsBatu7 = double.parse(value);
                                      } else {
                                        hargaBatu7 = customGol14!;
                                        caratPcsBatu7 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu7.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu7.text = '0';
                                            stokBatu7.text = '';
                                            crtPcsBatu7.text = '';
                                            ukuranBatu7.text = '';
                                            stokBatu7.text = '';
                                            batu7 = '';
                                            hargaBatu7 = 0;
                                            caratPcsBatu7 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu7

                        //size batu8
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu8.text = '';
                                        crtPcsBatu8.text = '';
                                        idStone8 = item.idStone;
                                        idBatu8 = item.id;
                                        hargaBatu8 = data[0]['unitCost'];
                                        caratPcsBatu8 = data[0]['caratPcs'];
                                        batu8 = item.keyWord.toString();
                                        stokBatu8.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu8!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu8
                            idStone8 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu8,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu8
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu8 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu8,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu8 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu8
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu8,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu8
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu8,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu8!.toLowerCase() == "custom emerald" ||
                                        batu8!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu8!.toLowerCase() ==
                                            "custom heart" ||
                                        batu8!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu8!.toLowerCase() == "custom oval" ||
                                        batu8!.toLowerCase() == "custom pear" ||
                                        batu8!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu8!.toLowerCase() == "custom ruby" ||
                                        batu8!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu8 = customGol1!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu8 = customGol2!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu8 = customGol3!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu8 = customGol4!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu8 = customGol5!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu8 = customGol6!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu8 = customGol7!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu8 = customGol8!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu8 = customGol9!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu8 = customGol10!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu8 = customGol11!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu8 = customGol12!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu8 = customGol13!;
                                        caratPcsBatu8 = double.parse(value);
                                      } else {
                                        hargaBatu8 = customGol14!;
                                        caratPcsBatu8 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu8.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu8.text = '0';
                                            stokBatu8.text = '';
                                            crtPcsBatu8.text = '';
                                            ukuranBatu8.text = '';
                                            stokBatu8.text = '';
                                            batu8 = '';
                                            hargaBatu8 = 0;
                                            caratPcsBatu8 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu8

                        //size batu9
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu9.text = '';
                                        crtPcsBatu9.text = '';
                                        idStone9 = item.idStone;
                                        idBatu9 = item.id;
                                        hargaBatu9 = data[0]['unitCost'];
                                        caratPcsBatu9 = data[0]['caratPcs'];
                                        batu9 = item.keyWord.toString();
                                        stokBatu9.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu9!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu9
                            idStone9 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu9,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu9
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu9 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu9,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu9 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu9
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu9,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu9
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu9,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu9!.toLowerCase() == "custom emerald" ||
                                        batu9!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu9!.toLowerCase() ==
                                            "custom heart" ||
                                        batu9!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu9!.toLowerCase() == "custom oval" ||
                                        batu9!.toLowerCase() == "custom pear" ||
                                        batu9!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu9!.toLowerCase() == "custom ruby" ||
                                        batu9!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu9 = customGol1!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu9 = customGol2!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu9 = customGol3!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu9 = customGol4!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu9 = customGol5!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu9 = customGol6!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu9 = customGol7!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu9 = customGol8!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu9 = customGol9!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu9 = customGol10!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu9 = customGol11!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu9 = customGol12!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu9 = customGol13!;
                                        caratPcsBatu9 = double.parse(value);
                                      } else {
                                        hargaBatu9 = customGol14!;
                                        caratPcsBatu9 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu9.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu9.text = '0';
                                            stokBatu9.text = '';
                                            crtPcsBatu9.text = '';
                                            ukuranBatu9.text = '';
                                            stokBatu9.text = '';
                                            batu9 = '';
                                            hargaBatu9 = 0;
                                            caratPcsBatu9 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu9
                        //size batu10
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu10.text = '';
                                        crtPcsBatu10.text = '';
                                        idStone10 = item.idStone;
                                        idBatu10 = item.id;
                                        hargaBatu10 = data[0]['unitCost'];
                                        caratPcsBatu10 = data[0]['caratPcs'];
                                        batu10 = item.keyWord.toString();
                                        stokBatu10.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu10!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu10
                            idStone10 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu10,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu10
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu10 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu10,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu10 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu10
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu10,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu10
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu10,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu10!.toLowerCase() == "custom emerald" ||
                                        batu10!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu10!.toLowerCase() ==
                                            "custom heart" ||
                                        batu10!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu10!.toLowerCase() ==
                                            "custom oval" ||
                                        batu10!.toLowerCase() ==
                                            "custom pear" ||
                                        batu10!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu10!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu10!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu10 = customGol1!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu10 = customGol2!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu10 = customGol3!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu10 = customGol4!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu10 = customGol5!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu10 = customGol6!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu10 = customGol7!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu10 = customGol8!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu10 = customGol9!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu10 = customGol10!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu10 = customGol11!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu10 = customGol12!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu10 = customGol13!;
                                        caratPcsBatu10 = double.parse(value);
                                      } else {
                                        hargaBatu10 = customGol14!;
                                        caratPcsBatu10 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu10.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu10.text = '0';
                                            stokBatu10.text = '';
                                            crtPcsBatu10.text = '';
                                            ukuranBatu10.text = '';
                                            stokBatu10.text = '';
                                            batu10 = '';
                                            hargaBatu10 = 0;
                                            caratPcsBatu10 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu10

                        //size batu11
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu11.text = '';
                                        crtPcsBatu11.text = '';
                                        idStone11 = item.idStone;
                                        idBatu11 = item.id;
                                        hargaBatu11 = data[0]['unitCost'];
                                        caratPcsBatu11 = data[0]['caratPcs'];
                                        batu11 = item.keyWord.toString();
                                        stokBatu11.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu11!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu11
                            idStone11 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu11,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu11
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu11 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu11,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu11 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu11
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu11,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu11
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu11,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu11!.toLowerCase() == "custom emerald" ||
                                        batu11!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu11!.toLowerCase() ==
                                            "custom heart" ||
                                        batu11!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu11!.toLowerCase() ==
                                            "custom oval" ||
                                        batu11!.toLowerCase() ==
                                            "custom pear" ||
                                        batu11!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu11!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu11!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu11 = customGol1!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu11 = customGol2!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu11 = customGol3!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu11 = customGol4!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu11 = customGol5!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu11 = customGol6!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu11 = customGol7!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu11 = customGol8!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu11 = customGol9!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu11 = customGol10!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu11 = customGol11!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu11 = customGol12!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu11 = customGol13!;
                                        caratPcsBatu11 = double.parse(value);
                                      } else {
                                        hargaBatu11 = customGol14!;
                                        caratPcsBatu11 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu11.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu11.text = '0';
                                            stokBatu11.text = '';
                                            crtPcsBatu11.text = '';
                                            ukuranBatu11.text = '';
                                            stokBatu11.text = '';
                                            batu11 = '';
                                            hargaBatu11 = 0;
                                            caratPcsBatu11 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu11

                        //size batu12
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu12.text = '';
                                        crtPcsBatu12.text = '';
                                        idStone12 = item.idStone;
                                        idBatu12 = item.id;
                                        hargaBatu12 = data[0]['unitCost'];
                                        caratPcsBatu12 = data[0]['caratPcs'];
                                        batu12 = item.keyWord.toString();
                                        stokBatu12.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu12!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu12
                            idStone12 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu12,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu12
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu12 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu12,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu12 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu12
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu12,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu12
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu12,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu12!.toLowerCase() == "custom emerald" ||
                                        batu12!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu12!.toLowerCase() ==
                                            "custom heart" ||
                                        batu12!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu12!.toLowerCase() ==
                                            "custom oval" ||
                                        batu12!.toLowerCase() ==
                                            "custom pear" ||
                                        batu12!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu12!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu12!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu12 = customGol1!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu12 = customGol2!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu12 = customGol3!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu12 = customGol4!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu12 = customGol5!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu12 = customGol6!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu12 = customGol7!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu12 = customGol8!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu12 = customGol9!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu12 = customGol10!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu12 = customGol11!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu12 = customGol12!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu12 = customGol13!;
                                        caratPcsBatu12 = double.parse(value);
                                      } else {
                                        hargaBatu12 = customGol14!;
                                        caratPcsBatu12 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu12.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu12.text = '0';
                                            stokBatu12.text = '';
                                            crtPcsBatu12.text = '';
                                            ukuranBatu12.text = '';
                                            stokBatu12.text = '';
                                            batu12 = '';
                                            hargaBatu12 = 0;
                                            caratPcsBatu12 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu12

                        //size batu13
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu13.text = '';
                                        crtPcsBatu13.text = '';
                                        idStone13 = item.idStone;
                                        idBatu13 = item.id;
                                        hargaBatu13 = data[0]['unitCost'];
                                        caratPcsBatu13 = data[0]['caratPcs'];
                                        batu13 = item.keyWord.toString();
                                        stokBatu13.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu13!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu13
                            idStone13 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu13,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu13
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu13 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu13,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu13 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu13
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu13,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu13
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu13,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu13!.toLowerCase() == "custom emerald" ||
                                        batu13!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu13!.toLowerCase() ==
                                            "custom heart" ||
                                        batu13!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu13!.toLowerCase() ==
                                            "custom oval" ||
                                        batu13!.toLowerCase() ==
                                            "custom pear" ||
                                        batu13!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu13!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu13!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu13 = customGol1!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu13 = customGol2!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu13 = customGol3!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu13 = customGol4!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu13 = customGol5!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu13 = customGol6!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu13 = customGol7!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu13 = customGol8!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu13 = customGol9!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu13 = customGol10!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu13 = customGol11!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu13 = customGol12!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu13 = customGol13!;
                                        caratPcsBatu13 = double.parse(value);
                                      } else {
                                        hargaBatu13 = customGol14!;
                                        caratPcsBatu13 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu13.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu13.text = '0';
                                            stokBatu13.text = '';
                                            crtPcsBatu13.text = '';
                                            ukuranBatu13.text = '';
                                            stokBatu13.text = '';
                                            batu13 = '';
                                            hargaBatu13 = 0;
                                            caratPcsBatu13 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu13

                        //size batu14
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu14.text = '';
                                        crtPcsBatu14.text = '';
                                        idStone14 = item.idStone;
                                        idBatu14 = item.id;
                                        hargaBatu14 = data[0]['unitCost'];
                                        caratPcsBatu14 = data[0]['caratPcs'];
                                        batu14 = item.keyWord.toString();
                                        stokBatu14.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu14!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu14
                            idStone14 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu14,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu14
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu14 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu14,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu14 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu14
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu14,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu14
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu14,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu14!.toLowerCase() == "custom emerald" ||
                                        batu14!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu14!.toLowerCase() ==
                                            "custom heart" ||
                                        batu14!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu14!.toLowerCase() ==
                                            "custom oval" ||
                                        batu14!.toLowerCase() ==
                                            "custom pear" ||
                                        batu14!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu14!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu14!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu14 = customGol1!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu14 = customGol2!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu14 = customGol3!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu14 = customGol4!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu14 = customGol5!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu14 = customGol6!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu14 = customGol7!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu14 = customGol8!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu14 = customGol9!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu14 = customGol10!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu14 = customGol11!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu14 = customGol12!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu14 = customGol13!;
                                        caratPcsBatu14 = double.parse(value);
                                      } else {
                                        hargaBatu14 = customGol14!;
                                        caratPcsBatu14 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu14.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu14.text = '0';
                                            stokBatu14.text = '';
                                            crtPcsBatu14.text = '';
                                            ukuranBatu14.text = '';
                                            stokBatu14.text = '';
                                            batu14 = '';
                                            hargaBatu14 = 0;
                                            caratPcsBatu14 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu14

//size batu15
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu15.text = '';
                                        crtPcsBatu15.text = '';
                                        idStone15 = item.idStone;
                                        idBatu15 = item.id;
                                        hargaBatu15 = data[0]['unitCost'];
                                        caratPcsBatu15 = data[0]['caratPcs'];
                                        batu15 = item.keyWord.toString();
                                        stokBatu15.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu15!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu15
                            idStone15 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu15,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu15
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu15 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu15,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu15 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu15
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu15,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu15
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu15,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu15!.toLowerCase() == "custom emerald" ||
                                        batu15!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu15!.toLowerCase() ==
                                            "custom heart" ||
                                        batu15!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu15!.toLowerCase() ==
                                            "custom oval" ||
                                        batu15!.toLowerCase() ==
                                            "custom pear" ||
                                        batu15!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu15!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu15!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu15 = customGol1!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu15 = customGol2!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu15 = customGol3!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu15 = customGol4!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu15 = customGol5!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu15 = customGol6!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu15 = customGol7!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu15 = customGol8!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu15 = customGol9!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu15 = customGol10!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu15 = customGol11!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu15 = customGol12!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu15 = customGol13!;
                                        caratPcsBatu15 = double.parse(value);
                                      } else {
                                        hargaBatu15 = customGol14!;
                                        caratPcsBatu15 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu15.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu15.text = '0';
                                            stokBatu15.text = '';
                                            crtPcsBatu15.text = '';
                                            ukuranBatu15.text = '';
                                            stokBatu15.text = '';
                                            batu15 = '';
                                            hargaBatu15 = 0;
                                            caratPcsBatu15 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu15

//size batu16
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu16.text = '';
                                        crtPcsBatu16.text = '';
                                        idStone16 = item.idStone;
                                        idBatu16 = item.id;
                                        hargaBatu16 = data[0]['unitCost'];
                                        caratPcsBatu16 = data[0]['caratPcs'];
                                        batu16 = item.keyWord.toString();
                                        stokBatu16.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu16!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu16
                            idStone16 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu16,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu16
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu16 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu16,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu16 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu16
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu16,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu16
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu16,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu16!.toLowerCase() == "custom emerald" ||
                                        batu16!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu16!.toLowerCase() ==
                                            "custom heart" ||
                                        batu16!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu16!.toLowerCase() ==
                                            "custom oval" ||
                                        batu16!.toLowerCase() ==
                                            "custom pear" ||
                                        batu16!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu16!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu16!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu16 = customGol1!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu16 = customGol2!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu16 = customGol3!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu16 = customGol4!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu16 = customGol5!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu16 = customGol6!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu16 = customGol7!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu16 = customGol8!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu16 = customGol9!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu16 = customGol10!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu16 = customGol11!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu16 = customGol12!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu16 = customGol13!;
                                        caratPcsBatu16 = double.parse(value);
                                      } else {
                                        hargaBatu16 = customGol14!;
                                        caratPcsBatu16 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu16.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu16.text = '0';
                                            stokBatu16.text = '';
                                            crtPcsBatu16.text = '';
                                            ukuranBatu16.text = '';
                                            stokBatu16.text = '';
                                            batu16 = '';
                                            hargaBatu16 = 0;
                                            caratPcsBatu16 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu16

//size batu17
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu17.text = '';
                                        crtPcsBatu17.text = '';
                                        idStone17 = item.idStone;
                                        idBatu17 = item.id;
                                        hargaBatu17 = data[0]['unitCost'];
                                        caratPcsBatu17 = data[0]['caratPcs'];
                                        batu17 = item.keyWord.toString();
                                        stokBatu17.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu17!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu17
                            idStone17 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu17,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu17
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu17 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu17,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu17 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu17
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu17,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu17
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu17,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu17!.toLowerCase() == "custom emerald" ||
                                        batu17!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu17!.toLowerCase() ==
                                            "custom heart" ||
                                        batu17!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu17!.toLowerCase() ==
                                            "custom oval" ||
                                        batu17!.toLowerCase() ==
                                            "custom pear" ||
                                        batu17!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu17!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu17!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu17 = customGol1!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu17 = customGol2!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu17 = customGol3!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu17 = customGol4!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu17 = customGol5!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu17 = customGol6!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu17 = customGol7!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu17 = customGol8!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu17 = customGol9!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu17 = customGol10!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu17 = customGol11!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu17 = customGol12!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu17 = customGol13!;
                                        caratPcsBatu17 = double.parse(value);
                                      } else {
                                        hargaBatu17 = customGol14!;
                                        caratPcsBatu17 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu17.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu17.text = '0';
                                            stokBatu17.text = '';
                                            crtPcsBatu17.text = '';
                                            ukuranBatu17.text = '';
                                            stokBatu17.text = '';
                                            batu17 = '';
                                            hargaBatu17 = 0;
                                            caratPcsBatu17 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu17

//size batu18
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu18.text = '';
                                        crtPcsBatu18.text = '';
                                        idStone18 = item.idStone;
                                        idBatu18 = item.id;
                                        hargaBatu18 = data[0]['unitCost'];
                                        caratPcsBatu18 = data[0]['caratPcs'];
                                        batu18 = item.keyWord.toString();
                                        stokBatu18.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu18!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu18
                            idStone18 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu18,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu18
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu18 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu18,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu18 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu18
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu18,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu18
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu18,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu18!.toLowerCase() == "custom emerald" ||
                                        batu18!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu18!.toLowerCase() ==
                                            "custom heart" ||
                                        batu18!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu18!.toLowerCase() ==
                                            "custom oval" ||
                                        batu18!.toLowerCase() ==
                                            "custom pear" ||
                                        batu18!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu18!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu18!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu18 = customGol1!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu18 = customGol2!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu18 = customGol3!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu18 = customGol4!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu18 = customGol5!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu18 = customGol6!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu18 = customGol7!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu18 = customGol8!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu18 = customGol9!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu18 = customGol10!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu18 = customGol11!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu18 = customGol12!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu18 = customGol13!;
                                        caratPcsBatu18 = double.parse(value);
                                      } else {
                                        hargaBatu18 = customGol14!;
                                        caratPcsBatu18 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu18.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu18.text = '0';
                                            stokBatu18.text = '';
                                            crtPcsBatu18.text = '';
                                            ukuranBatu18.text = '';
                                            stokBatu18.text = '';
                                            batu18 = '';
                                            hargaBatu18 = 0;
                                            caratPcsBatu18 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu18

//size batu19
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu19.text = '';
                                        crtPcsBatu19.text = '';
                                        idStone19 = item.idStone;
                                        idBatu19 = item.id;
                                        hargaBatu19 = data[0]['unitCost'];
                                        caratPcsBatu19 = data[0]['caratPcs'];
                                        batu19 = item.keyWord.toString();
                                        stokBatu19.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu19!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu19
                            idStone19 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu19,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu19
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu19 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu19,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu19 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu19
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu19,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu19
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu19,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu19!.toLowerCase() == "custom emerald" ||
                                        batu19!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu19!.toLowerCase() ==
                                            "custom heart" ||
                                        batu19!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu19!.toLowerCase() ==
                                            "custom oval" ||
                                        batu19!.toLowerCase() ==
                                            "custom pear" ||
                                        batu19!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu19!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu19!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu19 = customGol1!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu19 = customGol2!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu19 = customGol3!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu19 = customGol4!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu19 = customGol5!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu19 = customGol6!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu19 = customGol7!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu19 = customGol8!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu19 = customGol9!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu19 = customGol10!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu19 = customGol11!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu19 = customGol12!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu19 = customGol13!;
                                        caratPcsBatu19 = double.parse(value);
                                      } else {
                                        hargaBatu19 = customGol14!;
                                        caratPcsBatu19 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu19.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu19.text = '0';
                                            stokBatu19.text = '';
                                            crtPcsBatu19.text = '';
                                            ukuranBatu19.text = '';
                                            stokBatu19.text = '';
                                            batu19 = '';
                                            hargaBatu19 = 0;
                                            caratPcsBatu19 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu19

//size batu20
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu20.text = '';
                                        crtPcsBatu20.text = '';
                                        idStone20 = item.idStone;
                                        idBatu20 = item.id;
                                        hargaBatu20 = data[0]['unitCost'];
                                        caratPcsBatu20 = data[0]['caratPcs'];
                                        batu20 = item.keyWord.toString();
                                        stokBatu20.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu20!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu20
                            idStone20 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu20,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu20
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu20 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu20,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu20 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu20
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu20,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu20
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu20,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu20!.toLowerCase() == "custom emerald" ||
                                        batu20!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu20!.toLowerCase() ==
                                            "custom heart" ||
                                        batu20!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu20!.toLowerCase() ==
                                            "custom oval" ||
                                        batu20!.toLowerCase() ==
                                            "custom pear" ||
                                        batu20!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu20!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu20!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu20 = customGol1!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu20 = customGol2!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu20 = customGol3!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu20 = customGol4!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu20 = customGol5!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu20 = customGol6!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu20 = customGol7!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu20 = customGol8!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu20 = customGol9!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu20 = customGol10!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu20 = customGol11!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu20 = customGol12!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu20 = customGol13!;
                                        caratPcsBatu20 = double.parse(value);
                                      } else {
                                        hargaBatu20 = customGol14!;
                                        caratPcsBatu20 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu20.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu20.text = '0';
                                            stokBatu20.text = '';
                                            crtPcsBatu20.text = '';
                                            ukuranBatu20.text = '';
                                            stokBatu20.text = '';
                                            batu20 = '';
                                            hargaBatu20 = 0;
                                            caratPcsBatu20 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu20

//size batu21
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu21.text = '';
                                        crtPcsBatu21.text = '';
                                        idStone21 = item.idStone;
                                        idBatu21 = item.id;
                                        hargaBatu21 = data[0]['unitCost'];
                                        caratPcsBatu21 = data[0]['caratPcs'];
                                        batu21 = item.keyWord.toString();
                                        stokBatu21.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu21!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu21
                            idStone21 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu21,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu21
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu21 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu21,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu21 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu21
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu21,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu21
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu21,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu21!.toLowerCase() == "custom emerald" ||
                                        batu21!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu21!.toLowerCase() ==
                                            "custom heart" ||
                                        batu21!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu21!.toLowerCase() ==
                                            "custom oval" ||
                                        batu21!.toLowerCase() ==
                                            "custom pear" ||
                                        batu21!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu21!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu21!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu21 = customGol1!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu21 = customGol2!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu21 = customGol3!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu21 = customGol4!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu21 = customGol5!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu21 = customGol6!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu21 = customGol7!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu21 = customGol8!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu21 = customGol9!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu21 = customGol10!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu21 = customGol11!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu21 = customGol12!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu21 = customGol13!;
                                        caratPcsBatu21 = double.parse(value);
                                      } else {
                                        hargaBatu21 = customGol14!;
                                        caratPcsBatu21 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu21.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu21.text = '0';
                                            stokBatu21.text = '';
                                            crtPcsBatu21.text = '';
                                            ukuranBatu21.text = '';
                                            stokBatu21.text = '';
                                            batu21 = '';
                                            hargaBatu21 = 0;
                                            caratPcsBatu21 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu21

//size batu22
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu22.text = '';
                                        crtPcsBatu22.text = '';
                                        idStone22 = item.idStone;
                                        idBatu22 = item.id;
                                        hargaBatu22 = data[0]['unitCost'];
                                        caratPcsBatu22 = data[0]['caratPcs'];
                                        batu22 = item.keyWord.toString();
                                        stokBatu22.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu22!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu22
                            idStone22 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu22,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu22
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu22 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu22,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu22 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu22
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu22,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu22
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu22,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu22!.toLowerCase() == "custom emerald" ||
                                        batu22!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu22!.toLowerCase() ==
                                            "custom heart" ||
                                        batu22!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu22!.toLowerCase() ==
                                            "custom oval" ||
                                        batu22!.toLowerCase() ==
                                            "custom pear" ||
                                        batu22!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu22!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu22!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu22 = customGol1!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu22 = customGol2!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu22 = customGol3!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu22 = customGol4!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu22 = customGol5!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu22 = customGol6!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu22 = customGol7!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu22 = customGol8!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu22 = customGol9!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu22 = customGol10!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu22 = customGol11!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu22 = customGol12!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu22 = customGol13!;
                                        caratPcsBatu22 = double.parse(value);
                                      } else {
                                        hargaBatu22 = customGol14!;
                                        caratPcsBatu22 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu22.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu22.text = '0';
                                            stokBatu22.text = '';
                                            crtPcsBatu22.text = '';
                                            ukuranBatu22.text = '';
                                            stokBatu22.text = '';
                                            batu22 = '';
                                            hargaBatu22 = 0;
                                            caratPcsBatu22 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu22

//size batu23
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu23.text = '';
                                        crtPcsBatu23.text = '';
                                        idStone23 = item.idStone;
                                        idBatu23 = item.id;
                                        hargaBatu23 = data[0]['unitCost'];
                                        caratPcsBatu23 = data[0]['caratPcs'];
                                        batu23 = item.keyWord.toString();
                                        stokBatu23.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu23!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu23
                            idStone23 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu23,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu23
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu23 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu23,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu23 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu23
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu23,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu23
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu23,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu23!.toLowerCase() == "custom emerald" ||
                                        batu23!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu23!.toLowerCase() ==
                                            "custom heart" ||
                                        batu23!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu23!.toLowerCase() ==
                                            "custom oval" ||
                                        batu23!.toLowerCase() ==
                                            "custom pear" ||
                                        batu23!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu23!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu23!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu23 = customGol1!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu23 = customGol2!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu23 = customGol3!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu23 = customGol4!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu23 = customGol5!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu23 = customGol6!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu23 = customGol7!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu23 = customGol8!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu23 = customGol9!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu23 = customGol10!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu23 = customGol11!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu23 = customGol12!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu23 = customGol13!;
                                        caratPcsBatu23 = double.parse(value);
                                      } else {
                                        hargaBatu23 = customGol14!;
                                        caratPcsBatu23 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu23.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu23.text = '0';
                                            stokBatu23.text = '';
                                            crtPcsBatu23.text = '';
                                            ukuranBatu23.text = '';
                                            stokBatu23.text = '';
                                            batu23 = '';
                                            hargaBatu23 = 0;
                                            caratPcsBatu23 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu23

//size batu24
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu24.text = '';
                                        crtPcsBatu24.text = '';
                                        idStone24 = item.idStone;
                                        idBatu24 = item.id;
                                        hargaBatu24 = data[0]['unitCost'];
                                        caratPcsBatu24 = data[0]['caratPcs'];
                                        batu24 = item.keyWord.toString();
                                        stokBatu24.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu24!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu24
                            idStone24 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu24,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu24
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu24 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu24,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu24 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu24
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu24,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu24
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu24,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu24!.toLowerCase() == "custom emerald" ||
                                        batu24!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu24!.toLowerCase() ==
                                            "custom heart" ||
                                        batu24!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu24!.toLowerCase() ==
                                            "custom oval" ||
                                        batu24!.toLowerCase() ==
                                            "custom pear" ||
                                        batu24!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu24!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu24!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu24 = customGol1!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu24 = customGol2!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu24 = customGol3!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu24 = customGol4!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu24 = customGol5!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu24 = customGol6!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu24 = customGol7!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu24 = customGol8!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu24 = customGol9!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu24 = customGol10!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu24 = customGol11!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu24 = customGol12!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu24 = customGol13!;
                                        caratPcsBatu24 = double.parse(value);
                                      } else {
                                        hargaBatu24 = customGol14!;
                                        caratPcsBatu24 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu24.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu24.text = '0';
                                            stokBatu24.text = '';
                                            crtPcsBatu24.text = '';
                                            ukuranBatu24.text = '';
                                            stokBatu24.text = '';
                                            batu24 = '';
                                            hargaBatu24 = 0;
                                            caratPcsBatu24 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu24

//size batu25
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu25.text = '';
                                        crtPcsBatu25.text = '';
                                        idStone25 = item.idStone;
                                        idBatu25 = item.id;
                                        hargaBatu25 = data[0]['unitCost'];
                                        caratPcsBatu25 = data[0]['caratPcs'];
                                        batu25 = item.keyWord.toString();
                                        stokBatu25.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu25!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu25
                            idStone25 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu25,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu25
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu25 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu25,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu25 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu25
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu25,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu25
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu25,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu25!.toLowerCase() == "custom emerald" ||
                                        batu25!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu25!.toLowerCase() ==
                                            "custom heart" ||
                                        batu25!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu25!.toLowerCase() ==
                                            "custom oval" ||
                                        batu25!.toLowerCase() ==
                                            "custom pear" ||
                                        batu25!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu25!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu25!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu25 = customGol1!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu25 = customGol2!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu25 = customGol3!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu25 = customGol4!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu25 = customGol5!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu25 = customGol6!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu25 = customGol7!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu25 = customGol8!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu25 = customGol9!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu25 = customGol10!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu25 = customGol11!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu25 = customGol12!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu25 = customGol13!;
                                        caratPcsBatu25 = double.parse(value);
                                      } else {
                                        hargaBatu25 = customGol14!;
                                        caratPcsBatu25 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu25.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu25.text = '0';
                                            stokBatu25.text = '';
                                            crtPcsBatu25.text = '';
                                            ukuranBatu25.text = '';
                                            stokBatu25.text = '';
                                            batu25 = '';
                                            hargaBatu25 = 0;
                                            caratPcsBatu25 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu25

//size batu26
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu26.text = '';
                                        crtPcsBatu26.text = '';
                                        idStone26 = item.idStone;
                                        idBatu26 = item.id;
                                        hargaBatu26 = data[0]['unitCost'];
                                        caratPcsBatu26 = data[0]['caratPcs'];
                                        batu26 = item.keyWord.toString();
                                        stokBatu26.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu26!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu26
                            idStone26 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu26,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu26
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu26 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu26,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu26 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu26
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu26,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu26
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu26,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu26!.toLowerCase() == "custom emerald" ||
                                        batu26!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu26!.toLowerCase() ==
                                            "custom heart" ||
                                        batu26!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu26!.toLowerCase() ==
                                            "custom oval" ||
                                        batu26!.toLowerCase() ==
                                            "custom pear" ||
                                        batu26!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu26!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu26!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu26 = customGol1!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu26 = customGol2!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu26 = customGol3!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu26 = customGol4!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu26 = customGol5!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu26 = customGol6!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu26 = customGol7!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu26 = customGol8!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu26 = customGol9!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu26 = customGol10!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu26 = customGol11!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu26 = customGol12!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu26 = customGol13!;
                                        caratPcsBatu26 = double.parse(value);
                                      } else {
                                        hargaBatu26 = customGol14!;
                                        caratPcsBatu26 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu26.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu26.text = '0';
                                            stokBatu26.text = '';
                                            crtPcsBatu26.text = '';
                                            ukuranBatu26.text = '';
                                            stokBatu26.text = '';
                                            batu26 = '';
                                            hargaBatu26 = 0;
                                            caratPcsBatu26 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu26
//size batu27
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu27.text = '';
                                        crtPcsBatu27.text = '';
                                        idStone27 = item.idStone;
                                        idBatu27 = item.id;
                                        hargaBatu27 = data[0]['unitCost'];
                                        caratPcsBatu27 = data[0]['caratPcs'];
                                        batu27 = item.keyWord.toString();
                                        stokBatu27.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu27!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu27
                            idStone27 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu27,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu27
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu27 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu27,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu27 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu27
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu27,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu27
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu27,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu27!.toLowerCase() == "custom emerald" ||
                                        batu27!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu27!.toLowerCase() ==
                                            "custom heart" ||
                                        batu27!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu27!.toLowerCase() ==
                                            "custom oval" ||
                                        batu27!.toLowerCase() ==
                                            "custom pear" ||
                                        batu27!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu27!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu27!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu27 = customGol1!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu27 = customGol2!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu27 = customGol3!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu27 = customGol4!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu27 = customGol5!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu27 = customGol6!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu27 = customGol7!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu27 = customGol8!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu27 = customGol9!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu27 = customGol10!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu27 = customGol11!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu27 = customGol12!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu27 = customGol13!;
                                        caratPcsBatu27 = double.parse(value);
                                      } else {
                                        hargaBatu27 = customGol14!;
                                        caratPcsBatu27 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu27.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu27.text = '0';
                                            stokBatu27.text = '';
                                            crtPcsBatu27.text = '';
                                            ukuranBatu27.text = '';
                                            stokBatu27.text = '';
                                            batu27 = '';
                                            hargaBatu27 = 0;
                                            caratPcsBatu27 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu27
//size batu28
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu28.text = '';
                                        crtPcsBatu28.text = '';
                                        idStone28 = item.idStone;
                                        idBatu28 = item.id;
                                        hargaBatu28 = data[0]['unitCost'];
                                        caratPcsBatu28 = data[0]['caratPcs'];
                                        batu28 = item.keyWord.toString();
                                        stokBatu28.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu28!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu28
                            idStone28 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu28,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu28
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu28 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu28,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu28 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu28
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu28,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu28
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu28,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu28!.toLowerCase() == "custom emerald" ||
                                        batu28!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu28!.toLowerCase() ==
                                            "custom heart" ||
                                        batu28!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu28!.toLowerCase() ==
                                            "custom oval" ||
                                        batu28!.toLowerCase() ==
                                            "custom pear" ||
                                        batu28!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu28!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu28!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu28 = customGol1!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu28 = customGol2!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu28 = customGol3!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu28 = customGol4!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu28 = customGol5!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu28 = customGol6!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu28 = customGol7!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu28 = customGol8!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu28 = customGol9!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu28 = customGol10!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu28 = customGol11!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu28 = customGol12!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu28 = customGol13!;
                                        caratPcsBatu28 = double.parse(value);
                                      } else {
                                        hargaBatu28 = customGol14!;
                                        caratPcsBatu28 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu28.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu28.text = '0';
                                            stokBatu28.text = '';
                                            crtPcsBatu28.text = '';
                                            ukuranBatu28.text = '';
                                            stokBatu28.text = '';
                                            batu28 = '';
                                            hargaBatu28 = 0;
                                            caratPcsBatu28 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu28
//size batu29
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu29.text = '';
                                        crtPcsBatu29.text = '';
                                        idStone29 = item.idStone;
                                        idBatu29 = item.id;
                                        hargaBatu29 = data[0]['unitCost'];
                                        caratPcsBatu29 = data[0]['caratPcs'];
                                        batu29 = item.keyWord.toString();
                                        stokBatu29.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu29!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu29
                            idStone29 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu29,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu29
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu29 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu29,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu29 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu29
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu29,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu29
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu29,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu29!.toLowerCase() == "custom emerald" ||
                                        batu29!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu29!.toLowerCase() ==
                                            "custom heart" ||
                                        batu29!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu29!.toLowerCase() ==
                                            "custom oval" ||
                                        batu29!.toLowerCase() ==
                                            "custom pear" ||
                                        batu29!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu29!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu29!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu29 = customGol1!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu29 = customGol2!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu29 = customGol3!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu29 = customGol4!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu29 = customGol5!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu29 = customGol6!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu29 = customGol7!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu29 = customGol8!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu29 = customGol9!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu29 = customGol10!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu29 = customGol11!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu29 = customGol12!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu29 = customGol13!;
                                        caratPcsBatu29 = double.parse(value);
                                      } else {
                                        hargaBatu29 = customGol14!;
                                        caratPcsBatu29 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu29.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu29.text = '0';
                                            stokBatu29.text = '';
                                            crtPcsBatu29.text = '';
                                            ukuranBatu29.text = '';
                                            stokBatu29.text = '';
                                            batu29 = '';
                                            hargaBatu29 = 0;
                                            caratPcsBatu29 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu29
//size batu30
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu30.text = '';
                                        crtPcsBatu30.text = '';
                                        idStone30 = item.idStone;
                                        idBatu30 = item.id;
                                        hargaBatu30 = data[0]['unitCost'];
                                        caratPcsBatu30 = data[0]['caratPcs'];
                                        batu30 = item.keyWord.toString();
                                        stokBatu30.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu30!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu30
                            idStone30 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu30,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu30
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu30 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu30,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu30 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu30
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu30,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu30
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu30,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu30!.toLowerCase() == "custom emerald" ||
                                        batu30!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu30!.toLowerCase() ==
                                            "custom heart" ||
                                        batu30!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu30!.toLowerCase() ==
                                            "custom oval" ||
                                        batu30!.toLowerCase() ==
                                            "custom pear" ||
                                        batu30!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu30!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu30!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu30 = customGol1!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu30 = customGol2!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu30 = customGol3!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu30 = customGol4!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu30 = customGol5!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu30 = customGol6!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu30 = customGol7!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu30 = customGol8!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu30 = customGol9!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu30 = customGol10!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu30 = customGol11!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu30 = customGol12!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu30 = customGol13!;
                                        caratPcsBatu30 = double.parse(value);
                                      } else {
                                        hargaBatu30 = customGol14!;
                                        caratPcsBatu30 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu30.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu30.text = '0';
                                            stokBatu30.text = '';
                                            crtPcsBatu30.text = '';
                                            ukuranBatu30.text = '';
                                            stokBatu30.text = '';
                                            batu30 = '';
                                            hargaBatu30 = 0;
                                            caratPcsBatu30 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu30
//size batu31
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu31.text = '';
                                        crtPcsBatu31.text = '';
                                        idStone31 = item.idStone;
                                        idBatu31 = item.id;
                                        hargaBatu31 = data[0]['unitCost'];
                                        caratPcsBatu31 = data[0]['caratPcs'];
                                        batu31 = item.keyWord.toString();
                                        stokBatu31.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu31!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu31
                            idStone31 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu31,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu31
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu31 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu31,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu31 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu31
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu31,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu31
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu31,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu31!.toLowerCase() == "custom emerald" ||
                                        batu31!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu31!.toLowerCase() ==
                                            "custom heart" ||
                                        batu31!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu31!.toLowerCase() ==
                                            "custom oval" ||
                                        batu31!.toLowerCase() ==
                                            "custom pear" ||
                                        batu31!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu31!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu31!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu31 = customGol1!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu31 = customGol2!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu31 = customGol3!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu31 = customGol4!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu31 = customGol5!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu31 = customGol6!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu31 = customGol7!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu31 = customGol8!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu31 = customGol9!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu31 = customGol10!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu31 = customGol11!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu31 = customGol12!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu31 = customGol13!;
                                        caratPcsBatu31 = double.parse(value);
                                      } else {
                                        hargaBatu31 = customGol14!;
                                        caratPcsBatu31 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu31.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu31.text = '0';
                                            stokBatu31.text = '';
                                            crtPcsBatu31.text = '';
                                            ukuranBatu31.text = '';
                                            stokBatu31.text = '';
                                            batu31 = '';
                                            hargaBatu31 = 0;
                                            caratPcsBatu31 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu31
//size batu32
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu32.text = '';
                                        crtPcsBatu32.text = '';
                                        idStone32 = item.idStone;
                                        idBatu32 = item.id;
                                        hargaBatu32 = data[0]['unitCost'];
                                        caratPcsBatu32 = data[0]['caratPcs'];
                                        batu32 = item.keyWord.toString();
                                        stokBatu32.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu32!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu32
                            idStone32 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu32,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu32
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu32 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu32,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu32 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu32
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu32,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu32
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu32,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu32!.toLowerCase() == "custom emerald" ||
                                        batu32!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu32!.toLowerCase() ==
                                            "custom heart" ||
                                        batu32!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu32!.toLowerCase() ==
                                            "custom oval" ||
                                        batu32!.toLowerCase() ==
                                            "custom pear" ||
                                        batu32!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu32!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu32!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu32 = customGol1!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu32 = customGol2!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu32 = customGol3!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu32 = customGol4!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu32 = customGol5!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu32 = customGol6!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu32 = customGol7!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu32 = customGol8!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu32 = customGol9!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu32 = customGol10!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu32 = customGol11!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu32 = customGol12!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu32 = customGol13!;
                                        caratPcsBatu32 = double.parse(value);
                                      } else {
                                        hargaBatu32 = customGol14!;
                                        caratPcsBatu32 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu32.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu32.text = '0';
                                            stokBatu32.text = '';
                                            crtPcsBatu32.text = '';
                                            ukuranBatu32.text = '';
                                            stokBatu32.text = '';
                                            batu32 = '';
                                            hargaBatu32 = 0;
                                            caratPcsBatu32 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu32
//size batu33
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu33.text = '';
                                        crtPcsBatu33.text = '';
                                        idStone33 = item.idStone;
                                        idBatu33 = item.id;
                                        hargaBatu33 = data[0]['unitCost'];
                                        caratPcsBatu33 = data[0]['caratPcs'];
                                        batu33 = item.keyWord.toString();
                                        stokBatu33.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu33!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu33
                            idStone33 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu33,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu33
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu33 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu33,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu33 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu33
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu33,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu33
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu33,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu33!.toLowerCase() == "custom emerald" ||
                                        batu33!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu33!.toLowerCase() ==
                                            "custom heart" ||
                                        batu33!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu33!.toLowerCase() ==
                                            "custom oval" ||
                                        batu33!.toLowerCase() ==
                                            "custom pear" ||
                                        batu33!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu33!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu33!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu33 = customGol1!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu33 = customGol2!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu33 = customGol3!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu33 = customGol4!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu33 = customGol5!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu33 = customGol6!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu33 = customGol7!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu33 = customGol8!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu33 = customGol9!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu33 = customGol10!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu33 = customGol11!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu33 = customGol12!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu33 = customGol13!;
                                        caratPcsBatu33 = double.parse(value);
                                      } else {
                                        hargaBatu33 = customGol14!;
                                        caratPcsBatu33 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu33.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu33.text = '0';
                                            stokBatu33.text = '';
                                            crtPcsBatu33.text = '';
                                            ukuranBatu33.text = '';
                                            stokBatu33.text = '';
                                            batu33 = '';
                                            hargaBatu33 = 0;
                                            caratPcsBatu33 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu33
//size batu34
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu34.text = '';
                                        crtPcsBatu34.text = '';
                                        idStone34 = item.idStone;
                                        idBatu34 = item.id;
                                        hargaBatu34 = data[0]['unitCost'];
                                        caratPcsBatu34 = data[0]['caratPcs'];
                                        batu34 = item.keyWord.toString();
                                        stokBatu34.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu34!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu34
                            idStone34 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu34,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu34
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu34 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu34,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu34 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu34
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu34,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu34
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu34,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu34!.toLowerCase() == "custom emerald" ||
                                        batu34!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu34!.toLowerCase() ==
                                            "custom heart" ||
                                        batu34!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu34!.toLowerCase() ==
                                            "custom oval" ||
                                        batu34!.toLowerCase() ==
                                            "custom pear" ||
                                        batu34!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu34!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu34!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu34 = customGol1!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu34 = customGol2!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu34 = customGol3!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu34 = customGol4!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu34 = customGol5!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu34 = customGol6!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu34 = customGol7!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu34 = customGol8!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu34 = customGol9!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu34 = customGol10!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu34 = customGol11!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu34 = customGol12!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu34 = customGol13!;
                                        caratPcsBatu34 = double.parse(value);
                                      } else {
                                        hargaBatu34 = customGol14!;
                                        caratPcsBatu34 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu34.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu34.text = '0';
                                            stokBatu34.text = '';
                                            crtPcsBatu34.text = '';
                                            ukuranBatu34.text = '';
                                            stokBatu34.text = '';
                                            batu34 = '';
                                            hargaBatu34 = 0;
                                            caratPcsBatu34 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu34
//size batu35
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              height: 45,
                              padding: const EdgeInsets.only(top: 5),
                              child: DropdownSearch<BatuModel>(
                                asyncItems: (String? filter) => getData(filter),
                                popupProps: const PopupPropsMultiSelection
                                    .modalBottomSheet(
                                  showSelectedItems: true,
                                  itemBuilder: _listBatu,
                                  showSearchBox: true,
                                ),
                                compareFn: (item, sItem) => item.id == sItem.id,
                                onChanged: (item) async {
                                  try {
                                    final response = await http.get(
                                      Uri.parse(
                                          '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                    );
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      final data = jsonDecode(response.body);
                                      print(data);
                                      setState(() {
                                        ukuranBatu35.text = '';
                                        crtPcsBatu35.text = '';
                                        idStone35 = item.idStone;
                                        idBatu35 = item.id;
                                        hargaBatu35 = data[0]['unitCost'];
                                        caratPcsBatu35 = data[0]['caratPcs'];
                                        batu35 = item.keyWord.toString();
                                        stokBatu35.text = item.qty.toString();
                                      });
                                    }
                                  } catch (e) {
                                    print('Error get data batu');
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    label: Text(
                                      batu35!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            //ukuran batu35
                            idStone35 != -2
                                ? const SizedBox()
                                : Container(
                                    width: 220,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: ukuranBatu35,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        label: const Text('Ukuran'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                            //qty batu35
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: batu35 == '' ? false : true,
                                textInputAction: TextInputAction.next,
                                controller: qtyBatu35,
                                onChanged: (value) {
                                  setState(() {
                                    qtyIntBatu35 = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Qty'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //stok batu35
                            Container(
                              width: 80,
                              height: 45,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                controller: stokBatu35,
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Stok',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            //crt/pcsbatu35
                            Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: crtPcsBatu35,
                                onChanged: (value) {
                                  setState(() {
                                    //todo: perhitungan batu custom
                                    if (batu35!.toLowerCase() == "custom emerald" ||
                                        batu35!.toLowerCase() ==
                                            "custom baguete" ||
                                        batu35!.toLowerCase() ==
                                            "custom heart" ||
                                        batu35!.toLowerCase() ==
                                            "custom marquise" ||
                                        batu35!.toLowerCase() ==
                                            "custom oval" ||
                                        batu35!.toLowerCase() ==
                                            "custom pear" ||
                                        batu35!.toLowerCase() ==
                                            "custom princess cut" ||
                                        batu35!.toLowerCase() ==
                                            "custom ruby" ||
                                        batu35!.toLowerCase() ==
                                            "custom tapper") {
                                      //? kondisi sesuai carat/pcs
                                      if (double.parse(value) < 0.071) {
                                        hargaBatu35 = customGol1!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.121) {
                                        hargaBatu35 = customGol2!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.182) {
                                        hargaBatu35 = customGol3!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.231) {
                                        hargaBatu35 = customGol4!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.266) {
                                        hargaBatu35 = customGol5!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.356) {
                                        hargaBatu35 = customGol6!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.406) {
                                        hargaBatu35 = customGol7!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.456) {
                                        hargaBatu35 = customGol8!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.506) {
                                        hargaBatu35 = customGol9!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.556) {
                                        hargaBatu35 = customGol10!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.606) {
                                        hargaBatu35 = customGol11!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.656) {
                                        hargaBatu35 = customGol12!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else if (double.parse(value) < 0.706) {
                                        hargaBatu35 = customGol13!;
                                        caratPcsBatu35 = double.parse(value);
                                      } else {
                                        hargaBatu35 = customGol14!;
                                        caratPcsBatu35 = double.parse(value);
                                      }
                                    }
                                    //! keluar dari kondisi batu custom
                                    else {}
                                  });
                                },
                                decoration: InputDecoration(
                                  label: const Text('Carat / Pcs'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            qtyBatu35.text.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            qtyBatu35.text = '0';
                                            stokBatu35.text = '';
                                            crtPcsBatu35.text = '';
                                            ukuranBatu35.text = '';
                                            stokBatu35.text = '';
                                            batu35 = '';
                                            hargaBatu35 = 0;
                                            caratPcsBatu35 = 0;
                                          });
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                          ],
                        ),
// end row batu35
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ));
  }

  clearForm() async {
    kodeDesignMdbc.text = '';
    kodeMarketing.text = '';
    kodeProduksi.text = '';
    namaDesigner.text = '';
    namaModeller.text = '';
    kodeDesign.text = '';
    tema.text = '';
    rantai.text = '';
    qtyRantai.text = '';
    lain2.text = '';
    qtyLain2.text = '';
    earnut.text = '';
    qtyEarnut.text = '';
    panjangRantai.text = '';
    customKomponen.text = '';
    qtyCustomKomponen.text = '';
    jenisBarang.text = '';
    kategoriBarang.text = '';
    brand.text = '';
    photoShoot.text = '';
    color.text = '';
    beratEmas.text = '';
    estimasiHarga.text = '';
    ringSize.text = '';
    siklus.text = '';
    batu1 = '';
    qtyBatu1.text = '';
    batu2 = '';
    qtyBatu2.text = '';
    batu3 = '';
    qtyBatu3.text = '';
    batu4 = '';
    qtyBatu4.text = '';
    batu5 = '';
    qtyBatu5.text = '';
    batu6 = '';
    qtyBatu6.text = '';
    batu7 = '';
    qtyBatu7.text = '';
    batu8 = '';
    qtyBatu8.text = '';
    batu9 = '';
    qtyBatu9.text = '';
    batu10 = '';
    qtyBatu10.text = '';
    batu11 = '';
    qtyBatu11.text = '';
    batu12 = '';
    qtyBatu12.text = '';
    batu13 = '';
    qtyBatu13.text = '';
    batu14 = '';
    qtyBatu14.text = '';
    batu15 = '';
    qtyBatu15.text = '';
    batu16 = '';
    qtyBatu16.text = '';
    batu17 = '';
    qtyBatu17.text = '';
    batu18 = '';
    qtyBatu18.text = '';
    batu19 = '';
    qtyBatu19.text = '';
    batu20 = '';
    qtyBatu20.text = '';
    batu21 = '';
    qtyBatu21.text = '';
    batu22 = '';
    qtyBatu22.text = '';
    batu23 = '';
    qtyBatu23.text = '';
    batu24 = '';
    qtyBatu24.text = '';
    batu25 = '';
    qtyBatu25.text = '';
    batu26 = '';
    qtyBatu26.text = '';
    batu27 = '';
    qtyBatu27.text = '';
    batu28 = '';
    qtyBatu28.text = '';
    batu29 = '';
    qtyBatu29.text = '';
    batu30 = '';
    qtyBatu30.text = '';
    batu31 = '';
    qtyBatu31.text = '';
    batu32 = '';
    qtyBatu32.text = '';
    batu33 = '';
    qtyBatu33.text = '';
    batu34 = '';
    qtyBatu34.text = '';
    batu35 = '';
    qtyBatu35.text = '';
    _imageFile = null;
    stokBatu1.text = '';
    stokBatu2.text = '';
    stokBatu3.text = '';
    stokBatu4.text = '';
    stokBatu5.text = '';
    stokBatu6.text = '';
    stokBatu7.text = '';
    stokBatu8.text = '';
    stokBatu9.text = '';
    stokBatu10.text = '';
    stokBatu11.text = '';
    stokBatu12.text = '';
    stokBatu13.text = '';
    stokBatu14.text = '';
    stokBatu15.text = '';
    stokBatu16.text = '';
    stokBatu17.text = '';
    stokBatu18.text = '';
    stokBatu19.text = '';
    stokBatu20.text = '';
    stokBatu21.text = '';
    stokBatu22.text = '';
    stokBatu23.text = '';
    stokBatu24.text = '';
    stokBatu25.text = '';
    stokBatu26.text = '';
    stokBatu27.text = '';
    stokBatu28.text = '';
    stokBatu29.text = '';
    stokBatu30.text = '';
    stokBatu31.text = '';
    stokBatu32.text = '';
    stokBatu33.text = '';
    stokBatu34.text = '';
    stokBatu35.text = '';
  }

  postAPI() async {
    ukuranBatu1.text.isNotEmpty
        ? batu1 = '$batu1 ${ukuranBatu1.text}'
        : batu1 = batu1;
    ukuranBatu2.text.isNotEmpty
        ? batu2 = '$batu2 ${ukuranBatu2.text}'
        : batu2 = batu2;
    ukuranBatu3.text.isNotEmpty
        ? batu3 = '$batu3 ${ukuranBatu3.text}'
        : batu3 = batu3;
    ukuranBatu4.text.isNotEmpty
        ? batu4 = '$batu4 ${ukuranBatu4.text}'
        : batu4 = batu4;
    ukuranBatu5.text.isNotEmpty
        ? batu5 = '$batu5 ${ukuranBatu5.text}'
        : batu5 = batu5;
    ukuranBatu6.text.isNotEmpty
        ? batu6 = '$batu6 ${ukuranBatu6.text}'
        : batu6 = batu6;
    ukuranBatu7.text.isNotEmpty
        ? batu7 = '$batu7 ${ukuranBatu7.text}'
        : batu7 = batu7;
    ukuranBatu8.text.isNotEmpty
        ? batu8 = '$batu8 ${ukuranBatu8.text}'
        : batu8 = batu8;
    ukuranBatu9.text.isNotEmpty
        ? batu9 = '$batu9 ${ukuranBatu9.text}'
        : batu9 = batu9;
    ukuranBatu10.text.isNotEmpty
        ? batu10 = '$batu10 ${ukuranBatu10.text}'
        : batu10 = batu10;
    ukuranBatu11.text.isNotEmpty
        ? batu11 = '$batu11 ${ukuranBatu11.text}'
        : batu11 = batu11;
    ukuranBatu12.text.isNotEmpty
        ? batu12 = '$batu12 ${ukuranBatu12.text}'
        : batu12 = batu12;
    ukuranBatu13.text.isNotEmpty
        ? batu13 = '$batu13 ${ukuranBatu13.text}'
        : batu13 = batu13;
    ukuranBatu14.text.isNotEmpty
        ? batu14 = '$batu14 ${ukuranBatu14.text}'
        : batu14 = batu14;
    ukuranBatu15.text.isNotEmpty
        ? batu15 = '$batu15 ${ukuranBatu15.text}'
        : batu15 = batu15;
    ukuranBatu16.text.isNotEmpty
        ? batu16 = '$batu16 ${ukuranBatu16.text}'
        : batu16 = batu16;
    ukuranBatu17.text.isNotEmpty
        ? batu17 = '$batu17 ${ukuranBatu17.text}'
        : batu17 = batu17;
    ukuranBatu18.text.isNotEmpty
        ? batu18 = '$batu18 ${ukuranBatu18.text}'
        : batu18 = batu18;
    ukuranBatu19.text.isNotEmpty
        ? batu19 = '$batu19 ${ukuranBatu19.text}'
        : batu19 = batu19;
    ukuranBatu20.text.isNotEmpty
        ? batu20 = '$batu20 ${ukuranBatu20.text}'
        : batu20 = batu20;
    ukuranBatu21.text.isNotEmpty
        ? batu21 = '$batu21 ${ukuranBatu21.text}'
        : batu21 = batu21;
    ukuranBatu22.text.isNotEmpty
        ? batu22 = '$batu22 ${ukuranBatu22.text}'
        : batu22 = batu22;
    ukuranBatu23.text.isNotEmpty
        ? batu23 = '$batu23 ${ukuranBatu23.text}'
        : batu23 = batu23;
    ukuranBatu24.text.isNotEmpty
        ? batu24 = '$batu24 ${ukuranBatu24.text}'
        : batu24 = batu24;
    ukuranBatu25.text.isNotEmpty
        ? batu25 = '$batu25 ${ukuranBatu25.text}'
        : batu25 = batu25;
    ukuranBatu26.text.isNotEmpty
        ? batu26 = '$batu26 ${ukuranBatu26.text}'
        : batu26 = batu26;
    ukuranBatu27.text.isNotEmpty
        ? batu27 = '$batu27 ${ukuranBatu27.text}'
        : batu27 = batu27;
    ukuranBatu28.text.isNotEmpty
        ? batu28 = '$batu28 ${ukuranBatu28.text}'
        : batu28 = batu28;
    ukuranBatu29.text.isNotEmpty
        ? batu29 = '$batu29 ${ukuranBatu29.text}'
        : batu29 = batu29;
    ukuranBatu30.text.isNotEmpty
        ? batu30 = '$batu30 ${ukuranBatu30.text}'
        : batu30 = batu30;
    ukuranBatu31.text.isNotEmpty
        ? batu31 = '$batu31 ${ukuranBatu31.text}'
        : batu31 = batu31;
    ukuranBatu32.text.isNotEmpty
        ? batu32 = '$batu32 ${ukuranBatu32.text}'
        : batu32 = batu32;
    ukuranBatu33.text.isNotEmpty
        ? batu33 = '$batu33 ${ukuranBatu33.text}'
        : batu33 = batu33;
    ukuranBatu34.text.isNotEmpty
        ? batu34 = '$batu34 ${ukuranBatu34.text}'
        : batu34 = batu34;
    ukuranBatu35.text.isNotEmpty
        ? batu35 = '$batu35 ${ukuranBatu35.text}'
        : batu35 = batu35;

    Map<String, dynamic> body = {
      'kodeDesignMdbc': kodeDesignMdbc.text,
      'kodeMarketing': kodeMarketing.text,
      'kodeProduksi': kodeProduksi.text,
      'namaDesigner': namaDesigner.text,
      'namaModeller': namaModeller.text,
      'kodeDesign': kodeDesign.text,
      'siklus': siklus.text,
      'tema': tema.text,
      'rantai': rantai.text,
      'qtyRantai': qtyRantai.text,
      'lain2': lain2.text,
      'qtyLain2': qtyLain2.text,
      'earnut': earnut.text,
      'qtyEarnut': qtyEarnut.text,
      'panjangRantai': panjangRantai.text,
      'customKomponen': customKomponen.text,
      'qtyCustomKomponen': qtyCustomKomponen.text,
      'jenisBarang': jenisBarang.text,
      'kategoriBarang': kategoriBarang.text,
      'brand': brand.text,
      'photoShoot': photoShoot.text,
      'color': color.text,
      'beratEmas': beratEmas.text,
      'estimasiHarga': estimasiHarga.text,
      'ringSize': ringSize.text,
      'batu1': batu1!,
      'qtyBatu1': qtyBatu1.text,
      'batu2': batu2!,
      'qtyBatu2': qtyBatu2.text,
      'batu3': batu3!,
      'qtyBatu3': qtyBatu3.text,
      'batu4': batu4!,
      'qtyBatu4': qtyBatu4.text,
      'batu5': batu5!,
      'qtyBatu5': qtyBatu5.text,
      'batu6': batu6!,
      'qtyBatu6': qtyBatu6.text,
      'batu7': batu7!,
      'qtyBatu7': qtyBatu7.text,
      'batu8': batu8!,
      'qtyBatu8': qtyBatu8.text,
      'batu9': batu9!,
      'qtyBatu9': qtyBatu9.text,
      'batu10': batu10!,
      'qtyBatu10': qtyBatu10.text,
      'batu11': batu11!,
      'qtyBatu11': qtyBatu11.text,
      'batu12': batu12!,
      'qtyBatu12': qtyBatu12.text,
      'batu13': batu13!,
      'qtyBatu13': qtyBatu13.text,
      'batu14': batu14!,
      'qtyBatu14': qtyBatu14.text,
      'batu15': batu15!,
      'qtyBatu15': qtyBatu15.text,
      'batu16': batu16!,
      'qtyBatu16': qtyBatu16.text,
      'batu17': batu17!,
      'qtyBatu17': qtyBatu17.text,
      'batu18': batu18!,
      'qtyBatu18': qtyBatu18.text,
      'batu19': batu19!,
      'qtyBatu19': qtyBatu19.text,
      'batu20': batu20!,
      'qtyBatu20': qtyBatu20.text,
      'batu21': batu21!,
      'qtyBatu21': qtyBatu21.text,
      'batu22': batu22!,
      'qtyBatu22': qtyBatu22.text,
      'batu23': batu23!,
      'qtyBatu23': qtyBatu23.text,
      'batu24': batu24!,
      'qtyBatu24': qtyBatu24.text,
      'batu25': batu25!,
      'qtyBatu25': qtyBatu25.text,
      'batu26': batu26!,
      'qtyBatu26': qtyBatu26.text,
      'batu27': batu27!,
      'qtyBatu27': qtyBatu27.text,
      'batu28': batu28!,
      'qtyBatu28': qtyBatu28.text,
      'batu29': batu29!,
      'qtyBatu29': qtyBatu29.text,
      'batu30': batu30!,
      'qtyBatu30': qtyBatu30.text,
      'batu31': batu31!,
      'qtyBatu31': qtyBatu31.text,
      'batu32': batu32!,
      'qtyBatu32': qtyBatu32.text,
      'batu33': batu33!,
      'qtyBatu33': qtyBatu33.text,
      'batu34': batu34!,
      'qtyBatu34': qtyBatu34.text,
      'batu35': batu35!,
      'qtyBatu35': qtyBatu35.text,
      'imageUrl': lastIdForm! == '0' ? imageUrl! : lastIdForm! + imageUrl!,
      'statusForm': statusForm.text,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postFormDesigner),
        body: body);
    print(response.body);
  }

  postApiQtyBatu1() async {
    var resultBatu1 =
        (int.parse(stokBatu1.text) - int.parse(qtyBatu1.text)).toString();
    Map<String, String> body = {
      'id': idBatu1.toString(),
      'qty': resultBatu1,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu2() async {
    var resultBatu2 =
        (int.parse(stokBatu2.text) - int.parse(qtyBatu2.text)).toString();
    Map<String, String> body = {
      'id': idBatu2.toString(),
      'qty': resultBatu2,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu3() async {
    var resultBatu3 =
        (int.parse(stokBatu3.text) - int.parse(qtyBatu3.text)).toString();
    Map<String, String> body = {
      'id': idBatu3.toString(),
      'qty': resultBatu3,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu4() async {
    var resultBatu4 =
        (int.parse(stokBatu4.text) - int.parse(qtyBatu4.text)).toString();
    Map<String, String> body = {
      'id': idBatu4.toString(),
      'qty': resultBatu4,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu5() async {
    var resultBatu5 =
        (int.parse(stokBatu5.text) - int.parse(qtyBatu5.text)).toString();
    Map<String, String> body = {
      'id': idBatu5.toString(),
      'qty': resultBatu5,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu6() async {
    var resultBatu6 =
        (int.parse(stokBatu6.text) - int.parse(qtyBatu6.text)).toString();
    Map<String, String> body = {
      'id': idBatu6.toString(),
      'qty': resultBatu6,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu7() async {
    var resultBatu7 =
        (int.parse(stokBatu7.text) - int.parse(qtyBatu7.text)).toString();
    Map<String, String> body = {
      'id': idBatu7.toString(),
      'qty': resultBatu7,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu8() async {
    var resultBatu8 =
        (int.parse(stokBatu8.text) - int.parse(qtyBatu8.text)).toString();
    Map<String, String> body = {
      'id': idBatu8.toString(),
      'qty': resultBatu8,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu9() async {
    var resultBatu9 =
        (int.parse(stokBatu9.text) - int.parse(qtyBatu9.text)).toString();
    Map<String, String> body = {
      'id': idBatu9.toString(),
      'qty': resultBatu9,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu10() async {
    var resultBatu10 =
        (int.parse(stokBatu10.text) - int.parse(qtyBatu10.text)).toString();
    Map<String, String> body = {
      'id': idBatu10.toString(),
      'qty': resultBatu10,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu11() async {
    var resultBatu11 =
        (int.parse(stokBatu11.text) - int.parse(qtyBatu11.text)).toString();
    Map<String, String> body = {
      'id': idBatu11.toString(),
      'qty': resultBatu11,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu12() async {
    var resultBatu12 =
        (int.parse(stokBatu12.text) - int.parse(qtyBatu12.text)).toString();
    Map<String, String> body = {
      'id': idBatu12.toString(),
      'qty': resultBatu12,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu13() async {
    var resultBatu13 =
        (int.parse(stokBatu13.text) - int.parse(qtyBatu13.text)).toString();
    Map<String, String> body = {
      'id': idBatu13.toString(),
      'qty': resultBatu13,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu14() async {
    var resultBatu14 =
        (int.parse(stokBatu14.text) - int.parse(qtyBatu14.text)).toString();
    Map<String, String> body = {
      'id': idBatu14.toString(),
      'qty': resultBatu14,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu15() async {
    var resultBatu15 =
        (int.parse(stokBatu15.text) - int.parse(qtyBatu15.text)).toString();
    Map<String, String> body = {
      'id': idBatu15.toString(),
      'qty': resultBatu15,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu16() async {
    var resultBatu16 =
        (int.parse(stokBatu16.text) - int.parse(qtyBatu16.text)).toString();
    Map<String, String> body = {
      'id': idBatu16.toString(),
      'qty': resultBatu16,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu17() async {
    var resultBatu17 =
        (int.parse(stokBatu17.text) - int.parse(qtyBatu17.text)).toString();
    Map<String, String> body = {
      'id': idBatu17.toString(),
      'qty': resultBatu17,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu18() async {
    var resultBatu18 =
        (int.parse(stokBatu18.text) - int.parse(qtyBatu18.text)).toString();
    Map<String, String> body = {
      'id': idBatu18.toString(),
      'qty': resultBatu18,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu19() async {
    var resultBatu19 =
        (int.parse(stokBatu19.text) - int.parse(qtyBatu19.text)).toString();
    Map<String, String> body = {
      'id': idBatu19.toString(),
      'qty': resultBatu19,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu20() async {
    var resultBatu20 =
        (int.parse(stokBatu20.text) - int.parse(qtyBatu20.text)).toString();
    Map<String, String> body = {
      'id': idBatu20.toString(),
      'qty': resultBatu20,
    };

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu21() async {
    var resultBatu21 =
        (int.parse(stokBatu21.text) - int.parse(qtyBatu21.text)).toString();
    Map<String, String> body = {
      'id': idBatu21.toString(),
      'qty': resultBatu21,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu22() async {
    var resultBatu22 =
        (int.parse(stokBatu22.text) - int.parse(qtyBatu22.text)).toString();
    Map<String, String> body = {
      'id': idBatu22.toString(),
      'qty': resultBatu22,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu23() async {
    var resultBatu23 =
        (int.parse(stokBatu23.text) - int.parse(qtyBatu23.text)).toString();
    Map<String, String> body = {
      'id': idBatu23.toString(),
      'qty': resultBatu23,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu24() async {
    var resultBatu24 =
        (int.parse(stokBatu24.text) - int.parse(qtyBatu24.text)).toString();
    Map<String, String> body = {
      'id': idBatu24.toString(),
      'qty': resultBatu24,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu25() async {
    var resultBatu25 =
        (int.parse(stokBatu25.text) - int.parse(qtyBatu25.text)).toString();
    Map<String, String> body = {
      'id': idBatu25.toString(),
      'qty': resultBatu25,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu26() async {
    var resultBatu26 =
        (int.parse(stokBatu26.text) - int.parse(qtyBatu26.text)).toString();
    Map<String, String> body = {
      'id': idBatu26.toString(),
      'qty': resultBatu26,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu27() async {
    var resultBatu27 =
        (int.parse(stokBatu27.text) - int.parse(qtyBatu27.text)).toString();
    Map<String, String> body = {
      'id': idBatu27.toString(),
      'qty': resultBatu27,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu28() async {
    var resultBatu28 =
        (int.parse(stokBatu28.text) - int.parse(qtyBatu28.text)).toString();
    Map<String, String> body = {
      'id': idBatu28.toString(),
      'qty': resultBatu28,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu29() async {
    var resultBatu29 =
        (int.parse(stokBatu29.text) - int.parse(qtyBatu29.text)).toString();
    Map<String, String> body = {
      'id': idBatu29.toString(),
      'qty': resultBatu29,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu30() async {
    var resultBatu30 =
        (int.parse(stokBatu30.text) - int.parse(qtyBatu30.text)).toString();
    Map<String, String> body = {
      'id': idBatu30.toString(),
      'qty': resultBatu30,
    };

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu31() async {
    var resultBatu31 =
        (int.parse(stokBatu31.text) - int.parse(qtyBatu31.text)).toString();
    Map<String, String> body = {
      'id': idBatu31.toString(),
      'qty': resultBatu31,
    };

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu32() async {
    var resultBatu32 =
        (int.parse(stokBatu32.text) - int.parse(qtyBatu32.text)).toString();
    Map<String, String> body = {
      'id': idBatu32.toString(),
      'qty': resultBatu32,
    };

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu33() async {
    var resultBatu33 =
        (int.parse(stokBatu33.text) - int.parse(qtyBatu33.text)).toString();
    Map<String, String> body = {
      'id': idBatu33.toString(),
      'qty': resultBatu33,
    };

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu34() async {
    var resultBatu34 =
        (int.parse(stokBatu34.text) - int.parse(qtyBatu34.text)).toString();
    Map<String, String> body = {
      'id': idBatu34.toString(),
      'qty': resultBatu34,
    };

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  postApiQtyBatu35() async {
    var resultBatu35 =
        (int.parse(stokBatu35.text) - int.parse(qtyBatu35.text)).toString();
    Map<String, String> body = {
      'id': idBatu35.toString(),
      'qty': resultBatu35,
    };

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postUpdateDataBatu),
        body: body);
    print(response.body);
  }

  Future<List<BatuModel>> getData(filter) async {
    // 'http://54.179.58.215:8080/api/indexcustomer',
    // 'http://192.168.22.228/Api_Flutter/spk/batu.php',
    // 'https://fakestoreapi.com/products',
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getDataBatu,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return BatuModel.fromJsonList(data);
    }
    return [];
  }

  Future<List<RantaiModel>> getListRantai(filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListRantai,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return RantaiModel.fromJsonList(data);
    }
    return [];
  }

  Future<List<EarnutModel>> getListEarnut(filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListEarnut,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return EarnutModel.fromJsonList(data);
    }
    return [];
  }

  Future<List<Lain2Model>> getListLain2(filter) async {
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getListLain2,
      queryParameters: {"filter": filter.toLowerCase()},
    );
    final data = response.data;
    if (data != null) {
      return Lain2Model.fromJsonList(data);
    }
    return [];
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
}

Widget _listBatu(
  BuildContext context,
  BatuModel? item,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item?.size ?? '',
          ),
          Text('(${item?.lot})'),
        ],
      ),
      subtitle: Text('Qty : ${item?.qty}'),
    ),
  );
}

Widget _listRantai(
  BuildContext context,
  RantaiModel? item,
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
      subtitle: Text('Qty : ${item?.qty}'),
    ),
  );
}

Widget _listEarnut(
  BuildContext context,
  EarnutModel? item,
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
      subtitle: Text('Qty : ${item?.qty}'),
    ),
  );
}

Widget _listLain2(
  BuildContext context,
  Lain2Model? item,
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
      subtitle: Text('Qty : ${item?.qty}'),
    ),
  );
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

//class untuk ambil character
extension E on String {
  String lastChars(int n) => substring(length - n);
}
