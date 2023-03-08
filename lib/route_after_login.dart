import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nou/mobile_logIn.dart';
import 'package:nou/mobile_main.dart';

import 'auth_page.dart';

class Route_login extends StatefulWidget {
  const Route_login({Key? key}) : super(key: key);

  @override
  State<Route_login> createState() => _Route_loginState();
}

class _Route_loginState extends State<Route_login> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MobileMainScreen();
        } else {
          return  AuthPage();
        }
      },
    );
  }
}
