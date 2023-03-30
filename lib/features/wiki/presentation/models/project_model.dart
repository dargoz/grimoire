import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';

class ProjectModel {
  ProjectModel(
      {required this.projectId,
      required this.ref,
      required this.fileTree,
      required this.hiddenFileTree});

  String projectId;
  String ref;
  List<FileTreeModel> fileTree;
  List<FileTreeModel> hiddenFileTree;
}
