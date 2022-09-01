import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/highlight_entity.dart';

class SearchResultEntity {
  SearchResultEntity(
      {required this.documentEntity,
      required this.highlights,
      required this.textMatch});

  DocumentEntity? documentEntity;
  List<HighlightEntity>? highlights;
  int textMatch;

  @override
  String toString() {
    return 'SearchResultEntity{'
        'documentEntity: $documentEntity, '
        'highlights: $highlights, '
        'textMatch: $textMatch}';
  }
}
