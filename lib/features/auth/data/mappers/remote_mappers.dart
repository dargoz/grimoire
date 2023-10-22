import 'package:grimoire/features/auth/data/sources/remote/responses/bearer_token_response.dart';
import 'package:grimoire/features/auth/domain/entities/auth_entity.dart';

extension BearerTokenMapper on BearerTokenResponse {
  AuthEntity toAuthEntity() {
    return AuthEntity(
        username: '', accessToken: accessToken, isExpired: isExpired);
  }
}
