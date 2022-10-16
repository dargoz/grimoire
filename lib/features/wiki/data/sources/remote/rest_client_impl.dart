import 'package:dio/dio.dart';
import 'package:grimoire/core/models/configs.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/gitlab_api_service.dart';
import 'package:grimoire/features/wiki/data/sources/remote/rest_client.dart';

import '../../../../../core/api/interceptor.dart';

class RestClientImpl extends RestClient {
  RestClientImpl(Configs configs) {
    final dio = Dio()..interceptors.add(CustomInterceptors(configs.accessToken));
    //dio.addSentry(captureFailedRequests: true);
    service = GitlabApiService(dio, baseUrl: configs.repositoryUrl);
  }
}
