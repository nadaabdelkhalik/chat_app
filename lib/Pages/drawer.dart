// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/login_cubit.dart';
import '../Bloc/register_cubit.dart';
import '../Utilities/consts.dart';
import '../Widgets/set_new_photo.dart';
import 'login_page.dart';

Drawer drawer({required BuildContext context}) {
  final ImagePicker picker = ImagePicker();
  return Drawer(
    child: ListView(children: [
      const SizedBox(
        height: 50,
      ),
       const Center(child: SetNewPhoto()),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("WallPaper"),
                      IconButton(
                          onPressed: () async {
                            BlocProvider.of<RegisterCubit>(context)
                                    .pickedBackGroundFile =
                                await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100);
                            BlocProvider.of<RegisterCubit>(context)
                                .changeState();
                          },
                          icon: const Icon(
                            Icons.wallpaper,
                            size: 40,
                            color: kprimaryColor,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Log Out"),
                      IconButton(
                          onPressed: () {
                            firebaseInstance.signOut().then((value) {
                             currentUserId = '';
                              BlocProvider.of<RegisterCubit>(context)
                                  .clearingData();
                              BlocProvider.of<LoginCubit>(context)
                                  .clearingData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => LoginPage()),
                                ),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.logout,
                            size: 40,
                            color: kprimaryColor,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}
