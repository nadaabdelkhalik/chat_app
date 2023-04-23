import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Utilities/consts.dart';

Widget chatBubbleList({required BuildContext context}) => StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('chats/tv6pNtVSns6qWgQTtYr1/messages')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(
            color: ksecondaryColor,
          ),
        );
      }
      return ListView.builder(
          itemCount: snapshot.data == null ? 10 : snapshot.data!.docs.length,
          itemBuilder: ((context, index) => Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: kprimaryColor),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    snapshot.data?.docs[index]['text']??'hi',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )));
    });
