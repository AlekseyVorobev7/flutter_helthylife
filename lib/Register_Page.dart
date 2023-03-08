import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailcontroller = TextEditingController();
  final _passwordlcontroller = TextEditingController();
  final _confirmpasswordlcontroller = TextEditingController();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _schollNameController = TextEditingController();
  final _egeNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordlcontroller.dispose();
    _confirmpasswordlcontroller.dispose();
    _firstNameController.dispose();
    _secondNameController.dispose();
    _schollNameController.dispose();
    _egeNameController.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordlcontroller.text.trim(),
      );
      var fuser = result.user;
      FirebaseFirestore.instance.collection('users').doc(fuser?.uid).set({
        'first name': _firstNameController.text.trim(),
        'second name': _secondNameController.text.trim(),
        'email' : _emailcontroller.text.trim(),
        'scholl': _schollNameController.text.trim(),
        'balanc': 0,
        'complete tasks': 0,
        'class': int.parse(_egeNameController.text.trim()),
        'is first task': false,
        'is second task': false,
        'is third task': false,
        'is fourth task': false,
        'is fith task': false,

      });
    }
  }

  Future addUserDetails(
      String firstname, String secondname, String email, String scholl, int clas) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstname,
      'second name': secondname,
      'email' : email,
      'scholl': scholl,
      'balanc': 0,
      'complete tasks': 0,
      'class': clas,
      'is first task': false,
      'is second task': false,
      'is third task': false,
      'is fourth task': false,
      'is fith task': false,
    });
  }

  bool passwordConfirmed() {
    if (_passwordlcontroller.text.trim() ==
        _confirmpasswordlcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

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
                "Регистрация",
                textAlign: TextAlign.center,
                maxLines: 1,
                minFontSize: 30,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Имя',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  controller: _secondNameController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Фамилия',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  controller: _egeNameController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Класс',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  controller: _schollNameController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Школа',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _passwordlcontroller,
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
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _confirmpasswordlcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Подтвердите Пароль',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 30, 50, 5),
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: const AutoSizeText(
                      'Регистрация',
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
                    const AutoSizeText(
                      'Есть аккаунт?',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: null,
                      style: TextButton.styleFrom(),
                      child: GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const AutoSizeText(
                          "Войти",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
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
