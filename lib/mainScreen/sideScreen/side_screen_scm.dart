// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:form_designer/SCM/mainScreen/kebutuhan_batu_by_siklus.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/calculatePricing/list_calculate_pricing_screen.dart';
import 'package:form_designer/calculatePricingFuji/list_calculate_pricing_screen_fuji.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_batu_screen.dart';
import 'package:form_designer/mainScreen/list_data_modeller.dart';
import 'package:form_designer/mainScreen/list_designer_screen.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/mainScreen/list_status_approval.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

// ignore: must_be_immutable
class MainViewScm extends StatefulWidget {
  //fungsi untuk menerima data
  int col = 0;
  //init data
  MainViewScm({super.key, required this.col});

  @override
  // ignore: library_private_types_in_public_api
  _MainViewScmState createState() => _MainViewScmState();
}

class _MainViewScmState extends State<MainViewScm> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> screenDevi = [
    const HomeScreen(),
    const ListDataModellerScreen(),
    const ListDesignerScreen(),
    const ListBatuScreen(),
    const ListCalculatePricingScreen(),
    const ListKebutuhanBatuScreen(),
    const ListStatusApprovalScreen(),
    const ListMpsScreen(),
    const HomeScreen()
  ];
  List<Widget> screenEka = [
    const HomeScreen(),
    const ListDesignerScreen(),
    const ListBatuScreen(),
    const ListKebutuhanBatuScreen(),
    const ListMpsScreen(),
    const HomeScreen()
  ];
  List<Widget> screenFuji = [
    const HomeScreen(),
    const ListCalculatePricingScreen(),
    const ListCalculatePricingFujiScreen(),
    const ListStatusApprovalScreen(),
    const HomeScreen()
  ];
  List<Widget> screenEva = [
    const HomeScreen(),
    const ListDataModellerScreen(),
    const ListBatuScreen(),
    const ListMpsScreen(),
    const HomeScreen()
  ];

  final _formKey = GlobalKey<FormState>();

  bool isKodeAkses = false;
  TextEditingController kodeAkses = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //method multi screen
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return screenDekstop();
            // return screenMobile();
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

    return Row(
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
          footer: const SideNavigationBarFooter(
              label: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              '© Copyright PT Cahaya Sani Vokasi. All Rights Reserved',
              style: TextStyle(color: Colors.white),
            ),
          )),
          initiallyExpanded: true,
          selectedIndex: widget.col,
          // ignore: prefer_const_literals_to_create_immutables
          items: sharedPreferences!.getString('role') == '4'
              ? listEva()
              : sharedPreferences!.getString('role') == '3'
                  ? listEka()
                  : sharedPreferences!.getString('role') == '2'
                      ? listFuji()
                      : listDevi(),

          onTap: (index) {
            print(sharedPreferences!.getString('role'));
            if (sharedPreferences!.getString('role') == '1') {
              //! devi
              if (index == 8) {
                //! sign out
                showDialog(
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
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 10),
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
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                          prefs.setString('token', 'null');
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      const LoginScreen()));
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
              } else if (index == 4) {
                //! kalkulator
                showDialog(
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
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 10),
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
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            setState(() {
                                              widget.col = index;
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
              } else {
                setState(() {
                  widget.col = index;
                });
              }
            }
            //! eka
            else if (sharedPreferences!.getString('role') == '3') {
              if (index == 5) {
                //! sign out
                showDialog(
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
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 10),
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
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                          prefs.setString('token', 'null');
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      const LoginScreen()));
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
              } else {
                setState(() {
                  widget.col = index;
                });
              }
            }
            //! eva
            else if (sharedPreferences!.getString('role') == '4') {
              if (index == 4) {
                //! sign out
                showDialog(
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
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 10),
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
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                          prefs.setString('token', 'null');
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      const LoginScreen()));
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
              } else {
                setState(() {
                  widget.col = index;
                });
              }
            } else if (sharedPreferences!.getString('role') == '2') {
              //! fuji
              if (index == 4) {
                //! sign out
                showDialog(
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
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 10),
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
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                          prefs.setString('token', 'null');
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      const LoginScreen()));
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
              } else if (index == 1) {
                //! kalkulator
                showDialog(
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
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 10),
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
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            setState(() {
                                              widget.col = index;
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
              } else {
                setState(() {
                  widget.col = index;
                });
              }
            } else {
              setState(() {
                widget.col = index;
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
                unselectedItemColor: const Color.fromRGBO(147, 155, 163, 1),
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
          child: sharedPreferences!.getString('role') == '4'
              ? screenEva.elementAt(widget.col)
              : sharedPreferences!.getString('role') == '3'
                  ? screenEka.elementAt(widget.col)
                  : sharedPreferences!.getString('role') == '2'
                      ? screenFuji.elementAt(widget.col)
                      : screenDevi.elementAt(widget.col),
        )
      ],
    );
  }

  listDevi() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard',
      ),
      const SideNavigationBarItem(
        icon: Icons.data_array,
        label: 'List data modeller',
      ),
      const SideNavigationBarItem(
        icon: Icons.list_alt,
        label: 'List form designer',
      ),
      const SideNavigationBarItem(
        icon: Icons.list,
        label: 'List stok batu',
      ),
      const SideNavigationBarItem(
        icon: Icons.calculate_outlined,
        label: 'Calculate Price',
      ),
      const SideNavigationBarItem(
        icon: Icons.bar_chart_sharp,
        label: 'Kebutuhan Data Batu',
      ),
      const SideNavigationBarItem(
        icon: Icons.verified,
        label: 'Status Approval',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'Monitoring Per Siklus',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      ),
    ];
  }

  listEka() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard',
      ),
      const SideNavigationBarItem(
        icon: Icons.list_alt,
        label: 'List form designer',
      ),
      const SideNavigationBarItem(
        icon: Icons.list,
        label: 'List stok batu',
      ),
      const SideNavigationBarItem(
        icon: Icons.bar_chart_sharp,
        label: 'Kebutuhan Data Batu',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'Monitoring Per Siklus',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      ),
    ];
  }

  listFuji() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard',
      ),
      const SideNavigationBarItem(
        icon: Icons.calculate_outlined,
        label: 'Calculate Price',
      ),
      const SideNavigationBarItem(
        icon: Icons.calculate_outlined,
        label: 'Kalkulator Custom',
      ),
      const SideNavigationBarItem(
        icon: Icons.verified,
        label: 'Status Approval',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      ),
    ];
  }

  listEva() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard',
      ),
      const SideNavigationBarItem(
        icon: Icons.list_alt,
        label: 'List data modeller',
      ),
      const SideNavigationBarItem(
        icon: Icons.list,
        label: 'List stok batu',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'Monitoring Per Siklus',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      ),
    ];
  }
}
