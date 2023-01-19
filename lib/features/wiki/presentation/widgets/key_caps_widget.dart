import 'package:flutter/material.dart';

class KeyCapsWidget extends StatelessWidget {
  const KeyCapsWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFd5dbe4),
                Color(0xFFf8f8f8),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(2)),
            boxShadow: [

              BoxShadow(
                  blurStyle: BlurStyle.inner,
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color(0xFFffffff)),
              BoxShadow(
                  blurStyle: BlurStyle.inner,
                  offset: Offset(0, 2),
                  blurRadius: 0,
                  spreadRadius: 0,
                  color: Color(0xFFcdcde6)),
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  offset: Offset(0, -1),
                  blurRadius: 2,
                  spreadRadius: 1,
                  color: Color.fromRGBO(30, 35, 90, 0.4)),

            ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          child: Text(text,
              style: const TextStyle(fontSize: 10, color: Colors.black87)),
        ),
      ),
    );
  }
}

// linear-gradient(-225deg,#d5dbe4,#f8f8f8)
// shadow : inset 0 -2px 0 0 #cdcde6,inset 0 0 1px 1px #fff,0 1px 2px 1px rgba(30,35,90,0.4)
// text-color : #969faf
