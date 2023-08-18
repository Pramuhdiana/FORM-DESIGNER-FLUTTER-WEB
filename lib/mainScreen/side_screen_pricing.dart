import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_batu_screen.dart';
import 'package:form_designer/mainScreen/list_designer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

import '../calculatePricing/list_calculate_pricing_screen.dart';
import 'login.dart';

class MainViewPricing extends StatefulWidget {
  const MainViewPricing({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainViewPricingState createState() => _MainViewPricingState();
}

class _MainViewPricingState extends State<MainViewPricing> {
  List<Widget> views = const [
    HomeScreen(),
    ListDesignerScreen(),
    ListBatuScreen(),
    ListCalculatePricingScreen(),
  ];
  final _formKey = GlobalKey<FormState>();

  int selectedIndex = 3;
  bool isKodeAkses = false;
  TextEditingController kodeAkses = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideNavigationBar(
            selectedIndex: selectedIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.home,
                label: 'Dashboard',
              ),
              SideNavigationBarItem(
                icon: Icons.list_alt,
                label: 'List form designer',
              ),
              SideNavigationBarItem(
                icon: Icons.list,
                label: 'List stok batu',
              ),
              SideNavigationBarItem(
                icon: Icons.calculate_outlined,
                label: 'Calculate Price',
              ),
              SideNavigationBarItem(
                icon: Icons.logout,
                label: 'Keluar',
              ),
            ],
            onTap: (index) {
              if (index == 3) {
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
                                          if (value! != 'S@niv0kasi') {
                                            return 'Kode akses salah';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          isKodeAkses = true;
                                          kodeAkses.text == 'S@niv0kasi'
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
                                              selectedIndex = index;
                                              Navigator.of(context).pop();
                                            });
                                          } else {}
                                          // kodeAkses.text = '';
                                          // isKodeAkses == false
                                          //     ? Navigator.pop(context)
                                          //     : setState(() {
                                          //         selectedIndex = index;
                                          //         Navigator.of(context).pop();
                                          //       });
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
              backgroundColor: Colors.blue,
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
      ),
    );
  }
}
