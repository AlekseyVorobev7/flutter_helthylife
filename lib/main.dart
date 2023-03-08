import 'package:flutter/material.dart';
import 'package:nou/dektop_main.dart';
import 'package:nou/desktop_LogIn.dart';
import 'package:nou/mobile_logIn.dart';
import 'package:nou/mobile_main.dart';
import 'package:nou/resposive_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nou/route_after_login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        desktopScreen: DesktopLogInScreen(),
        mobileScreen: Route_login(),
      ),
    );
  }
}