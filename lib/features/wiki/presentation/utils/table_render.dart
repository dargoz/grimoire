import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget tableRender(
    {required RenderContext renderContext,
    required Widget widget,
    required Future<Widget>? Function(String?) imageProvider}) {
  var contents = renderContext.tree.children;
  print('render context : ${renderContext.tree.name}');
  print('render attributes : ${renderContext.tree.attributes}');
  print('table content : ${contents.length}');
  List<TableRow> tableRows = List.empty(growable: true);
  for (var content in contents) {
    print('element child : ${content.name}');
    print('element child has children : ${content.children.length}');

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
  print('*~*~*~*~*~*~*~**~*~*');
  print('element : ${styledElement.element?.text}');
  print('inner children : ${styledElement.children.toList()}');
  print('*~*~*~*~*~*~*~**~*~*');

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
