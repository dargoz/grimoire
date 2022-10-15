import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class KeyboardController extends StateNotifier<int> {
  final searchBarController = FloatingSearchBarController();
  List<LogicalKeyboardKey> keys = [];

  FocusNode focusNode = FocusNode();

  KeyboardController(Ref ref): super(0);

  void onKeyEvent(RawKeyEvent event) {
    final key = event.logicalKey;
    if (event is RawKeyDownEvent) {
      if (keys.contains(key)) return;
      keys.add(key);
      // your keyboard command
      if (keys.contains(LogicalKeyboardKey.controlLeft) &&
          keys.contains(LogicalKeyboardKey.space)) {
        showSearchBar();
      }
    } else {
      keys.remove(key);
    }
    print('keys : $keys');
  }

  void showSearchBar() {
    searchBarController.show();
    searchBarController.open();
  }

  void hideSearchBar() {
    searchBarController.close();
    searchBarController.hide();
    focusNode.requestFocus();
  }
}
