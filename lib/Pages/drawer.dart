// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/login_cubit.dart';
import '../Bloc/register_cubit.dart';
import '../Utilities/consts.dart';
import '../Widgets/button.dart';
import '../Widgets/set_new_photo.dart';
import '../Widgets/text_field.dart';
import 'login_page.dart';

Drawer drawer({required BuildContext context}) {
  final ImagePicker picker = ImagePicker();
  return Drawer(
    child: ListView(children: [
      const SizedBox(
        height: 50,
      ),
      Center(child: setNewPhoto(context: context)),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            textField(
                hintText: BlocProvider.of<RegisterCubit>(context).nickNameController?.text ??
                    BlocProvider.of<RegisterCubit>(context).firstNameController.text,
                suffixIcon: Icons.edit,
                controller:
                    BlocProvider.of<RegisterCubit>(context).nickNameController!),
            textField(
                hintText: BlocProvider.of<RegisterCubit>(context).firstNameController.text,
                controller:
                    BlocProvider.of<RegisterCubit>(context).firstNameController,
                suffixIcon: Icons.edit),
            textField(
                hintText: BlocProvider.of<RegisterCubit>(context).lastNameController.text,
                controller:
                    BlocProvider.of<RegisterCubit>(context).lastNameController,
                suffixIcon: Icons.edit),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: materialButton(
                  context: context,
                  child: const Text("Save Changes"),
                  onPressed: () {
                    BlocProvider.of<RegisterCubit>(context).firstNameController.text =
                        BlocProvider.of<RegisterCubit>(context)
                            .firstNameController
                            .text;
                    BlocProvider.of<RegisterCubit>(context).lastNameController.text =
                        BlocProvider.of<RegisterCubit>(context)
                            .lastNameController
                            .text;
                    BlocProvider.of<RegisterCubit>(context).nickNameController?.text =
                        BlocProvider.of<RegisterCubit>(context)
                            .nickNameController!
                            .text;
                  }),
            ),
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
                            BlocProvider.of<RegisterCubit>(context)
                                .clearingData();
                            BlocProvider.of<LoginCubit>(context).clearingData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => LoginPage()),
                              ),
                            );
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
