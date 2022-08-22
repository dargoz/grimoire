import 'package:flutter/foundation.dart';
import 'package:grimoire/features/wiki/data/mappers/local_mappers.dart';
import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/local/local_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/remote_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/requests/repository_tree_request.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: WikiRepository)
class WikiRepositoryImpl extends WikiRepository {
  WikiRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final String _projectId = '27745171';
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  @override
  Future<DocumentEntity> getDocument(String id, String filePath) async {
    var cache = await _localDataSource.getDocument(id);
    if (cache != null) {
      if(kDebugMode) {
        print("using cache");
      }
      return cache.toDocumentEntity();
    }
    var fileResponse =
        await _remoteDataSource.getRepositoryFile(_projectId, filePath, "main");
    var commitResponse =
        await _remoteDataSource.getCommit(_projectId, fileResponse.commitId);
    var documentEntity = fileResponse.toDocumentEntity();
    documentEntity.commitEntity = commitResponse.toCommitEntity();
    var fileObject = fileResponse.toFileObject();
    fileObject.commitObject = commitResponse.toCommitObject();
    _localDataSource.saveDocument(fileObject);
    return documentEntity;
  }

  @override
  Future<List<FileTreeEntity>> getFileTree(bool recursive, int perPage) async {
    var response = await _remoteDataSource.getRepositoryTree(
        RepositoryTreeRequest(id: _projectId, recursive: true));
    return response.map((fileTree) => fileTree.toFileTreeEntity()).toList();
  }
}
