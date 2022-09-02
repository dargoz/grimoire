import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {Key? key,
      this.controller,
      this.onFocusChanged,
      this.onQueryChanged,
      required this.itemList})
      : super(key: key);

  final FloatingSearchBarController? controller;
  final Function(bool)? onFocusChanged;
  final void Function(String query)? onQueryChanged;
  final List<Widget> itemList;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Search...',
      controller: controller,
      initiallyHidden: true,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 0),
      transitionCurve: Curves.ease,
      physics: const BouncingScrollPhysics(),
      // 0.0 mean center
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 500 : 600,
      debounceDelay: const Duration(milliseconds: 0),
      onFocusChanged: onFocusChanged,
      onQueryChanged: onQueryChanged,
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: itemList,
            ),
          ),
        );
      },
    );
  }
}
