import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../widgets/admonition_widget.dart';

Widget admonitionRender(ExtensionContext renderContext) {
  var type = '';
  if (renderContext.attributes['class'] != null) {
    String lg = renderContext.attributes['class'] as String;
    type = lg.substring(5);
  }

  var contents = renderContext.element?.text.split('\n');
  if (contents?[contents.length - 1].trim().isEmpty ?? false) {
    contents?.removeAt(contents.length - 1);
  }
  var content = contents?.join('\n');
  return AdmonitionWidget(
    title: type,
    content: content,
  );
}
