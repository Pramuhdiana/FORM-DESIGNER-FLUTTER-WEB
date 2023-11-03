// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/dev/network.dart';
import 'package:form_designer/global/currency_format.dart';
import 'package:form_designer/model/form_designer_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: must_be_immutable
class PrintPage extends StatefulWidget {
  FormDesignerModel? modelDesigner;

  PrintPage({
    super.key,
    this.modelDesigner,
    FormDesignerModel? models,
  });

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
// ignore: unused_field, prefer_final_fields
  List _get = [];
  List<XFile>? imagefiles;
  // ignore: unused_field
  PlatformFile? _imageFile;

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

  TextEditingController inModeller = TextEditingController();
  TextEditingController outModeller = TextEditingController();
  TextEditingController finishingPoint = TextEditingController();
  TextEditingController polishing1Point = TextEditingController();
  TextEditingController assembly1Point = TextEditingController();
  TextEditingController polishing2Point = TextEditingController();
  TextEditingController assembly2Point = TextEditingController();
  TextEditingController polseBalesPoint = TextEditingController();

  TextEditingController pointModeller = TextEditingController();
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
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  int count = 0;
  List<PlatformFile>? _paths;

  @override
  void initState() {
    super.initState();
    finishingPoint.text = "  ";
    polishing1Point.text = "  ";
    assembly1Point.text = "  ";
    polishing2Point.text = "  ";
    assembly2Point.text = "  ";
    polseBalesPoint.text = "  ";
    inModeller.text = '${widget.modelDesigner!.tanggalInModeller!} ';
    outModeller.text = '${widget.modelDesigner!.tanggalOutModeller!} ';
    kodeDesignMdbc.text = '${widget.modelDesigner!.kodeDesignMdbc!} ';
    kodeMarketing.text = '${widget.modelDesigner!.kodeMarketing!} ';
    kodeProduksi.text = '${widget.modelDesigner!.kodeProduksi!} ';
    namaDesigner.text = '${widget.modelDesigner!.namaDesigner!} ';
    namaModeller.text = '${widget.modelDesigner!.namaModeller!} ';
    siklus.text = '${widget.modelDesigner!.siklus!} ';
    kodeDesign.text = '${widget.modelDesigner!.kodeDesign!} ';
    tema.text = '${widget.modelDesigner!.tema!} ';
    rantai.text = '${widget.modelDesigner!.rantai!} ';
    qtyRantai.text = '${widget.modelDesigner!.qtyRantai!} ';
    lain2.text = '${widget.modelDesigner!.lain2!} ';
    qtyLain2.text = '${widget.modelDesigner!.qtyLain2!} ';
    earnut.text = '${widget.modelDesigner!.earnut!} ';
    qtyEarnut.text = '${widget.modelDesigner!.qtyEarnut!} ';
    panjangRantai.text = '${widget.modelDesigner!.panjangRantai!} ';
    customKomponen.text = '${widget.modelDesigner!.customKomponen!} ';
    qtyCustomKomponen.text = '${widget.modelDesigner!.qtyCustomKomponen!} ';
    jenisBarang.text = '${widget.modelDesigner!.jenisBarang!} ';
    kategoriBarang.text = '${widget.modelDesigner!.kategoriBarang!} ';
    brand.text = '${widget.modelDesigner!.brand!} ';
    photoShoot.text = '${widget.modelDesigner!.photoShoot!} ';
    color.text = '${widget.modelDesigner!.color!} ';
    beratEmas.text = '${widget.modelDesigner!.beratEmas!} ';
    doubleBeratEmas = widget.modelDesigner!.beratEmas!;
    estimasiHarga.text = brand.text == "BELI BERLIAN"
        ? 'Rp .${CurrencyFormat.convertToDollar(widget.modelDesigner!.estimasiHarga!, 0)}'
        : brand.text == "METIER"
            ? 'Rp .${CurrencyFormat.convertToDollar(widget.modelDesigner!.estimasiHarga!, 0)}'
            : '\$ ${CurrencyFormat.convertToDollar(widget.modelDesigner!.estimasiHarga!, 0)}';
    ringSize.text = '${widget.modelDesigner!.ringSize!} ';
    batu1 = '${widget.modelDesigner!.batu1!} ';
    qtyBatu1.text = '${widget.modelDesigner!.qtyBatu1!} ';
    batu2 = '${widget.modelDesigner!.batu2!} ';
    qtyBatu2.text = '${widget.modelDesigner!.qtyBatu2!} ';
    batu3 = '${widget.modelDesigner!.batu3!} ';
    qtyBatu3.text = '${widget.modelDesigner!.qtyBatu3!} ';
    batu4 = '${widget.modelDesigner!.batu4!} ';
    qtyBatu4.text = '${widget.modelDesigner!.qtyBatu4!} ';
    batu5 = '${widget.modelDesigner!.batu5!} ';
    qtyBatu5.text = '${widget.modelDesigner!.qtyBatu5!} ';
    batu6 = '${widget.modelDesigner!.batu6!} ';
    qtyBatu6.text = '${widget.modelDesigner!.qtyBatu6!} ';
    batu7 = '${widget.modelDesigner!.batu7!} ';
    qtyBatu7.text = '${widget.modelDesigner!.qtyBatu7!} ';
    batu8 = '${widget.modelDesigner!.batu8!} ';
    qtyBatu8.text = '${widget.modelDesigner!.qtyBatu8!} ';
    batu9 = '${widget.modelDesigner!.batu9!} ';
    qtyBatu9.text = '${widget.modelDesigner!.qtyBatu9!} ';
    batu10 = '${widget.modelDesigner!.batu10!} ';
    qtyBatu10.text = '${widget.modelDesigner!.qtyBatu10!} ';
    batu11 = '${widget.modelDesigner!.batu11!} ';
    qtyBatu11.text = '${widget.modelDesigner!.qtyBatu11!} ';
    batu12 = '${widget.modelDesigner!.batu12!} ';
    qtyBatu12.text = '${widget.modelDesigner!.qtyBatu12!} ';
    batu13 = '${widget.modelDesigner!.batu13!} ';
    qtyBatu13.text = '${widget.modelDesigner!.qtyBatu13!} ';
    batu14 = '${widget.modelDesigner!.batu14!} ';
    qtyBatu14.text = '${widget.modelDesigner!.qtyBatu14!} ';
    batu15 = '${widget.modelDesigner!.batu15!} ';
    qtyBatu15.text = '${widget.modelDesigner!.qtyBatu15!} ';
    batu16 = '${widget.modelDesigner!.batu16!} ';
    qtyBatu16.text = '${widget.modelDesigner!.qtyBatu16!} ';
    batu17 = '${widget.modelDesigner!.batu17!} ';
    qtyBatu17.text = '${widget.modelDesigner!.qtyBatu17!} ';
    batu18 = '${widget.modelDesigner!.batu18!} ';
    qtyBatu18.text = '${widget.modelDesigner!.qtyBatu18!} ';
    batu19 = '${widget.modelDesigner!.batu19!} ';
    qtyBatu19.text = '${widget.modelDesigner!.qtyBatu19!} ';
    batu20 = '${widget.modelDesigner!.batu20!} ';
    qtyBatu20.text = '${widget.modelDesigner!.qtyBatu20!} ';
    batu21 = '${widget.modelDesigner!.batu21!} ';
    qtyBatu21.text = '${widget.modelDesigner!.qtyBatu21!} ';
    batu22 = '${widget.modelDesigner!.batu22!} ';
    qtyBatu22.text = '${widget.modelDesigner!.qtyBatu22!} ';
    batu23 = '${widget.modelDesigner!.batu23!} ';
    qtyBatu23.text = '${widget.modelDesigner!.qtyBatu23!} ';
    batu24 = '${widget.modelDesigner!.batu24!} ';
    qtyBatu24.text = '${widget.modelDesigner!.qtyBatu24!} ';
    batu25 = '${widget.modelDesigner!.batu25!} ';
    qtyBatu25.text = '${widget.modelDesigner!.qtyBatu25!} ';
    batu26 = '${widget.modelDesigner!.batu26!} ';
    qtyBatu26.text = '${widget.modelDesigner!.qtyBatu26!} ';
    batu27 = '${widget.modelDesigner!.batu27!} ';
    qtyBatu27.text = '${widget.modelDesigner!.qtyBatu27!} ';
    batu28 = '${widget.modelDesigner!.batu28!} ';
    qtyBatu28.text = '${widget.modelDesigner!.qtyBatu28!} ';
    batu29 = '${widget.modelDesigner!.batu29!} ';
    qtyBatu29.text = '${widget.modelDesigner!.qtyBatu29!} ';
    batu30 = '${widget.modelDesigner!.batu30!} ';
    qtyBatu30.text = '${widget.modelDesigner!.qtyBatu30!} ';
    batu31 = '${widget.modelDesigner!.batu31!} ';
    qtyBatu31.text = '${widget.modelDesigner!.qtyBatu31!} ';
    batu32 = '${widget.modelDesigner!.batu32!} ';
    qtyBatu32.text = '${widget.modelDesigner!.qtyBatu32!} ';
    batu33 = '${widget.modelDesigner!.batu33!} ';
    qtyBatu33.text = '${widget.modelDesigner!.qtyBatu33!} ';
    batu34 = '${widget.modelDesigner!.batu34!} ';
    qtyBatu34.text = '${widget.modelDesigner!.qtyBatu34!} ';
    batu35 = '${widget.modelDesigner!.batu35!} ';
    qtyBatu35.text = '${widget.modelDesigner!.qtyBatu35!} ';
    imageUrl = '${widget.modelDesigner!.imageUrl!} ';
    keteranganStatusBatu.text =
        '${widget.modelDesigner!.keteranganStatusBatu!} ';
    pointModeller.text = widget.modelDesigner!.pointModeller!;

//get stok
    // getStokAllBatu(); //!belum dipakai
  }

  getStokAllBatu() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.getDataBatuByName}?size="$batu1"'),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          stokBatu1.text = data[0]['qty'].toString();
        });
      }
    } catch (e) {
      print(e);
    }
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

  // ignore: unused_element
  Future<void> _pickImage() async {
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
          ApiClient.uploadFile(_paths!.first.bytes!, _paths!.first.name);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              SizedBox(
                // decoration: BoxDecoration(
                //     border: Border.all(
                //         color: Colors.black, style: BorderStyle.solid)),
                width: 1100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _bagianKiri(),
                    _bagianTengah(),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Center(
                    //     child: Text(
                    //   'Tekan CTRL + P untuk print',
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.bold),
                    // )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: SizedBox(
                          child: Row(
                            children: [
                              Lottie.asset("loadingJSON/backbutton.json",
                                  fit: BoxFit.cover),
                              Text(
                                'Kembali',
                                style: TextStyle(
                                    color: Colors.blue.shade200,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bagianKiri() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15),
      child: SizedBox(
          width: 600,
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              //baris 1
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //kode design mdbc
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: kodeDesignMdbc,
                        decoration: InputDecoration(
                          labelText: kodeDesignMdbc.text.isEmpty
                              ? ""
                              : "Kode Design MDBC",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //nama deisner
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: namaDesigner,
                        decoration: InputDecoration(
                          labelText:
                              namaDesigner.text.isEmpty ? "" : "Nama Designer",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //nama modeller
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: namaModeller,
                        decoration: InputDecoration(
                          labelText:
                              namaModeller.text.isEmpty ? "" : "Nama Modeller",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //! baris 2
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //kode marketing
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: kodeMarketing,
                        decoration: InputDecoration(
                          labelText: kodeMarketing.text.isEmpty
                              ? ""
                              : "Kode Marketing",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //siklus
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: siklus,
                        decoration: InputDecoration(
                          labelText: siklus.text.isEmpty ? "" : "Siklus",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //kode design
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: kodeDesign,
                        decoration: InputDecoration(
                          labelText:
                              kodeDesign.text.isEmpty ? "" : "Kode Design",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //! baris 3
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //kode produksi
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: kodeProduksi,
                        decoration: InputDecoration(
                          labelText:
                              kodeProduksi.text.isEmpty ? "" : "Kode Produksi",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //keterangan status batu
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: keteranganStatusBatu,
                        decoration: InputDecoration(
                          labelText: keteranganStatusBatu.text.isEmpty
                              ? "  "
                              : "Status Batu",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //Tema
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: tema,
                        decoration: InputDecoration(
                          labelText: tema.text.isEmpty ? "" : "Tema",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //gambar
              imageUrl != null
                  ? Row(
                      children: [
                        Container(
                          width: 400,
                          height: 288,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            ApiConstants.baseUrlImage + imageUrl!,
                            fit: BoxFit.scaleDown,
                            // scale: 2,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          width: 490,
                          height: 200,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
              //! baris 4
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Rantai
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 260,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: rantai,
                        decoration: InputDecoration(
                          labelText: rantai.text.isEmpty ? "" : "Rantai",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //qty
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: qtyRantai,
                        decoration: InputDecoration(
                          labelText: qtyRantai.text.isEmpty ? "" : "Qty",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //stok
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: stokRantai,
                        decoration: InputDecoration(
                          labelText: stokRantai.text.isEmpty ? "" : "Stok",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //jenis barang
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: jenisBarang,
                        decoration: InputDecoration(
                          labelText:
                              jenisBarang.text.isEmpty ? "" : "Jenis Barang",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //! baris 5
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //lain2
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 260,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: lain2,
                        decoration: InputDecoration(
                          labelText: lain2.text.isEmpty ? "" : "Lain - Lain",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //qty
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: qtyLain2,
                        decoration: InputDecoration(
                          labelText: qtyLain2.text.isEmpty ? "" : "Qty",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //stok
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: stokLain2,
                        decoration: InputDecoration(
                          labelText: stokLain2.text.isEmpty ? "" : "Stok",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //kategori barang
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: kategoriBarang,
                        decoration: InputDecoration(
                          labelText: kategoriBarang.text.isEmpty
                              ? ""
                              : "Kategori Barang",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //! baris 6
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //earnut
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 260,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: earnut,
                        decoration: InputDecoration(
                          labelText: earnut.text.isEmpty ? "" : "Earnut",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //qty
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: qtyEarnut,
                        decoration: InputDecoration(
                          labelText: qtyEarnut.text.isEmpty ? "" : "Qty",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //stok
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: stokEarnut,
                        decoration: InputDecoration(
                          labelText: stokEarnut.text.isEmpty ? "" : "Stok",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //Brand
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: brand,
                        decoration: InputDecoration(
                          labelText: brand.text.isEmpty ? "" : "Brand",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //! baris 7
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //panjang rantai
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 260,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: panjangRantai,
                        decoration: InputDecoration(
                          labelText: panjangRantai.text.isEmpty
                              ? ""
                              : "Panjang Rantai",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                    ),

                    //
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                    ),

                    //photo shoot
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: photoShoot,
                        decoration: InputDecoration(
                          labelText:
                              photoShoot.text.isEmpty ? "" : "Photo Shoot",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //! baris 8
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //custom componen
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 260,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: customKomponen,
                        decoration: InputDecoration(
                          labelText: customKomponen.text.isEmpty
                              ? ""
                              : "Custom Componen",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //qty
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: qtyCustomKomponen,
                        decoration: InputDecoration(
                          labelText:
                              qtyCustomKomponen.text.isEmpty ? "" : "Qty",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //stok
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: stokCustomKomponen,
                        decoration: InputDecoration(
                          labelText:
                              stokCustomKomponen.text.isEmpty ? "" : "Stok",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //Color
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: color,
                        decoration: InputDecoration(
                          labelText: color.text.isEmpty ? "" : "Color",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //! baris 9
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Berat Emas
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 260,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: beratEmas,
                        decoration: InputDecoration(
                          labelText: beratEmas.text.isEmpty ? "" : "Berat Emas",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //estimasi harga
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 140,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: estimasiHarga,
                        decoration: InputDecoration(
                          labelText: estimasiHarga.text.isEmpty
                              ? ""
                              : "Estimasi Harga",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),

                    //ringSize
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.next,
                        controller: ringSize,
                        decoration: InputDecoration(
                          labelText: ringSize.text.isEmpty ? "" : "Ring Size",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }

  Widget _bagianTengah() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10),
      child: SizedBox(
        width: 445,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  //size batu1
                  int.parse(qtyBatu1.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu1,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 60,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu1.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //point modeller
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: pointModeller,
                      decoration: InputDecoration(
                        labelText: pointModeller.text.isEmpty ? "" : "Modeller",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu1

              Row(
                children: [
                  //size batu2
                  int.parse(qtyBatu2.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu2,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 60,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu2.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //Finishing point
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: finishingPoint,
                      decoration: InputDecoration(
                        labelText: "Finishing",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu2
              Row(
                children: [
                  //size batu3
                  int.parse(qtyBatu3.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu3,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 60,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu3.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //Polishing 1 point
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: polishing1Point,
                      decoration: InputDecoration(
                        labelText: "Polishing 1",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu3
              //size batu4
              Row(
                children: [
                  int.parse(qtyBatu4.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu4,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 60,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu4.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //Assembly 1 point
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: assembly1Point,
                      decoration: InputDecoration(
                        labelText: "Assembly 1",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu4
              Row(
                children: [
                  //size batu5
                  int.parse(qtyBatu5.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu5,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 60,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu5.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //Polishing 2 point
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: polishing2Point,
                      decoration: InputDecoration(
                        labelText: "Polishing 2",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu5
              Row(
                children: [
                  //size batu6
                  int.parse(qtyBatu6.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu6,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 60,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu6.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //Assembly 2 point
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: assembly2Point,
                      decoration: InputDecoration(
                        labelText: "Assembly 2",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu6
              Row(
                children: [
                  //size batu7
                  int.parse(qtyBatu7.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu7,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 60,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu7.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //Poles Bales point
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: polseBalesPoint,
                      decoration: InputDecoration(
                        labelText: "Poles Bales",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu7
              //size batu8
              Row(
                children: [
                  int.parse(qtyBatu8.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu8,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 140,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu8.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //in modeller
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: inModeller,
                      decoration: InputDecoration(
                        labelText: "In Modeller",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              // end row batu8
              Row(
                children: [
                  //size batu9
                  int.parse(qtyBatu9.text) <= 0
                      ? const SizedBox(
                          width: 260,
                          height: 30,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 200,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: batu9,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 5),
                              width: 140,
                              height: 30,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: qtyBatu9.text,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //out modeller
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 30,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: outModeller,
                      decoration: InputDecoration(
                        labelText: "Out Modeller",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu10,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu10.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu11,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu11.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu12,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu12.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu13,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu13.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu14,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu14.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu15,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu15.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu16,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu16.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu17,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu17.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu18,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu18.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu19,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu19.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu20,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu20.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu21,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu21.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu22,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu22.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu23,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu23.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu24,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu24.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu25,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu25.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu26,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu26.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu27,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu27.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu28,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu28.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu29,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu29.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu30,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu30.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu31,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu31.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu32,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu32.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu33,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu33.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu34,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu34.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: batu35,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15, bottom: 5),
                          width: 140,
                          height: 30,
                          child: TextFormField(
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: qtyBatu35.text,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
              // end row batu35
            ],
          ),
        ),
      ),
    );
  }
}
