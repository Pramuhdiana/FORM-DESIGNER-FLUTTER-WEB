// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:form_designer/SCM/mainScreen/kebutuhan_batu_by_siklus.dart';
import 'package:form_designer/SCM/mainScreen/list_scm.dart';
import 'package:form_designer/admin/list_user.dart';
import 'package:form_designer/api/api_constant.dart';
import 'package:form_designer/calculatePricing/list_calculate_pricing_screen.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/home_admin.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_batu_screen.dart';
import 'package:form_designer/mainScreen/list_data_modeller.dart';
import 'package:form_designer/mainScreen/list_designer_screen.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/mainScreen/list_status_approval.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/pembelian/list_form_pr.dart';
import 'package:form_designer/produksi/mainScreen/dashboard_control.dart';
import 'package:form_designer/produksi/mainScreen/monthly_meeting_scm.dart';
import 'package:form_designer/produksi/mainScreen/produksi_new_screen.dart';
import 'package:form_designer/produksi/mainScreen/report_untuk_manufaktur.dart';
import 'package:form_designer/produksi/mainScreen/summary_pasang_batu.dart';
import 'package:form_designer/produksi/mainScreen/summary_produktivitas.dart';
import 'package:form_designer/produksi/mainScreen/summary_susut.dart';
import 'package:form_designer/qc/mainScreen/list_form_pr_qc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

class MainViewAdmin extends StatefulWidget {
  const MainViewAdmin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainViewAdminState createState() => _MainViewAdminState();
}

class _MainViewAdminState extends State<MainViewAdmin> {
  List<Widget> views = [
    //? 0
    const HomeScreenAdmin(),
    const ListUser(),
    const ListDataModellerScreen(),
    const ListBatuScreen(), //* produksi
    const ListDesignerScreen(),
    const ListScmScreen(),
    const ListCalculatePricingScreen(),
    const ListKebutuhanBatuScreen(),
    const ListStatusApprovalScreen(),
    const ListMpsScreen(),
    const ListFormPr(),
    const ListFormPrQc(),
    const MonthlyMeetingScm(),
    const ReportUntukManufaktur(),
    const DashboardControl(),
    const ProduksiNewScreen(),
    const SummarySusutScreen(),
    const SummaryPasangBatuScreen(),
    const SummaryProduktivitasScreen(),
    //! keluar admin
    const HomeScreen()
  ];

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
          if (constraints.maxWidth < 900) {
            return screenMobile();
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
          items: const [
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Dashboard',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List User',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Data Modeller',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Data Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Data Designer',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Data SCM',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Calculator',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Data Kebutuhan Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Status Approval',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'MPS',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Form PR Pembelian',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Form PR QC',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Monthly Meeting SCM',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Report Manufactur',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Dashboard Control',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Daily Produksi',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'SUM Susut',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'SUM Pasang Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'SUM Produktivitas',
            ),
            SideNavigationBarItem(
              icon: Icons.logout,
              label: 'Keluar',
            ),
          ],

          onTap: (index) {
            print('$index = ${views.length - 1}');
            if (index == views.length - 1) {
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
          items: const [
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Dashboard',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Data Modeller',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'List Designer',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Calculator',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Kebutuhan Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Status Approval',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'MPS',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Form PR',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Monthly Meeting SCM',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Report Manufactur',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Dashboard Control',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'Daily Produksi',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'SUM Susut',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'SUM Pasang Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.developer_mode,
              label: 'SUM Produktivitas',
            ),
            SideNavigationBarItem(
              icon: Icons.logout,
              label: 'Keluar',
            ),
          ],

          onTap: (index) {
            if (index == views.length) {
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
          child: views.elementAt(selectedIndex),
        )
      ],
    );
  }
}
