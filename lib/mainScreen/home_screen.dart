import 'package:flutter/material.dart';
import 'package:form_designer/global/global.dart';

import '../widgets/drawer_1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: null_check_always_fails
      onWillPop: () async => null!,
      child: Scaffold(
        drawer: Drawer1(),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(sharedPreferences!.getString('nama')!),
        ),
      ),
    );
  }
}
