// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chat_app/Utilities/consts.dart';
import 'package:chat_app/Widgets/user_photo_avatar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/register_cubit.dart';

class SetNewPhoto extends StatefulWidget {
  const SetNewPhoto({super.key});

  @override
  State<SetNewPhoto> createState() => _SetNewPhotoState();
}

class _SetNewPhotoState extends State<SetNewPhoto> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        UserPhotoAvatar(
          size: 90,
          radius: 70,
          backgroundImage:
              BlocProvider.of<RegisterCubit>(context).pickedProfileFile == null
                  ? null
                  : FileImage(File(BlocProvider.of<RegisterCubit>(context)
                      .pickedProfileFile!
                      .path)),
        ),
        IconButton(
          onPressed: () async {
            BlocProvider.of<RegisterCubit>(context).pickedProfileFile =
                await picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 100);
            setState(() {});
            final Reference ref = FirebaseStorage.instance
                .ref()
                .child('userImage')
                .child('$currentUserId.jpg');
            await ref.putFile(File(BlocProvider.of<RegisterCubit>(context)
                .pickedProfileFile!
                .path));
            imageURL = await ref.getDownloadURL();
            setState(() {});
          },
          icon: const Icon(Icons.camera_alt),
          color: Colors.grey,
          iconSize: 30,
        )
      ],
    );
  }
}
