import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/presentation/utils/admonition_syntax.dart';
import 'package:grimoire/features/wiki/presentation/utils/code_preview_syntax.dart';
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
    var markdown = '# Reference Test\n\n&&&path\ntitle1\ntitle2\ntitle3\n&&&\n';
    var result =
        markdownToHtml(markdown, blockSyntaxes: const [ReferenceSyntax()]);
    expect(
        result,
        '<h1>Reference Test</h1>\n'
        '<pre><reference class="refer-path">title1\n'
        'title2\n'
        'title3\n'
        '</reference></pre>\n');
  });

  test('markdown table', () async {
    var markdown = '# table sample\n'
        '| step   | 1. Layar Home                   | 2. Layar Menu m-info                   | 3. Layar Info                         |\n'
        '|--------|---------------------------------|----------------------------------------|---------------------------------------|\n'
        '| screen | ![img](.assets/home_screen.png) | ![img](.assets/detail_screen.png)      | ![img](.assets/info_screen.png)       |\n';
    var result = markdownToHtml(markdown, blockSyntaxes: const [TableSyntax()]);
    expect(
        result,
        '<h1>table sample</h1>\n'
        '<table>'
        '<thead><tr><th>step</th>'
        '<th>1. Layar Home</th>'
        '<th>2. Layar Menu m-info</th>'
        '<th>3. Layar Info</th></tr>'
        '</thead>'
        '<tbody><tr><td>screen</td>'
        '<td><img src=".assets/home_screen.png" alt="img" /></td>'
        '<td><img src=".assets/detail_screen.png" alt="img" /></td>'
        '<td><img src=".assets/info_screen.png" alt="img" /></td></tr>'
        '</tbody>'
        '</table>\n');
  });

  test('image render test', () async {
    var markdown =
        '# The standard Lorem Ipsum passage, used since the 1500s\n\n'
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do `eiusmod tempor incididunt` ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
        'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
        'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla '
        'pariatur. Excepteur sint occaecat cupidatat non proident, '
        'sunt in culpa qui officia deserunt mollit anim id est laborum."'
        '![turtle](.assets/1-1377908956.png)';
    var result = markdownToHtml(markdown,
        blockSyntaxes: const [HeaderWithIdSyntax(), TableSyntax()]);
    print('result : $result');
  });

  test('markdown code selector', () async {
    var markdown = '''%%%xml-java\n```xml
      <CheckBox
          android:layout_width="match_parent"
          android:layout_height="wrap_content"
          android:text="@string/label"/>
      ```
      --split--
      ```kotlin
      @Composable
      fun Checkbox(
          checked: Boolean,
          onCheckedChange: ((Boolean) -> Unit)?,
          modifier: Modifier = Modifier,
          enabled: Boolean = true,
          colors: CheckboxColors = CheckboxDefaults.colors(),
          interactionSource: MutableInteractionSource = remember { MutableInteractionSource() }
      ): Unit
      ```
      %%%''';
    var result =
        markdownToHtml(markdown, blockSyntaxes: const [CodePreviewSyntax(), TableSyntax()]);
    print('result :\n$result');
    expect(result, '''<pre><code-preview class="xml-java">```xml
      &lt;CheckBox
          android:layout_width="match_parent"
          android:layout_height="wrap_content"
          android:text="@string/label"/&gt;
      ```
      --split--
      ```kotlin
      @Composable
      fun Checkbox(
          checked: Boolean,
          onCheckedChange: ((Boolean) -&gt; Unit)?,
          modifier: Modifier = Modifier,
          enabled: Boolean = true,
          colors: CheckboxColors = CheckboxDefaults.colors(),
          interactionSource: MutableInteractionSource = remember { MutableInteractionSource() }
      ): Unit\n      ```\n</code-preview></pre>\n''');
  });
}
