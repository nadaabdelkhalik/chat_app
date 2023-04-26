import 'package:flutter/material.dart';

import '../Utilities/consts.dart';
import 'button.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.data, required this.onPressed});
  final String data;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ksecondaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isSmall: true,
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  )),
              Button(
                  onPressed: onPressed,
                  isSmall: true,
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
