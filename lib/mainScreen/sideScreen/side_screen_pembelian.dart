// // ignore_for_file: file_names, avoid_print

// import 'package:flutter/material.dart';
// import 'package:form_designer/global/global.dart';
// import 'package:form_designer/mainScreen/login.dart';
// import 'package:form_designer/pembelian/home_pembelian.dart';
// import 'package:form_designer/pembelian/list_form_pr.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:side_navigation/side_navigation.dart';

// // ignore: must_be_immutable
// class MainViewPembelian extends StatefulWidget {
//   //fungsi untuk menerima data
//   int col = 0;
//   final VoidCallback? onBackPressed;
//   //init data
//   MainViewPembelian({super.key, required this.col, this.onBackPressed});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MainViewPembelianState createState() => _MainViewPembelianState();
// }

// class _MainViewPembelianState extends State<MainViewPembelian> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   List<Widget> views = [
//     const HomescreenUserRole(),
//     const ListFormPr(),
//     const HomescreenUserRole()
//   ];

//   bool isKodeAkses = false;
//   TextEditingController kodeAkses = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //method multi screen
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return screenDekstop();
//         },
//       ),
//     );
//   }

//   //screen dekstop
//   screenDekstop() {
//     String greeting() {
//       var hour = DateTime.now().hour;
//       if (hour < 12) {
//         return 'Pagi';
//       }
//       if (hour < 15) {
//         return 'Siang';
//       }
//       if (hour < 17) {
//         return 'Sore';
//       }
//       return 'Malam';
//     }

//     return Row(
//       children: [
//         SideNavigationBar(
//           header: SideNavigationBarHeader(
//               image: const CircleAvatar(
//                 child: Icon(Icons.person_2_outlined),
//               ),
//               title: Text(
//                 'Selamat ${greeting()}',
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               ),
//               subtitle: Text(
//                 sharedPreferences!.getString('nama')!,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               )),
//           footer: SideNavigationBarFooter(
//               label: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Text(
//               '© Copyright PT Cahaya Sani Vokasi. All Rights Reserved\n $version',
//               style: const TextStyle(color: Colors.white),
//             ),
//           )),
//           initiallyExpanded: true,
//           selectedIndex: widget.col,
//           items: const [
//             SideNavigationBarItem(
//               icon: Icons.home,
//               label: 'Dashboard',
//             ),
//             SideNavigationBarItem(
//               icon: Icons.list_alt,
//               label: 'List Form PR',
//             ),
//             SideNavigationBarItem(
//               icon: Icons.logout,
//               label: 'Keluar',
//             ),
//           ],

//           onTap: (index) {
//             if (index == 2) {
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       content: Stack(
//                         clipBehavior: Clip.none,
//                         children: <Widget>[
//                           Positioned(
//                             right: -47.0,
//                             top: -47.0,
//                             child: InkResponse(
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const CircleAvatar(
//                                 backgroundColor: Colors.red,
//                                 child: Icon(Icons.close),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             child: Form(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   const Padding(
//                                     padding:
//                                         EdgeInsets.only(top: 5, bottom: 10),
//                                     child: Text('Yakin ingin keluar ?'),
//                                   ),
//                                   Container(
//                                     width: 200,
//                                     height: 50,
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.red),
//                                       child: const Text("Keluar"),
//                                       onPressed: () async {
//                                         SharedPreferences prefs =
//                                             await SharedPreferences
//                                                 .getInstance();
//                                         prefs.clear();
//                                         prefs.setString('token', 'null');
//                                         // ignore: use_build_context_synchronously
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (c) =>
//                                                     const LoginScreen()));
//                                       },
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//             } else {
//               setState(() {
//                 widget.col = index;
//               });
//             }
//           },
//           toggler: SideBarToggler(
//               expandIcon: Icons.keyboard_arrow_left,
//               shrinkIcon: Icons.keyboard_arrow_right,
//               onToggle: () {
//                 const Text('Hide');
//               }),

//           // Change the background color and disabled header/footer dividers
//           // Make use of standard() constructor for other themes
//           theme: SideNavigationBarTheme(
//             backgroundColor: colorDasar,
//             itemTheme: SideNavigationBarItemTheme(
//                 unselectedItemColor: const Color.fromRGBO(147, 155, 163, 1),
//                 selectedItemColor: Colors.white,
//                 iconSize: 32.5,
//                 labelTextStyle:
//                     const TextStyle(fontSize: 15, color: Colors.red)),
//             togglerTheme: const SideNavigationBarTogglerTheme(
//                 shrinkIconColor: Colors.white),
//             dividerTheme: SideNavigationBarDividerTheme.standard(),
//           ),
//         ),
//         Expanded(
//           child: views.elementAt(widget.col),
//         )
//       ],
//     );
//   }
// }

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_designer/admin/menu_model.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:http/http.dart' as http;

class MainViewPembelian extends StatefulWidget {
  const MainViewPembelian({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainViewPembelianState createState() => _MainViewPembelianState();
}

class _MainViewPembelianState extends State<MainViewPembelian> {
  List<int> userMenuIds = [];
  List<Widget> screenUserRole = [];
  List<String> listMenu = [];
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  bool isKodeAkses = false;
  TextEditingController kodeAkses = TextEditingController();
  String? userDivision;
  String? userRole;
  String? menuUserRole;
  bool isLoading = true; // Tambahkan variabel isLoading

  @override
  void initState() {
    print('init oke');
    super.initState();
    userDivision = sharedPreferences!.getString('divisi')?.toLowerCase();
    userRole = sharedPreferences!.getString('role')?.toLowerCase();
    menuUserRole = sharedPreferences!.getString('listMenu')?.toLowerCase();
    getList();
  }

  getList() async {
    userMenuIds = menuUserRole!.split(',').map((e) => int.parse(e)).toList();
    await listUser();
  }

  Future<void> listNamaMenu() async {
    print('list menu oke');

    listMenu = [];
    try {
      final response = await http
          .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.getListMenu));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        var allData =
            jsonResponse.map((data) => MenuModel.fromJson(data)).toList();
        for (int i = 0; i < userMenuIds.length; i++) {
          // user list 2
          var filterbyList = allData
              .where((element) => element.idMenu == userMenuIds[i])
              .toList();
          listMenu.add(filterbyList.first.menu!);
        }
        listMenu.add('Logout');
        print(listMenu);
      } else {
        throw Exception('Unexpected error occured!');
      }
    } catch (e) {
      print('err get menu $e');
    }
  }

  listUser() async {
    screenUserRole = [];
    await listNamaMenu();
    // Tambahkan widget sesuai dengan daftar menu user
    for (int menuId in userMenuIds) {
      if (menuId >= 0 && menuId < screenGlobal.length) {
        screenUserRole.add(screenGlobal[menuId]);
      }
    }
    // Tambahkan widget logout sekali di akhir daftar
    screenUserRole.add(const SizedBox()); //! logout
    print('menu $screenUserRole');
    setState(() {
      isLoading = false; // Setelah data tersedia, set isLoading menjadi false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //method multi screen
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return screenDekstop();
          } else {
            return screenDekstop();
          }
        },
      ),
    );
  }

  //screen dekstop
  screenDekstop() {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Pagi';
      }
      if (hour < 15) {
        return 'Siang';
      }
      if (hour < 17) {
        return 'Sore';
      }
      return 'Malam';
    }

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Row(
            children: [
              SideNavigationBar(
                header: SideNavigationBarHeader(
                    image: CircleAvatar(
                      child: Image.network(
                        '${ApiConstants.baseUrlImage}icon.png',
                        fit: BoxFit.scaleDown,
                        // scale: 2,
                      ),
                    ),
                    title: Text(
                      'Selamat ${greeting()}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      sharedPreferences!.getString('nama')!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                footer: SideNavigationBarFooter(
                    label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    '© Copyright PT Cahaya Sani Vokasi. All Rights Reserved\n $version',
                    style: const TextStyle(color: Colors.white),
                  ),
                )),
                initiallyExpanded: true,
                selectedIndex: selectedIndex,
                items: listMenuUser(),
                onTap: (index) {
                  //* HINTS Periksa divisi pengguna
                  if (index == screenUserRole.length - 1) {
                    // Jika divisi adalah 'GA' atau 'Pembelian' dan index adalah index terakhir dari layar yang sesuai, tampilkan dialog logout
                    alertLogout();
                  } else {
                    // Selain itu, tetapkan indeks yang dipilih ke variabel selectedIndex
                    setState(() {
                      selectedIndex = index;
                    });
                  }
                },
                toggler: SideBarToggler(
                    expandIcon: Icons.keyboard_arrow_left,
                    shrinkIcon: Icons.keyboard_arrow_right,
                    onToggle: () {
                      const Text('Hide');
                    }),

                // Change the background color and disabled header/footer dividers
                // Make use of standard() constructor for other themes
                theme: SideNavigationBarTheme(
                  backgroundColor: colorDasar,
                  itemTheme: SideNavigationBarItemTheme(
                      unselectedItemColor:
                          const Color.fromRGBO(147, 155, 163, 1),
                      selectedItemColor: Colors.white,
                      iconSize: 32.5,
                      labelTextStyle:
                          const TextStyle(fontSize: 15, color: Colors.red)),
                  togglerTheme: const SideNavigationBarTogglerTheme(
                      shrinkIconColor: Colors.white),
                  dividerTheme: SideNavigationBarDividerTheme.standard(),
                ),
              ),
              Expanded(
                child: screenUserRole.elementAt(selectedIndex),
              ),
            ],
          );
  }

//alert logout
  alertLogout() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -47.0,
                  top: -47.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                SizedBox(
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Text('Yakin ingin keluar ?'),
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text("Keluar"),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              prefs.setString('token', 'null');
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const LoginScreen()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  alertKalkulator(index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -47.0,
                  top: -47.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                SizedBox(
                  height: 190,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Text('Masukan Kode Akses'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: true,
                            obscureText: true,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textInputAction: TextInputAction.next,
                            controller: kodeAkses,
                            validator: (value) {
                              if (value! != aksesKode) {
                                return 'Kode akses salah';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              isKodeAkses = true;
                              kodeAkses.text == aksesKode
                                  ? isKodeAkses = true
                                  : isKodeAkses = false;
                            },
                            decoration: InputDecoration(
                              labelText: "Kode Akses",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            child: const Text("Submit"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                  selectedIndex = index;
                                  Navigator.of(context).pop();
                                });
                              } else {}
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

//? all list divisi
  List<SideNavigationBarItem> listMenuUser() {
    return [
      for (int i = 0; i < listMenu.length; i++)
        SideNavigationBarItem(
          icon: iconMapGlobal.containsKey(listMenu[i])
              ? iconMapGlobal[listMenu[i]]!
              : Icons
                  .error, // Menggunakan ikon default jika tidak ditemukan ikon
          label: listMenu[i],
        )
    ];
  }
}
