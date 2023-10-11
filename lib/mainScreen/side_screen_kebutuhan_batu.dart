// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:form_designer/SCM/mainScreen/kebutuhan_batu_by_siklus.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_batu_screen.dart';
import 'package:form_designer/mainScreen/list_designer_screen.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/mainScreen/list_status_approval.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_navigation/side_navigation.dart';

import '../calculatePricing/list_calculate_pricing_screen.dart';
import '../global/global.dart';
import 'login.dart';

class MainViewKebutuhanBatu extends StatefulWidget {
  const MainViewKebutuhanBatu({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainViewKebutuhanBatuState createState() => _MainViewKebutuhanBatuState();
}

class _MainViewKebutuhanBatuState extends State<MainViewKebutuhanBatu> {
  List<Widget> views = [
    //? 0
    const HomeScreen(),
    //? 1
    sharedPreferences!.getString('level') == '4'
        ? const ListBatuScreen() //* produksi
        : sharedPreferences!.getString('level') == '3'
            ? const ListBatuScreen() //* modeller
            : const ListDesignerScreen(),
    //? 2
    sharedPreferences!.getString('level') == '4'
        ? const ListMpsScreen() //* produksi
        : const ListBatuScreen(),
    //? 3
    sharedPreferences!.getString('level') == '4'
        ? const ListMpsScreen() //* produksi
        : const ListCalculatePricingScreen(),
    //? 4
    const ListKebutuhanBatuScreen(),
    //? 5
    const ListStatusApprovalScreen(),
    //? 6
    const ListMpsScreen(),
    //! keluar untuk scm dan admin
    const HomeScreen()
  ];

  final _formKey = GlobalKey<FormState>();

  int selectedIndex = 4;
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
          initiallyExpanded: true,
          selectedIndex: selectedIndex,
          items: [
            const SideNavigationBarItem(
              icon: Icons.home,
              label: 'Dashboard',
            ),
            if (sharedPreferences!.getString('level') == '1' ||
                sharedPreferences!.getString('level') == '2')
              const SideNavigationBarItem(
                icon: Icons.list_alt,
                label: 'List form designer',
              ),
            const SideNavigationBarItem(
              icon: Icons.list,
              label: 'List stok batu',
            ),
            if (sharedPreferences!.getString('level') == '1' ||
                sharedPreferences!.getString('level') == '2')
              const SideNavigationBarItem(
                icon: Icons.calculate_outlined,
                label: 'Calculate Price',
              ),
            if (sharedPreferences!.getString('level') == '1')
              const SideNavigationBarItem(
                icon: Icons.bar_chart_sharp,
                label: 'Kebutuhan Data Batu',
              ),
            if (sharedPreferences!.getString('level') == '1')
              const SideNavigationBarItem(
                icon: Icons.verified,
                label: 'Status Approval',
              ),
            if (sharedPreferences!.getString('level') == '1' ||
                sharedPreferences!.getString('level') == '4')
              const SideNavigationBarItem(
                icon: Icons.moving_outlined,
                label: 'Monitoring Per Siklus',
              ),
            const SideNavigationBarItem(
              icon: Icons.logout,
              label: 'Keluar',
            ),
          ],

          onTap: (index) {
            print(index);
            print(sharedPreferences!.getString('level'));
            if (index == 7) {
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
            } else if (index == 3 &&
                sharedPreferences!.getString('level') == '4') {
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
            } else if (index == 2 &&
                sharedPreferences!.getString('level') == '3') {
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
            } else if (index == 3 &&
                (sharedPreferences!.getString('level') == '1' ||
                    sharedPreferences!.getString('level') == '2')) {
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
            } else if (index == 4 &&
                sharedPreferences!.getString('level') == '2') {
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
          items: [
            const SideNavigationBarItem(
              icon: Icons.home,
              label: 'Dashboard',
            ),
            if (sharedPreferences!.getString('level') == '1' ||
                sharedPreferences!.getString('level') == '2')
              const SideNavigationBarItem(
                icon: Icons.list_alt,
                label: 'List form designer',
              ),
            const SideNavigationBarItem(
              icon: Icons.list,
              label: 'List stok batu',
            ),
            if (sharedPreferences!.getString('level') == '1' ||
                sharedPreferences!.getString('level') == '2')
              const SideNavigationBarItem(
                icon: Icons.calculate_outlined,
                label: 'Calculate Price',
              ),
            if (sharedPreferences!.getString('level') == '1')
              const SideNavigationBarItem(
                icon: Icons.bar_chart_sharp,
                label: 'Kebutuhan Data Batu',
              ),
            if (sharedPreferences!.getString('level') == '1')
              const SideNavigationBarItem(
                icon: Icons.verified,
                label: 'Status Approval',
              ),
            if (sharedPreferences!.getString('level') == '1' ||
                sharedPreferences!.getString('level') == '4')
              const SideNavigationBarItem(
                icon: Icons.moving_outlined,
                label: 'Monitoring Per Siklus',
              ),
            const SideNavigationBarItem(
              icon: Icons.logout,
              label: 'Keluar',
            ),
          ],

          onTap: (index) {
            print(index);
            print(sharedPreferences!.getString('level'));
            if (index == 7) {
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
            } else if (index == 3 &&
                sharedPreferences!.getString('level') == '4') {
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
            } else if (index == 2 &&
                sharedPreferences!.getString('level') == '3') {
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
            } else if (index == 3 &&
                (sharedPreferences!.getString('level') == '1' ||
                    sharedPreferences!.getString('level') == '2')) {
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
            } else if (index == 4 &&
                sharedPreferences!.getString('level') == '2') {
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
    );
  }
}
