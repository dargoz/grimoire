class FileTreeModel {
  FileTreeModel(
      {required this.id,
      required this.name,
      required this.type,
      this.children = const [],
      required this.path});

  String id;
  String name;
  String type;
  List<FileTreeModel> children;
  String path;
}
