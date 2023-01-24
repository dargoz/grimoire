import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';

import '../entities/branch_entity.dart';
import '../entities/document_entity.dart';

abstract class WikiRepository {
  Future<DocumentEntity> getDocument(String id, String filePath,
      {String projectId = ''});

  Future<List<FileTreeEntity>> getFileTree(bool recursive, int perPage,
      {String projectId = '', String ref = ''});

  Future<DocumentEntity> getImage(String id, String filePath,
      {String projectId = '', String ref = ''});

  Future<List<BranchEntity>> getBranches(String id);
}
