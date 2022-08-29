import 'package:dio/dio.dart';
import './responses/file_response.dart';
import './responses/repository_tree_response.dart';
import './responses/commit_response.dart';
import 'package:retrofit/http.dart';

part 'gitlab_api_service.g.dart';

@RestApi(baseUrl: 'https://gitlab.com/api/v4/')
abstract class GitlabApiService {
  factory GitlabApiService(Dio dio, {String baseUrl}) = _GitlabApiService;

  @GET('/projects/{project_id}/repository/files/{file_path}')
  Future<FileResponse> getFile(@Path('project_id') String projectId,
      @Path('file_path') String filePath, @Query('ref') String ref);

  @GET('/projects/{project_id}/repository/tree')
  Future<List<RepositoryTreeResponse>> getRepositoryTree(
      @Path('project_id') String projectId,
      @Query("recursive") bool recursive,
      @Query('per_page') int perPage);

  @GET('/projects/{project_id}/repository/commits/{commit_id}')
  Future<CommitResponse> getCommit(
      @Path('project_id') String projectId, @Path('commit_id') commitId);
}
