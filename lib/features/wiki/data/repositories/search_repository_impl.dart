import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/search_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/search_query_request.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/search_result_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this._searchDataSource);

  final SearchDataSource _searchDataSource;

  @override
  Future createCollection(DocumentEntity entity) {
    // TODO: implement createCollection
    throw UnimplementedError();
  }

  @override
  Future addDocument(DocumentEntity entity) {
    return _searchDataSource.addDocument('wiki', entity.toDocumentRequest());
  }

  @override
  Future<List<SearchResultEntity>> searchDocument(String query) async {
    var response = await _searchDataSource.searchDocument(
        'wiki', SearchQueryRequest(q: query, queryBy: 'content'));
    return response.toSearchEntity();
  }
}
