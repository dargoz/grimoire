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
  EdgeInsets? margin;
  switch (renderContext.elementName) {
    case 'h1':
      fontSize = 48;
      fontWeight = FontWeight.bold;
      margin = const EdgeInsets.only(bottom: 10);
      break;
    case 'h2':
      fontSize = 32;
      fontWeight = FontWeight.bold;
      margin = const EdgeInsets.only(top: 16, bottom: 4);
      break;
    case 'h3':
      fontSize = 24;
      if (renderContext.element?.children.isNotEmpty ?? false) {
        if (renderContext.element?.children[0].localName == 'strong') {
          fontWeight = FontWeight.bold;
        }
      }
      margin = const EdgeInsets.only(top: 6);
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
    print(
        "widget : ${renderContext.element.toString()} :: $globalKey :: globalIndex $globalSectionIndex");
  }
  onRender(id, globalKey);

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

  return Container(
    margin: margin,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        renderWidget,
        Divider(
          color: (renderContext.elementName == 'h1') ? null : Colors.transparent,
        )
      ],
    ),
  );
}
