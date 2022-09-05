import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';

import '../entities/document_entity.dart';

abstract class WikiRepository {
  Future<DocumentEntity> getDocument(String id, String filePath,
      {String projectId = ''});

  Future<List<FileTreeEntity>> getFileTree(bool recursive, int perPage,
      {String projectId = ''});
}
