import 'package:flutter/material.dart';
import 'package:grimoire/core/designs/bg_state_color.dart';
import 'package:grimoire/core/designs/elevation_state_color.dart';

class BreadcrumbWidget extends StatelessWidget {
  const BreadcrumbWidget(
      {super.key, required this.path, required this.onPressed});

  final String path;
  final void Function(String path) onPressed;

  @override
  Widget build(BuildContext context) {
    var menuItems = path.split("/").map((e) => Menu(label: e)).toList();
    print('breadcrumb items : $menuItems');

    menuItems.last.isActive = false;
    return Row(
      children: [
        TextButton(
            onPressed: () => onPressed("README.md"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
              enabledMouseCursor: SystemMouseCursors.click,
              disabledMouseCursor: SystemMouseCursors.text,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ).copyWith(
                minimumSize: const MaterialStatePropertyAll(Size(24, 32)),
                backgroundColor: const BgStateColor(Colors.transparent),
                elevation: const ElevationStateColor()),
            child: const Icon(
              Icons.home,
              size: 16,
            )),
        for (var menu in menuItems)
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 8,
                ),
              ),
              TextButton(
                  onPressed: menu.isActive ? () => onPressed(menuItems.toPath(menu)) : null,
                  style: ElevatedButton.styleFrom(
                    enabledMouseCursor: SystemMouseCursors.click,
                    disabledMouseCursor: SystemMouseCursors.text,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ).copyWith(
                      backgroundColor: const BgStateColor(Colors.transparent),
                      elevation: const ElevationStateColor()),
                  child: Text(
                    menu.label.replaceAll('.md', ''),
                    style: const TextStyle(color: Colors.black87, fontSize: 12),
                  )),
            ],
          )
      ],
    );
  }
}

class Menu {
  Menu({this.isActive = true, required this.label});

  bool isActive;
  String label;

  @override
  String toString() {
    return 'Menu{isActive: $isActive, label: $label}';
  }
}

extension MenuConverter on List<Menu> {

  String toPath(Menu menu) {
    String path = '';
    for (var item in this) {
      path += '${item.label}/';
      if(item == menu) break;
    }
    return '${path}README.md';
  }

}
