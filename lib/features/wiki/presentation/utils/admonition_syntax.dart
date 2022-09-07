import 'dart:convert';

import 'package:markdown/markdown.dart';

import 'flavor_patterns.dart';

/// inspiration : https://docusaurus.io/docs/markdown-features/admonitions
class AdmonitionSyntax extends BlockSyntax {
  const AdmonitionSyntax();

  @override
  bool canParse(BlockParser parser) {
    final match = pattern.firstMatch(parser.current);
    if (match == null) return false;
    final codeFence = match.group(1)!;
    final infoString = match.group(2);
    // From the CommonMark spec:
    //
    // > If the info string comes after a backtick fence, it may not contain
    // > any backtick characters.
    return (codeFence.codeUnitAt(0) != $colon ||
        !infoString!.codeUnits.contains($colon));
  }

  @override
  List<String> parseChildLines(BlockParser parser, [String? endBlock]) {
    endBlock ??= '';

    final childLines = <String>[];
    parser.advance();

    while (!parser.isDone) {
      final match = pattern.firstMatch(parser.current);
      if (match == null || !match[1]!.startsWith(endBlock)) {
        childLines.add(parser.current);
        parser.advance();
      } else {
        parser.advance();
        break;
      }
    }

    return childLines;
  }

  @override
  Node? parse(BlockParser parser) {
    final match = pattern.firstMatch(parser.current)!;
    final endBlock = match.group(1);
    var infoString = match.group(2)!;
    print('endBlock : $endBlock');
    print('infoString : $infoString');
    final childLines = parseChildLines(parser, endBlock);

    // The Markdown tests expect a trailing newline.
    childLines.add('');

    var text = childLines.join('\n');
    if (parser.document.encodeHtml) {
      var escapeHtml = const HtmlEscape(HtmlEscapeMode.element);
      text = escapeHtml.convert(text);
    }
    final code = Element.text('admonition', text);

    // the info-string should be trimmed
    // http://spec.commonmark.org/0.22/#example-100
    infoString = infoString.trim();
    if (infoString.isNotEmpty) {
      // only use the first word in the syntax
      // http://spec.commonmark.org/0.22/#example-100
      final firstSpace = infoString.indexOf(' ');
      if (firstSpace >= 0) {
        infoString = infoString.substring(0, firstSpace);
      }
      if (parser.document.encodeHtml) {
        var escapeHtmlAttribute = const HtmlEscape(HtmlEscapeMode.attribute);
        infoString = escapeHtmlAttribute.convert(infoString);
      }
      code.attributes['class'] = 'type-$infoString';
    }

    final element = Element('pre', [code]);

    return element;
  }

  @override
  RegExp get pattern => flavorPattern;
}
