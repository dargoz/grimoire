import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/controllers/repository_controller.dart';
import 'package:grimoire/features/wiki/presentation/widgets/file_tree_widget.dart';

import '../controllers/file_tree_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.put(RepositoryController());
  final FileTreeController _treeController = Get.put(FileTreeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              child: const Text('get file tree'),
              onPressed: () {
                _treeController.getFileTree();
              }),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 700,
                child: FileTreeWidget(),
              ),
              Obx(
                () => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 700,
                  child: Markdown(
                    controller: ScrollController(),
                    data: controller.data.value.data?.content ?? '',
                    onTapLink: (text, href, title) => controller.redirect(
                        text, href, _treeController.state.value.data!),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
