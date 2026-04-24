import 'package:flutter/material.dart';

extension WidgetStateSet on Set<WidgetState> {
  bool get isHovered => contains(WidgetState.hovered);
  bool get isFocused => contains(WidgetState.focused);
  bool get isPressed => contains(WidgetState.pressed);
  bool get isDisabled => contains(WidgetState.disabled);
}
