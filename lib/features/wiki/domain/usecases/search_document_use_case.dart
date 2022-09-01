import 'package:grimoire/core/usecases/usecase.dart';
import 'package:grimoire/features/wiki/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/search_result_entity.dart';

@injectable
class SearchDocumentUseCase extends UseCase<List<SearchResultEntity>, String> {
  SearchDocumentUseCase(this._searchRepository);

  final SearchRepository _searchRepository;

  @override
  Future<List<SearchResultEntity>> useCase(String params) async {
    List<SearchResultEntity> result = await _searchRepository.searchDocument(params);
    return result;
  }

}
