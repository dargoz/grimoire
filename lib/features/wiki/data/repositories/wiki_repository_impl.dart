import 'package:flutter/foundation.dart';
import 'package:grimoire/features/wiki/data/mappers/local_mappers.dart';
import 'package:grimoire/features/wiki/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/wiki/data/sources/local/local_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/responses/file_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/remote_data_source.dart';

import '../sources/remote/gitlab/requests/repository_tree_request.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

import '../sources/remote/gitlab/responses/commit_response.dart';
import '../sources/remote/gitlab/responses/repository_tree_response.dart';

@Singleton(as: WikiRepository)
class WikiRepositoryImpl extends WikiRepository {
  WikiRepositoryImpl(this._remoteDataSource, this._localDataSource);

  String _projectId = '27745171';
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  @override
  Future<DocumentEntity> getDocument(String id, String filePath,
      {String projectId = ''}) async {
    var cacheProject = await _localDataSource.loadProject();
    if (cacheProject != null) {
      _projectId = cacheProject;
    }
    if (projectId.isNotEmpty) _projectId = projectId;
    var cache = await _localDataSource.getDocument(id + filePath);
    print('cache document : $cache');
    if (cache != null) {
      if (kDebugMode) {
        print("using cache");
      }
      return cache.toDocumentEntity();
    }
    filePath = filePath.replaceAll('/', '%2F');
    filePath = filePath.replaceAll('.', '%2E');
    print('call get repository file : $filePath');
    FileResponse fileResponse =
        await _remoteDataSource.getRepositoryFile(_projectId, filePath, "main");
    CommitResponse commitResponse = await _remoteDataSource.getCommit(
        _projectId, fileResponse.lastCommitId);
    print('mapping response... : $commitResponse');
    var documentEntity = fileResponse.toDocumentEntity();
    documentEntity.commitEntity = commitResponse.toCommitEntity();
    var fileObject = fileResponse.toFileObject();
    fileObject.commitObject = commitResponse.toCommitObject();
    print('start save document : $filePath');
    _localDataSource.saveDocument(fileObject);
    print('return entity : $documentEntity');
    return documentEntity;
  }

  @override
  Future<List<FileTreeEntity>> getFileTree(bool recursive, int perPage,
      {String projectId = ''}) async {
    if (projectId.isNotEmpty) _projectId = projectId;
    _localDataSource.saveProject(_projectId);
    List<RepositoryTreeResponse> response =
        await _remoteDataSource.getRepositoryTree(RepositoryTreeRequest(
            id: _projectId, recursive: true, perPage: 100), "main");
    return response.map((fileTree) => fileTree.toFileTreeEntity()).toList();
  }

  @override
  Future<DocumentEntity> getImage(String id, String filePath, {String projectId = ''}) async {
    if (projectId.isNotEmpty) _projectId = projectId;
    var cache = await _localDataSource.getDocument(id + filePath);
    if (cache != null) {
      if (kDebugMode) {
        print("using image cache");
      }
      return cache.toDocumentEntity();
    }
    filePath = filePath.replaceAll('/', '%2F');
    filePath = filePath.replaceAll('.', '%2E');
    FileResponse fileResponse =
        await _remoteDataSource.getRepositoryFile(_projectId, filePath, "main");
    CommitResponse commitResponse = await _remoteDataSource.getCommit(
        _projectId, fileResponse.lastCommitId);
    var documentEntity = fileResponse.toDocumentEntity();
    documentEntity.commitEntity = commitResponse.toCommitEntity();
    var fileObject = fileResponse.toFileObject();
    fileObject.blobId = id;
    fileObject.commitObject = commitResponse.toCommitObject();
    _localDataSource.saveDocument(fileObject);
    return documentEntity;
  }
}
