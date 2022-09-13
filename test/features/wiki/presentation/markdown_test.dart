import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/presentation/utils/admonition_syntax.dart';
import 'package:grimoire/features/wiki/presentation/utils/reference_syntax.dart';
import 'package:markdown/markdown.dart';

void main() {
  test('markdown admonition', () async {
    var markdown = '# Introduction Content - Beginning\n'
        '\n:::tip\n\nmy info content here\n\n:::\n\n'
        '\n:::warning\n\nmy worries content here\n\n:::\n';
    var result =
        markdownToHtml(markdown, blockSyntaxes: const [AdmonitionSyntax()]);
    expect(
        result,
        '<h1>Introduction Content - Beginning</h1>\n'
        '<pre><admonition class="type-tip">\n'
        'my info content here\n\n'
        '</admonition></pre>\n'
        '<pre><admonition class="type-warning">\n'
        'my worries content here\n\n'
        '</admonition></pre>\n');
  });

  test('markdown reference', () async {
    var markdown = '# Reference Test\n\n&&&\ntitle1\ntitle2\ntitle3\n&&&\n';
    var result =
        markdownToHtml(markdown, blockSyntaxes: const [ReferenceSyntax()]);
    expect(
        result,
        '<h1>Reference Test</h1>\n'
        '<pre><reference>title1\n'
        'title2\n'
        'title3\n'
        '</reference></pre>\n');
  });

  test('markdown table', () async {
    var markdown = '# table sample\n'
        '| step   | 1. Layar Home BCA mobile        | 2. Layar Menu m-info                   | 3. Layar Info Saldo Rekeing           |\n'
        '|--------|---------------------------------|----------------------------------------|---------------------------------------|\n'
        '| screen | ![img](.assets/home_screen.png) | ![img](.assets/detail_screen.png)      | ![img](.assets/info_screen.png)       |\n';
    var result = markdownToHtml(markdown, blockSyntaxes: const [
      AdmonitionSyntax(),
      ReferenceSyntax(),
      TableSyntax()
    ]);
    expect(
        result,
        '<h1>table sample</h1>\n'
        '<table>'
        '<thead><tr><th>step</th>'
        '<th>1. Layar Home BCA mobile</th>'
        '<th>2. Layar Menu m-info</th>'
        '<th>3. Layar Info Saldo Rekeing</th></tr>'
        '</thead>'
        '<tbody><tr><td>screen</td>'
        '<td><img src=".assets/home_screen.png" alt="img" /></td>'
        '<td><img src=".assets/detail_screen.png" alt="img" /></td>'
        '<td><img src=".assets/info_screen.png" alt="img" /></td></tr>'
        '</tbody>'
        '</table>\n');
  });
}
