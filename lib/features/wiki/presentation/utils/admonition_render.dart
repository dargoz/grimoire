import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

Widget admonitionRender(RenderContext renderContext, Widget widget) {
  var type = '';
  print('admonition render test');
  if (renderContext.tree.element?.attributes['class'] != null) {
    String lg = renderContext.tree.element?.attributes['class'] as String;
    type = lg.substring(5);
  }
  print('content : ${renderContext.tree.element?.text}');
  return Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 76, 179, 212),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    child: Container(
      margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 238, 249, 253),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type),
            Text(renderContext.tree.element?.text ?? '')
          ],
        ),
      ),
    ),
  );
}
