import 'dart:developer';
import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/search_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/search_query_request.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/search_result_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typesense/typesense.dart';

import '../../../../core/errors/catcher.dart';
import '../../../../core/errors/failures.dart';
import '../sources/local/local_data_source.dart';

@Singleton(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this._searchDataSource, this._localDataSource);

  final SearchDataSource _searchDataSource;
  final LocalDataSource _localDataSource;

  @override
  Future addDocument(DocumentEntity entity) async {
    var projectId = await _localDataSource.loadProject();
    projectId ??= 'unclassified';
    try {
      var result = await _searchDataSource.addDocument(
          projectId, entity.toDocumentRequest());
      return result;
    } on ObjectNotFound catch (e) {
      Catcher.captureException(e);

      var createResult = await _searchDataSource.createCollection(
          entity.toDocumentRequest().toSchemaModel(projectId));
      log('creation result : $createResult');
      if (createResult == null) {
        throw ServerFailure(
            errorCode: '500', errorMessage: 'Oops.. something goes wrong');
      }
      return _searchDataSource.addDocument(
          projectId, entity.toDocumentRequest());
    }
  }

  @override
  Future<List<SearchResultEntity>> searchDocument(String query) async {
    var projectId = await _localDataSource.loadProject();
    projectId ??= 'unclassified';
    try {
      var response = await _searchDataSource.searchDocument(
          projectId, SearchQueryRequest(q: query, queryBy: 'content'));
      return response.toSearchEntity();
    } on ObjectNotFound catch (e) {
      Catcher.captureException(e);
      throw ServerFailure(
          errorCode: '${e.statusCode}', errorMessage: e.message);
    }
  }
}
