import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nou/User.dart';
import 'package:nou/get_top_users.dart';

import 'package:nou/mobile_main.dart';
import 'package:nou/route_after_login.dart';

class MobileProfileScreen extends StatefulWidget {
  const MobileProfileScreen({super.key});

  @override
  State<MobileProfileScreen> createState() => _MobileProfileScreenState();
}

class _MobileProfileScreenState extends State<MobileProfileScreen> {
  String avatarPath = 'assets/images/avatar.png';
  var money;
  var tasks;
  var firstname;
  var secondname;
  var school;
  Set<String> docsId = {};

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('balanc', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              docsId.add(document.reference.id);
            }));
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((sn) {
        Map<String, dynamic> data = sn.data() as Map<String, dynamic>;
        firstname = data['first name'];
        secondname = data['second name'];
        school = data['scholl'];
        money = data['balanc'];
        tasks = data['complete tasks'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDocId();
    _fetch();
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
                'Профиль',
                minFontSize: 2,
                maxLines: 1,
                maxFontSize: 40,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(avatarPath), fit: BoxFit.scaleDown),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.deepPurple,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: FutureBuilder(
                        future: _fetch(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AutoSizeText(
                              "$firstname $secondname",
                              maxFontSize: 18,
                              minFontSize: 8,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: FutureBuilder(
                        future: _fetch(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            return AutoSizeText(
                              'Из "$school"',
                              maxFontSize: 18,
                              minFontSize: 8,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
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
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(26, 10, 10, 10),
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                          child: AutoSizeText(
                            'Выполнено задач',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: FutureBuilder(
                            future: _fetch(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.done){
                                return AutoSizeText(
                                  '$tasks',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
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
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                          child: AutoSizeText(
                            'Баланс',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: FutureBuilder(
                            future: _fetch(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.done){
                                return AutoSizeText(
                                  '$money',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
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
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: const AutoSizeText(
                  "ТОП пользователей",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 500,
                ), // **THIS is the important part**
                child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: docsId.length > 5 ? 5: docsId.length,
                        itemBuilder: (context, index) {
                          return GetUserInfo(docId: docsId.elementAt(index), place: index+1,);
                        });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Route_login();
                  }));
                },
                child: AutoSizeText("Выйти из аккаунта"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
