import 'package:flutter/material.dart';
import 'package:grimoire/features/wiki/presentation/utils/code_preview_render.dart';
import 'package:grimoire/features/wiki/presentation/utils/custom_code_render.dart';
import 'package:grimoire/features/wiki/presentation/utils/image_render.dart';
import 'package:grimoire/features/wiki/presentation/utils/table_syntax.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:flutter_html/flutter_html.dart';

import 'package:grimoire/features/wiki/presentation/utils/admonition_render.dart';
import 'package:grimoire/features/wiki/presentation/utils/admonition_syntax.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../models/file_tree_model.dart';
import '../utils/code_preview_syntax.dart';
import '../utils/html_custom_render.dart';
import '../utils/reference_render.dart';
import '../utils/reference_syntax.dart';
import '../utils/table_render.dart';

Widget markdownWidget(
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
      extensions: [
        TagExtension(
          tagsToExtend: {"code"},
          builder: (extensionContext) {
            return CustomCodeRender(renderContext: extensionContext);
          },
        ),
        TagExtension(
          tagsToExtend: {"h1", "h2", "h3", "h4", "h5", "h6"},
          builder: (extensionContext) {
            return customHeaderRender(extensionContext,
                onRender: (label, key) => onSectionRender(
                    label,
                    key,
                    extensionContext.elementName.characters.last),
                controller: controller);
          },
        ),
        TagExtension(
          tagsToExtend: {"table"},
          builder: (extensionContext) {
            return tableRender(
                renderContext: extensionContext,
                context: context,
                imageProvider: imageProvider);
          },
        ),
        TagExtension(
          tagsToExtend: {"img"},
          builder: (extensionContext) {
            return imageRender(
                renderContext: extensionContext,
                imageProvider: imageProvider);
          },
        ),
        TagExtension(
          tagsToExtend: {"admonition"},
          builder: admonitionRender,
        ),
        TagExtension(
          tagsToExtend: {"code-preview"},
          builder: codePreviewRender,
        ),TagExtension(
          tagsToExtend: {"reference"},
          builder: (extensionContext) {
            return referenceRender(
                extensionContext,
                onTap: onReferenceTap);
          },
        ),

      ],
      data: md.markdownToHtml(htmlContent ?? '', blockSyntaxes: const [
        md.HeaderWithIdSyntax(),
        AdmonitionSyntax(),
        ReferenceSyntax(),
        TableSyntax(),
        CodePreviewSyntax()
      ]),
      onAnchorTap: onAnchorTap,
    ),
  );
}
