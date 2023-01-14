import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

import '../widgets/admonition_widget.dart';

Widget admonitionRender(RenderContext renderContext, Widget widget) {
  var type = '';
  if (renderContext.tree.element?.attributes['class'] != null) {
    String lg = renderContext.tree.element?.attributes['class'] as String;
    type = lg.substring(5);
  }

  var contents = renderContext.tree.element?.text.split('\n');
  if (contents?[contents.length - 1].trim().isEmpty ?? false) {
    contents?.removeAt(contents.length - 1);
  }
  var content = contents?.join('\n');
  return AdmonitionWidget(
    title: type,
    content: content,
  );
}
