class RepositoryTreeRequest {
  String id;
  bool recursive;
  int perPage;
  int page;

  RepositoryTreeRequest(
      {required this.id, required this.recursive, this.perPage = 20, this.page = 1});
}
