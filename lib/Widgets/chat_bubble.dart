import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Utilities/consts.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.userName,
  });
  final String userName;

  @override
  Widget build(BuildContext context) {
    late bool isMe = true;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
              'chats/chatsDoc/chat$userName/chat/messages',
            )
            .orderBy('createdAt', descending: false)
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
              itemCount:
                  snapshot.data == null ? 10 : snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                isMe = currentUserId == snapshot.data?.docs[index]['userId'];
                return Align(
                  alignment:
                      isMe ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(30),
                            topRight: const Radius.circular(30),
                            bottomRight: isMe
                                ? const Radius.circular(30)
                                : const Radius.circular(0),
                            bottomLeft: !isMe
                                ? const Radius.circular(30)
                                : const Radius.circular(0)),
                        color: isMe ? kprimaryColor : ksecondaryColor),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data?.docs[index]['text'] ?? 'hi',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
  }
}
