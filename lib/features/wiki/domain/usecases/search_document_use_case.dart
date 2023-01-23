import 'package:flutter/foundation.dart';
import 'package:grimoire/features/wiki/domain/entities/highlight_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/search_result_entity.dart';

@injectable
class SearchDocumentUseCase extends UseCase<List<SearchResultEntity>, String> {
  SearchDocumentUseCase(this._searchRepository);

  final SearchRepository _searchRepository;

  @override
  Future<List<SearchResultEntity>> useCase(String params) async {
    List<SearchResultEntity> result =
        await _searchRepository.searchDocument(params);
    for (var entity in result) {
      for (var highlight in entity.highlights ?? <HighlightEntity>[]) {
        var splitWord = highlight.snippet.split('\n');
        if (kDebugMode) {
          print('split word : $splitWord');
        }
        var index =
            splitWord.indexWhere((element) => element.contains("<mark>"));
        if (index != -1) {
          highlight.snippet = splitWord[index];
        }
      }
    }
    return result;
  }
}
