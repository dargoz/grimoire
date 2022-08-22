class RepositoryTreeRequest {
  String id;
  bool recursive;
  int perPage;

  RepositoryTreeRequest(
      {required this.id, required this.recursive, this.perPage = 20});
}
