import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grimoire/core/designs/colors/color_schemes.dart';

class AdmonitionWidget extends StatelessWidget {
  const AdmonitionWidget(
      {super.key,
      this.strokeColor,
      this.backgroundColor,
      this.textColor,
      this.icon,
      required this.title,
      this.content});

  static const String _tip = "TIP";
  static const String _info = "INFO";
  static const String _caution = "CAUTION";
  static const String _danger = "DANGER";

  final Color? strokeColor; // Color.fromARGB(255, 76, 179, 212)
  final Color? backgroundColor; // Color.fromARGB(255, 238, 249, 253)
  final Color? textColor;
  final Widget? icon;
  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: strokeColor ?? _defaultStrokeColor(),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
        decoration: BoxDecoration(
          color: backgroundColor ?? _defaultBackgroundColor(),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon ?? _defaultIcon(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor ?? _defaultTextColor()),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 2),
                child: Text(
                  content ?? '',
                  style: TextStyle(
                    color: textColor ?? _defaultTextColor(),
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _defaultStrokeColor() {
    if (title.toUpperCase() == _tip) return ColorSchemes.tipBase;
    if (title.toUpperCase() == _info) return ColorSchemes.infoBase;
    if (title.toUpperCase() == _caution) return ColorSchemes.cautionBase;
    if (title.toUpperCase() == _danger) return ColorSchemes.dangerBase;
    return ColorSchemes.infoBase;
  }

  Color _defaultBackgroundColor() {
    if (title.toUpperCase() == _tip) return ColorSchemes.tipLighten;
    if (title.toUpperCase() == _info) return ColorSchemes.infoLighten;
    if (title.toUpperCase() == _caution) return ColorSchemes.cautionLighten;
    if (title.toUpperCase() == _danger) return ColorSchemes.dangerLighten;
    return ColorSchemes.infoLighten;
  }

  Color _defaultTextColor() {
    if (title.toUpperCase() == _tip) return ColorSchemes.tipDarken;
    if (title.toUpperCase() == _info) return ColorSchemes.infoDarken;
    if (title.toUpperCase() == _caution) return ColorSchemes.cautionDarken;
    if (title.toUpperCase() == _danger) return ColorSchemes.dangerDarken;
    return ColorSchemes.infoLighten;
  }

  Widget _defaultIcon() {
    if (title.toUpperCase() == _tip) {
      return const FaIcon(
        FontAwesomeIcons.lightbulb,
        color: ColorSchemes.tipDarken,
        size: 18,
      );
    }
    if (title.toUpperCase() == _info) {
      return const FaIcon(
        FontAwesomeIcons.circleInfo,
        color: ColorSchemes.infoDarken,
        size: 18,
      );
    }
    if (title.toUpperCase() == _caution) {
      return const FaIcon(
        FontAwesomeIcons.triangleExclamation,
        color: ColorSchemes.cautionDarken,
        size: 18,
      );
    }
    if (title.toUpperCase() == _danger) {
      return const FaIcon(
        FontAwesomeIcons.fire,
        color: ColorSchemes.dangerDarken,
        size: 18,
      );
    }
    return const FaIcon(
      FontAwesomeIcons.circleInfo,
      color: ColorSchemes.infoDarken,
      size: 18,
    );
  }
}
