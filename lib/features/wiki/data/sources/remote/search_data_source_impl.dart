import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/search_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/schema_model.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense_client.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SearchDataSource)
class SearchDataSourceImpl extends SearchDataSource {
  final typeSenseClient = TypeSenseClient();

  @override
  Future createCollection(SchemaModel schema) {
    return typeSenseClient.client.collections.create(schema.toSchema());
  }
}
