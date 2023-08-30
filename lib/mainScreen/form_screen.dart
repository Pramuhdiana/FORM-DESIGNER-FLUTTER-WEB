// ignore_for_file: sized_box_for_whitespace, avoid_print, depend_on_referenced_packages
import 'dart:developer';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_designer/mainScreen/side_screen_design.dart';
import 'package:form_designer/model/batu_model.dart';
import 'package:form_designer/model/earnut_model.dart';
import 'package:form_designer/model/jenis_barang_model.dart';
import 'package:form_designer/model/lain2_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
// import "package:async/async.dart";

import '../api/api_constant.dart';
import '../dev/network.dart';
import '../global/currency_format.dart';
import '../global/global.dart';
import '../model/rantai_model.dart';
import '../widgets/custom_loading.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // ignore: unused_field, prefer_final_fields
  List<PlatformFile>? _paths;
  List pemakaianBatu = [];
  List<XFile>? imagefiles;
  PlatformFile? _imageFile;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double doubleBeratEmasDariCustomer = 0;

  TextEditingController kodeDesignMdbc = TextEditingController();
  TextEditingController kodeMarketing = TextEditingController();
  TextEditingController siklus = TextEditingController();
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

  int? labour = 0;
  double doubleBeratEmas = 0;

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
  String? imageUrl = 'default.jpg';
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  int count = 0;
  @override
  void initState() {
    super.initState();
    namaDesigner.text = sharedPreferences!.getString('nama')!;
    // _getData();
  }

  //start image
  final ImagePicker imgpicker = ImagePicker();

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
    // try {
    //   // Pick an image file using file_picker package
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.image,
    //   );

    //   // If user cancels the picker, do nothing
    //   if (result == null) return;
    //   // Uint8List uploadfile = result.files.single.bytes!;
    //   // String filename = (result.files.single.name);

    //   PlatformFile file = result.files.first;

    //   // If user picks an image, update the state with the new image file
    //   setState(() {
    //     // upload(File(uploadfile.toString()));
    //     // imageUrl = file.name;
    //   });
    // } catch (e) {
    //   // If there is an error, show a snackbar with the error message
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(e.toString()),
    //     ),
    //   );
    // }
  }

  Future _getData() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getNilaiData));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
          emas = data[0]['emas'];
          upEmas = data[0]['upEmas'];
          upBatu = data[0]['upBatu'];
          upLabour = data[0]['upLabour'];
          upFinal = data[0]['upFinal'];
          kurs = data[0]['kurs'];
          others1 = data[0]['others1'];
          others2 = data[0]['kurs'];
          others3 = data[0]['others3'];
        });
      }
    } catch (e) {
      print(e);
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
      var totalLabour = ((labour! + others1) * upLabour);
      double total;
      total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;

      var output =
          total.round().toString()[total.round().toString().length - 1];

      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others1');
          total = (total + (5 - int.parse(output)));
          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others1');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others1');

          estimasiHarga.text = total.toString();
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

      var totalLabour = ((labour! + others2) * upLabour);
      double total;
      total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;

      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others2');
          total = (total + (5 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others2');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others2');

          estimasiHarga.text = total.toString();
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
          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others3');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others3');

          estimasiHarga.text = total.toString();
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
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
              upFinal) /
          kurs;
      total = ((total * 1.2) * 1.33);
      var output =
          total.round().toString()[total.round().toString().length - 1];

      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others1');
          total = (total + (5 - int.parse(output)));
          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others1');
          total = (total + (10 - int.parse(output)));
          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others1');

          estimasiHarga.text = total.toString();
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
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
              upFinal) /
          kurs;
      total = ((total * 1.2) * 1.33);
      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others2');
          total = (total + (5 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others2');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others2');

          estimasiHarga.text = total.toString();
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
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
              upFinal) /
          kurs;
      total = ((total * 1.2) * 1.33);
      var output =
          total.round().toString()[total.round().toString().length - 1];
      if (int.parse(output) >= 1 && int.parse(output) <= 4) {
        setState(() {
          print('others3');
          total = (total + (5 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others3');
          total = (total + (10 - int.parse(output)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others3');

          estimasiHarga.text = total.toString();
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
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
              upFinal) /
          kurs;
      total = (((total.round() * kurs) * 1.2) * 1.65);
      var output =
          total.round().toString()[total.round().toString().length - 5];
      var result = total.round().toString().lastChars(5); // 'World'
      print(result);
      if (int.parse(output) >= 0 && int.parse(output) <= 4) {
        setState(() {
          print('others1');
          total = (total + (50000 - int.parse(result)));
          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others1');
          total = (total + (100000 - int.parse(result)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others1');

          estimasiHarga.text = total.toString();
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
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
              upFinal) /
          kurs;
      total = (((total.round() * kurs) * 1.2) * 1.65);
      var output =
          total.round().toString()[total.round().toString().length - 5];
      var result = total.round().toString().lastChars(5); // 'World'
      print(result);
      if (int.parse(output) >= 0 && int.parse(output) <= 4) {
        setState(() {
          print('others2');
          total = (total + (50000 - int.parse(result)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others2');
          total = (total + (100000 - int.parse(result)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others2');

          estimasiHarga.text = total.toString();
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
      total = (((totalDiamond * upDiamondMetier) + totalEmas + totalLabour) *
              upFinal) /
          kurs;
      total = (((total.round() * kurs) * 1.2) * 1.65);

      var output =
          total.round().toString()[total.round().toString().length - 5];
      var result = total.round().toString().lastChars(5); // 'World'
      print(result);
      if (int.parse(output) >= 0 && int.parse(output) <= 4) {
        setState(() {
          print('others3');
          total = (total + (50000 - int.parse(result)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else if (int.parse(output) >= 6 && int.parse(output) <= 9) {
        setState(() {
          print('others3');
          total = (total + (100000 - int.parse(result)));

          estimasiHarga.text = total.toString();
        });
        return total;
      } else {
        setState(() {
          print('others3');

          estimasiHarga.text = total.toString();
        });
        return total;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Form Designer",
          style: TextStyle(fontSize: 25, color: Colors.white),
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
                  // _bagianKanan(),
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
                // return;
              } else if (siklus.text.isEmpty) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                          title: Text(
                            'Siklus wajib diisi',
                          ),
                        ));
                btnController.error();
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  btnController.reset(); //reset
                });
              } else if (jenisBarang.text.isEmpty) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                          title: Text(
                            'jenis barang wajib diisi',
                          ),
                        ));
                btnController.error();
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  btnController.reset(); //reset
                });
              } else if (jenisBarang.text == "Necklace" &&
                  rantai.text.isEmpty) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                          title: Text(
                            'Rantai Wajib di isi',
                          ),
                        ));
                btnController.error();
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  btnController.reset(); //reset
                });
              } else if (jenisBarang.text == "Earings" && earnut.text.isEmpty) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                          title: Text(
                            'Earnut Wajib di isi',
                          ),
                        ));
                btnController.error();
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  btnController.reset(); //reset
                });
              } else {
                Future.delayed(const Duration(seconds: 2)).then((value) async {
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
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const AlertDialog(
                              title: Text(
                                'Design Tersimpan',
                              ),
                            ));
                  });
                  setState(() {
                    clearForm();
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const MainViewFormDesign()));
                });
              }
            },
            child: const Text(
              "Save Design",
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          )),
    );
  }

  Widget _bagianKiri() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.40,
        child: Form(
          key: formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //kode design mdbc
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextFormField(
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
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextFormField(
                    enabled: false,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.next,
                    controller: namaDesigner,
                    onChanged: (value) {},
                    decoration: InputDecoration(
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
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextFormField(
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
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
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
                    width: MediaQuery.of(context).size.width * 0.1,
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
                          print(siklus.text);
                        });
                      },
                      popupProps:
                          const PopupPropsMultiSelection.modalBottomSheet(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Siklus",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  //kode deisgn
                  SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
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
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
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
                  //tema
                  SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
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
              child:
                  //upload image
                  ElevatedButton(
                      onPressed: () {
                        // sendImage(ImageSource.gallery);
                        _pickImage();
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
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'Rantai',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        );
                      },
                      child: const Text('Gambar Design')),
            ),
            _imageFile != null
                ? Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 350,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.memory(
                      Uint8List.fromList(_imageFile!.bytes!),
                      fit: BoxFit.cover,
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
                          width: MediaQuery.of(context).size.width * 0.15,
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Rantai",
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 65,
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: TextFormField(
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
                          width: MediaQuery.of(context).size.width * 0.05,
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
                    width: MediaQuery.of(context).size.width * 0.1,
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
                          _getData();
                          jenisBarang.text = item!.nama;
                          labour = item.harga;
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Jenis Barang",
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
                          width: MediaQuery.of(context).size.width * 0.15,
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Lain Lain",
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 65,
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: TextFormField(
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
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: TextFormField(
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
                    height: 65,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: DropdownSearch<String>(
                      items: const ["CLASSIC", "FASHION"],
                      onChanged: (item) {
                        setState(() {
                          kategoriBarang.text = item!;
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Kategori Barang",
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
                          width: MediaQuery.of(context).size.width * 0.15,
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Earnut",
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 65,
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: TextFormField(
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
                          width: MediaQuery.of(context).size.width * 0.05,
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
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: DropdownSearch<String>(
                      items: const ["PARVA", "BELI BERLIAN", "METIER", "FINE"],
                      onChanged: (item) {
                        setState(() {
                          brand.text = item!;
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Brand",
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
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: panjangRantai,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
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
                    width: MediaQuery.of(context).size.width * 0.1,
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
                          width: MediaQuery.of(context).size.width * 0.15,
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
                          width: MediaQuery.of(context).size.width * 0.06,
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
                          width: MediaQuery.of(context).size.width * 0.05,
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
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: DropdownSearch<String>(
                      items: const ["WG", "RG", "MIX"],
                      onChanged: (item) {
                        setState(() {
                          color.text = item!;
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Color",
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
                    width: MediaQuery.of(context).size.width * 0.1,
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
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Berat Emas",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 65,
                    width: MediaQuery.of(context).size.width * 0.12,
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
                              ? '\$ ${CurrencyFormat.convertToDollar(totalPriceBeliBerlian, 0)}'
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
                    width: MediaQuery.of(context).size.width * 0.1,
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
        width: MediaQuery.of(context).size.width * 0.55,
        child: Row(
          children: [
            namaDesigner.text == ''
                ? const SizedBox()
                : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 0),
                          child: const Text(
                            'Ukuran / Size Batu',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 250,
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
                                      onChanged: (item) async {
                                        try {
                                          final response = await http.get(
                                            Uri.parse(
                                                '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                          );
                                          print(response.statusCode);
                                          if (response.statusCode == 200) {
                                            print(response.body);
                                            final data =
                                                jsonDecode(response.body);
                                            print(data);
                                            setState(() {
                                              hargaBatu1 = data[0]['unitCost'];
                                              idBatu1 = item.id;
                                              caratPcsBatu1 =
                                                  data[0]['caratPcs'];
                                              crtPcsBatu1.text = data[0]
                                                      ['caratPcs']
                                                  .toString();
                                              batu1 = item.keyWord.toString();
                                              stokBatu1.text =
                                                  item.qty.toString();
                                            });
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      dropdownDecoratorProps:
                                          const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          // label: Text(
                                          //   batu1!,
                                          //   style: const TextStyle(
                                          //       fontSize: 18,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //qty batu1
                                  Container(
                                    width: 80,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
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

                                  //crt/pcsbatu1
                                  Container(
                                    width: 120,
                                    height: 38,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: TextFormField(
                                      enabled:
                                          caratPcsBatu1 <= 0 ? true : false,
                                      textInputAction: TextInputAction.next,
                                      controller: crtPcsBatu1,
                                      onChanged: (value) {
                                        caratPcsBatu1 = double.parse(value);
                                      },
                                      decoration: InputDecoration(
                                        label: const Text(
                                          'Carat/Pcs',
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

                                  qtyBatu1.text.isEmpty
                                      ? const SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  qtyBatu1.text = '0';
                                                  stokBatu1.text = '';
                                                  batu1 = '';
                                                  hargaBatu1 = 0;
                                                  caratPcsBatu1 = 0;
                                                  crtPcsBatu1.text = '';
                                                });
                                              },
                                              icon: const Icon(Icons.cancel)),
                                        ),
                                ],
                              ),
                              // end row batu1

                              //batu2
                              qtyBatu1.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu2
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu2 =
                                                        data[0]['unitCost'];
                                                    idBatu2 = item.id;
                                                    caratPcsBatu2 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu2.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu2 =
                                                        item.keyWord.toString();
                                                    stokBatu2.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu2!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu2
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu2 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu2,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu2 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu2,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu2
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu2 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu2,
                                            onChanged: (value) {
                                              caratPcsBatu2 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu2.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu2.text = '0';
                                                        stokBatu2.text = '';
                                                        batu2 = '';
                                                        hargaBatu2 = 0;
                                                        caratPcsBatu2 = 0;
                                                        crtPcsBatu2.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu2

                              //batu3
                              qtyBatu2.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu3
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu3 =
                                                        data[0]['unitCost'];
                                                    idBatu3 = item.id;
                                                    caratPcsBatu3 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu3.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu3 =
                                                        item.keyWord.toString();
                                                    stokBatu3.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu3!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu3
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu3 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu3,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu3 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu3,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu3
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu3 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu3,
                                            onChanged: (value) {
                                              caratPcsBatu3 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu3.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu3.text = '0';
                                                        stokBatu3.text = '';
                                                        batu3 = '';
                                                        hargaBatu3 = 0;
                                                        caratPcsBatu3 = 0;
                                                        crtPcsBatu3.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu3

                              //batu4
                              qtyBatu3.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu4
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu4 =
                                                        data[0]['unitCost'];
                                                    idBatu4 = item.id;
                                                    caratPcsBatu4 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu4.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu4 =
                                                        item.keyWord.toString();
                                                    stokBatu4.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu4!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu4
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu4 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu4,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu4 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu4,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu4
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu4 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu4,
                                            onChanged: (value) {
                                              caratPcsBatu4 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu4.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu4.text = '0';
                                                        stokBatu4.text = '';
                                                        batu4 = '';
                                                        hargaBatu4 = 0;
                                                        caratPcsBatu4 = 0;
                                                        crtPcsBatu4.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu4

                              //batu5
                              qtyBatu4.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu5
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu5 =
                                                        data[0]['unitCost'];
                                                    idBatu5 = item.id;
                                                    caratPcsBatu5 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu5.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu5 =
                                                        item.keyWord.toString();
                                                    stokBatu5.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu5!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu5
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu5 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu5,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu5 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu5,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu5
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu5 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu5,
                                            onChanged: (value) {
                                              caratPcsBatu5 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu5.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu5.text = '0';
                                                        stokBatu5.text = '';
                                                        batu5 = '';
                                                        hargaBatu5 = 0;
                                                        caratPcsBatu5 = 0;
                                                        crtPcsBatu5.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu5

                              //batu6
                              qtyBatu5.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu6
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu6 =
                                                        data[0]['unitCost'];
                                                    idBatu6 = item.id;
                                                    caratPcsBatu6 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu6.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu6 =
                                                        item.keyWord.toString();
                                                    stokBatu6.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu6!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu6
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu6 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu6,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu6 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu6,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu6
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu6 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu6,
                                            onChanged: (value) {
                                              caratPcsBatu6 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu6.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu6.text = '0';
                                                        stokBatu6.text = '';
                                                        batu6 = '';
                                                        hargaBatu6 = 0;
                                                        caratPcsBatu6 = 0;
                                                        crtPcsBatu6.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu6

                              //batu7
                              qtyBatu6.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu7
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu7 =
                                                        data[0]['unitCost'];
                                                    idBatu7 = item.id;
                                                    caratPcsBatu7 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu7.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu7 =
                                                        item.keyWord.toString();
                                                    stokBatu7.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu7!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu7
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu7 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu7,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu7 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu7,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu7
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu7 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu7,
                                            onChanged: (value) {
                                              caratPcsBatu7 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu7.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu7.text = '0';
                                                        stokBatu7.text = '';
                                                        batu7 = '';
                                                        hargaBatu7 = 0;
                                                        caratPcsBatu7 = 0;
                                                        crtPcsBatu7.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu7

                              //batu8
                              qtyBatu7.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu8
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu8 =
                                                        data[0]['unitCost'];
                                                    idBatu8 = item.id;
                                                    caratPcsBatu8 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu8.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu8 =
                                                        item.keyWord.toString();
                                                    stokBatu8.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu8!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu8
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu8 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu8,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu8 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu8,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu8
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu8 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu8,
                                            onChanged: (value) {
                                              caratPcsBatu8 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu8.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu8.text = '0';
                                                        stokBatu8.text = '';
                                                        batu8 = '';
                                                        hargaBatu8 = 0;
                                                        caratPcsBatu8 = 0;
                                                        crtPcsBatu8.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu8

                              //batu9
                              qtyBatu8.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu9
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu9 =
                                                        data[0]['unitCost'];
                                                    idBatu9 = item.id;
                                                    caratPcsBatu9 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu9.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu9 =
                                                        item.keyWord.toString();
                                                    stokBatu9.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu9!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu9
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: batu9 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu9,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu9 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu9,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu9
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu9 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu9,
                                            onChanged: (value) {
                                              caratPcsBatu9 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu9.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu9.text = '0';
                                                        stokBatu9.text = '';
                                                        batu9 = '';
                                                        hargaBatu9 = 0;
                                                        caratPcsBatu9 = 0;
                                                        crtPcsBatu9.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu9

                              //batu10
                              qtyBatu9.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu10
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu10 =
                                                        data[0]['unitCost'];
                                                    idBatu10 = item.id;
                                                    caratPcsBatu10 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu10.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu10 =
                                                        item.keyWord.toString();
                                                    stokBatu10.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu10!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu10
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu10 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu10,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu10 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu10,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu10
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu10 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu10,
                                            onChanged: (value) {
                                              caratPcsBatu10 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu10.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu10.text = '0';
                                                        stokBatu10.text = '';
                                                        batu10 = '';
                                                        hargaBatu10 = 0;
                                                        caratPcsBatu10 = 0;
                                                        crtPcsBatu10.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu10

                              //batu11
                              qtyBatu10.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu11
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu11 =
                                                        data[0]['unitCost'];
                                                    idBatu11 = item.id;
                                                    caratPcsBatu11 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu11.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu11 =
                                                        item.keyWord.toString();
                                                    stokBatu11.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu11!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu11
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu11 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu11,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu11 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu11,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu11
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu11 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu11,
                                            onChanged: (value) {
                                              caratPcsBatu11 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu11.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu11.text = '0';
                                                        stokBatu11.text = '';
                                                        batu11 = '';
                                                        hargaBatu11 = 0;
                                                        caratPcsBatu11 = 0;
                                                        crtPcsBatu11.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu11

                              //batu12
                              qtyBatu11.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu12
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu12 =
                                                        data[0]['unitCost'];
                                                    idBatu12 = item.id;
                                                    caratPcsBatu12 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu12.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu12 =
                                                        item.keyWord.toString();
                                                    stokBatu12.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu12!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu12
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu12 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu12,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu12 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu12,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu12
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu12 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu12,
                                            onChanged: (value) {
                                              caratPcsBatu12 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu12.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu12.text = '0';
                                                        stokBatu12.text = '';
                                                        batu12 = '';
                                                        hargaBatu12 = 0;
                                                        caratPcsBatu12 = 0;
                                                        crtPcsBatu12.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu12

                              //batu13
                              qtyBatu12.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu13
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu13 =
                                                        data[0]['unitCost'];
                                                    idBatu13 = item.id;
                                                    caratPcsBatu13 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu13.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu13 =
                                                        item.keyWord.toString();
                                                    stokBatu13.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu13!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu13
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu13 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu13,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu13 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu13,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu13
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu13 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu13,
                                            onChanged: (value) {
                                              caratPcsBatu13 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu13.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu13.text = '0';
                                                        stokBatu13.text = '';
                                                        batu13 = '';
                                                        hargaBatu13 = 0;
                                                        caratPcsBatu13 = 0;
                                                        crtPcsBatu13.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu13

                              //batu14
                              qtyBatu13.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu14
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu14 =
                                                        data[0]['unitCost'];
                                                    idBatu14 = item.id;
                                                    caratPcsBatu14 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu14.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu14 =
                                                        item.keyWord.toString();
                                                    stokBatu14.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu14!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu14
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu14 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu14,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu14 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu14,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu14
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu14 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu14,
                                            onChanged: (value) {
                                              caratPcsBatu14 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu14.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu14.text = '0';
                                                        stokBatu14.text = '';
                                                        batu14 = '';
                                                        hargaBatu14 = 0;
                                                        caratPcsBatu14 = 0;
                                                        crtPcsBatu14.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu14

                              //batu15
                              qtyBatu14.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu15
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu15 =
                                                        data[0]['unitCost'];
                                                    idBatu15 = item.id;
                                                    caratPcsBatu15 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu15.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu15 =
                                                        item.keyWord.toString();
                                                    stokBatu15.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu15!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu15
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu15 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu15,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu15 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu15,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu15
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu15 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu15,
                                            onChanged: (value) {
                                              caratPcsBatu15 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu15.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu15.text = '0';
                                                        stokBatu15.text = '';
                                                        batu15 = '';
                                                        hargaBatu15 = 0;
                                                        caratPcsBatu15 = 0;
                                                        crtPcsBatu15.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu15

                              //batu16
                              qtyBatu15.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu16
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu16 =
                                                        data[0]['unitCost'];
                                                    idBatu16 = item.id;
                                                    caratPcsBatu16 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu16.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu16 =
                                                        item.keyWord.toString();
                                                    stokBatu16.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu16!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu16
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu16 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu16,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu16 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu16,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu16
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu16 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu16,
                                            onChanged: (value) {
                                              caratPcsBatu16 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu16.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu16.text = '0';
                                                        stokBatu16.text = '';
                                                        batu16 = '';
                                                        hargaBatu16 = 0;
                                                        caratPcsBatu16 = 0;
                                                        crtPcsBatu16.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu16

                              //batu17
                              qtyBatu16.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu17
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu17 =
                                                        data[0]['unitCost'];
                                                    idBatu17 = item.id;
                                                    caratPcsBatu17 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu17.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu17 =
                                                        item.keyWord.toString();
                                                    stokBatu17.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu17!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu17
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu17 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu17,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu17 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu17,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu17
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu17 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu17,
                                            onChanged: (value) {
                                              caratPcsBatu17 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu17.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu17.text = '0';
                                                        stokBatu17.text = '';
                                                        batu17 = '';
                                                        hargaBatu17 = 0;
                                                        caratPcsBatu17 = 0;
                                                        crtPcsBatu17.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu17

                              //batu18
                              qtyBatu17.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu18
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu18 =
                                                        data[0]['unitCost'];
                                                    idBatu18 = item.id;
                                                    caratPcsBatu18 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu18.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu18 =
                                                        item.keyWord.toString();
                                                    stokBatu18.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu18!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu18
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu18 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu18,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu18 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu18,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu18
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu18 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu18,
                                            onChanged: (value) {
                                              caratPcsBatu18 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu18.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu18.text = '0';
                                                        stokBatu18.text = '';
                                                        batu18 = '';
                                                        hargaBatu18 = 0;
                                                        caratPcsBatu18 = 0;
                                                        crtPcsBatu18.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu18

                              //batu19
                              qtyBatu18.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu19
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu19 =
                                                        data[0]['unitCost'];
                                                    idBatu19 = item.id;
                                                    caratPcsBatu19 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu19.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu19 =
                                                        item.keyWord.toString();
                                                    stokBatu19.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu19!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu19
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu19 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu19,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu19 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu19,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu19
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu19 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu19,
                                            onChanged: (value) {
                                              caratPcsBatu19 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu19.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu19.text = '0';
                                                        stokBatu19.text = '';
                                                        batu19 = '';
                                                        hargaBatu19 = 0;
                                                        caratPcsBatu19 = 0;
                                                        crtPcsBatu19.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu19

                              //batu20
                              qtyBatu19.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu20
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu20 =
                                                        data[0]['unitCost'];
                                                    idBatu20 = item.id;
                                                    caratPcsBatu20 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu20.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu20 =
                                                        item.keyWord.toString();
                                                    stokBatu20.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu20!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu20
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu20 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu20,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu20 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu20,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu20
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu20 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu20,
                                            onChanged: (value) {
                                              caratPcsBatu20 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu20.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu20.text = '0';
                                                        stokBatu20.text = '';
                                                        batu20 = '';
                                                        hargaBatu20 = 0;
                                                        caratPcsBatu20 = 0;
                                                        crtPcsBatu20.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu20

                              //batu21
                              qtyBatu20.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu21
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu21 =
                                                        data[0]['unitCost'];
                                                    idBatu21 = item.id;
                                                    caratPcsBatu21 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu21.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu21 =
                                                        item.keyWord.toString();
                                                    stokBatu21.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu21!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu21
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu21 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu21,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu21 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu21,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu21
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu21 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu21,
                                            onChanged: (value) {
                                              caratPcsBatu21 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu21.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu21.text = '0';
                                                        stokBatu21.text = '';
                                                        batu21 = '';
                                                        hargaBatu21 = 0;
                                                        caratPcsBatu21 = 0;
                                                        crtPcsBatu21.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu21

                              //batu22
                              qtyBatu21.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu22
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu22 =
                                                        data[0]['unitCost'];
                                                    idBatu22 = item.id;
                                                    caratPcsBatu22 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu22.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu22 =
                                                        item.keyWord.toString();
                                                    stokBatu22.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu22!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu22
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu22 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu22,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu22 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu22,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu22
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu22 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu22,
                                            onChanged: (value) {
                                              caratPcsBatu22 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu22.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu22.text = '0';
                                                        stokBatu22.text = '';
                                                        batu22 = '';
                                                        hargaBatu22 = 0;
                                                        caratPcsBatu22 = 0;
                                                        crtPcsBatu22.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu22

                              //batu23
                              qtyBatu22.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu23
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu23 =
                                                        data[0]['unitCost'];
                                                    idBatu23 = item.id;
                                                    caratPcsBatu23 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu23.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu23 =
                                                        item.keyWord.toString();
                                                    stokBatu23.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu23!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu23
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu23 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu23,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu23 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu23,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu23
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu23 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu23,
                                            onChanged: (value) {
                                              caratPcsBatu23 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu23.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu23.text = '0';
                                                        stokBatu23.text = '';
                                                        batu23 = '';
                                                        hargaBatu23 = 0;
                                                        caratPcsBatu23 = 0;
                                                        crtPcsBatu23.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu23

                              //batu24
                              qtyBatu23.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu24
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu24 =
                                                        data[0]['unitCost'];
                                                    idBatu24 = item.id;
                                                    caratPcsBatu24 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu24.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu24 =
                                                        item.keyWord.toString();
                                                    stokBatu24.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu24!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu24
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu24 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu24,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu24 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu24,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu24
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu24 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu24,
                                            onChanged: (value) {
                                              caratPcsBatu24 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu24.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu24.text = '0';
                                                        stokBatu24.text = '';
                                                        batu24 = '';
                                                        hargaBatu24 = 0;
                                                        caratPcsBatu24 = 0;
                                                        crtPcsBatu24.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu24

                              //batu25
                              qtyBatu24.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu25
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu25 =
                                                        data[0]['unitCost'];
                                                    idBatu25 = item.id;
                                                    caratPcsBatu25 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu25.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu25 =
                                                        item.keyWord.toString();
                                                    stokBatu25.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu25!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu25
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu25 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu25,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu25 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu25,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu25
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu25 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu25,
                                            onChanged: (value) {
                                              caratPcsBatu25 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu25.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu25.text = '0';
                                                        stokBatu25.text = '';
                                                        batu25 = '';
                                                        hargaBatu25 = 0;
                                                        caratPcsBatu25 = 0;
                                                        crtPcsBatu25.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu25

                              //batu26
                              qtyBatu25.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu26
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu26 =
                                                        data[0]['unitCost'];
                                                    idBatu26 = item.id;
                                                    caratPcsBatu26 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu26.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu26 =
                                                        item.keyWord.toString();
                                                    stokBatu26.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu26!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu26
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu26 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu26,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu26 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu26,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu26
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu26 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu26,
                                            onChanged: (value) {
                                              caratPcsBatu26 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu26.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu26.text = '0';
                                                        stokBatu26.text = '';
                                                        batu26 = '';
                                                        hargaBatu26 = 0;
                                                        caratPcsBatu26 = 0;
                                                        crtPcsBatu26.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu26

                              //batu27
                              qtyBatu26.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu27
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu27 =
                                                        data[0]['unitCost'];
                                                    idBatu27 = item.id;
                                                    caratPcsBatu27 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu27.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu27 =
                                                        item.keyWord.toString();
                                                    stokBatu27.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu27!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu27
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu27 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu27,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu27 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu27,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu27
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu27 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu27,
                                            onChanged: (value) {
                                              caratPcsBatu27 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu27.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu27.text = '0';
                                                        stokBatu27.text = '';
                                                        batu27 = '';
                                                        hargaBatu27 = 0;
                                                        caratPcsBatu27 = 0;
                                                        crtPcsBatu27.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu27

                              //batu28
                              qtyBatu27.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu28
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu28 =
                                                        data[0]['unitCost'];
                                                    idBatu28 = item.id;
                                                    caratPcsBatu28 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu28.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu28 =
                                                        item.keyWord.toString();
                                                    stokBatu28.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu28!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu28
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu28 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu28,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu28 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu28,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu28
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu28 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu28,
                                            onChanged: (value) {
                                              caratPcsBatu28 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu28.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu28.text = '0';
                                                        stokBatu28.text = '';
                                                        batu28 = '';
                                                        hargaBatu28 = 0;
                                                        caratPcsBatu28 = 0;
                                                        crtPcsBatu28.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu28

                              //batu29
                              qtyBatu28.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu29
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu29 =
                                                        data[0]['unitCost'];
                                                    idBatu29 = item.id;
                                                    caratPcsBatu29 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu29.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu29 =
                                                        item.keyWord.toString();
                                                    stokBatu29.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu29!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu29
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu29 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu29,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu29 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu29,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu29
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu29 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu29,
                                            onChanged: (value) {
                                              caratPcsBatu29 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu29.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu29.text = '0';
                                                        stokBatu29.text = '';
                                                        batu29 = '';
                                                        hargaBatu29 = 0;
                                                        caratPcsBatu29 = 0;
                                                        crtPcsBatu19.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu29

                              //batu30
                              qtyBatu29.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu30
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu30 =
                                                        data[0]['unitCost'];
                                                    idBatu30 = item.id;
                                                    caratPcsBatu30 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu30.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu30 =
                                                        item.keyWord.toString();
                                                    stokBatu30.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu30!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu30
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu30 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu30,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu30 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu30,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu30
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu30 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu30,
                                            onChanged: (value) {
                                              caratPcsBatu30 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu30.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu30.text = '0';
                                                        stokBatu30.text = '';
                                                        batu30 = '';
                                                        hargaBatu30 = 0;
                                                        caratPcsBatu30 = 0;
                                                        crtPcsBatu30.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu30

                              //batu31
                              qtyBatu30.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu31
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu31 =
                                                        data[0]['unitCost'];
                                                    idBatu31 = item.id;
                                                    caratPcsBatu31 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu31.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu31 =
                                                        item.keyWord.toString();
                                                    stokBatu31.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu31!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu31
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu31 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu31,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu31 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu31,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu31
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu31 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu31,
                                            onChanged: (value) {
                                              caratPcsBatu31 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu31.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu31.text = '0';
                                                        stokBatu31.text = '';
                                                        batu31 = '';
                                                        hargaBatu31 = 0;
                                                        caratPcsBatu31 = 0;
                                                        crtPcsBatu31.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu31

                              //batu32
                              qtyBatu31.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu32
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu32 =
                                                        data[0]['unitCost'];
                                                    idBatu32 = item.id;
                                                    caratPcsBatu32 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu32.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu32 =
                                                        item.keyWord.toString();
                                                    stokBatu32.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu32!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu32
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu32 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu32,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu32 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu32,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu32
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu32 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu32,
                                            onChanged: (value) {
                                              caratPcsBatu32 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu32.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu32.text = '0';
                                                        stokBatu32.text = '';
                                                        batu32 = '';
                                                        hargaBatu32 = 0;
                                                        caratPcsBatu32 = 0;
                                                        crtPcsBatu32.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu32

                              //batu33
                              qtyBatu32.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu33
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu33 =
                                                        data[0]['unitCost'];
                                                    idBatu33 = item.id;
                                                    caratPcsBatu33 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu33.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu33 =
                                                        item.keyWord.toString();
                                                    stokBatu33.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu33!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu33
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu33 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu33,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu33 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu33,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu33
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu33 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu33,
                                            onChanged: (value) {
                                              caratPcsBatu33 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu33.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu33.text = '0';
                                                        stokBatu33.text = '';
                                                        batu33 = '';
                                                        hargaBatu33 = 0;
                                                        caratPcsBatu33 = 0;
                                                        crtPcsBatu33.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu33

                              //batu34
                              qtyBatu33.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu34
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu34 =
                                                        data[0]['unitCost'];
                                                    idBatu34 = item.id;
                                                    caratPcsBatu34 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu34.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu34 =
                                                        item.keyWord.toString();
                                                    stokBatu34.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu34!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu34
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu34 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu34,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu34 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu34,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu34
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu34 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu34,
                                            onChanged: (value) {
                                              caratPcsBatu34 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu34.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu34.text = '0';
                                                        stokBatu34.text = '';
                                                        batu34 = '';
                                                        hargaBatu34 = 0;
                                                        caratPcsBatu34 = 0;
                                                        crtPcsBatu34.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu34

                              //batu35
                              qtyBatu34.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu35
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 38,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: DropdownSearch<BatuModel>(
                                            asyncItems: (String? filter) =>
                                                getData(filter),
                                            popupProps:
                                                const PopupPropsMultiSelection
                                                    .modalBottomSheet(
                                              showSelectedItems: true,
                                              itemBuilder: _listBatu,
                                              showSearchBox: true,
                                            ),
                                            compareFn: (item, sItem) =>
                                                item.id == sItem.id,
                                            onChanged: (item) async {
                                              try {
                                                final response = await http.get(
                                                  Uri.parse(
                                                      '${ApiConstants.baseUrl}${ApiConstants.getDataBatuMdbc}?idStone=${item!.idStone}'),
                                                );
                                                print(response.statusCode);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(response.body);
                                                  final data =
                                                      jsonDecode(response.body);
                                                  print(data);
                                                  setState(() {
                                                    hargaBatu35 =
                                                        data[0]['unitCost'];
                                                    idBatu35 = item.id;
                                                    caratPcsBatu35 =
                                                        data[0]['caratPcs'];
                                                    crtPcsBatu35.text = data[0]
                                                            ['caratPcs']
                                                        .toString();
                                                    batu35 =
                                                        item.keyWord.toString();
                                                    stokBatu35.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                // label: Text(
                                                //   batu35!,
                                                //   style: const TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.bold),
                                                // ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu35
                                        Container(
                                          width: 80,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled:
                                                batu35 == '' ? false : true,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu35,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu35 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu35,
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Stok',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //crt/pcsbatu35
                                        Container(
                                          width: 120,
                                          height: 38,
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 15),
                                          child: TextFormField(
                                            enabled: caratPcsBatu35 <= 0
                                                ? true
                                                : false,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: crtPcsBatu35,
                                            onChanged: (value) {
                                              caratPcsBatu35 =
                                                  double.parse(value);
                                            },
                                            decoration: InputDecoration(
                                              label: const Text(
                                                'Carat/Pcs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        qtyBatu35.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu35.text = '0';
                                                        stokBatu35.text = '';
                                                        batu35 = '';
                                                        hargaBatu35 = 0;
                                                        caratPcsBatu35 = 0;
                                                        crtPcsBatu35.text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
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

  // ignore: unused_element
  Widget _bagianKanan() {
    return Container(
        padding: const EdgeInsets.only(left: 5, top: 20),
        width: MediaQuery.of(context).size.width * 0.35,
        child: Row(children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 0),
                  child: const Text(
                    'Lot',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: const Text(
                    'Ukuran Fancy',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: const Text(
                    'Size',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ])
        ]));
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
      'imageUrl': imageUrl,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postFormDesigner),
        body: body);
    print(response.statusCode);
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
