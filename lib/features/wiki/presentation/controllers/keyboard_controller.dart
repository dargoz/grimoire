import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/presentation/widgets/search_bar_widget_v2.dart';

final keyboardStateNotifierProvider =
    StateNotifierProvider<KeyboardController, int>(
        (ref) => KeyboardController(ref));

class KeyboardController extends StateNotifier<int> {
  var searchBarController = SearchBarController();
  List<LogicalKeyboardKey> keys = [];

  FocusNode focusNode = FocusNode();

  KeyboardController(Ref ref) : super(0);

  void onKeyEvent(RawKeyEvent event) {
    final key = event.logicalKey;
    if (event is RawKeyDownEvent) {
      if (keys.contains(key)) return;
      keys.add(key);
      // your keyboard command
      if (keys.contains(LogicalKeyboardKey.controlLeft) &&
          keys.contains(LogicalKeyboardKey.space)) {
        showSearchBar();
      } else if (keys.contains(LogicalKeyboardKey.escape) &&
          searchBarController.isOpen) {
        hideSearchBar();
      }
    } else {
      keys.remove(key);
    }
    print('keys : $keys');
  }

  void showSearchBar() {
    searchBarController.show();
  }

  void hideSearchBar() {
    searchBarController.hide();
    focusNode.requestFocus();
  }
}
