import 'package:grimoire/features/wiki/data/sources/remote/search_data_source.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
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
}
