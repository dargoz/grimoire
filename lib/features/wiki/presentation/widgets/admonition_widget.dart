import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      width: MediaQuery.of(context).size.width,
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
    if (title.toUpperCase() == _tip) return const Color(0xFF009400);
    if (title.toUpperCase() == _info) return const Color(0xFF4cb3d4);
    if (title.toUpperCase() == _caution) return const Color(0xFFe6a700);
    if (title.toUpperCase() == _danger) return const Color(0xFFe13238);
    return const Color(0xFF4cb3d4);
  }

  Color _defaultBackgroundColor() {
    if (title.toUpperCase() == _tip) return const Color(0xFFe6f6e6);
    if (title.toUpperCase() == _info) return const Color(0xFFeef9fd);
    if (title.toUpperCase() == _caution) return const Color(0xFFfff8e6);
    if (title.toUpperCase() == _danger) return const Color(0xFFffebec);
    return const Color(0xFFeef9fd);
  }

  Color _defaultTextColor() {
    if (title.toUpperCase() == _tip) return const Color(0xFF003100);
    if (title.toUpperCase() == _info) return const Color(0xFF193c47);
    if (title.toUpperCase() == _caution) return const Color(0xFF4d3800);
    if (title.toUpperCase() == _danger) return const Color(0xFF4b1113);
    return const Color(0xFF193c47);
  }

  Widget _defaultIcon() {
    if (title.toUpperCase() == _tip) {
      return const FaIcon(
        FontAwesomeIcons.lightbulb,
        color: Color(0xFF003100),
        size: 18,
      );
    }
    if (title.toUpperCase() == _info) {
      return const FaIcon(
        FontAwesomeIcons.circleInfo,
        color: Color(0xFF193c47),
        size: 18,
      );
    }
    if (title.toUpperCase() == _caution) {
      return const FaIcon(
        FontAwesomeIcons.triangleExclamation,
        color: Color(0xFF4d3800),
        size: 18,
      );
    }
    if (title.toUpperCase() == _danger) {
      return const FaIcon(
        FontAwesomeIcons.fire,
        color: Color(0xFF4b1113),
        size: 18,
      );
    }
    return const FaIcon(
      FontAwesomeIcons.circleInfo,
      color: Color(0xFF193c47),
      size: 18,
    );
  }
}
