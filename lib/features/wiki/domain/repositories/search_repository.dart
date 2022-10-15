import '../entities/document_entity.dart';

abstract class SearchRepository {
  Future<dynamic> addDocument(DocumentEntity entity);
  Future<dynamic> searchDocument(String query);
}
