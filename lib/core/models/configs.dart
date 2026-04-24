class Configs {
  Configs({required this.repositoryUrl, required this.accessToken});

  String repositoryUrl;
  String accessToken = '';
}

Configs globalConfig = Configs(
  repositoryUrl: 'https://gitlab.com/api/v4/',
  accessToken: 'glpat-JXKHgICOEHba-u7cNlmo5WM6MQpvOjEKdTptZXJkZw8.01.1713evnuf',
);
