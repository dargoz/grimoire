import 'package:grimoire/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {

  Future saveAccessToken(String token);

  Future<String?> getAccessToken();

  Future<AuthEntity> requestAccessToken(String username, String password);

  Future removeAccessToken();
}
