import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          for (var fileTree in fileTreeModels)
            fileTree.toExpansionTile(onTap, false)
        ],
      ),
    );
  }
}

extension FileTreeToExpansion on FileTreeModel {
  Widget toExpansionTile(
      void Function(FileTreeModel fileTreeModel)? onTap, bool hasParent) {
    return children.isNotEmpty
        ? Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: CustomExpansionTile(
              textColor: Colors.black87,
              initiallyExpanded: true,
              // trailing: const SizedBox.shrink(),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              onExpansionTileTap: () {
                if (onTap != null) {
                  onTap(this);
                }
              },
              title: Text(
                name,
                style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              hasParent: hasParent,
              children:
                  children.map((e) => e.toExpansionTile(onTap, true)).toList(),
            ))
        : CustomListTile(
            title: name,
            onTap: onTap == null ? null : () => onTap(this),
          );
  }
}
