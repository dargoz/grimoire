import 'package:grimoire/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class GetAccessTokenUseCase extends UseCase<String?, NoParams> {
  GetAccessTokenUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<String?> useCase(NoParams params) async {
    return _authRepository.getAccessToken();
  }
}
