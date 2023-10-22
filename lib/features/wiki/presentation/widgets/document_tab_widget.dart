import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/controllers/document_controller.dart';
import 'package:grimoire/features/wiki/presentation/controllers/file_tree_controller.dart';
import 'package:grimoire/features/wiki/presentation/controllers/sub_document_controller.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/widgets/breadcrumb_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/version_widget.dart';

import '../../../../core/designs/colors/color_schemes.dart';

class DocumentTabWidget extends ConsumerStatefulWidget {
  const DocumentTabWidget(
      {super.key, required this.tabs, required this.widgets, this.onTabChange, this.selectedIndex = 0});

  final List<String> tabs;
  final List<Widget> widgets;
  final Function(int index)? onTabChange;
  final int selectedIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DocumentTabState();
}

class DocumentTabState extends ConsumerState<DocumentTabWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabs.length, vsync: this, initialIndex: widget.selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didUpdateWidget(covariant DocumentTabWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _tabController.index = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    var documentController = ref.read(documentStateNotifierProvider.notifier);
    return DefaultTabController(
        length: widget.tabs.length,
        child: Scaffold(
          body: Container(
            color: Colors.transparent,
            child: SingleChildScrollView(
              controller: documentController.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._header(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: const BoxDecoration(
                        color: ColorSchemes.blue10,
                        borderRadius: BorderRadius.all(Radius.circular(64))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        labelColor: Colors.white,
                        unselectedLabelColor: ColorSchemes.bluePrimary,
                        indicator: const BubbleTabIndicator(
                            indicatorHeight: 48.0,
                            indicatorColor: ColorSchemes.bluePrimary,
                            tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            indicatorRadius: 32,
                            insets: EdgeInsets.zero),
                        tabs: widget.tabs
                            .map(
                              (e) => SizedBox(
                                width: MediaQuery.sizeOf(context).width *
                                    0.5 /
                                    widget.tabs.length,
                                child: Tab(
                                  text: e.capitalizeFirst,
                                  height: 48,
                                ),
                              ),
                            )
                            .toList(),
                        onTap: (index) {
                          setState(() {});
                          if (widget.onTabChange != null) {
                            widget.onTabChange!(index);
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: widget.widgets[_tabController.index],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> _header() {
    var model = ref.watch(subDocumentStateNotifierProvider);

    var documentController = ref.read(documentStateNotifierProvider.notifier);
    var fileTreeController = ref.read(fileTreeStateNotifierProvider.notifier);
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
        child: BreadcrumbWidget(
          path: model?.value?.data?.filePath ?? "",
          onPressed: (String label) {
            var model =
                FileTreeModel(id: '', name: '', type: 'tree', path: label);
            documentController
                .getDocument(fileTreeController.findReference(model) ?? model);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: VersionWidget(
          author: model?.value?.data?.versionModel?.authorName ?? '',
          lastModifiedDate:
              model?.value?.data?.versionModel?.committedDate ?? '',
        ),
      ),
    ];
  }
}
