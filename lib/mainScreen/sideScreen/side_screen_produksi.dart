// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/produksi/mainScreen/dashboard_control.dart';
import 'package:form_designer/produksi/mainScreen/monthly_meeting_scm.dart';
import 'package:form_designer/produksi/mainScreen/produksi_new_screen.dart';
import 'package:form_designer/produksi/mainScreen/report_untuk_manufaktur.dart';
import 'package:form_designer/produksi/mainScreen/summary_pasang_batu.dart';
import 'package:form_designer/produksi/mainScreen/summary_produktivitas.dart';
import 'package:form_designer/produksi/mainScreen/summary_susut.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

class MainViewProduksi extends StatefulWidget {
  const MainViewProduksi({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainViewProduksiState createState() => _MainViewProduksiState();
}

class _MainViewProduksiState extends State<MainViewProduksi> {
  List<Widget> screenElan = [
    //? 0
    const MonthlyMeetingScm(),
    //? 1
    const ReportUntukManufaktur(),
    //? 2
    const DashboardControl(),
    //? 3
    const ProduksiNewScreen(),
    //? 4
    const ListMpsScreen(),
    //? 5
    const SummarySusutScreen(),
    //? 6
    const SummaryPasangBatuScreen(),
    //? 7
    const SummaryProduktivitasScreen(),
    //? 8
    const MonthlyMeetingScm(),
  ];
  List<Widget> screenAyu = [
    const DashboardControl(),
    const ListMpsScreen(),
    const DashboardControl(),
  ];
  List<Widget> screenSisi = [
    const DashboardControl(),
    const ListMpsScreen(),
    const DashboardControl(),
  ];
  List<Widget> screenRiska = [
    const DashboardControl(),
    const ListMpsScreen(),
    const DashboardControl(),
  ];

  List<Widget> screenTriSartika = [
    const MonthlyMeetingScm(),
    const ReportUntukManufaktur(),
    const DashboardControl(),
    const ListMpsScreen(),
    const DashboardControl(),
  ];

  // final _formKey = GlobalKey<FormState>();

  int selectedIndex = 0;
  bool isKodeAkses = false;
  TextEditingController kodeAkses = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //method multi screen
      body: LayoutBuilder(
        builder: (context, constraints) {
          // if (constraints.maxWidth < 900) {
          //   return screenMobile();
          // } else {
          return screenDekstop();
          // }
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
          items: sharedPreferences!.getString('role') == '5'
              ? listRiska()
              : sharedPreferences!.getString('role') == '4'
                  ? listSisi()
                  : sharedPreferences!.getString('role') == '3'
                      ? listAyu()
                      : sharedPreferences!.getString('role') == '2'
                          ? listTriSartika()
                          : listElan(),

          onTap: (index) {
            if (sharedPreferences!.getString('role') == '1') {
              if (index == 8) {
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
                  selectedIndex = index;
                });
              }
            } else if (sharedPreferences!.getString('role') == '2') {
              if (index == 4) {
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
                  selectedIndex = index;
                });
              }
            } else {
              if (index == 2) {
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
                  selectedIndex = index;
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
            itemTheme: SideNavigationBarItemTheme(
                unselectedItemColor: const Color.fromRGBO(147, 155, 163, 1),
                selectedItemColor: Colors.white,
                unselectedBackgroundColor: colorBG,
                selectedBackgroundColor: colorBG,
                iconSize: 32.5,
                labelTextStyle:
                    const TextStyle(fontSize: 15, color: Colors.red)),
            togglerTheme: const SideNavigationBarTogglerTheme(
                shrinkIconColor: Colors.white),
            dividerTheme: SideNavigationBarDividerTheme.standard(),
            backgroundColor: colorDasar,
          ),
        ),
        Expanded(
          child: sharedPreferences!.getString('role') == '5'
              ? screenRiska.elementAt(selectedIndex)
              : sharedPreferences!.getString('role') == '4'
                  ? screenSisi.elementAt(selectedIndex)
                  : sharedPreferences!.getString('role') == '3'
                      ? screenAyu.elementAt(selectedIndex)
                      : sharedPreferences!.getString('role') == '2'
                          ? screenTriSartika.elementAt(selectedIndex)
                          : screenElan.elementAt(selectedIndex),
        )
      ],
    );
  }

  listElan() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Monthly Meeting SCM',
      ),
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Manufaktur Review',
      ),
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard Control',
      ),
      const SideNavigationBarItem(
        icon: Icons.format_align_right_outlined,
        label: 'Produksi',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'MPS',
      ),
      const SideNavigationBarItem(
        icon: Icons.list_alt_outlined,
        label: 'Summary Susut',
      ),
      const SideNavigationBarItem(
        icon: Icons.sticky_note_2_rounded,
        label: 'Summary Pasang Batu',
      ),
      const SideNavigationBarItem(
        icon: Icons.format_align_center,
        label: 'Summary Produktivitas',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      )
    ];
  }

  listAyu() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard Control',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'MPS',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      )
    ];
  }

  listTriSartika() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Monthly Meeting SCM',
      ),
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Manufaktur Review',
      ),
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard Control',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'MPS',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      )
    ];
  }

  listSisi() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard Control',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'MPS',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      )
    ];
  }

  listRiska() {
    return [
      const SideNavigationBarItem(
        icon: Icons.home,
        label: 'Dashboard Control',
      ),
      const SideNavigationBarItem(
        icon: Icons.moving_outlined,
        label: 'MPS',
      ),
      const SideNavigationBarItem(
        icon: Icons.logout,
        label: 'Keluar',
      )
    ];
  }
}
