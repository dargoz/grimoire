import 'package:dio/dio.dart';
import 'package:grimoire/core/api/auth_interceptor.dart';
import 'package:grimoire/features/auth/data/sources/remote/auth_rest_client.dart';
import 'package:grimoire/features/auth/data/sources/remote/grimoire_api_service.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRestClient)
class AuthRestClientImpl extends AuthRestClient {
  AuthRestClientImpl() {
    final dio = Dio()
      ..interceptors.addAll(
          [AuthInterceptors()]);
    service = GrimoireApiService(dio);
  }   
}
