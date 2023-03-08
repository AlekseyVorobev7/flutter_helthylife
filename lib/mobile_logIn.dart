// ignore: file_names
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'forgot_password.dart';

class MobileLogInScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const MobileLogInScreen({super.key, required this.showRegisterPage});

  @override
  State<MobileLogInScreen> createState() => _MobileLogInScreenState();
}

class _MobileLogInScreenState extends State<MobileLogInScreen> {
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextInputController.text.trim(),
      password: passwordTextInputController.text.trim(),
    );
    print("QQQQ");
  }

  // @override
  // void dispose()
  // {
  //   emailTextInputController.dispose();
  //   passwordTextInputController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Logo.png"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const AutoSizeText(
                "Вход",
                textAlign: TextAlign.center,
                maxLines: 1,
                minFontSize: 30,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  controller: emailTextInputController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Введите Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: passwordTextInputController,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Введите Пароль',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgotPasswordPage();
                        },
                      ),
                    );
                  },
                  child: const AutoSizeText(
                    "Забыл пароль?",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 15, 50, 5),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: const AutoSizeText(
                      'Войти',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText('Нет аккаунта?'),
                    TextButton(
                      onPressed: null,
                      child: GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: AutoSizeText(
                          "Зарегистрироваться",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
                      style: TextButton.styleFrom(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
