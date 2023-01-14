import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget tableRender(
    {required RenderContext renderContext,
    required Widget widget,
    required Future<Widget>? Function(String?) imageProvider}) {
  var contents = renderContext.tree.children;
  List<TableRow> tableRows = List.empty(growable: true);
  for (var content in contents) {
    log('element child : ${content.name}');
    log('element child has children : ${content.children.length}');

    for (var tableContent in content.children) {
      var tr = tableContent.children;
      tableRows.add(TableRow(
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: content.name == 'thead'
                  ? const Color(0xFFf0f0f0)
                  : Colors.white),
          children: tr
              .map<Widget>((td) => td.children.isEmpty
                  ? Text(td.element?.text ?? '')
                  : _innerWidget(td, imageProvider))
              .toList()));
    }
  }

  return Table(
    border: TableBorder.all(
        color: Colors.black45,
        borderRadius: const BorderRadius.all(Radius.circular(8))),
    children: tableRows,
  );
}

Widget _innerWidget(StyledElement styledElement,
    Future<Widget>? Function(String?) imageProvider) {
  if (kDebugMode) {
    log('*~*~*~*~*~*~*~**~*~*');
    log('element : ${styledElement.element?.text}');
    log('inner children : ${styledElement.children.toList()}');
    log('*~*~*~*~*~*~*~**~*~*');
  }

  if (styledElement.children[0].name == 'img') {
    return FutureBuilder<Widget>(
        future: imageProvider(styledElement.children[0].attributes['src']),
        initialData: const Icon(Icons.broken_image),
        builder: (buildContext, snapshot) =>
            snapshot.data ?? const Icon(Icons.broken_image));
  }
  return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: _renderElement(styledElement));
}

Widget _renderElement(StyledElement element) {
  return Html(data: element.element?.innerHtml);
}
