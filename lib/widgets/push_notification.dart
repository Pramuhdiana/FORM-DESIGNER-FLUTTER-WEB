// // // ignore_for_file: avoid_print

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:overlay_support/overlay_support.dart';

// // // ignore: use_key_in_widget_constructors
// // class PushNotification extends StatefulWidget {
// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _PushNotificationState createState() => _PushNotificationState();
// // }

// // class _PushNotificationState extends State<PushNotification> {

// //   @override
// //   void initState() {
// //     super.initState();
// //     _configureFirebaseMessaging();
// //   }

// //   void _configureFirebaseMessaging() {
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       print("onMessage: $message");
// //       // Handle message when the app is in the foreground
// //     });

// //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //       print("onMessageOpenedApp: $message");
// //       // Handle when the app is opened from a terminated state
// //     });

// //     FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
// //   }

// //   Future<void> _handleBackgroundMessage(RemoteMessage message) async {
// //     print("onBackgroundMessage: $message");
// //     // Handle when the app is in the background
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'My App',
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('My App'),
// //         ),
// //         body: const Center(
// //           child: Text('Welcome to My App'),
// //         ),
// //       ),
// //     );
// //   }
// // }



// class PushNotificationsSystem {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   //notifications arrived/received
//   Future whenNotificationReceived(BuildContext context) async {
//     //1. Terminated
//     //When the app is completely closed and opened directly from the push notification
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? remoteMessage) {
//       if (remoteMessage != null) {
//          FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
//     print("onBackgroundMessage: $remoteMessage");  
//       // Handle message when the app is in the foreground
//     });
//   }});

//     //2. Foreground
//     //When the app is open and it receives a push notification
//     FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) async {
//       if (remoteMessage != null) {
//        print("onMessageOpenedApp: $remoteMessage");
//         showSimpleNotification(
//           Text(remoteMessage.notification!.title.toString()),
//           subtitle: Text(remoteMessage.notification!.body.toString()),
//           background: Colors.orange.shade700,
//           duration: const Duration(seconds: 5),
//         );
//         // showNotificationWhenOpenApp(
//         //   context,
//         // );
//       } else {}
//     });

//     // 3. Background
//     // When the app is in the background and opened directly from the push notification.

//     FirebaseMessaging.onMessageOpenedApp
//         .listen((RemoteMessage? remoteMessage) async {
//       if (remoteMessage != null) {
        
//           //open the app - show notification data
//            print("onMessage: $remoteMessage");
//           showSimpleNotification(
//             Text(remoteMessage.notification!.title.toString()),
//             subtitle: Text(remoteMessage.notification!.body.toString()),
//             background: Colors.orange.shade700,
//             duration: const Duration(seconds: 5),
//           );
//           // showNotificationWhenOpenApp(
//           //   context,
//           // );
        
//       } else {}
//     });
//   }

//   // //device recognition token
//   // Future generateDeviceRecognitionToken() async {
//   //   String? registrationDeviceToken = await messaging.getToken();

//   //   FirebaseFirestore.instance
//   //       .collection("UserTokens")
//   //       .doc(sharedPreferences!.getString("name"))
//   //       .update({
//   //     "token": registrationDeviceToken,
//   //   });

//   //   messaging.subscribeToTopic("allSellers");
//   //   messaging.subscribeToTopic("allUsers");
//   // }

//   showNotificationWhenOpenApp(context) {
//     showReusableSnackBar(
//         context, "you have new Notification. \n\n Please Check now.");
//   }

//   showReusableSnackBar(BuildContext context, String title) {
//     SnackBar snackBar = SnackBar(
//       backgroundColor: Colors.green,
//       duration: const Duration(seconds: 5),
//       content: Text(
//         title.toString(),
//         style: const TextStyle(
//           fontSize: 16,
//           color: Colors.white,
//         ),
//       ),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   Future notificationPopUp(BuildContext context) async {
//     messaging = FirebaseMessaging.instance;
//     // FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     //   print('Message clicked!');
//     // });
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
//       print("message recieved");
      
//       // showDialog(
//       //     context: context,
//       //     builder: (BuildContext context) {
//       //       return AlertDialog(
//       //         title: Text(event.notification!.title!),
//       //         content: Text(event.notification!.body!),
//       //         actions: [
//       //           TextButton(
//       //             child: const Text("Ok"),
//       //             onPressed: () {
//       //               Navigator.of(context).pop();
//       //             },
//       //           )
//       //         ],
//       //       );
//       //     });
//     });
//     // messaging.subscribeToTopic("messaging");
//   }
// }
