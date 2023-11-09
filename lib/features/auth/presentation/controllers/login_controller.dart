import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/auth/domain/entities/auth_form_entity.dart';
import 'package:grimoire/features/auth/domain/usecases/request_access_token_use_case.dart';
import 'package:grimoire/features/auth/domain/usecases/save_access_token_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/service_controller.dart';
import 'package:grimoire/injection.dart';
import 'package:grimoire/translation/app_translation.dart';

import '../../../../core/models/resource.dart';

final loginStateNotifierProvider =
    StateNotifierProvider.autoDispose<LoginController, Resource<String>>(
        (ref) => LoginController(ref));

class LoginController extends StateNotifier<Resource<String>> {
  LoginController(this.ref) : super(const Resource<String>.initial('initial')) {
    _serviceController = ref.read(serviceStateNotifierProvider.notifier);
  }

  final Ref ref;
  late final ServiceController _serviceController;
  final RequestAccessTokenUseCase _getBearerTokenUseCase = getIt<RequestAccessTokenUseCase>();

  final SaveAccessTokenUseCase _saveAccessTokenUseCase =
      getIt<SaveAccessTokenUseCase>();

  String tempPassword = '';
  String username = '';

  void onPasswordChanged(String password) {
    tempPassword = password;
  }

  void onUserDomainChanged(String userDomain) {
    username = userDomain;
  }

  void loginButtonPressed() async {
    state = const Resource<String>.loading('login button pressed');
    AuthFormEntity authFormEntity = AuthFormEntity(username: username, password: tempPassword);
    var bearerToken = await _getBearerTokenUseCase.executeUseCase(authFormEntity);

    if(bearerToken.data == null){
      state = Resource<String>.error(AppTranslation.loginFailed.tr, errorCode: "403");
      return;
    }
    
    var result = await _serviceController.executeService(
        _saveAccessTokenUseCase,
        AuthFormEntity(username: '', password: bearerToken.data!.accessToken));
    if (result.status == Status.completed) {
      state = const Resource.initial('done');
    }
  }
}
