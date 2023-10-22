import 'package:injectable/injectable.dart';

import '../../../../core/configuration/configs.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_form_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class SaveAccessTokenUseCase extends UseCase<String, AuthFormEntity> {
  SaveAccessTokenUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<String> useCase(AuthFormEntity params) async {
    // String token = await _authRepository.requestOAuthToken(params.username, params.password);
    globalConfig.accessToken = params.password;
    _authRepository.saveAccessToken(globalConfig.accessToken);
    return globalConfig.accessToken;
  }
}
