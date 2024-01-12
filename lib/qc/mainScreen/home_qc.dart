// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/global/global.dart';
// ignore: unused_import
import 'package:form_designer/mainScreen/form_screen_by_id.dart';

class HomeScreenQc extends StatefulWidget {
  const HomeScreenQc({super.key});

  @override
  State<HomeScreenQc> createState() => _HomeScreenQcState();
}

TextEditingController controller = TextEditingController();

class _HomeScreenQcState extends State<HomeScreenQc> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
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

    return WillPopScope(
        // ignore: null_check_always_fails
        onWillPop: () async => null!,
        child: Scaffold(
            backgroundColor: colorBG,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              leadingWidth: 320,
              // ignore: avoid_unnecessary_containers
              title: Container(
                // width: MediaQuery.of(context).size.width * 0.3,
                child: CupertinoSearchTextField(
                  placeholder: 'Search Anything...',
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  itemColor: Colors.black,
                  // autofocus: false,
                  controller: controller,
                  backgroundColor: Colors.black12,
                  // keyboardType: TextInputType.number,
                  // focusNode: numberFocusNode,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width * 1,
              color: colorBG,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 26),
                            child: const Text(
                              'Dashboard QC',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                            ),
                          ),
                        ]),
                  )),
            )));
  }
}
