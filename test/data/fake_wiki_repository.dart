import 'dart:convert';

import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/repository_tree_response.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';

import 'get_string.dart';

class FakeWikiRepository extends WikiRepository {
  @override
  Future<DocumentEntity> getDocument(String id, String filePath) {
    // TODO: implement getDocument
    throw UnimplementedError();
  }

  @override
  Future<List<FileTreeEntity>> getFileTree(bool recursive, int perPage) async {
    String apiResponseString = getString('repository_tree_list_response.json');
    Iterable json = jsonDecode(apiResponseString);
    var result = List<RepositoryTreeResponse>.from(
        json.map((e) => RepositoryTreeResponse.fromJson(e)));
    return result.map((fileTree) => fileTree.toFileTreeEntity()).toList();
  }
}
