// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_designer/login/my_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../api/api_constant.dart';
import '../global/global.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({super.key});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool isLogo = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      // Positioned(
      //     left: 0,
      //     top: -35,
      //     child: Transform.scale(
      //       scale: 0.8,
      //       child: SizedBox(
      //         // width: MediaQuery.of(context).size.width * 1,
      //         child: Lottie.asset("loadingJSON/logoLOTI.json"),
      //       ),
      //     )),
      Positioned(
          right: 55,
          top: 1,
          child: SizedBox(
            // width: MediaQuery.of(context).size.width * 1,
            child: Lottie.asset("loadingJSON/BGlogin.json"),
          )),
      Row(
        children: [
          Expanded(
              //<-- Expanded widget
              child: Image.network(
            '${ApiConstants.baseUrlImage}sanivokasi_logo-01.png',
            // 'http://192.168.22.228/Api_Flutter/spk/upload/sanivokasi_logo-01.png',
            fit: BoxFit.cover,
          )),
          // ),
          Expanded(
            //<-- Expanded widget
            child: Container(
              constraints: const BoxConstraints(maxWidth: 21),
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome back',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login to your account',
                      style: GoogleFonts.inter(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 35),
                    TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Email",
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
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.next,
                      controller: password,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                activeColor: const Color(0xff00C8E8),
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  _isChecked == true
                                      ? setState(() {
                                          _isChecked = false;
                                        })
                                      : setState(() {
                                          _isChecked = true;

                                          sharedPreferences!.clear();
                                          sharedPreferences!
                                              .setString('token', 'ingat saya');
                                        });
                                },
                              ),
                              const SizedBox(width: 10.0),
                              const Text("Ingat Saya",
                                  style: TextStyle(
                                      color: Color(0xff646464),
                                      fontSize: 12,
                                      fontFamily: 'Rubic')),
                            ]),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Lupa Password ?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 110, 114, 236),
                                  fontSize: 12,
                                  fontFamily: 'Rubic')),
                        )
                      ],
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Map<String, dynamic> body = {
                              'email': email.text,
                              'password': password.text,
                            };
                            final response = await http.post(
                                Uri.parse(ApiConstants.baseUrl +
                                    ApiConstants.postLogin),
                                body: body);
                            final data = jsonDecode(response.body);
                            int value = data['value'];
                            print(response.statusCode);
                            if (value == 1) {
                              String id = data['id'];
                              // String emailAPI = data['email'];
                              // String namaAPI = data['nama'];
                              // String levelAPI = data['level'];
                              // String statusAPI = data['status'];
                              // String divisiAPI = data['divisi'];
                              // String roleAPI = data['role'];
                              // String listMenuAPI = data['listMenu'];
                              setState(() {
                                sharedPreferences!
                                    .setString('token', 'ingat saya');
                                sharedPreferences!.setString('id', id);
                                // sharedPreferences!.setString('nama', namaAPI);
                                // sharedPreferences!.setString('email', emailAPI);
                                // sharedPreferences!.setString('level', levelAPI);
                                // sharedPreferences!
                                //     .setString('status', statusAPI);
                                // sharedPreferences!
                                //     .setString('divisi', divisiAPI);
                                // sharedPreferences!.setString('role', roleAPI);

                                // print(listMenuAPI);

                                sharedPreferences!.setBool('isLogin', true);
                                // savePref(
                                //     id, emailAPI, namaAPI, levelAPI, statusAPI);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) =>
                                            const MySplashScreen()));
                              });
                            } else if (value == 0) {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const AlertDialog(
                                        title: Text(
                                          'Email dan Password salah',
                                        ),
                                      ));
                            }
                          }
                        },
                        child: const Text(
                          'Login Now',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text('pasword'),
                    //   //...
                    //   //...
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  // savePref(
  //   String id,
  //   String email,
  //   String nama,
  //   String level,
  //   String status,
  // ) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setString("id", id);
  //     preferences.setString("email", email);
  //     preferences.setString("nama", nama);
  //     preferences.setString("level", level);
  //     preferences.setString("status", status);
  //     preferences.setString("isLogin", 'true');
  //   });
  // }
}
