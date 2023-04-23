import 'package:chat_app/Widgets/user_photo_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Bloc/register_cubit.dart';
import '../Pages/chat_page.dart';
import '../Utilities/consts.dart';

Widget chatsListItem({required BuildContext context}) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data != null ? snapshot.data!.docs.length : 10,
            itemBuilder: ((context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => ChatPage()),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            userPhotoAvatar(
                                context: context, size: 30, radius: 45),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data?.docs[index]["username"]}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const Text("How are you today👉🏽💜👈🏽? "),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  DateFormat.yMd().format(DateTime.now()),
                                  style: TextStyle(color: ksecondaryColor),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.deepPurple[300],
                                  radius: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
      });
}
