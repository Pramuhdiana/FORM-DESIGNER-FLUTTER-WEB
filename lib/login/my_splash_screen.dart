// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/mainScreen/side_screen.dart';
import '../global/global.dart';
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
    Timer(const Duration(seconds: 4), () async {
      //user sudah login
      print('token $token');
      if (sharedPreferences!.getString("token").toString() != "null") {
        try {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const MainView()));
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

//get token
  getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("token notif is $mtoken");
      });
      saveToken(token!);
    });
  }

  //save token
  saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(sharedPreferences!.getString("name").toString())
        .set({
      'token': token,
    });
    FirebaseMessaging.instance.subscribeToTopic("allUsers");
  }

  //request permission
  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provosional permission');
    } else {
      print('user declined or has not accepted permission');
    }
  }

  // ignore: unused_element
  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection("UserTokens")
        .doc('Sandy')
        .snapshots()
        .listen((event) {
      setState(() {});
    });
    try {
      // await apiProvider.getUsers();
      // setState(() {
      //   role = int.parse(sharedPreferences!.getString('role_sales_brand')!);
      //   print(role);
      // });
    } catch (c) {
      // sharedPreferences!.setString('name', 'Failed To Load Data');
      // Fluttertoast.showToast(msg: "Failed To Load Data User");
    }

    setState(() {
      isLoading = false;
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Lottie.asset("loadingJSON/animation_llvy7jo7.json"),
                // child: Image.network(
                //   '${ApiConstants.baseUrlImage}sanivokasi_logo-01.png',
                //   height: 400,
                //   width: 400,
                //   fit: BoxFit.cover,
                // ),
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
