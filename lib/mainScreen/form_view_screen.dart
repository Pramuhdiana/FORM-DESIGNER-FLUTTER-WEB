// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
import 'package:form_designer/model/batu_model.dart';
import 'package:form_designer/model/earnut_model.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:form_designer/model/jenis_barang_model.dart';
import 'package:form_designer/model/lain2_model.dart';
import 'package:form_designer/model/modeller_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../dev/network.dart';
import '../global/currency_format.dart';
import '../model/rantai_model.dart';
import '../widgets/custom_loading.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FormViewScreen extends StatefulWidget {
  FormDesignerModel? modelDesigner;

  FormViewScreen({
    super.key,
    this.modelDesigner,
    FormDesignerModel? models,
  });
  @override
  State<FormViewScreen> createState() => _FormViewScreenState();
}

class _FormViewScreenState extends State<FormViewScreen> {
  // ignore: unused_field, prefer_final_fields
  List _get = [];
  List<XFile>? imagefiles;
  // ignore: unused_field
  PlatformFile? _imageFile;
  String? noUrutBulan;
  String? jenisBatu;
  String? kodeKualitasBarang;

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

  TextEditingController jo = TextEditingController();
  TextEditingController tanggalInModeller = TextEditingController();
  TextEditingController tanggalOutModeller = TextEditingController();
  TextEditingController tanggalInProduksi = TextEditingController();
  TextEditingController pointModeller = TextEditingController();
  TextEditingController beratModeller = TextEditingController();
  TextEditingController kodeDesignMdbc = TextEditingController();
  TextEditingController siklus = TextEditingController();
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
  TextEditingController keteranganStatusBatu = TextEditingController();
  String? bulanDesigner;
  String? valueBulanDesigner;
  String? kodeBulan;

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

  int emas = 0;
  double upEmas = 0;
  double upLabour = 0;
  double upBatu = 0;
  double upFinal = 0;
  int kurs = 0;
  int others1 = 0;
  int others2 = 0;
  int others3 = 0;
  String? imageUrl = '';
  String? kodeJenisBarang = '';
  String? kodeWarna = '';
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController btnGenerateKodeMarketing =
      RoundedLoadingButtonController();
  int count = 0;
  List<PlatformFile>? _paths;
  String? status = 'NO';
  String? lastIdForm = '0';

  @override
  void initState() {
    super.initState();
    lastIdForm = widget.modelDesigner!.id!.toString();
    status = widget.modelDesigner!.statusForm!.toString();
    kodeDesignMdbc.text = widget.modelDesigner!.kodeDesignMdbc!.toString();
    kodeMarketing.text = widget.modelDesigner!.kodeMarketing!.toString();
    kodeProduksi.text = widget.modelDesigner!.kodeProduksi!.toString();
    namaDesigner.text = widget.modelDesigner!.namaDesigner!.toString();
    namaModeller.text = widget.modelDesigner!.namaModeller!.toString();
    siklus.text = widget.modelDesigner!.siklus!.toString();
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
    keteranganStatusBatu.text =
        widget.modelDesigner!.keteranganStatusBatu!.toString();
    pointModeller.text = widget.modelDesigner!.pointModeller!.toString();
    beratModeller.text = widget.modelDesigner!.beratModeller!.toString();
    tanggalInModeller.text = widget.modelDesigner!.tanggalInModeller!.isEmpty
        ? ''
        : DateFormat('dd/MMMM/yyyy').format(DateTime.parse(
            widget.modelDesigner!.tanggalInModeller!.toString()));
    tanggalOutModeller.text = widget.modelDesigner!.tanggalOutModeller!.isEmpty
        ? ''
        : DateFormat('dd/MMMM/yyyy').format(DateTime.parse(
            widget.modelDesigner!.tanggalOutModeller!.toString()));

    tanggalInProduksi.text = widget.modelDesigner!.tanggalInProduksi!.isEmpty
        ? ''
        : DateFormat('dd/MMMM/yyyy').format(DateTime.parse(
            widget.modelDesigner!.tanggalInProduksi!.toString()));

    var now = DateTime.now();
    bulanDesigner = DateFormat('MMMM', 'id').format(now);
    valueBulanDesigner = DateFormat('MMyy', 'id').format(now);
    String kodeMonth = DateFormat('M', 'id').format(now);

    kodeBulan = getHuruf(int.parse(kodeMonth));

    _getData();
    _getDataBatu();
  }

  String getHuruf(int angka) {
    return String.fromCharCode(angka + 64);
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
      print("error while picking file. $e");
    }
  }

  // ignore: unused_element
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

  Future _getDataBatu() async {
    print('masuk get batu');
    //batu1
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu1"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu1.text = data[0]['qty'].toString();
          beforeStokBatu1 = data[0]['qty'];
          beforeIdBatu1 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }

    //batu2
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu2"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu2.text = data[0]['qty'].toString();
          beforeStokBatu2 = data[0]['qty'];
          beforeIdBatu2 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }

//batu3
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu3"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu3.text = data[0]['qty'].toString();
          beforeStokBatu3 = data[0]['qty'];
          beforeIdBatu3 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu4
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu4"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu4.text = data[0]['qty'].toString();
          beforeStokBatu4 = data[0]['qty'];
          beforeIdBatu4 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu5
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu5"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu5.text = data[0]['qty'].toString();
          beforeStokBatu5 = data[0]['qty'];
          beforeIdBatu5 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu6
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu6"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu6.text = data[0]['qty'].toString();
          beforeStokBatu6 = data[0]['qty'];
          beforeIdBatu6 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu7
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu7"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu7.text = data[0]['qty'].toString();
          beforeStokBatu7 = data[0]['qty'];
          beforeIdBatu7 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu8
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu8"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu8.text = data[0]['qty'].toString();
          beforeStokBatu8 = data[0]['qty'];
          beforeIdBatu8 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu9
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu9"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu9.text = data[0]['qty'].toString();
          beforeStokBatu9 = data[0]['qty'];
          beforeIdBatu9 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu10
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu10"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu10.text = data[0]['qty'].toString();
          beforeStokBatu10 = data[0]['qty'];
          beforeIdBatu10 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu11
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu11"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu11.text = data[0]['qty'].toString();
          beforeStokBatu11 = data[0]['qty'];
          beforeIdBatu11 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu12
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu12"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu12.text = data[0]['qty'].toString();
          beforeStokBatu12 = data[0]['qty'];
          beforeIdBatu12 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu13
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu13"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu13.text = data[0]['qty'].toString();
          beforeStokBatu13 = data[0]['qty'];
          beforeIdBatu13 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu14
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu14"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu14.text = data[0]['qty'].toString();
          beforeStokBatu14 = data[0]['qty'];
          beforeIdBatu14 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu15
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu15"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu15.text = data[0]['qty'].toString();
          beforeStokBatu15 = data[0]['qty'];
          beforeIdBatu15 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu16
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu16"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu16.text = data[0]['qty'].toString();
          beforeStokBatu16 = data[0]['qty'];
          beforeIdBatu16 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu17
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu17"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu17.text = data[0]['qty'].toString();
          beforeStokBatu17 = data[0]['qty'];
          beforeIdBatu17 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu18
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu18"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu18.text = data[0]['qty'].toString();
          beforeStokBatu18 = data[0]['qty'];
          beforeIdBatu18 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu19
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu19"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu19.text = data[0]['qty'].toString();
          beforeStokBatu19 = data[0]['qty'];
          beforeIdBatu19 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu20
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu20"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu20.text = data[0]['qty'].toString();
          beforeStokBatu20 = data[0]['qty'];
          beforeIdBatu20 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu21
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu21"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu21.text = data[0]['qty'].toString();
          beforeStokBatu21 = data[0]['qty'];
          beforeIdBatu21 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu22
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu22"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu22.text = data[0]['qty'].toString();
          beforeStokBatu22 = data[0]['qty'];
          beforeIdBatu22 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu23
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu23"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu23.text = data[0]['qty'].toString();
          beforeStokBatu23 = data[0]['qty'];
          beforeIdBatu23 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu24
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu24"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu24.text = data[0]['qty'].toString();
          beforeStokBatu24 = data[0]['qty'];
          beforeIdBatu24 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu25
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu25"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu25.text = data[0]['qty'].toString();
          beforeStokBatu25 = data[0]['qty'];
          beforeIdBatu25 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu26
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu26"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu26.text = data[0]['qty'].toString();
          beforeStokBatu26 = data[0]['qty'];
          beforeIdBatu26 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu27
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu27"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu27.text = data[0]['qty'].toString();
          beforeStokBatu27 = data[0]['qty'];
          beforeIdBatu27 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu28
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu28"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu28.text = data[0]['qty'].toString();
          beforeStokBatu28 = data[0]['qty'];
          beforeIdBatu28 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu29
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu29"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu29.text = data[0]['qty'].toString();
          beforeStokBatu29 = data[0]['qty'];
          beforeIdBatu29 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu30
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu30"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu30.text = data[0]['qty'].toString();
          beforeStokBatu30 = data[0]['qty'];
          beforeIdBatu30 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu31
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu31"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu31.text = data[0]['qty'].toString();
          beforeStokBatu31 = data[0]['qty'];
          beforeIdBatu31 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu32
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu32"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu32.text = data[0]['qty'].toString();
          beforeStokBatu32 = data[0]['qty'];
          beforeIdBatu32 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu33
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu33"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu33.text = data[0]['qty'].toString();
          beforeStokBatu33 = data[0]['qty'];
          beforeIdBatu33 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu34
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu34"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu34.text = data[0]['qty'].toString();
          beforeStokBatu34 = data[0]['qty'];
          beforeIdBatu34 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
//batu35
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuId}?size="$batu35"'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu35.text = data[0]['qty'].toString();
          beforeStokBatu35 = data[0]['qty'];
          beforeIdBatu35 = data[0]['id'];
        });
      }
    } catch (e) {
      return e;
    }
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
      return e;
    }
  }

  String get totalPrice {
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
        (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
        (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
        (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
        (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
        (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));
    print('Diamond $totalDiamond');
    var totalQtyCrt = (((caratPcsBatu1 * qtyIntBatu1!) +
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
            (caratPcsBatu35 * qtyIntBatu35!)) /
        5);
    var totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);

    var totalLabour = ((labour! + 0) * upLabour);
    var total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;

    if (total.toString() == 'NaN') {
      return '\$ ${CurrencyFormat.convertToDollar(0, 0)}';
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
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = (((caratPcsBatu1 * qtyIntBatu1!) +
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
              (caratPcsBatu35 * qtyIntBatu35!)) /
          5);
      var totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);

      var totalLabour = ((labour! + others1) * upLabour);
      var total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;
      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print(output);
          print(total);
          print('others1');
          estimasiHarga.text = (total + (5 - int.parse(output))).toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total + (5 - int.parse(output)), 0)}';
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others1');
          print(output);
          print(total);
          estimasiHarga.text = (total + (10 - int.parse(output))).toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total + (10 - int.parse(output)), 0)}';
      } else {
        setState(() {
          print('others1');

          estimasiHarga.text = total.toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total, 0)}';
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
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = (((caratPcsBatu1 * qtyIntBatu1!) +
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
              (caratPcsBatu35 * qtyIntBatu35!)) /
          5);
      var totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);

      var totalLabour = ((labour! + others2) * upLabour);
      var total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;
      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print(output);
          print(total);
          print('others2');
          estimasiHarga.text = (total + (5 - int.parse(output))).toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total + (5 - int.parse(output)), 0)}';
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print(output);
          print(total);
          print('others2');
          estimasiHarga.text = (total + (10 - int.parse(output))).toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total + (10 - int.parse(output)), 0)}';
      } else {
        setState(() {
          print('others2');
          estimasiHarga.text = total.toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total, 0)}';
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
          (hargaBatu31 * (caratPcsBatu31 * qtyIntBatu31!)) +
          (hargaBatu32 * (caratPcsBatu32 * qtyIntBatu32!)) +
          (hargaBatu33 * (caratPcsBatu33 * qtyIntBatu33!)) +
          (hargaBatu34 * (caratPcsBatu34 * qtyIntBatu34!)) +
          (hargaBatu35 * (caratPcsBatu35 * qtyIntBatu35!));

      var totalQtyCrt = (((caratPcsBatu1 * qtyIntBatu1!) +
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
              (caratPcsBatu35 * qtyIntBatu35!)) /
          5);
      var totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);

      var totalLabour = ((labour! + others3) * upLabour);
      var total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;
      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print(output);
          print(total);
          print('others3');
          print(totalEmas);
          print(totalDiamond);
          print(totalLabour);
          estimasiHarga.text = (total + (5 - int.parse(output))).toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total + (5 - int.parse(output)), 0)}';
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print(output);
          print(total);
          print('others3');
          print(totalEmas);
          print(totalDiamond);
          print(totalLabour);
          estimasiHarga.text = (total + (10 - int.parse(output))).toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total + (10 - int.parse(output)), 0)}';
      } else {
        setState(() {
          print(output);
          print(total);
          print('others3');
          print(totalEmas);
          print(totalDiamond);
          print(totalLabour);
          estimasiHarga.text = total.toString();
        });
        return '\$ ${CurrencyFormat.convertToDollar(total, 0)}';
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
          '${widget.modelDesigner!.kodeDesignMdbc} - ${widget.modelDesigner!.jenisBarang}',
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 2000,
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _bagianKiri(),
                  _bagianTengah(),
                  Container(
                    width: 250,
                    child: Column(
                      children: [
                        //in modeller
                        SizedBox(
                          height: tinggiTextfield,
                          width: 200,
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: tanggalInModeller,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "In Modeller",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        //out modeller
                        SizedBox(
                          height: tinggiTextfield,
                          width: 200,
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: tanggalOutModeller,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Out Modeller",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        //in produksi
                        sharedPreferences!.getString('level') != '1'
                            ? const SizedBox()
                            : tanggalInProduksi.text.isEmpty
                                ? Container(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          postTanggalProduksi();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      const MainView()));

                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const AlertDialog(
                                                    title: Text(
                                                      'Tanggal In Produksi Terisi',
                                                    ),
                                                  ));
                                        },
                                        child: const Text(
                                          'Kirim Ke Produksi',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  )
                                : SizedBox(
                                    height: tinggiTextfield,
                                    width: 200,
                                    child: TextFormField(
                                      readOnly: true,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textInputAction: TextInputAction.next,
                                      controller: tanggalInProduksi,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        // hintText: "example: Cahaya Sanivokasi",
                                        labelText: "In Produksi",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
      bottomNavigationBar: sharedPreferences!.getString('level') == '1'
          ?
          //untuk scm
          Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: CustomLoadingButton(
                controller: btnController,
                onPressed: () {
                  final isValid = formKey.currentState?.validate();
                  if (!isValid!) {
                    print('gagal');
                    btnController.error();
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      btnController.reset(); //reset
                    });
                    return;
                  }
                  print('berhasil');

                  Future.delayed(const Duration(seconds: 1))
                      .then((value) async {
                    btnController.success();
                    await postAPI();
                    await postDataModeller();
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      btnController.reset(); //reset
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => MainViewScm(col: 0)));

                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => const AlertDialog(
                                title: Text(
                                  'Pilih Modeller Berhasil',
                                ),
                              ));
                      setState(() {});
                    });
                  });
                },
                child: const Text(
                  "Simpan Modeller",
                  style: TextStyle(color: Colors.white, fontSize: 34),
                ),
              ))
          : sharedPreferences!.getString('level') == '2'
              ?
              //null untuk designer
              const SizedBox()
              :
              //untuk modeller
              Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: CustomLoadingButton(
                    controller: btnController,
                    onPressed: () {
                      final isValid = formKey.currentState?.validate();
                      if (!isValid!) {
                        btnController.error();
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) {
                          btnController.reset(); //reset
                        });
                        return;
                      }
                      Future.delayed(const Duration(seconds: 1))
                          .then((value) async {
                        btnController.success();
                        await postPoint();
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) {
                          btnController.reset(); //reset
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const MainView()));

                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const AlertDialog(
                                    title: Text(
                                      'Point berhasil di simpan',
                                    ),
                                  ));
                          setState(() {});
                        });
                      });
                    },
                    child: const Text(
                      "Simpan Point",
                      style: TextStyle(color: Colors.white, fontSize: 34),
                    ),
                  )),
    );
  }

  //method print
  // void _createPdf() async {
  //   final doc = pw.Document();

  //   doc.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text('Hello World'),
  //         ); // Center
  //       })); // Page
  // PdfDocument document = PdfDocument();
  // final doc = pw.Document();
  // doc.addPage(pw.MultiPage(
  //     pageFormat: PdfPageFormat.a4,
  //     build: (context) {
  //       return [
  //         pw.SizedBox(
  //           width: 250,
  //           child: pw.Row(
  //             children: [
  //               pw.Text('try'),
  //               pw.Text('saja'),
  //             ],
  //           ),
  //         )
  //       ];
  //     }));
  // }

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
                  height: tinggiTextfield,
                  child: TextFormField(
                    readOnly: true,
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
                  height: tinggiTextfield,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  height: tinggiTextfield,
                  width: 200,
                  child: DropdownSearch<String>(
                    enabled: sharedPreferences!.getString('level') == '1'
                        ? true
                        : false,
                    items: const [
                      "Arif Kurniawan",
                      "Aris Pravidan",
                      "Fikryansyah",
                      "Yuse",
                    ],
                    onChanged: (item) {
                      setState(() {
                        namaModeller.text = item!;
                      });
                    },
                    selectedItem:
                        namaModeller.text.isEmpty ? null : namaModeller.text,
                    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                      showSelectedItems: true,
                      showSearchBox: true,
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        label: Text(
                          "Nama Modeller",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //kode marketing
                  kodeMarketing.text.isEmpty &&
                          sharedPreferences!.getString('level') == '1'
                      ? Container(
                          height: tinggiTextfield,
                          width: 200,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: CustomLoadingButton(
                              controller: btnGenerateKodeMarketing,
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder:
                                              (context, setState) =>
                                                  AlertDialog(

                                                      //Jenis Batu
                                                      content: Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: <Widget>[
                                                        Positioned(
                                                          right: -47.0,
                                                          top: -47.0,
                                                          child: InkResponse(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                const CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              child: Icon(
                                                                  Icons.close),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 120,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                child: DecoratedBox(
                                                                    decoration: BoxDecoration(
                                                                        color: jenisBatu != null ? const Color.fromARGB(255, 8, 209, 69) : const Color.fromRGBO(238, 240, 235, 1), //background color of dropdown button
                                                                        border: Border.all(
                                                                          color:
                                                                              Colors.black38,
                                                                          // width:
                                                                          //     3
                                                                        ), //border of dropdown button
                                                                        borderRadius: BorderRadius.circular(0), //border raiuds of dropdown button
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
                                                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                                                        child: DropdownButton(
                                                                          value:
                                                                              jenisBatu,
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
                                                                          onChanged:
                                                                              (value) {
                                                                            jenisBatu =
                                                                                value;
                                                                            jenisBatu == 'SI'
                                                                                ? kodeKualitasBarang = 'I'
                                                                                : jenisBatu == 'VS'
                                                                                    ? kodeKualitasBarang = 'E'
                                                                                    : kodeKualitasBarang = 'A';

                                                                            setState(() =>
                                                                                jenisBatu);
                                                                          },
                                                                          icon: const Padding(
                                                                              padding: EdgeInsets.only(left: 20),
                                                                              child: Icon(Icons.arrow_circle_down_sharp)),
                                                                          iconEnabledColor:
                                                                              Colors.black, //Icon color
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.black, //Font color
                                                                            // fontSize:
                                                                            //     15 //font size on dropdown button
                                                                          ),

                                                                          dropdownColor:
                                                                              Colors.white, //dropdown background color
                                                                          underline:
                                                                              Container(), //remove underline
                                                                          isExpanded:
                                                                              true, //make true to make width 100%
                                                                        ))),
                                                              ),
                                                              Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: SizedBox(
                                                                      width: 250,
                                                                      height: 50,
                                                                      child: ElevatedButton(
                                                                          child: const Text("Simpan Data"),
                                                                          onPressed: () async {
                                                                            try {
                                                                              final response = await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getDataModeller));

                                                                              // if response successful
                                                                              if (response.statusCode == 200) {
                                                                                List jsonResponse = json.decode(response.body);
                                                                                var allData = jsonResponse.map((data) => ModellerModel.fromJson(data)).toList();
                                                                                var filterByMonth = allData.where((element) => element.bulan.toString().toLowerCase() == bulanDesigner!.toString().toLowerCase());
                                                                                var filterBynoUrut = filterByMonth.where((element) => element.noUrutBulan! > 0).toList();
                                                                                noUrutBulan = filterByMonth.isEmpty
                                                                                    ? '1'.padLeft(3, '0')
                                                                                    : filterBynoUrut.isEmpty
                                                                                        ? '1'.padLeft(3, '0')
                                                                                        : (filterBynoUrut.last.noUrutBulan! + 1).toString().padLeft(3, '0');
                                                                                print(noUrutBulan);
                                                                              } else {}
                                                                            } catch (c) {
                                                                              print('err get data modeller : $c');
                                                                            }
                                                                            try {
                                                                              final response = await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListJenisbarang));

                                                                              // if response successful
                                                                              if (response.statusCode == 200) {
                                                                                List jsonResponse = jsonDecode(response.body);
                                                                                var allData = jsonResponse.map((data) => JenisbarangModel.fromJson(data)).toList();

                                                                                var filterByMonth = allData.where((element) => element.nama.toString().toLowerCase() == jenisBarang.text.toString().toLowerCase());
                                                                                kodeJenisBarang = filterByMonth.first.kodeBarang;
                                                                              } else {}
                                                                            } catch (c) {
                                                                              print('err get data jenis barang : $c');
                                                                            }

                                                                            var kodeBrand =
                                                                                '';
                                                                            if (brand.text ==
                                                                                'PARVA') {
                                                                              kodeBrand = '0';
                                                                              kodeJenisBarang = '$kodeJenisBarang$kodeBrand';
                                                                            } else if (brand.text ==
                                                                                'METIER') {
                                                                              kodeBrand = 'M';
                                                                              kodeJenisBarang = '$kodeBrand$kodeJenisBarang';
                                                                            } else if (brand.text ==
                                                                                'BELI BERLIAN') {
                                                                              kodeBrand = 'B';
                                                                              kodeJenisBarang = '$kodeBrand$kodeJenisBarang';
                                                                            } else {
                                                                              kodeBrand = '0';
                                                                              kodeJenisBarang = '$kodeJenisBarang$kodeBrand';
                                                                            }

                                                                            color.text == 'WG'
                                                                                ? kodeWarna = '0'
                                                                                : color.text == 'RG'
                                                                                    ? kodeWarna = '2'
                                                                                    : color.text == 'MIX'
                                                                                        ? kodeWarna = '4'
                                                                                        : kodeWarna = '5';
                                                                            Future.delayed(const Duration(seconds: 1)).then((value) async {
                                                                              btnGenerateKodeMarketing.success();
                                                                            });

                                                                            setState(() {
                                                                              kodeMarketing.text = '$kodeJenisBarang$valueBulanDesigner$noUrutBulan$kodeWarna${kodeKualitasBarang}01E';
                                                                            });
                                                                            // ignore: use_build_context_synchronously
                                                                            Navigator.pop(context);
                                                                          })))
                                                            ],
                                                          ),
                                                        ),
                                                      ])));
                                    });
                                setState(() {
                                  kodeMarketing.text =
                                      '$kodeJenisBarang$valueBulanDesigner$noUrutBulan$kodeWarna${kodeKualitasBarang}01E';
                                });
                              },
                              child: const Text('Generate\nKode Marketing'),
                            ),
                          ))
                      : SizedBox(
                          height: tinggiTextfield,
                          width: 200,
                          child: TextFormField(
                            readOnly:
                                sharedPreferences!.getString('level') == '1'
                                    ? false
                                    : true,
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
                    height: tinggiTextfield,
                    width: 200,
                    child: DropdownSearch<String>(
                      enabled: false,
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
                          enabled: false,
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
                    height: tinggiTextfield,
                    width: 200,
                    child: TextFormField(
                      readOnly: true,
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
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //kode produksi
                  SizedBox(
                    height: tinggiTextfield,
                    width: 200,
                    child: TextFormField(
                      readOnly: true,
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
                  //keteranganStatus Batu
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: tinggiTextfield,
                    width: 250,
                    child: DropdownSearch<String>(
                      enabled: sharedPreferences!.getString('level') == '1'
                          ? true
                          : false,
                      items: const [
                        "BATU LENGKAP",
                        "BATU KURANG LENGKAP",
                        "BATU TIDAK LENGKAP",
                      ],
                      onChanged: (item) {
                        setState(() {
                          keteranganStatusBatu.text = item!;
                        });
                      },
                      selectedItem: keteranganStatusBatu.text.isEmpty
                          ? null
                          : keteranganStatusBatu.text,
                      popupProps:
                          const PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          label: Text(
                            "Keterangan Status Batu",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          // suffixText: keteranganStatusBatu.text.isEmpty
                          //     ? "Keterangan Status Batu"
                          //     : keteranganStatusBatu.text,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  //tema
                  SizedBox(
                    height: tinggiTextfield,
                    width: 200,
                    child: TextFormField(
                      readOnly: true,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none, //agar tidak menghalangi object

                  children: [
                    const Positioned(
                        right: 5,
                        bottom: 15,
                        child: Text(
                          'Gram',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 18, bottom: 10),
                      child: SizedBox(
                        width: 150,
                        height: 45,
                        child: TextFormField(
                          enabled: sharedPreferences!.getString('level') != '3'
                              ? false
                              : true,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textInputAction: TextInputAction.next,
                          controller: pointModeller,
                          decoration: InputDecoration(
                            labelText: "Point Modeller",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Point wajib diisi *';
                          //   } else if (value == '0') {
                          //     return 'Point wajib diisi *';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                    clipBehavior: Clip.none, //agar tidak menghalangi object

                    children: [
                      const Positioned(
                          right: 5,
                          bottom: 15,
                          child: Text(
                            'Gram',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 18, bottom: 10, left: 40),
                        child: SizedBox(
                          width: 150,
                          height: 45,
                          child: TextFormField(
                            enabled:
                                sharedPreferences!.getString('level') != '3'
                                    ? false
                                    : true,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: beratModeller,
                            decoration: InputDecoration(
                              labelText: "Berat Modeller",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Point wajib diisi *';
                            //   } else if (value == '0') {
                            //     return 'Point wajib diisi *';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ]),
                sharedPreferences!.getString('level') != '2'
                    ? const SizedBox(width: 60)
                    : (sharedPreferences!.getString('level') == '2' &&
                            tanggalOutModeller.text.isNotEmpty)
                        ? const SizedBox(width: 60)
                        : IconButton(
                            color: Colors.green,
                            onPressed: () {
                              postTanggalOutModeller();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const MainView()));

                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const AlertDialog(
                                        title: Text(
                                          'Form Berhasil Di Approve',
                                        ),
                                      ));
                            },
                            icon: const Icon(Icons.done_outline_sharp),
                          ),
                //JO
                Container(
                  padding: const EdgeInsets.only(top: 18, bottom: 10),
                  height: tinggiTextfield,
                  width: 200,
                  child: TextFormField(
                    enabled: sharedPreferences!.getString('level') == '1'
                        ? true
                        : false,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.next,
                    controller: jo,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      // hintText: "example: Cahaya Sanivokasi",
                      labelText: "Job Order (JO)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ],
            ),
            imageUrl != null
                ? Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 350,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                          height: tinggiTextfield,
                          width: 230,
                          child: DropdownSearch<RantaiModel>(
                            enabled: false,
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
                                enabled: false,
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
                          height: tinggiTextfield,
                          width: 100,
                          child: TextFormField(
                            readOnly: true,
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
                          height: tinggiTextfield,
                          width: 100,
                          child: TextFormField(
                            readOnly: true,
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
                    height: tinggiTextfield,
                    width: 230,
                    child: DropdownSearch<JenisbarangModel>(
                      enabled: false,
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
                          kodeJenisBarang = item.kodeBarang;
                        });
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          enabled: false,
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
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: tinggiTextfield,
                          width: 230,
                          child: DropdownSearch<Lain2Model>(
                            enabled: false,
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
                                enabled: false,
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
                          height: tinggiTextfield,
                          width: 100,
                          child: TextFormField(
                            readOnly: true,
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
                          height: tinggiTextfield,
                          width: 100,
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: stokLain2,
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
                    height: tinggiTextfield,
                    width: 230,
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: kategoriBarang,
                      decoration: InputDecoration(
                        enabled: false,
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: kategoriBarang.text.isEmpty
                            ? "Kategori Bararang"
                            : kategoriBarang.text,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: tinggiTextfield,
                          width: 230,
                          child: DropdownSearch<EarnutModel>(
                            enabled: false,
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
                                enabled: false,
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
                          height: tinggiTextfield,
                          width: 100,
                          child: TextFormField(
                            readOnly: true,
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
                          height: tinggiTextfield,
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
                    height: tinggiTextfield,
                    width: 230,
                    child: DropdownSearch<String>(
                      enabled: false,
                      items: const ["PARVA", "SIORAI", "METIER"],
                      onChanged: (item) {
                        setState(() {
                          brand.text = item!;
                        });
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          enabled: false,
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
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: tinggiTextfield,
                          width: 230,
                          child: TextFormField(
                            readOnly: true,
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
                    height: tinggiTextfield,
                    width: 230,
                    child: TextFormField(
                      readOnly: true,
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
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: tinggiTextfield,
                          width: 230,
                          child: TextFormField(
                            readOnly: true,
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
                          height: tinggiTextfield,
                          width: 100,
                          child: TextFormField(
                            readOnly: true,
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
                          height: tinggiTextfield,
                          width: 100,
                          child: TextFormField(
                            readOnly: true,
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
                    height: tinggiTextfield,
                    width: 230,
                    child: DropdownSearch<String>(
                      enabled: false,
                      items: const ["WG", "RG", "MIX"],
                      onChanged: (item) {
                        setState(() {
                          color.text = item!;
                        });
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          enabled: false,
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
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: tinggiTextfield,
                    width: 230,
                    child: TextFormField(
                      readOnly: true,
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
                    height: tinggiTextfield,
                    width: 200,
                    child: TextFormField(
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        label: Text(
                          brand.text == "BELI BERLIAN"
                              ? 'Rp. ${CurrencyFormat.convertToDollar(int.parse(estimasiHarga.text), 0)}'
                              : brand.text == "METIER"
                                  ? 'Rp. ${CurrencyFormat.convertToDollar(int.parse(estimasiHarga.text), 0)}'
                                  : '\$ ${CurrencyFormat.convertToDollar(int.parse(estimasiHarga.text), 0)}',
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: tinggiTextfield,
                    width: 230,
                    child: TextFormField(
                      readOnly: true,
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
                        int.parse(qtyBatu1.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu1
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu1,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu1
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu1

                        //size batu2
                        int.parse(qtyBatu2.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu2
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu2,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu2
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu2

                        //size batu3
                        int.parse(qtyBatu3.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu3
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu3,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu3
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu3

                        //size batu4
                        int.parse(qtyBatu4.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu4
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu4,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu4
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu4

                        //size batu5
                        int.parse(qtyBatu5.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu5
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu5,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu5
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu5

                        //size batu6
                        int.parse(qtyBatu6.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu6
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu6,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu6
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu6

                        //size batu7
                        int.parse(qtyBatu7.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu7
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu7,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu7
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu7

                        //size batu8
                        int.parse(qtyBatu8.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu8
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu8,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu8
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu8

                        //size batu9
                        int.parse(qtyBatu9.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu9
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu9,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu9
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu9

                        //size batu10
                        int.parse(qtyBatu10.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu10
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu10,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu10
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu10

                        //size batu11
                        int.parse(qtyBatu11.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu11
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu11,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu11
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu11

                        //size batu12
                        int.parse(qtyBatu12.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu12
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu12,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu12
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu12

                        //size batu13
                        int.parse(qtyBatu13.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu13
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu13,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu13
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu13

                        //size batu14
                        int.parse(qtyBatu14.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu14
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu14,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu14
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu14

                        //size batu15
                        int.parse(qtyBatu15.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu15
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu15,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu15
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu15

                        //size batu16
                        int.parse(qtyBatu16.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu16
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu16,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu16
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu16

                        //size batu17
                        int.parse(qtyBatu17.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu17
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu17,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu17
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu17

                        //size batu18
                        int.parse(qtyBatu18.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu18
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu18,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu18
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu18

                        //size batu19
                        int.parse(qtyBatu19.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu19
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu19,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu19
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu19

                        //size batu20
                        int.parse(qtyBatu20.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu20
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu20,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu20
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu20

                        //size batu21
                        int.parse(qtyBatu21.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu21
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu21,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu21
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu21

                        //size batu22
                        int.parse(qtyBatu22.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu22
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu22,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu22
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu22

                        //size batu23
                        int.parse(qtyBatu23.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu23
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu23,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu23
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu23

                        //size batu24
                        int.parse(qtyBatu24.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu24
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu24,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu24
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu24

                        //size batu25
                        int.parse(qtyBatu25.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu25
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu25,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu25
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu25

                        //size batu26
                        int.parse(qtyBatu26.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu26
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu26,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu26
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu26

                        //size batu27
                        int.parse(qtyBatu27.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu27
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu27,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu27
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu27

                        //size batu28
                        int.parse(qtyBatu28.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu28
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu28,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu28
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu28

                        //size batu29
                        int.parse(qtyBatu29.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu29
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu29,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu29
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu29

                        //size batu30
                        int.parse(qtyBatu30.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu30
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu30,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu30
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu30

                        //size batu31
                        int.parse(qtyBatu31.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu31
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu31,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu31
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu31

                        //size batu32
                        int.parse(qtyBatu32.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu32
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu32,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu32
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu32

                        //size batu33
                        int.parse(qtyBatu33.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu33
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu33,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu33
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu33

                        //size batu34
                        int.parse(qtyBatu34.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu34
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu34,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu34
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        // end row batu34

                        //size batu35
                        int.parse(qtyBatu35.text) <= 0
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 350,
                                    height: 38,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownSearch<BatuModel>(
                                      asyncItems: (String? filter) =>
                                          getData(filter),
                                      popupProps: const PopupPropsMultiSelection
                                          .modalBottomSheet(
                                        showSelectedItems: true,
                                        itemBuilder: _listBatu,
                                        showSearchBox: true,
                                      ),
                                      compareFn: (item, sItem) =>
                                          item.id == sItem.id,
                                      onChanged: (item) async {},
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
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
                                      enabled: false,
                                    ),
                                  ),

                                  //qty batu35
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled: false,
                                      textInputAction: TextInputAction.next,
                                      controller: qtyBatu35,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        label: const Text('Qty'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                  ),

                                  //stok batu35
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
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

  postTanggalProduksi() async {
    Map<String, String> body = {
      'id': widget.modelDesigner!.id!.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addTanggalProduksi}'),
        body: body);
    print(response.body);
  }

  postTanggalOutModeller() async {
    Map<String, String> body = {
      'id': widget.modelDesigner!.id!.toString(),
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addTanggalModeller}'),
        body: body);
    print(response.body);
  }

  postAPI() async {
    Map<String, String> body = {
      'id': widget.modelDesigner!.id!.toString(),
      'namaModeller': namaModeller.text,
      'kodeMarketing': kodeMarketing.text,
      'keteranganStatusBatu': keteranganStatusBatu.text,
      'jo': jo.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addModeller}'),
        body: body);
    print(response.body);
  }

  postDataModeller() async {
    Map<String, dynamic> body = {
      'kodeDesign': kodeDesignMdbc.text,
      'jenisBatu': jenisBatu,
      'bulan': bulanDesigner,
      'kodeBulan': kodeBulan,
      'tema': tema.text,
      'noUrutBulan': noUrutBulan,
      'kodeMarketing': kodeMarketing.text,
      'status': status,
      'marketing': 'STEPHANIE',
      'brand': brand.text,
      'designer': namaDesigner.text,
      'modeller': namaModeller.text,
      'keterangan': ''
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postDataModeller),
        body: body);
    print(response.body);
  }

  postPoint() async {
    Map<String, String> body = {
      'id': widget.modelDesigner!.id!.toString(),
      'pointModeller': pointModeller.text,
      'beratModeller': beratModeller.text,
    };
    final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addPointModeller}'),
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
