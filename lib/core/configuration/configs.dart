import 'package:grimoire/core/configuration/env.dart';

class Configs {
  Configs(
      {required this.repositoryUrl,
      required this.accessToken,
      required this.typeSenseUrl,
      required this.typeSenseApiKey});

  String repositoryUrl;
  String accessToken = '';
  String typeSenseUrl;
  String typeSenseApiKey;
}

Configs globalConfig = Configs(
    repositoryUrl: 'http://localhost:3004/api/v4/',
    accessToken: Env.gitAccessToken,
    typeSenseUrl: Env.typesenseUrl,
    typeSenseApiKey: Env.typesenseApiKey);
