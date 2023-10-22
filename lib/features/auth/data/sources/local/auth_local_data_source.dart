abstract class AuthLocalDataSource {
  Future<void> saveAccessToken(String accessToken);

  Future<String> getAccessToken();

  Future removeAccessToken();
}
