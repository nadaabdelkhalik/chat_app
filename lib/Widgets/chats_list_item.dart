import 'package:chat_app/Widgets/user_photo_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Pages/chat_page.dart';
import '../Utilities/consts.dart';

Widget chatsListItem({required BuildContext context}) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data != null ? snapshot.data!.docs.length : 10,
            itemBuilder: ((context, index) {
              String? userName =
                  snapshot.data?.docs[index]['displayName'] ?? 'user';
              String? userId = snapshot.data?.docs[index]['uid'] ?? 'user';

              FirebaseFirestore.instance
                  .collection('chats')
                  .doc('chatsDoc')
                  .collection('chat$userName')
                  .doc('chat')
                  .set({}).then((value) => null);

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ChatPage(
                          userName: userName ?? '',
                          userId: userId ?? '',
                        )),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
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
                                    "$userName",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const Text(""),
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
                             userId!=currentUserId?   CircleAvatar(
                                  backgroundColor: Colors.deepPurple[300],
                                  radius: 10,
                                ):const SizedBox(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
      });
}
