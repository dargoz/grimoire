import './gitlab/requests/repository_tree_request.dart';
import './gitlab/responses/commit_response.dart';
import './gitlab/responses/file_response.dart';
import './gitlab/responses/repository_tree_response.dart';

abstract class RemoteDataSource {
  Future<FileResponse> getRepositoryFile(
      String projectId, String filePath, String ref);

  Future<CommitResponse> getCommit(String projectId, String commitId);

  Future<List<RepositoryTreeResponse>> getRepositoryTree(
      RepositoryTreeRequest request);
}
