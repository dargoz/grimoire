import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'gitlab_api_service.g.dart';

@RestApi(baseUrl: 'https://gitlab.com/api/v4/')
abstract class GitlabApiService {
  factory GitlabApiService(Dio dio, {String baseUrl}) = _GitlabApiService;
}
