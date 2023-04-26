import 'package:chat_app/Widgets/delete_dialog.dart';
import 'package:chat_app/Widgets/user_photo_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Pages/chat_page.dart';
import '../Utilities/consts.dart';

class ChatsListItem extends StatelessWidget {
  const ChatsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount:
                    snapshot.data != null ? snapshot.data!.docs.length : 10,
                itemBuilder: ((context, index) {
                  String? userName =
                      snapshot.data?.docs[index]['displayName'] ?? 'user';
                  String? userId = snapshot.data?.docs[index]['uid'] ?? 'user';
                  String? userImageURL = snapshot.data?.docs[index]['imageURL'];

                  FirebaseFirestore.instance
                      .collection('chats')
                      .doc('chatsDoc')
                      .collection('chat$userName')
                      .doc('chat')
                      .set({}).then((value) => null);
                  FirebaseFirestore.instance
                      .collection('chats/chatsDoc/chat$userName/chat/messages')
                      .get()
                      .then((QuerySnapshot value) {
                    if (value.size == 0) {
                      FirebaseFirestore.instance
                          .collection(
                              'chats/chatsDoc/chat$userName/chat/messages')
                          .add({
                        'text': 'hello ',
                        'createdAt': DateTime.now(),
                        'userId': '1234'
                      });
                    }
                  });

                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(
                              'chats/chatsDoc/chat$userName/chat/messages')
                          .orderBy('createdAt', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) => DeleteDialog(
                                      data:
                                          'do you want to delete your conversation with $userName',
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .doc('users/$userId')
                                            .delete()
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      },
                                    ));
                          },
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        UserPhotoAvatar(
                                            backgroundImage: userImageURL ==
                                                    null
                                                ? null
                                                : NetworkImage(userImageURL),
                                            size: 30,
                                            radius: 45),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "$userName",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(snapshot.data != null
                                                  ? "${snapshot.data?.docs.last['text']}"
                                                  : " "),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              DateFormat('hh-mm a').format(
                                                  snapshot.data?.docs
                                                          .last['createdAt']
                                                          .toDate() ??
                                                      DateTime.now()),
                                              style: TextStyle(
                                                  color: ksecondaryColor),
                                            ),
                                            snapshot.data?.docs
                                                        .last['userId'] !=
                                                    currentUserId
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.deepPurple[300],
                                                    radius: 10,
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                        const SizedBox(width: 30,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }));
          }
        });
  }
}
