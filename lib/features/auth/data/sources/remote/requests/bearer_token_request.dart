import 'package:json_annotation/json_annotation.dart';
part 'bearer_token_request.g.dart';

@JsonSerializable()
class BearerTokenRequest {
  @JsonKey(name: 'username')
  String username;
  @JsonKey(name: 'password')
  String password;

  BearerTokenRequest(
      {required this.username, required this.password});

  factory BearerTokenRequest.fromJson(Map<String, dynamic> json) {
    return _$BearerTokenRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BearerTokenRequestToJson(this);
}
