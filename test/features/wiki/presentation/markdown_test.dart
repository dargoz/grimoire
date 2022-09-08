import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/presentation/utils/admonition_syntax.dart';
import 'package:markdown/markdown.dart';

void main() {
  test('markdown', () async {
    var markdown =
        '# Introduction Content - Beginning\n\n:::tip\n\nmy info content here\n\n:::\n\n\n:::warning\n\nmy worries content here\n\n:::\n';
    var result =
        markdownToHtml(markdown, blockSyntaxes: const [AdmonitionSyntax()]);
    print('result : $result');
  });
}
