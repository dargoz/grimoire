import '../entities/document_entity.dart';

abstract class SearchRepository {

  Future<dynamic> createCollection(DocumentEntity entity);

}