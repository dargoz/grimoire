import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grimoire/features/wiki/presentation/utils/custom_code_render.dart';
import 'package:markdown/markdown.dart';

import '../../../../core/designs/colors/color_schemes.dart';

Widget codePreviewRender(ExtensionContext renderContext) {
  log('code preview render');
  List<String> langList = List.empty(growable: true);
  if (renderContext.attributes['class'] != null) {
    String lg = renderContext.attributes['class'] as String;
    langList = lg.split('-');
  }

  print('render element ${renderContext.element?.text}');
  var contents = renderContext.element?.text.split('\n');
  if (contents?[contents.length - 1].trim().isEmpty ?? false) {
    contents?.removeAt(contents.length - 1);
  }
  var content = contents?.join('\n');
  print('content : $content');
  var codeBlocks = content?.split('--split--') ?? [];
  print('code blocks: $codeBlocks');
  var maxLength = codeBlocks.first.split('\n').length;
  for (var element in codeBlocks) {
    var length = element.split('\n').length;
    if (length > maxLength) {
      maxLength = length;
    }
  }
  return SizedBox(
    width: MediaQuery.of(renderContext.buildContext!).size.width,
    height: maxLength * 24,
    child: CodePreview(
      tabs: langList,
      codeBlocks: codeBlocks,
    ),
  );
}

class CodePreview extends StatefulWidget {
  const CodePreview({super.key, required this.tabs, required this.codeBlocks});

  final List<String> tabs;
  final List<String> codeBlocks;

  @override
  State<StatefulWidget> createState() => CodePreviewState();
}

class CodePreviewState extends State<CodePreview>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.tabs.length,
        child: Scaffold(
          body: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(4))),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: ColorSchemes.bluePrimary,
                        unselectedLabelColor: ColorSchemes.bluePrimary,
                        indicatorColor: ColorSchemes.bluePrimary,
                        tabs: widget.tabs
                            .map(
                              (e) => Tab(
                                text: e,
                                height: 32,
                              ),
                            )
                            .toList(),
                        onTap: (index) {
                          log("index : $index");
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(8))),
                    child: Html(
                      data: markdownToHtml(
                          widget.codeBlocks[_tabController.index]),
                      extensions: [
                        TagExtension(
                          tagsToExtend: {"code"},
                          builder: (extensionContext) {
                            return CustomCodeRender(renderContext: extensionContext, showBorder: false,);
                          },
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
