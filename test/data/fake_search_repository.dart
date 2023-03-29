import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/search_repository.dart';

class FakeSearchRepository implements SearchRepository {

  @override
  Future addDocument(DocumentEntity entity) async {
    return '';
  }

  @override
  Future searchDocument(String query) async {
    return '';
  }

}