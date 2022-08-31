import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/responses/file_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/typesense_client.dart';

import '../../../../data/get_string.dart';

void main() {
  test('generate collection from model', () async {
    var typeSense = TypeSenseClient();
    String apiResponseString = getString('file_response.json');
    var json = jsonDecode(apiResponseString);
    var result = FileResponse.fromJson(json);
    var collection = await typeSense.client.collections.create(result.toSchemaModel().toSchema());
    print('collection : ${collection.toString()}');
  });

  test('', () async {
    var typeSense = TypeSenseClient();
    var collection = await typeSense.client.collections.retrieve();
    // print('collection : ${collection}');
  });
}
