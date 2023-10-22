class AuthEntity {
  AuthEntity({required this.username, required this.accessToken, required this.isExpired});

  String username;
  String accessToken;
  bool isExpired;
}
