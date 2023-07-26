// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/model/batu_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../widgets/custom_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
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
  int? hargaEmas =
      0; //(berat emas + total crt/pcs dibagi 5 dikali 675000) di kali 1.2
  // int? hargaEmas = 0;
  // int? hargaEmas = 0;

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  List<String> listBatu = ["Batu 1", "Batu 2"];
  int count = 0;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(
          Uri.parse("http://192.168.22.228/Api_Flutter/spk/batu.php"),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // entry data to variabel list _get
        setState(() {
          _get = data;
          // showDialog<String>(
          //     context: context,
          //     builder: (BuildContext context) => const AlertDialog(
          //           title: Text(
          //             'Design Tersimpan localhost',
          //           ),
          //         ));
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

  Future<void> _pickImage() async {
    try {
      // Pick an image file using file_picker package
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // If user cancels the picker, do nothing
      if (result == null) return;

      // If user picks an image, update the state with the new image file
      setState(() {
        _imageFile = result.files.first;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Form Designer",
            style: TextStyle(fontSize: 25, color: Colors.black),
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
                  height: 45,
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
                  height: 45,
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
                        namaDesigner.text = value;
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
                  height: 45,
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
                    height: 45,
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
                    height: 45,
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
                    height: 45,
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
                    height: 45,
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
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: rantai,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Rantai",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 45,
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
                          height: 45,
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
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: jenisBarang,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Jenis Barang",
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
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: lain2,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Lain - Lain",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 45,
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
                          height: 45,
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
                    height: 45,
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
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: earnut,
                            decoration: InputDecoration(
                              // hintText: "example: Cahaya Sanivokasi",
                              labelText: "Earnut",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 45,
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
                          height: 45,
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
                    height: 45,
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
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.1,
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
                    height: 45,
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
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.1,
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
                          height: 45,
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
                          height: 45,
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
                    height: 45,
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
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: beratEmas,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Berat Emas",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      enabled: false,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: estimasiHarga,
                      decoration: InputDecoration(
                        // hintText: "example: Cahaya Sanivokasi",
                        labelText: "Estimasi Harga",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
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
                              //size batu 1
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
                                      onChanged: (item) {
                                        setState(() {
                                          batu1 = item?.size;
                                          stokBatu1.text = item!.qty.toString();
                                        });
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

                                  //qty batu 1
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
                                          qtyBatu1.text;
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

                                  //stok batu
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
                                ],
                              ),
                              // end row batu 1

                              //batu2
                              qtyBatu1.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 2
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
                                                batu2 = item?.size;
                                                stokBatu2.text =
                                                    item!.qty.toString();
                                              });
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

                                        //qty batu 2
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
                                                qtyBatu2.text;
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
                                      ],
                                    ),
                              // end row batu 2

                              //batu3
                              qtyBatu2.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 3
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
                                                batu3 = item?.size;
                                                stokBatu3.text =
                                                    item!.qty.toString();
                                              });
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

                                        //qty batu 3
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
                                                qtyBatu3.text;
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
                                      ],
                                    ),
                              // end row batu 3

                              //batu4
                              qtyBatu3.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 4
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
                                                batu4 = item?.size;
                                                stokBatu4.text =
                                                    item!.qty.toString();
                                              });
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

                                        //qty batu 4
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
                                                qtyBatu4.text;
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
                                      ],
                                    ),
                              // end row batu 4

                              //batu5
                              qtyBatu4.text.isEmpty
                                  ? const SizedBox()
                                  :
                                  //size batu 5
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
                                                batu5 = item?.size;
                                                stokBatu5.text =
                                                    item!.qty.toString();
                                              });
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

                                        //qty batu 5
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
                                                qtyBatu5.text;
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
                                      ],
                                    ),
                              // end row batu 5
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

  //form validasi
  postApi2() async {
    Map<String, String> body = {
      'size': '115',
      'qty': '20',
      'lot': '-2',
      'parcel': 'parcellll',
      'caratPcs': '0.02',
      'ukuran': '115.5',
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postDataBatu),
        body: body);
    print(response.statusCode);
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
      'imageUrl': 'gambar',
    };
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postFormDesigner),
        body: body);
    print(response.statusCode);
  }

  Future<List<BatuModel>> getData(filter) async {
    // 'http://54.179.58.215:8080/api/indexcustomer',
    // 'https://fakestoreapi.com/products',
    // 'http://192.168.22.228/Api_Flutter/spk/batu.php',
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
