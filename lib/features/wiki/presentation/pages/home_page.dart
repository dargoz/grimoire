import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/controllers/repository_controller.dart';
import 'package:grimoire/features/wiki/presentation/widgets/file_tree_widget.dart';

import '../controllers/file_tree_controller.dart';
import '../widgets/highlight_builder.dart';

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
                () => Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 80,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://secure.gravatar.com/avatar/018afd3eb4d4dcb676df54b56db7c80e?s=64&d=identicon'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                  'Author : ${controller.data.value.data?.commitEntity?.authorName}'),
                              Text(
                                  'Last Update : ${controller.data.value.data?.commitEntity?.committedDate}'),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Html(
                            customRender: const {'code': customCodeRender},
                            data: md.markdownToHtml(
                                controller.data.value.data?.content ?? ''),
                            onLinkTap: (text, renderContext, map, element) {
                              controller.redirect(text ?? '', map['href'],
                                  _treeController.state.value.data!);
                            },
                          ),
                        )

                        /*child: Markdown(
                        controller: ScrollController(),
                        data: controller.data.value.data?.content ?? '',
                        padding: const EdgeInsets.all(10),
                        builders: {
                          'code': CodeElementBuilder(),
                        },
                        onTapLink: (text, href, title) => controller.redirect(
                            text, href, _treeController.state.value.data!),
                      ),*/
                        )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
