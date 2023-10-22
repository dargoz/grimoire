import 'package:grimoire/features/auth/data/sources/remote/requests/bearer_token_request.dart';

abstract class AuthRemoteDataSource {
  Future requestOAuthAuthorization();
  Future requestOAuthToken(Uri responseUrl);
  Future requestBearerToken(BearerTokenRequest bearerTokenRequest);
}
