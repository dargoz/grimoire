import 'package:flutter/material.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:flutter_html/flutter_html.dart';

import 'package:grimoire/features/wiki/presentation/utils/admonition_render.dart';
import 'package:grimoire/features/wiki/presentation/utils/admonition_syntax.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../models/file_tree_model.dart';
import '../utils/html_custom_render.dart';
import '../utils/reference_render.dart';
import '../utils/reference_syntax.dart';
import '../utils/table_render.dart';

Widget documentWidget(
    {required BuildContext context,
    required AutoScrollController controller,
    required void Function(String label, GlobalKey parentKey, String attr)
        onSectionRender,
    required Future<Widget>? Function(String?) imageProvider,
    String? htmlContent,
    void Function(FileTreeModel)? onReferenceTap,
    OnTap? onAnchorTap}) {
  return SelectionArea(
    child: Html(
      tagsList: Html.tags
        ..add('admonition')
        ..add('reference'),
      customRender: {
        'code': customCodeRender,
        'h1': (renderContext, widget) => customHeaderRender(
            renderContext, widget,
            onRender: (label, key) => onSectionRender(label, key, '1'),
            controller: controller),
        'h2': (renderContext, widget) => customHeaderRender(
            renderContext, widget,
            onRender: (label, key) => onSectionRender(label, key, '2'),
            controller: controller),
        'h3': (renderContext, widget) => customHeaderRender(
            renderContext, widget,
            onRender: (label, key) => onSectionRender(label, key, '3'),
            controller: controller),
        'h4': (renderContext, widget) => customHeaderRender(
            renderContext, widget,
            onRender: (label, key) => onSectionRender(label, key, '4'),
            controller: controller),
        'h5': (renderContext, widget) => customHeaderRender(
            renderContext, widget,
            onRender: (label, key) => onSectionRender(label, key, '5'),
            controller: controller),
        'h6': (renderContext, widget) => customHeaderRender(
            renderContext, widget,
            onRender: (label, key) => onSectionRender(label, key, '6'),
            controller: controller),
        'table': (renderContext, widget) => tableRender(
            renderContext: renderContext,
            widget: widget,
            imageProvider: imageProvider),
        'admonition': admonitionRender,
        'reference': (renderContext, widget) =>
            referenceRender(renderContext, widget, onTap: onReferenceTap)
      },
      data: md.markdownToHtml(htmlContent ?? '', blockSyntaxes: const [
        md.HeaderWithIdSyntax(),
        AdmonitionSyntax(),
        ReferenceSyntax(),
        md.TableSyntax()
      ]),
      onAnchorTap: onAnchorTap,
    ),
  );
}
