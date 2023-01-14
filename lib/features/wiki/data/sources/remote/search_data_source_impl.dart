import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/search_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/schema_model.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/add_document_request.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/search_query_request.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/responses/search_response.dart';
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
  Future addDocument(
      String collectionName, AddDocumentRequest addDocumentRequest) {
    return typeSenseClient.client
        .collection(collectionName)
        .documents
        .upsert(addDocumentRequest.toJson());
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

  @override
  Future<SearchResponse> searchDocument(
      String collectionName, SearchQueryRequest searchQueryRequest) async {
    var result = await typeSenseClient.client
        .collection(collectionName)
        .documents
        .search(searchQueryRequest.toJson());
    return SearchResponse.fromJson(result);
  }
}
