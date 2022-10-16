class Configs {
  Configs({required this.repositoryUrl, required this.accessToken});

  String repositoryUrl;
  String accessToken = '';
}

Configs globalConfig = Configs(
    repositoryUrl: 'https://gitlab.com/api/v4/',
    accessToken: 'glpat-6VtJb2k-Ns8SXGApxzbb');
