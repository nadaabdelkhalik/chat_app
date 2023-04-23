import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/register_cubit.dart';
import '../Bloc/register_states.dart';
import '../Widgets/chats_list_item.dart';
import '../Widgets/user_photo_avatar.dart';
import 'drawer.dart';

class ChatsListPage extends StatelessWidget {
  ChatsListPage({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (BuildContext context, state) => Scaffold(
          key: _key,
          drawer: drawer(context: context),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: (() {}),
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ))
            ],
            title: const Text(
              "Chats",
              style: TextStyle(fontSize: 30),
            ),
            centerTitle: true,
            leading: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: userPhotoAvatar(context: context, radius: 45, size: 30),
              ),
              onTap: () => _key.currentState!.openDrawer(),
            ),
          ),
          body: chatsListItem(context: context)),
    );
  }
}
