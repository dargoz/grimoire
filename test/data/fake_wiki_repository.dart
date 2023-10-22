import 'dart:convert';

import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/responses/file_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/responses/repository_tree_response.dart';
import 'package:grimoire/features/wiki/domain/entities/branch_entity.dart';

import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';

import 'get_string.dart';

class FakeWikiRepository extends WikiRepository {
  FakeWikiRepository(
      {this.fileResponse = 'file_response.json',
        this.fileTreeResponse = 'repository_tree_list_response.json'});

  final String fileResponse;
  final String fileTreeResponse;

  @override
  Future<DocumentEntity> getDocument(String id, String filePath,
      {String projectId = '', String ref = ''}) async {
    String apiResponseString = getString(fileResponse);
    Map<String, dynamic> json = jsonDecode(apiResponseString);
    var response = FileResponse.fromJson(json);
    return response.toDocumentEntity();
  }

  @override
  Future<List<FileTreeEntity>> getFileTree(bool recursive, int perPage,
      {String projectId = '', String ref = ''}) async {
    String apiResponseString = getString(fileTreeResponse);
    Iterable json = jsonDecode(apiResponseString);
    var result = List<RepositoryTreeResponse>.from(
        json.map((e) => RepositoryTreeResponse.fromJson(e)));
    return result.map((fileTree) => fileTree.toFileTreeEntity()).toList();
  }

  @override
  Future<DocumentEntity> getImage(String id, String filePath,
      {String projectId = '', String ref = ''}) {
    // TODO: implement getImage
    throw UnimplementedError();
  }

  @override
  Future<List<BranchEntity>> getBranches(String id) {
    // TODO: implement getBranches
    throw UnimplementedError();
  }

  @override
  Future<String?> getSavedBranch() {
    // TODO: implement getSavedBranch
    throw UnimplementedError();
  }
}
