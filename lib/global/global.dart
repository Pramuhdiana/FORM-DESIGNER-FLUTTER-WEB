import 'dart:ui';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
int revisiBesar =
    1; //UI baru, banyak fitur baru, perubahan konsep, dll  (MAJOR)
int revisiKecil =
    25; //perubahan kecil                                    (MINOR)
int rilisPerbaikanbug =
    0; //perbaikan bug                                      (PATCH)
//? komen
Color colorDasar = const Color.fromRGBO(38, 54, 72, 1);
Color colorBG = const Color.fromARGB(255, 157, 157, 165);
Color colorGrey = const Color.fromARGB(243, 243, 243, 187);
Color colorCard1 = const Color.fromRGBO(90, 174, 170, 1);
Color colorCard2 = const Color.fromRGBO(194, 203, 201, 1);

String version = 'v$revisiBesar.$revisiKecil.$rilisPerbaikanbug';
String aksesKode = "S@niv0kasi";
double tinggiTextfield = 75.0; // tinggi text field

var now = DateTime.now();
String siklusSaatIini = DateFormat('MMMM', 'id').format(now);
