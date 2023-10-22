import 'package:dio/dio.dart';
import 'package:grimoire/features/auth/data/sources/remote/requests/bearer_token_request.dart';
import 'package:grimoire/features/auth/data/sources/remote/responses/bearer_token_response.dart';
import 'package:retrofit/http.dart';

part 'grimoire_api_service.g.dart';

@RestApi(baseUrl: 'http://grimoire-service.apps.ocpdev.dti.co.id/')
abstract class GrimoireApiService {
  factory GrimoireApiService(Dio dio, {String baseUrl}) = _GrimoireApiService;

  @POST('/auth')
  Future<BearerTokenResponse> requestBearerToken(
      @Body() BearerTokenRequest bearerTokenRequest,);
}
