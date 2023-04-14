import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hls/Tasks.dart';
import 'package:hls/data.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<StatefulWidget> createState() => _TasksScreen();
}

class _TasksScreen extends State<TasksScreen> {
  List<int> indexes = [];
  List<Tasks> tasks = [];
  String textdone = "";
  String is_third_done = "none";
  String is_fourt_done = "none";
  String is_fith_done = "none";
  String is_six_done = "none";
  int complete_task = 0;
  int balanc = 0;
  String date = "";
  _fetch2() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((sn) {
        Map<String, dynamic> data = sn.data() as Map<String, dynamic>;
        setState(() {
          is_third_done = data['is third task'];
          is_fourt_done = data['is fourth task'];
          is_fith_done = data['is fith task'];
          is_six_done = data['is six task'];
        });
        complete_task = data['complete tasks'];
        balanc = data['balanc'];
        List<int> temp = List.from(data['tasks']);
        indexes = temp;
        setState(() {
          tasks = getTasks(indexes);
        });

        print(indexes.toString());
      });
    }
  }

  List<Tasks> getTasks(List<int> index) {
    var doc = data;
    index.sort();
    List<dynamic> added = [];
    for (var x in index) {
      for (var y in doc) {
        if (x == y['id']) {
          added.add(y);
        }
      }
    }
    //print(added);
    return added.map<Tasks>(Tasks.fromJson).toList();
  }

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    date = DateFormat("d.MM.y").format(dateTime);
    _fetch2();
  }

  bool get_forTask(int index, String time) {
    String to_add = "";
    print(time);
    if (tasks[index].time_start.compareTo(time) > 0 ||
        tasks[index].time_end.compareTo(time) < 0) {
      tasks.removeAt(index);
      return false;
    }
    if (index == 0) {
      to_add = "is third task";
    }
    if (index == 1) {
      to_add = "is fourth task";
    }
    if (index == 2) {
      to_add = "is fith task";
    }
    if (index == 3) {
      to_add = "is six task";
    }
    balanc += 50;
    complete_task += 1;
    final firebaseUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser?.uid)
        .update({
      to_add: "true",
      'balanc': balanc,
      'complete tasks': complete_task,
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.black,
        elevation: 1,
        title: AutoSizeText(
          date,
          style: const TextStyle(
            fontFamily: 'Font Awesome 5 Brands',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              String goal = "none";
              if (index == 0) {
                goal = is_third_done;
              }
              if (index == 1) {
                goal = is_fourt_done;
              }
              if (index == 2) {
                goal = is_fith_done;
              }
              if (index == 3) {
                goal = is_six_done;
              }
              return Visibility(
                visible: goal == "true" ? false : true,
                child: Container(
                  margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: goal != "true"
                        ? Color.fromARGB(255, 56, 206, 61)
                        : Colors.transparent,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      AutoSizeText(task.taskTitle,
                          style: TextStyle(
                              color: goal == "true"
                                  ? Colors.transparent
                                  : Colors.white)),
                      SizedBox(
                        height: 10,
                      ),
                      AutoSizeText('C ${task.time_start} до ${task.time_end}',
                          style: TextStyle(
                              color: goal == "true"
                                  ? Colors.transparent
                                  : Colors.white)),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor: goal == "true"
                              ? Colors.transparent
                              : Colors.white,
                        ),
                        onPressed: () {
                          if (goal != "true") {
                            bool status = get_forTask(index,
                                DateFormat("HH.mm").format(DateTime.now()));
                            if (index == 0 && status) {
                              setState(() {
                                is_third_done = "true";
                              });
                            }
                            if (index == 1 && status) {
                              setState(() {
                                is_fourt_done = "true";
                              });
                            }
                            if (index == 2 && status) {
                              setState(() {
                                is_fith_done = "true";
                              });
                            }
                            if (index == 3 && status) {
                              setState(() {
                                is_six_done = "true";
                              });
                            }
                          }
                        },
                        child: AutoSizeText("Выполнить",
                            style: TextStyle(
                                color: goal == "true"
                                    ? Colors.transparent
                                    : Colors.black)),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
