import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/widgets/key_caps_widget.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_html/flutter_html.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:grimoire/features/wiki/presentation/widgets/loading_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/resource_error_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/search_bar_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/file_tree_widget.dart';
import 'package:grimoire/features/wiki/presentation/controllers/document_controller.dart';

import '../controllers/file_tree_controller.dart';
import '../controllers/keyboard_controller.dart';
import '../widgets/highlight_builder.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _keyboardController = Get.put(KeyboardController());
  final documentController = Get.put(DocumentController());
  final _treeController = Get.put(FileTreeController());

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        autofocus: true,
        focusNode: _keyboardController.focusNode,
        onKey: _keyboardController.onKeyEvent,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Grimoire'),
              toolbarHeight: 48,
              actions: [
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        _keyboardController.showSearchBar();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                              color: Colors.white),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Search',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: KeyCapsWidget(text: 'Ctrl'),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                                child: KeyCapsWidget(text: 'Space'),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                const Icon(Icons.help),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://secure.gravatar.com/avatar/018afd3eb4d4dcb676df54b56db7c80e?s=64&d=identicon',
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                buildContent(context),
                SearchBarWidget(
                  controller: _keyboardController.searchBarController,
                  onFocusChanged: (isFocus) {
                    if (!isFocus) {
                      _keyboardController.hideSearchBar();
                    }
                  },
                )
              ],
            )));
  }

  Widget versionWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 80,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://secure.gravatar.com/avatar/018afd3eb4d4dcb676df54b56db7c80e?s=64&d=identicon'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                    'Author : ${documentController.data.value.data?.versionModel.authorName}'),
                Text(
                    'Last Update : ${documentController.data.value.data?.versionModel.committedDate}'),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget documentWidget(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 32,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.fileLines,
                    size: 12,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
                      child: Center(
                        child: Text(
                          documentController.data.value.data?.fileName ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: ScrollController(),
              child: Html(
                customRender: const {'code': customCodeRender},
                data: md.markdownToHtml(
                    documentController.data.value.data?.content ?? ''),
                onLinkTap: (text, renderContext, map, element) {
                  documentController.redirect(text ?? '', map['href'],
                      _treeController.state.value.data!);
                },
              ),
            ))
          ],
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
        );
  }

  Widget buildContent(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          constraints: const BoxConstraints(minWidth: 100, minHeight: 100),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _treeController.getFileTree();
                  },
                  child: const Text('get file tree')),
              Expanded(child: FileTreeWidget())
            ],
          ),
        ),
        Obx(() {
          switch (documentController.data.value.status) {
            case Status.loading:
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.5,
                child: const LoadingWidget(),
              );
            case Status.initial:
            case Status.completed:
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(
                  children: [
                    versionWidget(context),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Expanded(child: documentWidget(context)),
                  ],
                ),
              );
            case Status.error:
              return const ResourceErrorWidget();
          }
        })
      ],
    );
  }
}
