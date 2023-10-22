import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/configuration/configs.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_saved_branch_use_case.dart';

import '../core/usecases/no_params.dart';
import '../features/auth/domain/usecases/get_access_token_use_case.dart';
import '../injection.dart';

class AppRouteGuard {
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    /*var getAccessTokenUseCase = getIt<GetAccessTokenUseCase>();
    var token = await getAccessTokenUseCase.executeUseCase(NoParams());
    print('guard ${token.data} - redirect :: location : ${state.matchedLocation}');
    if (token.data == '' && state.matchedLocation != '/login') {
      return '/login';
    }*/

    var getSavedBranchUseCase = getIt<GetSavedBranchUseCase>();
    var ref = await getSavedBranchUseCase.executeUseCase(NoParams());
    state.pathParameters['branch'] = ref.data ?? '';
    
    // globalConfig.accessToken = token.data!;
    return null;
  }
}
