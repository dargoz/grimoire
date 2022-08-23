import 'package:grimoire/features/wiki/data/sources/remote/remote_data_source.dart';
import 'package:grimoire/features/wiki/data/sources/remote/requests/repository_tree_request.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/commit_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/file_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/repository_tree_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/rest_client.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: RemoteDataSource)
class RemoteDataSourceImpl extends RemoteDataSource {
  RemoteDataSourceImpl(this._restClient);

  final RestClient _restClient;

  @override
  Future<CommitResponse> getCommit(String projectId, String commitId) {
    return _restClient.service.getCommit(projectId, commitId);
  }

  @override
  Future<FileResponse> getRepositoryFile(
      String projectId, String filePath, String ref) {
    return _restClient.service.getFile(projectId, filePath, ref);
  }

  @override
  Future<List<RepositoryTreeResponse>> getRepositoryTree(
      RepositoryTreeRequest request) {
    return _restClient.service
        .getRepositoryTree(request.id, request.recursive, request.perPage);
  }
}