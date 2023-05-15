import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

int globalSectionIndex = 0;

Widget customHeaderRender(ExtensionContext renderContext,
    {required void Function(String label, GlobalKey key) onRender,
    required AutoScrollController controller}) {
  var id = '';
  if (renderContext.attributes['id'] != null) {
    String lg = renderContext.attributes['id'] as String;
    id = lg;
  }
  var globalKey = GlobalKey(debugLabel: id);
  double fontSize = 24;
  var fontWeight = FontWeight.normal;
  switch (renderContext.elementName) {
    case 'h1':
      fontSize = 40;
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
    print(
        "widget : ${renderContext.element.toString()} :: $globalKey :: globalIndex $globalSectionIndex");
  }

  var renderWidget = AutoScrollTag(
    key: ValueKey(globalKey),
    controller: controller,
    index: globalSectionIndex++,
    child: Text(
      renderContext.element?.text ?? 'error_parsing',
      key: globalKey,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      renderWidget,
      Divider(
        color: (renderContext.elementName == 'h1') ? null : Colors.transparent,
      )
    ],
  );
}
