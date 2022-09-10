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

  @override
  String toString() {
    return 'FileTreeModel{id: $id, name: $name, type: $type, children: $children, path: $path}';
  }
}
