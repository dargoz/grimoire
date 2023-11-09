import 'package:grimoire/features/auth/data/sources/remote/auth_rest_client.dart';
import 'package:grimoire/features/auth/data/sources/remote/requests/bearer_token_request.dart';
import 'package:grimoire/features/auth/data/sources/remote/responses/bearer_token_response.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'auth_remote_data_source.dart';


const identifier =
    '50aacd1e1ae1da4d205722c418799835340b2698d489bb3a5c0688683ae8f31e';
const secret =
    'a607cedc3d58d2827eccb4f1336aa7be7aba488b85a1e40a0c8ea1ac3ba05cb3';

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final AuthRestClient _authRestClient;

  AuthRemoteDataSourceImpl(this._authRestClient);

  Future<void> redirect(Uri authorizationUrl) async {
    print('url redirect : ${authorizationUrl.toString()}');
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl);
    }
  }

  @override
  Future requestOAuthAuthorization() async {

  }

  @override
  Future requestOAuthToken(Uri responseUrl) async {

  }
  
  @override
  Future<BearerTokenResponse> requestBearerToken(BearerTokenRequest bearerTokenRequest) async {
    return _authRestClient.service.requestBearerToken(bearerTokenRequest);
  }
}
