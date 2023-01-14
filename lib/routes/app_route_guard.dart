import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/configuration/configs.dart';

class AppRouteGuard {
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    var token = globalConfig.accessToken;
    print('guard $token - redirect :: location : ${state.location}');
    return null;
  }
}
