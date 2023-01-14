import 'package:flutter/material.dart';

class ElevationStateColor implements MaterialStateProperty<double> {
  const ElevationStateColor();

  @override
  double resolve(Set<MaterialState> states) {
    return 0;
  }
}
