import 'package:flutter/material.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';

import '../../../../core/designs/bg_state_color.dart';

class ReferenceWidget extends StatelessWidget {
  const ReferenceWidget({super.key, this.contents, this.onPressed});

  final List<FileTreeModel>? contents;
  final void Function(FileTreeModel)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            for (var content in contents ?? <FileTreeModel>[])
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                constraints: const BoxConstraints(minWidth: 300),
                child: TextButton(
                    onPressed: () => onPressed == null ? null : onPressed!(content),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 128),
                      enabledMouseCursor: SystemMouseCursors.click,
                      disabledMouseCursor: SystemMouseCursors.text,
                      alignment: Alignment.centerLeft,
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ).copyWith(
                        backgroundColor: const BgStateColor(Colors.white),),
                    child: Text(
                      '${content.type == 'tree' ? '🗃' : '📄'} ${content.name.replaceAll('.md', '')}',
                      style: const TextStyle(color: Colors.black87,
                          fontSize: 24,),
                    )),
              )
          ]),
    );
  }
}
