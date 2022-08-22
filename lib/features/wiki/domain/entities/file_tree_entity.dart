class FileTreeEntity {
  FileTreeEntity(
      {required this.id,
      required this.name,
      required this.type,
      required this.path,
      required this.children,
      required this.mode});

  String id;
  String name;
  String type;
  String path;
  List<FileTreeEntity> children = List.empty(growable: true);
  String mode;
}
