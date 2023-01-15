import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

Widget customCodeRender(RenderContext renderContext, Widget widget) {
  var language = '';

  if (renderContext.tree.element?.attributes['class'] != null) {
    String lg = renderContext.tree.element?.attributes['class'] as String;
    language = lg.substring(9);
  }

  if (language.isEmpty) {
    bool isMultiLine = renderContext.tree.element!.text.contains('\n');
    return Container(
        width: isMultiLine
            ? MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .width
            : null,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            border: isMultiLine ? Border.all(color: Colors.grey) : null,
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: isMultiLine ? const EdgeInsets.all(8) : EdgeInsets.zero,
          child: Text(
            renderContext.tree.element!.text,
            style: TextStyle(
                fontSize: isMultiLine ? 14 : 12, fontFamily: 'JetBrainsMono'),
          ),
        ));
  } else {
    return SizedBox(
      width:
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      child: HighlightView(
        // The original code to be highlighted
        renderContext.tree.element!.text,

        // Specify language
        // It is recommended to give it a value for performance
        language: language,

        // Specify highlight theme
        // All available themes are listed in `themes` folder
        theme: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .platformBrightness ==
                Brightness.light
            ? atomOneLightTheme
            : atomOneDarkTheme,

        // Specify padding
        padding: const EdgeInsets.all(8),

        // Specify text style
        textStyle: GoogleFonts.robotoMono(),
      ),
    );
  }
}

int globalSectionIndex = 0;

Widget customHeaderRender(RenderContext renderContext, Widget widget,
    {required void Function(String label, GlobalKey key) onRender,
    required AutoScrollController controller}) {
  var id = '';
  if (renderContext.tree.element?.attributes['id'] != null) {
    String lg = renderContext.tree.element?.attributes['id'] as String;
    id = lg;
  }
  var globalKey = GlobalKey(debugLabel: id);
  double fontSize = 24;
  var fontWeight = FontWeight.normal;
  switch (renderContext.tree.name) {
    case 'h1':
      fontSize = 48;
      fontWeight = FontWeight.bold;
      break;
    case 'h2':
      fontSize = 32;
      fontWeight = FontWeight.bold;
      break;
    case 'h3':
      fontSize = 24;
      break;
    case 'h4':
      fontSize = 20;
      break;
    case 'h5':
      fontSize = 18;
      break;
    case 'h6':
      fontSize = 16;
      break;
  }
  if (kDebugMode) {
    print('---------------------------------------------------');
    onRender(id, globalKey);
    print("widget : ${widget.toString()} :: $globalKey :: globalIndex $globalSectionIndex");
  }

  var renderWidget = AutoScrollTag(
    key: ValueKey(globalKey),
    controller: controller,
    index: globalSectionIndex++,
    child: Text(
      renderContext.tree.element?.text ?? 'error_parsing',
      key: globalKey,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    ),
  );

  if (renderContext.tree.name == 'h1') {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [renderWidget, const Divider()],
    );
  } else {
    return renderWidget;
  }
}
