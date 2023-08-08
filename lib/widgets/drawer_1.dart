import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/calculate_pricing.dart';
import 'package:form_designer/mainScreen/form_screen.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_batu_screen.dart';
import '../mainScreen/list_designer_screen.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class Drawer1 extends StatelessWidget {
  Image img = Image.asset('images/login.png');
  bool isKodeAkses = false;
  TextEditingController kodeAkses = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Transform.scale(
            scale: 0.7,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "data:image/jpeg;base64,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",
                    ),
                  )),
              child: Text(
                ' ',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const HomeScreen()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('List form designer'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const ListDesignerScreen()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_outlined),
            title: const Text('Tambah form designer'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const FormScreen()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_sharp),
            title: const Text('Tambah stok batu'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const ListBatuScreen()))
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.developer_mode_outlined),
          //   title: const Text('Tambah stok batu'),
          //   onTap: () => {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (c) => ProfileScreen()))
          //   },
          // ),
          Container(
            color: Colors.red,
            child: ListTile(
              leading: const Icon(Icons.calculate_outlined),
              title: const Text('Calculate Price'),
              onTap: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
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
                              height: 160,
                              child: Form(
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
                                          kodeAkses.text = '';
                                          isKodeAkses == false
                                              ? Navigator.pop(context)
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (c) =>
                                                          const CalculateScreen()));
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
                    })
              },
            ),
          ),
        ],
      ),
    );
  }
}
