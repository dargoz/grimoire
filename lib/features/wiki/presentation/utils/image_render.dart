import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget imageRender(
    {required ExtensionContext renderContext,
    required Future<Widget>? Function(String?) imageProvider}) {
  var img = '';
  if (renderContext.attributes['src'] != null) {
    img = renderContext.attributes['src'] as String;
  }
  print('image content $img');
  return FutureBuilder<Widget>(
      future: imageProvider(img),
      initialData: const Icon(Icons.broken_image),
      builder: (buildContext, snapshot) =>
          snapshot.data ?? const Icon(Icons.broken_image));
}
