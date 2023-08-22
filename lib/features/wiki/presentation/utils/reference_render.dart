import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grimoire/features/wiki/presentation/utils/reference_widget.dart';

import '../models/file_tree_model.dart';

Widget referenceRender(ExtensionContext renderContext,
    {void Function(FileTreeModel)? onTap}) {
  var ref = '';
  if (renderContext.attributes['class'] != null) {
    String type = renderContext.attributes['class'] as String;
    ref = type.substring(6);
  }

  var contents = renderContext.element?.text.split('\n');
  if (contents?[contents.length - 1].trim().isEmpty ?? false) {
    contents?.removeAt(contents.length - 1);
  }

  if (ref.isEmpty) {
    return ReferenceWidget(
      contents:
          contents?.map((e) => FileTreeModel.fromJson(jsonDecode(e))).toList(),
      onPressed: onTap,
    );
  } else {
    return ReferenceWidget(
      contents: contents
          ?.map((e) => FileTreeModel(
              id: '', path: e, type: 'blob', name: e.split('/').last))
          .toList(),
      onPressed: onTap,
    );
  }
}
