import 'package:flutter/material.dart';

import 'key_caps_widget.dart';

class AppBarSearchWidget extends StatefulWidget {
  const AppBarSearchWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  State<StatefulWidget> createState() => AppBarSearchWidgetState();
}

class AppBarSearchWidgetState extends State<AppBarSearchWidget> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          setState(() {
            _isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHover = false;
          });
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  border: _isHover
                      ? Border.all(color: Colors.grey)
                      : Border.all(color: const Color(0xFFebedf0)),
                  color: const Color(0xFFebedf0)),
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
