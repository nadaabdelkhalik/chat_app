import 'dart:io';

import 'package:chat_app/Bloc/register_cubit.dart';
import 'package:chat_app/Bloc/register_states.dart';
import 'package:chat_app/Utilities/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/chat_bubble.dart';

import '../Widgets/text_field.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.userName, required this.userId});
  final ImagePicker picker = ImagePicker();
  final String userName;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image:
                BlocProvider.of<RegisterCubit>(context).pickedBackGroundFile ==
                        null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(BlocProvider.of<RegisterCubit>(context)
                              .pickedBackGroundFile!
                              .path),
                        ),
                      ),
          ),
          child: Column(
            children: [
              Expanded(
                  child: ChatBubble(
                userName: userName,
                
              )),
              SizedBox(
                height: 70,
                child: textField(
                    hintText: "Message",
                    suffix: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: IconButton(
                          onPressed: (() async {
                            BlocProvider.of<RegisterCubit>(context).pickedFile =
                                await picker
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 100)
                                    .then((value) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .changeState();
                              return null;
                            });
                          }),
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[500],
                            size: 30,
                          )),
                    ),
                    controller: BlocProvider.of<RegisterCubit>(context)
                        .messagesController,
                    suffixIcon: Icons.send,
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('chats/chatsDoc/chat$userName/chat/messages')
                          .add({
                        'text': BlocProvider.of<RegisterCubit>(context)
                            .messagesController
                            .text,
                        'createdAt': DateTime.now(),
                        
                        'userId':currentUserId
                      });

                      BlocProvider.of<RegisterCubit>(context)
                          .messagesController
                          .clear();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
