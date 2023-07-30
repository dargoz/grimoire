import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GIT_ACCESS_TOKEN', obfuscate: true)
  static final String gitAccessToken = _Env.gitAccessToken;

  @EnviedField(varName: 'TYPESENSE_API_KEY', obfuscate: true)
  static final String typesenseApiKey = _Env.typesenseApiKey;

  @EnviedField(varName: 'TYPESENSE_URL')
  static const String typesenseUrl = _Env.typesenseUrl;
}
