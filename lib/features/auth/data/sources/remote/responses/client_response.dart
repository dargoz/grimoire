class ClientResponse {
  String username;
  String accessToken;
  bool canRefresh;
  final List<String>? scopes;
  final DateTime? expiration;

  ClientResponse(
      this.username, this.accessToken, this.canRefresh, this.scopes, this.expiration);
}

extension OAuthExt on ClientResponse {
  String toAccessToken() {
    return accessToken;
  }
}
