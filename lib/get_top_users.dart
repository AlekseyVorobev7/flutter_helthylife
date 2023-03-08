import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserInfo extends StatelessWidget {
  const GetUserInfo({Key? key, required this.docId, required this.place}) : super(key: key);
  final String docId;
  final int place;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child:  AutoSizeText(
              '$place  ${data['first name']} ${data['second name']} из "${data['scholl']}" - Баланс : ${data['balanc']}',
              textAlign: TextAlign.left,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          );
        }
        return Container(
          decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const AutoSizeText(
            "Загрузка...",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}
