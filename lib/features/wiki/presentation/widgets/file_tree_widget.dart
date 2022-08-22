import 'package:flutter/widgets.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/controllers/file_tree_controller.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';

class FileTreeWidget extends StatelessWidget {
  FileTreeWidget({Key? key}) : super(key: key);

  final FileTreeController _treeController = Get.put(FileTreeController());

  @override
  Widget build(BuildContext context) {
    _treeController.getFileTree();
    return Obx(() => TreeView(
        controller: TreeViewController(
            children: _treeController.state.value.data?.toNodeList() ?? []),
      onNodeTap: _treeController.onNodeTap,

    ));
  }
}
