import 'package:flutter/material.dart';

import '../login/login_dekstop.dart';
import '../login/login_mobile.dart';
import '../login/login_tablet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: null_check_always_fails
      onWillPop: () async => null!,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return const LoginMobile();
            } else if (constraints.maxWidth > 600 &&
                constraints.maxWidth < 900) {
              // return const LoginTablet();
              return const LoginDesktop();
            } else {
              return const LoginDesktop();
            }
          },
        ),
      ),
    );
  }
}
