import 'package:flutter/material.dart';

import 'key_caps_widget.dart';

class AppBarSearchWidget extends StatelessWidget {
  const AppBarSearchWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  color: Color(0xFFebedf0)),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.black87),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: KeyCapsWidget(text: 'Ctrl'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                    child: KeyCapsWidget(text: 'Space'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
