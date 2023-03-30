import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/designs/colors/color_schemes.dart';

class DocumentTabWidget extends ConsumerStatefulWidget {
  const DocumentTabWidget(
      {super.key, required this.tabs, required this.widgets});

  final List<String> tabs;
  final List<Widget> widgets;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  decoration: const BoxDecoration(
                      color: ColorSchemes.blue10,
                      borderRadius:
                          BorderRadius.all(Radius.circular(64))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: ColorSchemes.bluePrimary,
                      indicator: const BubbleTabIndicator(
                          indicatorHeight: 64.0,
                          indicatorColor: ColorSchemes.bluePrimary,
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          indicatorRadius: 32,
                          insets: EdgeInsets.zero),
                      tabs: widget.tabs
                          .map(
                            (e) => SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.5 /
                              widget.tabs.length,
                          child: Tab(
                            text: e,
                            height: 64,
                          ),
                        ),
                      )
                          .toList(),
                      onTap: (index) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: widget.widgets[_tabController.index],
                ))
              ],
            ),
          ),
        ));
  }
}
