import 'package:grimoire/core/usecases/usecase.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVersionUseCase extends UseCase<List<String>, String> {
  GetVersionUseCase(this._wikiRepository);

  final WikiRepository _wikiRepository;

  @override
  Future<List<String>> useCase(String params) async {
    var result = await _wikiRepository.getBranches(params);
    return result.map((e) => e.name).toList();
  }
}
