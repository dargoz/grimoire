import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/schema_model.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/add_document_request.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/search_query_request.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/responses/search_response.dart';

abstract class SearchDataSource {
  Future<dynamic> createCollection(SchemaModel schema);

  Future<Map<String, dynamic>> multiSearch(Map<String, String> queryParams);

  Future<dynamic> addDocument(
      String collectionName, AddDocumentRequest addDocumentRequest);

  Future<dynamic> importDocuments(
      String collectionName, List<Map<String, dynamic>> documents);

  Future<SearchResponse> searchDocument(String collectionName,
      SearchQueryRequest searchQueryRequest);
}
