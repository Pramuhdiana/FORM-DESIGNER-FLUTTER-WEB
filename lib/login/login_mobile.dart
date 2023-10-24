// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import '../global/global.dart';
import 'my_splash_screen.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: SizedBox(
              width: 300,
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
                            print(data);
                            int value = data['value'];
                            String id = data['id'];
                            String emailAPI = data['email'];
                            String namaAPI = data['nama'];
                            String levelAPI = data['level'];
                            String statusAPI = data['status'];
                            String divisiAPI = data['divisi'];
                            if (value == 1) {
                              setState(() {
                                sharedPreferences!.setString('id', id);
                                sharedPreferences!.setString('nama', namaAPI);
                                sharedPreferences!.setString('email', emailAPI);
                                sharedPreferences!.setString('level', levelAPI);
                                sharedPreferences!
                                    .setString('status', statusAPI);
                                sharedPreferences!
                                    .setString('divisi', divisiAPI);
                                sharedPreferences!.setBool('isLogin', true);
                                // savePref(
                                //     id, emailAPI, namaAPI, levelAPI, statusAPI);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) =>
                                            const MySplashScreen()));
                              });
                            } else {
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
        ),
      ),
    );
  }
}
