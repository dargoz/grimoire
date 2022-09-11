import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:grimoire/features/wiki/presentation/utils/reference_widget.dart';

Widget referenceRender(RenderContext renderContext, Widget widget) {
  var contents = renderContext.tree.element?.text.split('\n');
  if (contents?[contents.length -1].trim().isEmpty ?? false) {
    contents?.removeAt(contents.length - 1);
  }
  return ReferenceWidget(contents: contents);
}
