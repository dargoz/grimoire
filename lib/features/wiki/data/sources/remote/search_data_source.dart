import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/schema_model.dart';

abstract class SearchDataSource {
  Future<dynamic> createCollection(SchemaModel schema);

  Future<Map<String, dynamic>> multiSearch(Map<String, String> queryParams);

  Future<dynamic> addDocument(
      String collectionName, Map<String, dynamic> document);

  Future<dynamic> importDocuments(
      String collectionName, List<Map<String, dynamic>> documents);
}
