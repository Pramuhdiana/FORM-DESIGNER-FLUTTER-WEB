// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_designer/admin/menu_model.dart';
import 'package:form_designer/admin/users_model.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_admin.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_designer.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_pembelian.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_produksi.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_qc.dart';
import 'package:form_designer/mainScreen/sideScreen/side_screen_scm.dart';
import 'package:form_designer/model/siklus_model.dart';
import 'package:form_designer/qc/modelQc/jenisBatuModel.dart';
import 'package:form_designer/qc/modelQc/panjangModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  String? mtoken = " ";
  String token = sharedPreferences!.getString("token").toString();
  int role = 0;

  var isLoading = false;
  splashScreenTimer() {
    Timer(const Duration(seconds: 3), () async {
      //user sudah login
      print('token $token');
      if (sharedPreferences!.getString("token").toString() != "null") {
        try {
          final response = await http
              .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getSiklus));
          if (response.statusCode == 200) {
            List jsonResponse = json.decode(response.body);

            var g =
                jsonResponse.map((data) => SiklusModel.fromJson(data)).toList();
            sharedPreferences!.setString('siklus', g[0].siklus!);
            // print(nowSiklus);
          } else {
            throw Exception('Unexpected error occured!');
          }

          if (sharedPreferences!.getString('divisi') == 'produksi') {
            print('masuk area produksi');
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const MainViewProduksi()));
          } else if (sharedPreferences!.getString('divisi') == 'scm') {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => MainViewScm(col: 0)));
          } else if (sharedPreferences!.getString('divisi') == 'designer') {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => MainViewDesigner(col: 0)));
          }
          // else if (sharedPreferences!.getString('divisi') == 'qc') {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (c) => MainViewQc(col: 0)));
          // }
          else if (sharedPreferences!.getString('divisi') == 'pembelian' ||
              sharedPreferences!.getString('divisi') == 'qc') {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const MainViewPembelian()));
          } else if (sharedPreferences!.getString('divisi') == 'admin') {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const MainViewAdmin()));
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (c) => const MainAdminScreen()));
          } else {
            //admin
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const MainView()));
          }
        } catch (c) {
          Fluttertoast.showToast(msg: "Failed get database");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const LoginScreen()));
        }
      } else //user is NOT already Logged-in
      {
        Fluttertoast.showToast(msg: "Failed To Load Data");
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
    splashScreenTimer();
  }

  _getData() async {
    await _getDataUser();
    await getPanjang();
    // await getLebar();
    await getJenisBatu();
    // await getKualitasBatu();
  }

  _getDataUser() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListUsers));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => UsersModel.fromJson(data)).toList();
      var filterByName = allData
          .where((element) =>
              element.nama.toString().toLowerCase() ==
              sharedPreferences!.getString('nama').toString().toLowerCase())
          .toList();
      String? listMenuAPI = filterByName.first.listMenu;
      sharedPreferences!.setString('listMenu', listMenuAPI!);

      // idMenu[i][j] =

      setState(() {});
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  //* HINTS menyimpan api ke list lokal
  getPanjang() async {
    print('on');
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListPanjang));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var alldata =
            jsonResponse.map((data) => PanjangModel.fromJson(data)).toList();
        final jsonList =
            alldata.map((panjang) => json.encode(panjang.toJson())).toList();
        await prefs.setStringList('listPanjang', jsonList);
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get data panjang = $c');
    }
  }

  getJenisBatu() async {
    print('on');
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListJenisBatu));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var alldata =
            jsonResponse.map((data) => JenisBatuModel.fromJson(data)).toList();
        final jsonList =
            alldata.map((panjang) => json.encode(panjang.toJson())).toList();
        await prefs.setStringList('jenisBatu', jsonList);
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (c) {
      print('err get data panjang = $c');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(12.0),
                // child: Lottie.asset("loadingJSON/fixLogo.json"),
                child: Lottie.asset("loadingJSON/loadingScreen.json"),
                // child: Lottie.asset("loadingJSON/animation_llvy7jo7.json"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "",
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 3,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dialogBox() {
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
                    title: const Text('Please choose aplikasi'),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        children: [
                          ElevatedButton(
                            //if user click this button, user can upload image from gallery
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (c) => const MainScreen()));
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.trending_up_sharp),
                                Text('Pos Mobile'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            //if user click this button. user can upload image from camera
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (c) => ApprovePricingScreen()));
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.price_check_sharp),
                                Text('Approval Pricing'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }
}
