import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget imageRender(
    {required ExtensionContext renderContext,
    required Future<Widget>? Function(String?, {double? width, double? height})
        imageProvider}) {
  var img = '';
  double? width;
  double? height;

  try {
    width = double.parse(renderContext.attributes['width'] ?? '');
  } catch (e) {
    width = null;
  }

  try {
    height = double.parse(renderContext.attributes['height'] ?? '');
  } catch (e) {
    height = null;
  }

  if (renderContext.attributes['src'] != null) {
    img = renderContext.attributes['src'] as String;
  }
  print('image content $img');
  return FutureBuilder<Widget>(
      future: imageProvider(img, width: width, height: height),
      initialData: const Icon(Icons.broken_image),
      builder: (buildContext, snapshot) =>
          snapshot.data ?? const Icon(Icons.broken_image));
}
