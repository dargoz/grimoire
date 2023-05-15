import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as d;

Widget tableRender(
    {required ExtensionContext renderContext,
    required BuildContext context,
    required Future<Widget>? Function(String?) imageProvider}) {
  var contents = renderContext.elementChildren;
  List<TableRow> tableColumn = List.empty(growable: true);
  List<TableRow> tableRows = List.empty(growable: true);
  var documentWidth = (MediaQuery.of(context).size.width * 0.6) - 32;
  for (var content in contents) {
    log('element child : ${content.localName}');
    log('element child has children : ${content.children.length}');

    for (var tableContent in content.children) {
      var tr = tableContent.children;
      if (content.localName == 'thead') {
        var cellWidth = documentWidth / tr.length;
        tableColumn.add(TableRow(
            decoration: const BoxDecoration(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(8)),
                color: Color(0xFFf0f0f0)),
            children: tr
                .map(
                  (th) => SizedBox(
                      width: cellWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          th.text ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )),
                )
                .toList()));
      } else if (content.localName == 'tbody') {
        var cellWidth = documentWidth / tr.length;
        tableRows.add(TableRow(
            children: tr
                .map((td) => SizedBox(
                      width: cellWidth,
                      child: _innerWidget(td, imageProvider),
                    ))
                .toList()));
      }
    }
  }

  var tableData = tableColumn + tableRows;
  try {
    return SizedBox(
        width: documentWidth,
        child: Table(
          border: TableBorder.all(
              color: Colors.black45,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          children: tableData,
        ),
      );
  } catch (e) {
    return renderContext.buildContext!.widget;
  }
}

Widget _innerWidget(d.Element styledElement,
    Future<Widget>? Function(String?) imageProvider) {
  if (kDebugMode) {
    log('*~*~*~*~*~*~*~**~*~*');
    log('element : ${styledElement.text}');
    log('inner children : ${styledElement.children.toList()}');
    log('*~*~*~*~*~*~*~**~*~*');
  }

  if (styledElement.children.isNotEmpty &&
      styledElement.children[0].localName == 'img') {
    return FutureBuilder<Widget>(
        future: imageProvider(styledElement.children[0].attributes['src']),
        initialData: const Icon(Icons.broken_image),
        builder: (buildContext, snapshot) =>
            snapshot.data ?? const Icon(Icons.broken_image));
  }
  return _renderElement(styledElement);
}

Widget _renderElement(d.Element element) {
  return Html(data: element.innerHtml);
}
