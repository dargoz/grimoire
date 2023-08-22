import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/configuration/configs.dart';

class AppRouteGuard {
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    var token = globalConfig.accessToken;
    if (kDebugMode) {
      print('guard $token - redirect :: location : ${state.matchedLocation}');
    }
    return null;
  }
}
