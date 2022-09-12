import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:grimoire/features/wiki/presentation/utils/reference_widget.dart';

import '../models/file_tree_model.dart';

Widget referenceRender(RenderContext renderContext, Widget widget,
    {void Function(FileTreeModel)? onTap}) {
  var contents = renderContext.tree.element?.text.split('\n');
  if (contents?[contents.length - 1].trim().isEmpty ?? false) {
    contents?.removeAt(contents.length - 1);
  }
  print('list : ${contents.toString()}');
  return ReferenceWidget(
    contents:
        contents?.map((e) => FileTreeModel.fromJson(jsonDecode(e))).toList(),
    onPressed: onTap,
  );
}
