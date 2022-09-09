import 'package:flutter/material.dart';

class KeyCapsWidget extends StatelessWidget {
  const KeyCapsWidget({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: const Color.fromARGB(255, 229, 232, 237),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12
          ),
        ),
      ),
    );
  }
}
