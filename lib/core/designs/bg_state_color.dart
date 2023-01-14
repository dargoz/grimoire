import 'package:flutter/material.dart';
import 'package:grimoire/core/designs/state_ext.dart';

class BgStateColor implements MaterialStateProperty<Color?> {
  const BgStateColor(this.baseColor);

  final Color baseColor;
  @override
  Color? resolve(Set<MaterialState> states) {
    Color? color = baseColor;
    Color? darkerVersion = Color.lerp(color, Colors.white, 0.3);
    // Darken our button color for each state we want to reflect. Buttons will
    // incrementally darken as more states are applied.
    if (states.isHovered) {
      color = Color.lerp(color, darkerVersion, 0.3);
    }
    if (states.isPressed) {
      color = Color.lerp(color, darkerVersion, 0.3);
    }
    if (states.isDisabled) {
      color = const Color(0xFFeeeeee);
    }
    return color;
  }
}
