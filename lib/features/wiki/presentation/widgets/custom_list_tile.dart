import 'package:flutter/material.dart';

import '../../../../core/designs/bg_state_color.dart';
import '../../../../core/designs/elevation_state_color.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.title, this.onTap});

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: TextButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          enabledMouseCursor: SystemMouseCursors.click,
          disabledMouseCursor: SystemMouseCursors.text,
          alignment: Alignment.centerLeft,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ).copyWith(
            backgroundColor: const BgStateColor(Colors.transparent),
            elevation: const ElevationStateColor()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black45, fontSize: 16),
          ),
        ),
      ),
    );
  }

}