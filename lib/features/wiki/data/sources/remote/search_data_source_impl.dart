import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/search_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/schema_model.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/typesense_client.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SearchDataSource)
class SearchDataSourceImpl extends SearchDataSource {
  final typeSenseClient = TypeSenseClient();

  @override
  Future createCollection(SchemaModel schema) {
    return typeSenseClient.client.collections.create(schema.toSchema());
  }

  @override
  Future<Map<String, dynamic>> multiSearch(Map<String, String> queryParams) {
    return typeSenseClient.client.multiSearch.perform(queryParams);
  }

  @override
  Future addDocument(String collectionName, Map<String, dynamic> document) {
    return typeSenseClient.client
        .collection(collectionName)
        .documents
        .upsert(document);
  }

  @override
  Future<dynamic> importDocuments(
      String collectionName, List<Map<String, dynamic>> documents) {
    var importResult = typeSenseClient.client
        .collection(collectionName)
        .documents
        .importDocuments(documents);
    return importResult;
  }
}
