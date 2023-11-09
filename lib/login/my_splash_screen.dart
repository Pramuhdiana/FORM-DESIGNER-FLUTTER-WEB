// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/mainScreen/side_screen.dart';
import 'package:form_designer/mainScreen/side_screen_produksi.dart';
import 'package:form_designer/model/siklus_model.dart';
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
          } else {
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
    splashScreenTimer();
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
                // child: Lottie.asset("loadingJSON/Logo.json"),
                child: Lottie.asset("loadingJSON/animation_llvy7jo7.json"),
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
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
          );
        });
  }
}
