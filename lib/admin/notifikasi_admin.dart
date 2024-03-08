// ignore_for_file: avoid_print, unused_local_variable, library_private_types_in_public_api, prefer_final_fields

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/admin/users_model.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class NotifikasiAdmin extends StatefulWidget {
  const NotifikasiAdmin({super.key});

  @override
  _NotifikasiAdminState createState() => _NotifikasiAdminState();
}

class _NotifikasiAdminState extends State<NotifikasiAdmin> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  String tokenUser = '';
  String? namaUser;
  List<UsersModel>? _listDataUsers;
  bool isLoading = false;
  @override
  initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });
    await _getDataUser();
    setState(() {
      isLoading = false;
    });
    await _getToken();
  }

  _getDataUser() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListUsers));

    // if response successful

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      var allData =
          jsonResponse.map((data) => UsersModel.fromJson(data)).toList();

      setState(() {
        _listDataUsers = allData;
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  _getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');
    // ignore: use_build_context_synchronously
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      width: 450,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      // onDismissCallback: (type) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Dismissed by $type'),
      //     ),
      //   );
      // },
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'INFO',
      desc: '$token',
      // showCloseIcon: true,
      // btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  // Fungsi untuk mengirim notifikasi ke pengguna
  void _sendNotification() {
    //*HINTS Panggil fungsi showCustomDialog
    showCustomDialog(
      context: context,
      dialogType: DialogType.success,
      title: 'SUCCESS',
      description: 'This is a success message!',
    );
    String title = _titleController.text;
    String content = _contentController.text;
    notif.sendNotificationTo(tokenUser, title, content);
    print(tokenUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: isLoading == true
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                height: 90,
                child: Lottie.asset("loadingJSON/loadingV1.json"),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(labelText: 'Content'),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color: namaUser != null
                            ? const Color.fromARGB(255, 8, 209, 69)
                            : const Color.fromARGB(255, 255, 255,
                                255), //background color of dropdown button
                        border: Border.all(
                          color: Colors.black38,
                          // width:
                          //     3
                        ), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            0), //border raiuds of dropdown button
                        boxShadow: const <BoxShadow>[]),
                    child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 200,
                        child: DropdownButton(
                          value: namaUser,
                          items: _listDataUsers!.map((user) {
                            return DropdownMenuItem(
                              value: user.nama.toString(),
                              child: Text(user.nama.toString()),
                            );
                          }).toList(),
                          hint: const Text('Pilih User'),
                          onChanged: (value) {
                            setState(() {
                              namaUser = value;
                              tokenUser = _listDataUsers!
                                  .firstWhere((user) =>
                                      user.nama.toString().toLowerCase() ==
                                      value.toString().toLowerCase())
                                  .token!;
                              // print(tokenUser);
                            });
                          },
                          icon: const Padding(
                              padding: EdgeInsets.only(left: 20, right: 5),
                              child: Icon(Icons.arrow_circle_down_sharp)),
                          iconEnabledColor: Colors.black, //Icon color
                          style: const TextStyle(
                            color: Colors.black, //Font color
                            // fontSize:
                            //     15 //font size on dropdown button
                          ),

                          dropdownColor:
                              Colors.white, //dropdown background color
                          underline: Container(), //remove underline
                          isExpanded: true, //make true to make width 100%
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _sendNotification,
                    child: const Text('Send Notification'),
                  ),
                ],
              ),
            ),
    );
  }
}
