import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/register_cubit.dart';


Widget userPhotoAvatar({required BuildContext context, required double radius,required double size }) =>
    CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      backgroundImage: BlocProvider.of<RegisterCubit>(context)
                  .pickedProfileFile ==
              null
          ? null
          : FileImage(File(
              BlocProvider.of<RegisterCubit>(context).pickedProfileFile!.path)),
      child: BlocProvider.of<RegisterCubit>(context).pickedProfileFile == null
          ? Icon(
              Icons.person,
              size:  size,
              color: Colors.grey,
            )
          : null,
    );
