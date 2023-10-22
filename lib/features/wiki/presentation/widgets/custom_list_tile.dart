import 'package:flutter/material.dart';

import '../../../../core/designs/bg_state_color.dart';
import '../../../../core/designs/elevation_state_color.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.onTap,
    this.isSelected = false,
    required this.lvl,
  });

  final String title;
  final void Function()? onTap;
  final bool isSelected;
  final int lvl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (lvl != 0) ...[
              Container(
                width: isSelected ? 2 : 1,
                color: isSelected
                    ? const Color(0xFF00B5F0)
                    : const Color.fromRGBO(255, 255, 255, 0.2),
              ),
            ],
            Expanded(
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
                    backgroundColor: isSelected
                        ? const BgStateColor(Color.fromARGB(30, 0, 0, 0))
                        : const BgStateColor(Colors.transparent),
                    elevation: const ElevationStateColor()),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white60,
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : null),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
