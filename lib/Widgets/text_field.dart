import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.hintText,
      this.prefix,
      this.suffix,
      this.suffixIcon,
      required this.controller,
      required this.obscure,
      required this.onPressed,
      this.validator,
      this.textInputType});
  final String hintText;
  final IconData? prefix;
  final Widget? suffix;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final bool obscure;
  final void Function() onPressed;
  final String? Function(String?)? validator;

  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
        keyboardType: textInputType,
        validator: validator,
        obscureText: obscure,
        controller: controller,
      ),
    );
  }
}
