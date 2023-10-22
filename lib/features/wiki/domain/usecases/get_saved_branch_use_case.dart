import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class GetSavedBranchUseCase extends UseCase<String?, NoParams> {
  GetSavedBranchUseCase(this._wikiRepository);

  final WikiRepository _wikiRepository;

  @override
  Future<String?> useCase(NoParams params) async {
    return _wikiRepository.getSavedBranch();
  }
}
