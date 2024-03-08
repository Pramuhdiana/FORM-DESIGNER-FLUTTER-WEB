// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationsSystem {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static void configureFirebaseMessaging(BuildContext context) {
    _firebaseMessaging.getToken().then((token) {
      print('Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      // Tambahkan logika untuk menangani pesan yang diterima saat aplikasi sedang aktif
      // Contoh: menampilkan dialog atau menavigasi ke layar tertentu
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        onDismissCallback: (type) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Dismissed by $type'),
            ),
          );
        },
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'INFO',
        desc: '${message.notification!.body}',
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
      // Tambahkan logika untuk menangani pesan yang diterima saat pengguna membuka aplikasi dari notifikasi
      // Contoh: menavigasi ke layar tertentu
    });
  }
}
