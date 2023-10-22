import 'package:grimoire/features/auth/domain/entities/auth_entity.dart';
import 'package:grimoire/features/auth/domain/entities/auth_form_entity.dart';
import 'package:grimoire/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@injectable
class RequestAccessTokenUseCase extends UseCase<AuthEntity, AuthFormEntity> {
  RequestAccessTokenUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<AuthEntity> useCase(AuthFormEntity params) async {
    return _authRepository.requestAccessToken(params.username, params.password);
  }
}
