import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/login/my_splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/global.dart';

Future<void> main() async {
  sharedPreferences = await SharedPreferences.getInstance();
  // var option = {
  //  var apiKey: "AIzaSyDOyDK9Pm49VTkT7-1-DACD-M84FZaiHhU",
  // authDomain: "flutter-web-83673.firebaseapp.com",
  // projectId: "flutter-web-83673",
  // storageBucket: "flutter-web-83673.appspot.com",
  // messagingSenderId: "493427708399",
  // appId: "1:493427708399:web:b9d4abd257d81fa639e61a"
  // };
  // await Firebase.initializeApp(
  //   options: 
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const MySplashScreen(),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
