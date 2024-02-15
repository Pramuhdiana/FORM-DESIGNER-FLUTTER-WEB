import 'package:flutter/material.dart';
import 'package:form_designer/mainScreen/list_designer_screen.dart';
import 'package:form_designer/widgets/side_menu.dart';

class MainDesignerScreen extends StatelessWidget {
  const MainDesignerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: ListDesignerScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
