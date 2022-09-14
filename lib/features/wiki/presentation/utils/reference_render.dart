import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:grimoire/features/wiki/presentation/utils/reference_widget.dart';

import '../models/file_tree_model.dart';

Widget referenceRender(RenderContext renderContext, Widget widget,
    {void Function(FileTreeModel)? onTap}) {
  var ref = '';
  if (renderContext.tree.element?.attributes['class'] != null) {
    String type = renderContext.tree.element?.attributes['class'] as String;
    ref = type.substring(6);
  }

  var contents = renderContext.tree.element?.text.split('\n');
  if (contents?[contents.length - 1].trim().isEmpty ?? false) {
    contents?.removeAt(contents.length - 1);
  }
  print('list : ${contents.toString()}');
  if (ref.isEmpty) {
    return ReferenceWidget(
      contents:
          contents?.map((e) => FileTreeModel.fromJson(jsonDecode(e))).toList(),
      onPressed: onTap,
    );
  } else {
    return ReferenceWidget(
      contents: contents
          ?.map((e) => FileTreeModel(id: '', path: e, type: 'blob', name: e.split('/').last))
          .toList(),
      onPressed: onTap,
    );
  }
}
