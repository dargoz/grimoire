import 'package:grimoire/core/usecases/no_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class RemoveAccessTokenUseCase extends UseCase<String?, NoParams> {
  RemoveAccessTokenUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<String?> useCase(NoParams params) async {
    _authRepository.removeAccessToken();
    return null;
  }
}
