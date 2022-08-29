import 'package:typesense/typesense.dart';

class SchemaModel {
  SchemaModel(this.name, this.fields,
      {this.defaultSortingField, this.documentCount});

  String name;
  final Set<Field> fields;

  /// A field in [fields] which will determine the order in which the search
  /// results are ranked when a `sort_by` clause is not provided during
  /// searching.
  final Field? defaultSortingField;

  /// Number of documents currently in the collection [name].
  final int? documentCount;
}
