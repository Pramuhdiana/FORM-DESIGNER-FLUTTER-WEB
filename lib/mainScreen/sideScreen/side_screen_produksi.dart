// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/produksi/mainScreen/dashboard_control.dart';
import 'package:form_designer/produksi/mainScreen/produksi_new_screen.dart';
import 'package:form_designer/produksi/mainScreen/report_untuk_manufaktur.dart';
import 'package:form_designer/produksi/mainScreen/report_untuk_scm.dart';
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
  List<Widget> views = [
    //? 0
    const ReportUntukSCM(),
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
    const ReportUntukSCM(),
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
          footer: const SideNavigationBarFooter(
              label: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              '© Copyright PT Cahaya Sani Vokasi. All Rights Reserved',
              style: TextStyle(color: Colors.white),
            ),
          )),
          initiallyExpanded: true,
          selectedIndex: selectedIndex,
          items: const [
            SideNavigationBarItem(
              icon: Icons.home,
              label: 'Monthly Meeting SCM',
            ),
            SideNavigationBarItem(
              icon: Icons.home,
              label: 'Manufaktur Review',
            ),
            SideNavigationBarItem(
              icon: Icons.home,
              label: 'Dashboard Control',
            ),
            SideNavigationBarItem(
              icon: Icons.format_align_right_outlined,
              label: 'Produksi',
            ),
            SideNavigationBarItem(
              icon: Icons.moving_outlined,
              label: 'MPS',
            ),
            SideNavigationBarItem(
              icon: Icons.list_alt_outlined,
              label: 'Summary Susut',
            ),
            SideNavigationBarItem(
              icon: Icons.sticky_note_2_rounded,
              label: 'Summary Pasang Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.format_align_center,
              label: 'Summary Produktivitas',
            ),
            SideNavigationBarItem(
              icon: Icons.logout,
              label: 'Keluar',
            ),
          ],

          onTap: (index) {
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
          child: views.elementAt(selectedIndex),
        )
      ],
    );
  }

  //screen mobile
  screenMobile() {
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
          footer: const SideNavigationBarFooter(
              label: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child:
                Text('© Copyright PT Cahaya Sani Vokasi. All Rights Reserved'),
          )),
          initiallyExpanded: false,
          selectedIndex: selectedIndex,
          items: const [
            SideNavigationBarItem(
              icon: Icons.home,
              label: 'Dashboard',
            ),
            SideNavigationBarItem(
              icon: Icons.list,
              label: 'List stok batu',
            ),
            SideNavigationBarItem(
              icon: Icons.bar_chart_sharp,
              label: 'MPS',
            ),
            SideNavigationBarItem(
              icon: Icons.moving_outlined,
              label: 'Summary Susut',
            ),
            SideNavigationBarItem(
              icon: Icons.logout,
              label: 'Keluar',
            ),
          ],

          onTap: (index) {
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
            backgroundColor: Colors.grey.shade600,
            itemTheme: SideNavigationBarItemTheme(
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.black,
                iconSize: 32.5,
                labelTextStyle: const TextStyle(
                    fontSize: 15,
                    // !! Won't work !! Custom text style colors gets overridden
                    // by unselectedItemColor and selectedItemColor
                    color: Colors.black)),
            togglerTheme: const SideNavigationBarTogglerTheme(
                shrinkIconColor: Colors.white),
            dividerTheme: SideNavigationBarDividerTheme.standard(),
          ),
        ),
        Expanded(
          child: views.elementAt(selectedIndex),
        )
      ],
    );
  }
}
