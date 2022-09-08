import './gitlab/requests/repository_tree_request.dart';

abstract class RemoteDataSource {
  Future getRepositoryFile(String projectId, String filePath, String ref);

  Future getCommit(String projectId, String commitId);

  Future getRepositoryTree(RepositoryTreeRequest request, String ref);
}
