import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:google_fonts/google_fonts.dart';

/*class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }
    print('lang : $language');
    if (language.isEmpty) {
      return HighlightView(
        // The original code to be highlighted
        element.textContent,

        // Specify language
        // It is recommended to give it a value for performance
        language: language,

        // Specify highlight theme
        // All available themes are listed in `themes` folder
        theme: MediaQueryData
            .fromWindow(WidgetsBinding.instance.window)
            .platformBrightness ==
            Brightness.light
            ? atomOneLightTheme
            : atomOneLightTheme,

        // Specify padding
        padding: const EdgeInsets.all(8),

        // Specify text style
        textStyle: GoogleFonts.robotoMono(),
      );
    } else {
      return SizedBox(
        width: MediaQueryData
            .fromWindow(WidgetsBinding.instance.window)
            .size
            .width,
        child: HighlightView(
          // The original code to be highlighted
          element.textContent,

          // Specify language
          // It is recommended to give it a value for performance
          language: language,

          // Specify highlight theme
          // All available themes are listed in `themes` folder
          theme: MediaQueryData
              .fromWindow(WidgetsBinding.instance.window)
              .platformBrightness ==
              Brightness.light
              ? atomOneLightTheme
              : atomOneDarkTheme,

          // Specify padding
          padding: const EdgeInsets.all(8),

          // Specify text style
          textStyle: GoogleFonts.robotoMono(),
        ),
      );
    }
  }
}*/

Widget customCodeRender(RenderContext renderContext, Widget widget) {
  var language = '';

  if (renderContext.tree.element?.attributes['class'] != null) {
    String lg = renderContext.tree.element?.attributes['class'] as String;
    language = lg.substring(9);
  }
  print('lang : $language');
  if (language.isEmpty) {
    return Text(
      renderContext.tree.element!.text,
    );
  } else {
    return SizedBox(
      width:
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      child: HighlightView(
        // The original code to be highlighted
        renderContext.tree.element!.text,

        // Specify language
        // It is recommended to give it a value for performance
        language: language,

        // Specify highlight theme
        // All available themes are listed in `themes` folder
        theme: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .platformBrightness ==
                Brightness.light
            ? atomOneLightTheme
            : atomOneDarkTheme,

        // Specify padding
        padding: const EdgeInsets.all(8),

        // Specify text style
        textStyle: GoogleFonts.robotoMono(),
      ),
    );
  }
}