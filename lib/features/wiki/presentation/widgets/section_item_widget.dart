import 'package:flutter/material.dart';

import '../models/section.dart';

class SectionItemWidget extends StatefulWidget {
  const SectionItemWidget({super.key, required this.section, this.onTap, this.isActive = false});

  final Section section;
  final void Function(String sectionKey)? onTap;
  final bool isActive;

  @override
  State<StatefulWidget> createState() => _SectionItemState();
}

class _SectionItemState extends State<SectionItemWidget> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    double tabSize = int.parse(widget.section.attr) * 8 - 8;
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(widget.section.id);
        }
      },
      child: MouseRegion(
        onEnter: (pointerEvent) {
          setState(() {
            _isHover = true;
          });
        },
        onExit: (pointerEvent) {
          setState(() {
            _isHover = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
          padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
          decoration: const BoxDecoration(
              border:
                  Border(left: BorderSide(color: Color(0xffd9d9d9), width: 4))),
          child: Padding(
            padding: EdgeInsets.fromLTRB(tabSize, 0, 0, 4),
            child: Text(
              widget.section.label.replaceAll("**", ""),
              style: TextStyle(
                color: _isHover || widget.isActive ? Colors.blueAccent : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
