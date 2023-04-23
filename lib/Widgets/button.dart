import 'package:flutter/material.dart';

import '../Utilities/consts.dart';



Widget materialButton(
    {required BuildContext context,
    required Widget child,
    required var onPressed}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    width: MediaQuery.of(context).size.width * 3 / 4,
    child: MaterialButton(
      onPressed: onPressed,
      color: kprimaryColor,
      shape: const StadiumBorder(),
      height: 55,
      textColor: Colors.white,
      child: child,
    ),
  );
}
