import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/responses/file_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/search_data_source_impl.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/search_query_request.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/typesense_client.dart';

import '../../../../data/get_string.dart';

void main() {
  test('generate collection', () async {
    var typeSense = TypeSenseClient();
    String apiResponseString = getString('file_response.json');
    var json = jsonDecode(apiResponseString);
    var result =
        FileResponse.fromJson(json).toDocumentEntity().toDocumentRequest();
    var collection = await typeSense.client.collections
        .create(result.toSchemaModel('2033').toSchema());
    print('collection : ${collection.toString()}');
  });

  test('search document', () async {
    var searchDataSource = SearchDataSourceImpl();
    try {
      var response = await searchDataSource.searchDocument('2033',
          SearchQueryRequest(q: 'table of content', queryBy: 'content'));
      print('response :\n${response.toJson()}');
    } catch (e) {
      print('exception : ${e.runtimeType}');
    }

    /*var documents = typeSense.client.collection('files').documents.search('searchParameters');
    print('collection : ${document}');*/
  });

  test('get document', () async {
    var searchDataSource = SearchDataSourceImpl();
    var result =
        searchDataSource.typeSenseClient.client.collection('wiki').documents;
    print('documents :\n$result');
  });

  test('drop collection', () async {
    var searchDataSource = SearchDataSourceImpl();
    var result = await searchDataSource.typeSenseClient.client
        .collection('2033')
        .delete();
    print('documents :\n$result');
  });
}
