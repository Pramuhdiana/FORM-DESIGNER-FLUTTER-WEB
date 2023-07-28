// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/model/batu_model.dart';
import 'package:form_designer/model/earnut_model.dart';
import 'package:form_designer/model/jenis_barang_model.dart';
import 'package:form_designer/model/lain2_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
// import "package:async/async.dart";

// import 'package:path/path.dart';

import '../api/api_constant.dart';
import '../global/currency_format.dart';
import '../model/rantai_model.dart';
import '../widgets/custom_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field, prefer_final_fields
  List _get = [];
  List<XFile>? imagefiles;
  PlatformFile? _imageFile;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController kodeDesignMdbc = TextEditingController();
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
  @override
  void initState() {
    super.initState();
    // _getData();
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

//   Future addProduct(File imageFile) async {
// // ignore: deprecated_member_use

//     // var stream =
//     //     new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//     var length = await imageFile.length();
// var uri = Uri.parse("http://10.0.2.2/foodsystem/uploadg.php");

// var request = new http.MultipartRequest("POST", uri);

// var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));

// request.files.add(multipartFile);

//     var respond = await request.send();
//     if (respond.statusCode == 200) {
//       print("Image Uploaded");
//     } else {
//       print("Upload Failed");
//     }
//   }

  Future<void> _pickImage() async {
    try {
      // Pick an image file using file_picker package
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // If user cancels the picker, do nothing
      if (result == null) return;
      PlatformFile file = result.files.first;

      // If user picks an image, update the state with the new image file
      setState(() {
        _imageFile = result.files.first;
        imageUrl = file.name;
      });
    } catch (e) {
      // If there is an error, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future _getData() async {
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
          others2 = data[0]['kurs'];
          others3 = data[0]['others3'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String get totalPrice {
    // var dpin = int.parse(dp);
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

    var totalQtyCrt =
        (((caratPcsBatu1 * qtyIntBatu1!) + (caratPcsBatu2 * qtyIntBatu2!)) / 5);
    var totalEmas = (((doubleBeratEmas + totalQtyCrt) * emas) * upEmas);

    var totalLabour = ((labour! + others3) * upLabour);
    var total = ((totalDiamond + totalEmas + totalLabour) * upFinal) / kurs;

    if (total.toString() == 'NaN') {
      return '\$ ${CurrencyFormat.convertToDollar(0, 0)}';
    } else {
      setState(() {
        estimasiHarga.text = total.toString();
      });
      // setState()({
      // });
      return '\$ ${CurrencyFormat.convertToDollar(total, 0)}';
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
          // title: const FakeSearch(),
          automaticallyImplyLeading: false,
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
                return;
              }
              Future.delayed(const Duration(seconds: 2)).then((value) async {
                btnController.success();
                postAPI();
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  btnController.reset(); //reset
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => const AlertDialog(
                            title: Text(
                              'Design Tersimpan',
                            ),
                            // content: const Text(
                            //   'Buat baru design',
                            // ),
                            // actions: <Widget>[
                            //   TextButton(
                            //     onPressed: () => Navigator.pop(
                            //       context,
                            //       'Cancel',
                            //     ),
                            //     child: const Text('Cancel'),
                            //   ),
                            //   TextButton(
                            //     onPressed: () {
                            //       setState(() {});
                            //       Navigator.pop(
                            //         context,
                            //         'OK',
                            //       );
                            //     },
                            //     child: const Text(
                            //       'OK',
                            //     ),
                            //   ),
                            // ],
                          ));
                });
                setState(() {
                  clearForm();
                });
              });
            },
            child: const Text(
              "Save Design",
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          ),
        ));
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
                      // hintText: "example: Cahaya Sanivokasi",
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
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.next,
                    controller: namaDesigner,
                    onChanged: (value) {
                      setState(() {
                        _getData();
                      });
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
              child: ElevatedButton(
                  onPressed: () {
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
                                stokRantai.text = item!.qty!.toString();
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
                          labour = item!.harga;
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
                                stokLain2.text = item!.qty!.toString();
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
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: kategoriBarang,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Kategori Barang",
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
                                stokEarnut.text = item!.qty!.toString();
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
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: brand,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Brand",
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
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: color,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Color",
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
                          // ignore: unnecessary_string_interpolations
                          "$totalPrice",
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
                                    width: 165,
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
                                          if (response.statusCode == 200) {
                                            final data =
                                                jsonDecode(response.body);
                                            setState(() {
                                              hargaBatu1 = data[0]['unitCost'];
                                              caratPcsBatu1 =
                                                  data[0]['caratPcs'];
                                              batu1 = item.size;
                                              stokBatu1.text =
                                                  item.qty.toString();
                                            });
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          label: Text(
                                            batu1!,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                        // hintText: "example: Cahaya Sanivokasi",
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
                                        // hintText: "example: Cahaya Sanivokasi",
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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu2 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu2 =
                                                        data[0]['caratPcs'];
                                                    batu2 = item.size;
                                                    stokBatu2.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu2!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu3 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu3 =
                                                        data[0]['caratPcs'];
                                                    batu3 = item.size;
                                                    stokBatu3.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu3!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu4 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu4 =
                                                        data[0]['caratPcs'];
                                                    batu4 = item.size;
                                                    stokBatu4.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu4!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu5 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu5 =
                                                        data[0]['caratPcs'];
                                                    batu5 = item.size;
                                                    stokBatu5.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu5!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu6 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu6 =
                                                        data[0]['caratPcs'];
                                                    batu6 = item.size;
                                                    stokBatu6.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu6!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                  //size batu1
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu1 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu1 =
                                                        data[0]['caratPcs'];
                                                    batu1 = item.size;
                                                    stokBatu1.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu1!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qtyBatu1,
                                            onChanged: (value) {
                                              setState(() {
                                                qtyIntBatu1 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: stokBatu1,
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                        qtyBatu1.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu1.text = '0';
                                                        stokBatu1.text = '';
                                                        batu1 = '';
                                                        hargaBatu1 = 0;
                                                        caratPcsBatu1 = 0;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel)),
                                              ),
                                      ],
                                    ),
                              // end row batu1

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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu8 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu8 =
                                                        data[0]['caratPcs'];
                                                    batu8 = item.size;
                                                    stokBatu8.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu8!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 2
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
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                        qtyBatu8.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu8.text = '';
                                                        stokBatu8.text = '';
                                                        batu8 = '';
                                                        hargaBatu8 = 0;
                                                        caratPcsBatu8 = 0;
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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu9 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu9 =
                                                        data[0]['caratPcs'];
                                                    batu9 = item.size;
                                                    stokBatu9.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu9!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 2
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
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                        qtyBatu9.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu9.text = '';
                                                        stokBatu9.text = '';
                                                        batu9 = '';
                                                        hargaBatu9 = 0;
                                                        caratPcsBatu9 = 0;
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
                                          width: 165,
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
                                                if (response.statusCode ==
                                                    200) {
                                                  final data =
                                                      jsonDecode(response.body);
                                                  setState(() {
                                                    hargaBatu10 =
                                                        data[0]['unitCost'];
                                                    caratPcsBatu10 =
                                                        data[0]['caratPcs'];
                                                    batu10 = item.size;
                                                    stokBatu10.text =
                                                        item.qty.toString();
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu10!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 2
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
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                        qtyBatu10.text.isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyBatu10.text = '';
                                                        stokBatu10.text = '';
                                                        batu10 = '';
                                                        hargaBatu10 = 0;
                                                        caratPcsBatu10 = 0;
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
                                  //size batu 11
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu11 = item?.size;
                                                stokBatu11.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu11!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 11
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
                                                qtyBatu11.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 11

                              //batu12
                              qtyBatu11.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 12
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu12 = item?.size;
                                                stokBatu12.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu12!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 12
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
                                                qtyBatu12.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 12

                              //batu13
                              qtyBatu12.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 13
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu13 = item?.size;
                                                stokBatu13.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu13!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 13
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
                                                qtyBatu13.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 13

                              //batu14
                              qtyBatu13.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 14
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu14 = item?.size;
                                                stokBatu14.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu14!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 14
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
                                                qtyBatu14.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 14

                              //batu15
                              qtyBatu14.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 15
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu15 = item?.size;
                                                stokBatu15.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu15!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 15
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
                                                qtyBatu15.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 15

                              //batu16
                              qtyBatu15.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 16
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu16 = item?.size;
                                                stokBatu16.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu16!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 16
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
                                                qtyBatu16.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 16

                              //batu17
                              qtyBatu16.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 17
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu17 = item?.size;
                                                stokBatu17.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu17!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 17
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
                                                qtyBatu17.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 17

                              //batu18
                              qtyBatu17.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 18
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu18 = item?.size;
                                                stokBatu18.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu18!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 18
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
                                                qtyBatu18.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 18

                              //batu19
                              qtyBatu18.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 19
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu19 = item?.size;
                                                stokBatu19.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu19!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 19
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
                                                qtyBatu19.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 19

                              //batu20
                              qtyBatu19.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 20
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu20 = item?.size;
                                                stokBatu20.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu20!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 20
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
                                                qtyBatu20.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 20

                              //batu21
                              qtyBatu20.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 11
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu21 = item?.size;
                                                stokBatu21.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu21!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 11
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
                                                qtyBatu21.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 21

                              //batu22
                              qtyBatu21.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 12
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu22 = item?.size;
                                                stokBatu22.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu22!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 12
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
                                                qtyBatu22.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 22

                              //batu23
                              qtyBatu22.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 13
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu23 = item?.size;
                                                stokBatu23.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu23!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 13
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
                                                qtyBatu23.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 23

                              //batu24
                              qtyBatu23.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 14
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu24 = item?.size;
                                                stokBatu24.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu24!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 14
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
                                                qtyBatu24.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 24

                              //batu25
                              qtyBatu24.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 15
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu25 = item?.size;
                                                stokBatu25.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu25!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 15
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
                                                qtyBatu25.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 25

                              //batu26
                              qtyBatu25.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 16
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu26 = item?.size;
                                                stokBatu26.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu26!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 16
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
                                                qtyBatu26.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 26

                              //batu27
                              qtyBatu26.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 17
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu27 = item?.size;
                                                stokBatu27.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu27!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 17
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
                                                qtyBatu27.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 27

                              //batu28
                              qtyBatu27.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 18
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu28 = item?.size;
                                                stokBatu28.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu28!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 18
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
                                                qtyBatu28.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 28

                              //batu29
                              qtyBatu28.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 19
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu29 = item?.size;
                                                stokBatu29.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu29!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 19
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
                                                qtyBatu29.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 29

                              //batu30
                              qtyBatu29.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 30
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu30 = item?.size;
                                                stokBatu30.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu30!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 30
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
                                                qtyBatu30.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 30

                              //batu31
                              qtyBatu30.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 11
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu31 = item?.size;
                                                stokBatu31.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu31!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 11
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
                                                qtyBatu31.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 31

                              //batu32
                              qtyBatu31.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 12
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu32 = item?.size;
                                                stokBatu32.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu32!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 12
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
                                                qtyBatu32.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 32

                              //batu33
                              qtyBatu32.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 13
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu33 = item?.size;
                                                stokBatu33.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu33!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 13
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
                                                qtyBatu33.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 33

                              //batu34
                              qtyBatu33.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 14
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu34 = item?.size;
                                                stokBatu34.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu34!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 14
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
                                                qtyBatu34.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 34

                              //batu35
                              qtyBatu34.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 15
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 165,
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
                                            onChanged: (item) {
                                              setState(() {
                                                batu35 = item?.size;
                                                stokBatu35.text =
                                                    item!.qty.toString();
                                              });
                                            },
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                label: Text(
                                                  batu35!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //qty batu 15
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
                                                qtyBatu35.text;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              // hintText: "example: Cahaya Sanivokasi",
                                              label: const Text('Qty'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                          ),
                                        ),

                                        //stok batu
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
                                              // hintText: "example: Cahaya Sanivokasi",
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
                                      ],
                                    ),
                              // end row batu 15
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
    Map<String, String> body = {
      'kodeDesignMdbc': kodeDesignMdbc.text,
      'kodeMarketing': kodeMarketing.text,
      'kodeProduksi': kodeProduksi.text,
      'namaDesigner': namaDesigner.text,
      'namaModeller': namaModeller.text,
      'kodeDesign': kodeDesign.text,
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
      'imageUrl': imageUrl!,
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postFormDesigner),
        body: body);
    print(response.statusCode);
  }

  Future<List<BatuModel>> getData(filter) async {
    // 'http://54.179.58.215:8080/api/indexcustomer',
    // 'http://192.168.22.228/Api_Flutter/spk/batu.php',
    // 'https://fakestoreapi.com/products',
    var response = await Dio().get(
      ApiConstants.baseUrl + ApiConstants.getDataBatu,
      queryParameters: {"filter": filter},
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
      queryParameters: {"filter": filter},
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
      queryParameters: {"filter": filter},
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
      queryParameters: {"filter": filter},
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
      queryParameters: {"filter": filter},
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
      title: Text(item?.size ?? ''),
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
