import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/typesense_client.dart';
import 'package:typesense/typesense.dart';

void main() {
  test('typesense', () async {
    var typeSense = TypeSenseClient();
    /*var collection = await typeSense.client.collections.create(Schema("name", fields));
    Schema data = collection[0];
    print('collection : ${collection.length}');
*/
  });
}
