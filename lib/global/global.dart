import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
int revisiBesar =
    1; //UI baru, banyak fitur baru, perubahan konsep, dll  (MAJOR)
int revisiKecil =
    3; //perubahan kecil                                    (MINOR)
int rilisPerbaikanbug =
    0; //perbaikan bug                                      (PATCH)

String version = 'v$revisiBesar.$revisiKecil.$rilisPerbaikanbug';
String aksesKode = "S@niv0kasi";
double tinggiTextfield = 75.0; // tinggi text field
