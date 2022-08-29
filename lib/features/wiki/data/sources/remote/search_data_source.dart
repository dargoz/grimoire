import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/schema_model.dart';

abstract class SearchDataSource {
  Future<dynamic> createCollection(SchemaModel schema);
}
