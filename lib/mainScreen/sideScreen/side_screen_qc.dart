// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:form_designer/global/global.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/login.dart';
import 'package:form_designer/qc/mainScreen/list_batu_qc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

// ignore: must_be_immutable
class MainViewQc extends StatefulWidget {
  //fungsi untuk menerima data
  int col = 0;
  //init data
  MainViewQc({super.key, required this.col});

  @override
  // ignore: library_private_types_in_public_api
  _MainViewQcState createState() => _MainViewQcState();
}

class _MainViewQcState extends State<MainViewQc> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> views = [
    const HomeScreen(),
    const ListBatuQc(),
    const HomeScreen(),
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
          items: const [
            SideNavigationBarItem(
              icon: Icons.home,
              label: 'Dashboard',
            ),
            SideNavigationBarItem(
              icon: Icons.add_card_sharp,
              label: 'Add Batu',
            ),
            SideNavigationBarItem(
              icon: Icons.logout,
              label: 'Keluar',
            ),
          ],

          onTap: (index) {
            print(index);
            print(sharedPreferences!.getString('level'));
            if (index == 2) {
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
            } else if (index == 3) {
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
                                        if (_formKey.currentState!.validate()) {
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
          child: views.elementAt(widget.col),
        )
      ],
    );
  }
}
