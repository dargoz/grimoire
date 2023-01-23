import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

Widget imageRender(
    {required RenderContext renderContext,
    required Widget widget,
    required Future<Widget>? Function(String?) imageProvider}) {
  var img = '';
  if (renderContext.tree.element?.attributes['src'] != null) {
    img = renderContext.tree.element?.attributes['src'] as String;
  }
  print('image content $img');
  return FutureBuilder<Widget>(
      future: imageProvider(img),
      initialData: const Icon(Icons.broken_image),
      builder: (buildContext, snapshot) =>
          snapshot.data ?? const Icon(Icons.broken_image));
}
