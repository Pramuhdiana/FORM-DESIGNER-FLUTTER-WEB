// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/pembelian/home_pembelian.dart';
import 'package:form_designer/qc/mainScreen/home_qc.dart';
import 'package:form_designer/qc/mainScreen/list_form_pr_qc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

// ignore: must_be_immutable
class MainViewQc extends StatefulWidget {
  //fungsi untuk menerima data
  int col = 0;
  final VoidCallback? onBackPressed;
  //init data
  MainViewQc({super.key, required this.col, this.onBackPressed});

  @override
  // ignore: library_private_types_in_public_api
  _MainViewQcState createState() => _MainViewQcState();
}

class _MainViewQcState extends State<MainViewQc> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> screenAtik = [
    const HomeScreenQc(),
    const ListFormPrQc(),
    const HomeScreenQc()
  ];
  List<Widget> screenNugraha = [
    const HomeScreenPembelian(),
    const HomeScreenPembelian(),
  ];

  bool isKodeAkses = false;
  TextEditingController kodeAkses = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //method multi screen
      body: LayoutBuilder(
        builder: (context, constraints) {
          return screenDekstop();
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
              image: const CircleAvatar(
                child: Icon(Icons.person_2_outlined),
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
          selectedIndex: widget.col,
          items: sharedPreferences!.getString('role') == '0'
              ? listAtik()
              : listNugraha(),

          onTap: (index) {
            if (sharedPreferences!.getString('role') == '0') {
              if (index == screenAtik.length - 1) {
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
            } else {
              if (index == screenNugraha.length - 1) {
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
          child: screenAtik.elementAt(widget.col),
        )
      ],
    );
  }

  listAtik() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard',
      ),
      const SideNavigationBarItem(
        icon: Icons.list_alt,
        label: 'List Form PR',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      ),
    ];
  }

  listNugraha() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      ),
    ];
  }
}
