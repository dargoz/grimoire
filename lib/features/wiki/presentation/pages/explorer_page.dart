import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/features/wiki/presentation/utils/admonition_render.dart';
import 'package:grimoire/features/wiki/presentation/utils/admonition_syntax.dart';
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
import '../models/file_tree_model.dart';
import '../utils/html_custom_render.dart';
import '../widgets/section_widget.dart';
import '../widgets/version_widget.dart';

class ExplorerPage extends StatelessWidget {
  final _keyboardController = Get.put(KeyboardController());
  final DocumentController _documentController = Get.find();
  final FileTreeController _treeController = Get.find();

  ExplorerPage({Key? key}) : super(key: key) {
    _treeController.state.value = Resource<List<FileTreeModel>>.initial(
        'page init',
        data: _treeController.state.value.data);
    _treeController.getHomeDocument();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: RawKeyboardListener(
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
                  Obx(() {
                    return SearchBarWidget(
                      controller: _keyboardController.searchBarController,
                      onFocusChanged: (isFocus) {
                        if (!isFocus) {
                          _keyboardController.hideSearchBar();
                        }
                      },
                      onQueryChanged: _documentController.onQueryChanged,
                      itemList: <Widget>[
                        if (_documentController.searchData.value.status ==
                                Status.completed &&
                            _documentController.hovers.isNotEmpty)
                          for (int index = 0;
                              index <
                                  _documentController
                                      .searchData.value.data!.length;
                              index++)
                            _searchItem(context, index),
                      ],
                    );
                  })
                ],
              ))),
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
                          _documentController.data.value.data?.fileName ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: ScrollController(),
              child: SelectionArea(
                child: Html(
                  tagsList: Html.tags..add('admonition'),
                  customRender: {
                    'code': customCodeRender,
                    'h1': (renderContext, widget) => customHeaderRender(
                        renderContext, widget,
                        onRender: (label, key) => _documentController
                            .documentWidgetSections
                            .add(Section(
                                id: '${label.hashCode}',
                                attr: '1',
                                label: label,
                                sectionKey: key))),
                    'h2': (renderContext, widget) => customHeaderRender(
                        renderContext, widget,
                        onRender: (label, key) => _documentController
                            .documentWidgetSections
                            .add(Section(
                                id: '${label.hashCode}',
                                attr: '2',
                                label: label,
                                sectionKey: key))),
                    'h3': (renderContext, widget) => customHeaderRender(
                        renderContext, widget,
                        onRender: (label, key) => _documentController
                            .documentWidgetSections
                            .add(Section(
                                id: '${label.hashCode}',
                                attr: '3',
                                label: label,
                                sectionKey: key))),
                    'h4': (renderContext, widget) => customHeaderRender(
                        renderContext, widget,
                        onRender: (label, key) => _documentController
                            .documentWidgetSections
                            .add(Section(
                                id: '${label.hashCode}',
                                attr: '4',
                                label: label,
                                sectionKey: key))),
                    'h5': (renderContext, widget) => customHeaderRender(
                        renderContext, widget,
                        onRender: (label, key) => _documentController
                            .documentWidgetSections
                            .add(Section(
                                id: '${label.hashCode}',
                                attr: '5',
                                label: label,
                                sectionKey: key))),
                    'h6': (renderContext, widget) => customHeaderRender(
                        renderContext, widget,
                        onRender: (label, key) => _documentController
                            .documentWidgetSections
                            .add(Section(
                                id: '${label.hashCode}',
                                attr: '6',
                                label: label,
                                sectionKey: key))),
                    'admonition': admonitionRender
                  },
                  data: md.markdownToHtml(
                      _documentController.data.value.data?.content ?? '',
                      blockSyntaxes: const [
                        md.HeaderWithIdSyntax(),
                        AdmonitionSyntax()
                      ]),
                  onAnchorTap: (text, renderContext, map, element) {
                    print('anchor tap : $text');
                    _documentController.redirect(text ?? '', map['href'],
                        _treeController.state.value.data!);
                  },
                ),
              ),
            ))
          ],
        ));
  }

  Widget buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        panelContainer(context,
            childWidget: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(16, 24, 24, 0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        labelText: 'search file..'),
                  ),
                ),
                Expanded(child: FileTreeWidget())
              ],
            )),
        Obx(() {
          switch (_documentController.data.value.status) {
            case Status.loading:
              return Expanded(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                child: const LoadingWidget(),
              ));
            case Status.initial:
            case Status.completed:
              return Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(
                  children: [
                    VersionWidget(
                      author: _documentController
                              .data.value.data?.versionModel?.authorName ??
                          '',
                      lastModifiedDate: _documentController
                              .data.value.data?.versionModel?.committedDate ??
                          '',
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Expanded(child: documentWidget(context)),
                  ],
                ),
              ));
            case Status.error:
              print('response : error :');
              return Expanded(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ResourceErrorWidget(
                    errorCode: _documentController.data.value.errorCode,
                    errorMessage: _documentController.data.value.message),
              ));
          }
        }),
        Obx(() {
          return SectionWidget(
            onTap: _documentController.onSectionClick,
            sections: _documentController.data.value.data?.sections ?? [],
          );
        })
      ],
    );
  }

  Widget panelContainer(BuildContext context, {required Widget childWidget}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      constraints: const BoxConstraints(minWidth: 100, minHeight: 100),
      child: childWidget,
    );
  }

  Widget _searchItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _keyboardController.hideSearchBar();
        _documentController.onSearchResultTap(index);
      },
      child: MouseRegion(
        onEnter: (pointerEvent) {
          _documentController.onItemHover(index, true);
        },
        onExit: (pointerEvent) {
          _documentController.onItemHover(index, false);
        },
        cursor: SystemMouseCursors.click,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: _documentController.hovers[index]
                ? const Color.fromARGB(255, 196, 239, 255)
                : Colors.white,
            border: const Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
          child: Builder(builder: (builderContext) {
            var item = _documentController.searchData.value.data![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  color: const Color.fromARGB(255, 171, 194, 206),
                  child: Text(item.document?.fileName ?? 'unknown'),
                ),
                Html(
                  data: item.marker.isEmpty ? '' : item.marker[0].snippet,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
