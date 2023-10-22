import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';

import 'custom_expansion_tile.dart';
import 'custom_list_tile.dart';

class FileTreeWidget extends StatelessWidget {
  const FileTreeWidget({Key? key, required this.fileTreeModels, this.onTap})
      : super(key: key);

  final List<FileTreeModel> fileTreeModels;
  final void Function(FileTreeModel fileTreeModel)? onTap;

  @override
  Widget build(BuildContext context) {
    var currentPath = GoRouterState.of(context)
        .uri
        .path
        .split('/')
        .last
        .replaceAll('%2F', '/')
        .replaceAll('%20', ' ');

    currentPath = currentPath.split('%23')[0];

    var splitCurrentPath = currentPath.split(".");
    if (splitCurrentPath.length > 2) {
      splitCurrentPath.removeAt(1);
      currentPath = splitCurrentPath.join(".");
    }

    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          for (var fileTree in fileTreeModels)
            fileTree.toExpansionTile(onTap, false, currentPath)
        ],
      ),
    );
  }
}

extension FileTreeToExpansion on FileTreeModel {
  Widget toExpansionTile(void Function(FileTreeModel fileTreeModel)? onTap,
      bool hasParent, String currentPath,
      {int lvl = 0}) {
    var lvlPath = currentPath.split('/');
    var isCurrentPathParent = lvl < lvlPath.length
        ? lvlPath.getRange(0, (lvl + 1)).join('/') == path
            ? true
            : false
        : false;
    return children.isNotEmpty
        ? Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: CustomExpansionTile(
              textColor: Colors.black87,
              initiallyExpanded: true,
              iconColor: Colors.white60,
              // trailing: const SizedBox.shrink(),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              onExpansionTileTap: () {
                if (onTap != null) {
                  onTap(this);
                }
              },
              title: isCurrentPathParent
                  ? Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Solid text as fill.
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 16.0,
                      ),
                    ),
              hasParent: hasParent,
              children: [
                for (var child in children)
                  if (child.name != 'README.md')
                    child.toExpansionTile(
                      onTap,
                      true,
                      currentPath,
                      lvl: lvl + 1,
                    ),
              ],
            ))
        : CustomListTile(
            title: name.replaceAll('.md', ''),
            onTap: onTap == null ? null : () => onTap(this),
            isSelected: currentPath == path ? true : false,
            lvl: lvl,
          );
  }
}
