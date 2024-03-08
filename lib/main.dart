// import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/login/my_splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/global.dart';

Future<void> main() async {
  sharedPreferences = await SharedPreferences.getInstance();

  //* HINTs notif init fire
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDOyDK9Pm49VTkT7-1-DACD-M84FZaiHhU",
          authDomain: "flutter-web-83673.firebaseapp.com",
          projectId: "flutter-web-83673",
          storageBucket: "flutter-web-83673.appspot.com",
          messagingSenderId: "493427708399",
          appId: "1:493427708399:web:b9d4abd257d81fa639e61a",
          measurementId: "G-XJ0LT97BZX"),
    );
    // Handle permission
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
      // Handle the message when the app is active
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened: ${message.notification?.title}');
      // Handle the message when the app is opened from the background
    });
  } catch (e) {
    print('err notif $e');
  }

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
