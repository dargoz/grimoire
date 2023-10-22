import 'package:grimoire/features/auth/data/mappers/remote_mappers.dart';
import 'package:grimoire/features/auth/data/sources/remote/auth_remote_data_source.dart';
import 'package:grimoire/features/auth/data/sources/remote/requests/bearer_token_request.dart';
import 'package:grimoire/features/auth/data/sources/remote/responses/bearer_token_response.dart';
import 'package:grimoire/features/auth/domain/entities/auth_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import '../sources/local/auth_local_data_source.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<String?> getAccessToken() async {
    return _authLocalDataSource.getAccessToken();
  }

  @override
  Future saveAccessToken(String token) async {
    _authLocalDataSource.saveAccessToken(token);
  }

  @override
  Future<AuthEntity> requestAccessToken(
      String username, String password) async {
        BearerTokenResponse response = await _authRemoteDataSource.requestBearerToken(BearerTokenRequest(username: username, password: password));
    return response.toAuthEntity();
  }
  
  @override
  Future removeAccessToken() async {
    _authLocalDataSource.removeAccessToken();
  }
}
