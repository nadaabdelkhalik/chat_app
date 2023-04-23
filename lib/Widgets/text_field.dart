import 'package:flutter/material.dart';

Widget textField(
    {required String hintText,
    IconData? prefix,
    Widget? suffix,
    IconData? suffixIcon,
    required TextEditingController controller,
    bool obscure = false,
    var onPressed,
    String? Function(String?)?validator,

    TextInputType? textInputType}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: TextFormField(
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefix),
          suffix: suffix,
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: onPressed,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
      keyboardType: textInputType,
      validator:validator,
      obscureText: obscure,
      controller: controller,
    ),
  );
}
