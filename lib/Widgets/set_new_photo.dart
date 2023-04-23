
// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Widgets/user_photo_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/register_cubit.dart';


Widget setNewPhoto({required BuildContext context}) {
  final ImagePicker picker = ImagePicker();
  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      userPhotoAvatar(context: context, size: 90, radius: 70),
      IconButton(
        onPressed: () async {
          BlocProvider.of<RegisterCubit>(context).pickedProfileFile =
              await picker.pickImage(
                  source: ImageSource.gallery, imageQuality: 100);
          BlocProvider.of<RegisterCubit>(context).changeState();
        },
        icon: const Icon(Icons.camera_alt),
        color: Colors.grey,
        iconSize: 40,
      )
    ],
  );
}
