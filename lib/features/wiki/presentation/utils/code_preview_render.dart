import 'dart:developer';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart';

import '../../../../core/designs/colors/color_schemes.dart';
import 'html_custom_render.dart';

Widget codePreviewRender(RenderContext renderContext, Widget widget) {
  print('code preview render');
  List<String> langList = List.empty(growable: true);
  if (renderContext.tree.element?.attributes['class'] != null) {
    String lg = renderContext.tree.element?.attributes['class'] as String;
    langList = lg.split('-');
  }

  print('render element ${renderContext.tree.element?.innerHtml}');
  var contents = renderContext.tree.element?.innerHtml.split('\n');
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
    width: MediaQuery.of(renderContext.buildContext).size.width,
    height: maxLength * 48,
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
            color: ColorSchemes.tipDarken,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              spreadRadius: 0)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        indicator: const BubbleTabIndicator(
                            indicatorHeight: 32.0,
                            indicatorColor: ColorSchemes.infoBase,
                            tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            indicatorRadius: 8,
                            insets: EdgeInsets.zero),
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
                      color: ColorSchemes.cautionLighten,
                      border: Border.all(color: ColorSchemes.infoDarken),
                    ),
                    child: Html(
                      data: markdownToHtml(
                          widget.codeBlocks[_tabController.index]),
                      customRender: const {
                        'code': customCodeRender,
                      },
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
