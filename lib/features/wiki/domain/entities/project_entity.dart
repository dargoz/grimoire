import 'file_tree_entity.dart';

class ProjectEntity {
  ProjectEntity(
      {required this.projectId,
      required this.ref,
      required this.fileTree,
      required this.hiddenFileTree});

  String projectId;
  String ref;
  List<FileTreeEntity> fileTree;
  List<FileTreeEntity> hiddenFileTree;
}
