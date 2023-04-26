import 'package:flutter/material.dart';

class UserPhotoAvatar extends StatelessWidget {
  const UserPhotoAvatar(
      {super.key,
      required this.radius,
      required this.size,
      this.backgroundImage});
  final double radius;
  final double size;
  final ImageProvider? backgroundImage;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      backgroundImage: backgroundImage,
      
    );
  }
}
