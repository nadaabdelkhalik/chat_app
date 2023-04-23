import 'package:chat_app/Bloc/register_cubit.dart';
import 'package:chat_app/Bloc/register_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/button.dart';
import '../Widgets/set_new_photo.dart';
import '../Widgets/text_field.dart';
import 'chats_list_page.dart';

class AddPhotoPage extends StatelessWidget {
  AddPhotoPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) => Form(
          key: _formKey,
          child: ListView(children: [
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [setNewPhoto(context: context)],
                ),
                const SizedBox(
                  height: 30,
                ),
                textField(
                    hintText: "  Nick Name",
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter your nick name';

                      return null;
                    },
                    controller: BlocProvider.of<RegisterCubit>(context)
                        .nickNameController!),
                materialButton(
                    context: context,
                    child: const Text("Next"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubit>(context)
                                .nickNameController
                                ?.text =
                            BlocProvider.of<RegisterCubit>(context)
                                .nickNameController!
                                .text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ChatsListPage()),
                          ),
                        );
                      }
                    })
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
