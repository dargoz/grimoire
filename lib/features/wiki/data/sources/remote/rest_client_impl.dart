import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/gitlab_api_service.dart';
import 'package:grimoire/features/wiki/data/sources/remote/rest_client.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/interceptor.dart';
import '../../../../../core/configuration/configs.dart';

@Singleton(as: RestClient)
class RestClientImpl extends RestClient {
  RestClientImpl() {
    final dio = Dio()
      ..interceptors.addAll(
          [CustomInterceptors(), if (kDebugMode) ChuckerDioInterceptor()]);
    //dio.addSentry(captureFailedRequests: true);
    service = GitlabApiService(dio, baseUrl: globalConfig.repositoryUrl);
  }
}
