import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GIT_ACCESS_TOKEN', obfuscate: true)
  static final gitAccessToken = _Env.gitAccessToken;

  @EnviedField(varName: 'TYPESENSE_API_KEY', obfuscate: true)
  static final typesenseApiKey = _Env.typesenseApiKey;

  @EnviedField(varName: 'TYPESENSE_URL')
  static const typesenseUrl = _Env.typesenseUrl;
}
