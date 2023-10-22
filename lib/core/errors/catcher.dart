import 'package:flutter/material.dart';

import 'exception_handler.dart';

class Catcher {
  static ExceptionHandler? _exceptionHandler;

  static void init(ExceptionHandler exceptionHandler) {
    _exceptionHandler = exceptionHandler;
  }

  static void captureException(dynamic exception,
      {dynamic stackTrace, dynamic hint}) {
    _exceptionHandler?.captureException(exception,
        stackTrace: stackTrace, hint: hint);
  }

  static Future<void> captureMessage(
      String? message, {
        CatchLevel? level = CatchLevel.info,
        String? template,
        List<dynamic>? params,
        dynamic hint
      }) async {

  }
}

/// Severity of the logged [Event].
@immutable
class CatchLevel {
  const CatchLevel._(this.name, this.ordinal);

  static const fatal = CatchLevel._('fatal', 5);
  static const error = CatchLevel._('error', 4);
  static const warning = CatchLevel._('warning', 3);
  static const info = CatchLevel._('info', 2);
  static const debug = CatchLevel._('debug', 1);

  /// API name of the level as it is encoded in the JSON protocol.
  final String name;
  final int ordinal;

  factory CatchLevel.fromName(String name) {
    switch (name) {
      case 'fatal':
        return CatchLevel.fatal;
      case 'error':
        return CatchLevel.error;
      case 'warning':
        return CatchLevel.warning;
      case 'info':
        return CatchLevel.info;
    }
    return CatchLevel.debug;
  }

  /// For use with Dart's
  /// [`log`](https://api.dart.dev/stable/2.12.4/dart-developer/log.html)
  /// function.
  /// These levels are inspired by
  /// https://pub.dev/documentation/logging/latest/logging/Level-class.html
  int toDartLogLevel() {
    switch (this) {
    // Level.SHOUT
      case CatchLevel.fatal:
        return 1200;
    // Level.SEVERE
      case CatchLevel.error:
        return 1000;
    // Level.SEVERE
      case CatchLevel.warning:
        return 900;
    // Level.INFO
      case CatchLevel.info:
        return 800;
    // Level.CONFIG
      case CatchLevel.debug:
        return 700;
    }
    return 700;
  }
}
