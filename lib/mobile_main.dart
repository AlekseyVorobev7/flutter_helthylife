import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nou/main_tasks.dart';

import 'mobile_profile.dart';

class MobileMainScreen extends StatefulWidget {
  const MobileMainScreen({super.key});

  @override
  State<MobileMainScreen> createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen> {
  var firstname;
  bool is_first_task = false;
  bool is_second_task = false;
  String uid = ' ';
  int  complete_task = 0;
  int balanc = 0;
  double _water = 0;
  bool is_first_task_done = false;

  _fetch1() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((sn) {
        Map<String, dynamic> data = sn.data() as Map<String, dynamic>;
        firstname = data['first name'];
        is_first_task = data['is first task'];
        is_second_task = data['is second task'];
        complete_task = data['complete tasks'];
        balanc = data['balanc'];
      });
      is_first_task_done = is_first_task;
    }
  }
  @override
  void initState() {
    super.initState();
    _fetch1();
  }

  void _complite_water_task() {
    setState(() {
      is_first_task = true;
      is_first_task_done = true;
    });
    is_first_task = true;
    is_first_task_done = true;
    balanc += 100;
    complete_task += 1;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid).update({
      'is first task': true,
      'balanc' : balanc,
      'complete tasks': complete_task,
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 47, 34, 88),
            elevation: 0,
            centerTitle: true,
            title: const Flexible(
              child: AutoSizeText(
                'Healthy Life',
                minFontSize: 2,
                maxLines: 1,
                maxFontSize: 40,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 216, 81, 240),
                Color.fromARGB(255, 142, 30, 161),
                Color.fromARGB(255, 7, 28, 219)
              ]),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: GNav(
              gap: 8,
              color: Colors.white,
              activeColor: Colors.white,
              tabs: [
                const GButton(
                  icon: Icons.home,
                  text: "Главная",
                ),
                const GButton(
                  icon: Icons.task_rounded,
                  text: "Задачи",
                ),
                GButton(
                  icon: Icons.man,
                  text: "Профиль",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MobileProfileScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: FutureBuilder(
                  future: _fetch1(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return AutoSizeText(
                        'Добрый день $firstname!',
                        minFontSize: 8,
                        maxFontSize: 40,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      );
                    }
                    return const AutoSizeText(
                      "Загрузка...",
                      maxFontSize: 18,
                      minFontSize: 8,
                      maxLines: 1,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: AutoSizeText(
                  'Задачи на день',
                  minFontSize: 8,
                  maxFontSize: 40,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple,  Colors.deepPurple],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        // ignore: prefer_const_constructors
                        Align(
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                            child: AutoSizeText(
                              'Выпей 2 литра воды за день',
                              maxFontSize: 22,
                              minFontSize: 8,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Font Awesome 5 Brands',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: AutoSizeText(
                            '$_water литра / 2 литров',
                            maxLines: 1,
                            maxFontSize: 18,
                            minFontSize: 6,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Font Awesome 5 Brands',
                            ),
                          ),
                        ),
                        Slider(
                          thumbColor: Colors.black,
                          inactiveColor: Colors.transparent,
                          activeColor: Colors.black,
                          value: _water,
                          max: 2,
                          divisions: 4,
                          onChanged: is_first_task_done ? null : (double value) {
                            setState(
                                  () {
                                _water = value;
                                if (_water == 2.0) {
                                  is_first_task_done = true;
                                } else {
                                  is_first_task_done = false;
                                }
                              },
                            );
                          },
                        ),
                        Visibility(
                          visible: !is_first_task && is_first_task_done,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                            child: OutlinedButton(
                              onPressed:  _complite_water_task,
                              style: OutlinedButton.styleFrom(
                                elevation: 0,
                                minimumSize: const Size(200, 45),
                                backgroundColor: const Color.fromARGB(255, 59, 238, 65),
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                                //padding: const EdgeInsets.all(15),
                                // ignore: prefer_const_constructor
                              ),
                              child: const Text(
                                'Забрать награду',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
