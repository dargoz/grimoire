import 'package:grimoire/features/wiki/data/sources/remote/requests/repository_tree_request.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/commit_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/file_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/repository_tree_response.dart';

abstract class RemoteDataSource {
  Future<FileResponse> getRepositoryFile(String projectId, String filePath, String ref);

  Future<CommitResponse> getCommit(String projectId, String commitId);

  Future<List<RepositoryTreeResponse>> getRepositoryTree(
      RepositoryTreeRequest request);
}
