import 'package:json_annotation/json_annotation.dart';
part 'bearer_token_response.g.dart';

@JsonSerializable()
class BearerTokenResponse{
  @JsonKey(name: 'accessToken')
  String accessToken;
  @JsonKey(name: 'isExpired')
  bool isExpired;

  BearerTokenResponse(this.accessToken, this.isExpired);

  factory BearerTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$BearerTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BearerTokenResponseToJson(this);
}