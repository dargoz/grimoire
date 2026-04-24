import 'package:flutter/material.dart';

class ElevationStateColor implements WidgetStateProperty<double> {
  const ElevationStateColor();

  @override
  double resolve(Set<WidgetState> states) {
    return 0;
  }
}
