import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/controllers/repository_controller.dart';
import 'package:grimoire/features/wiki/presentation/widgets/file_tree_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.put(RepositoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(child: const Text('get data'), onPressed: () {}),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: 700,
                child: FileTreeWidget(),
              ),
              Obx(
                () => SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 700,
                  child:
                      Markdown(data: controller.data.value.data?.content ?? ''),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
