// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:form_designer/global/global.dart';
import 'package:http/http.dart' as http;

class SendNotif {
  sendNotificationTo(token, title, body) async {
    Map<String, String> bodyNotification = {'title': title, 'body': body};
    Map<String, String> headersAPI = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmServerToken',
    };
    Map<String, dynamic> bodyAPI = {
      'to': token,
      'notification': bodyNotification,
    };

    // Kirim permintaan POST ke FCM
    http.Response response = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headersAPI,
      body: jsonEncode(bodyAPI),
    );

    // Periksa respons dari FCM
    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }

    // Print respons body untuk informasi lebih lanjut
    print('Response body: ${response.body}');
  }
}
