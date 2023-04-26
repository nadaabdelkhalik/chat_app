import 'package:flutter/material.dart';

import '../Utilities/consts.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.isSmall});
  final Widget child;
  final void Function() onPressed;
  final bool isSmall;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      width: isSmall
          ? MediaQuery.of(context).size.width * 1 / 4
          : MediaQuery.of(context).size.width * 3 / 4,
      child: MaterialButton(
        onPressed: onPressed,
        color: kprimaryColor,
        shape: const StadiumBorder(),
        height: isSmall ? 40 : 55,
        textColor: Colors.white,
        child: child,
      ),
    );
  }
}
