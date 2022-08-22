import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';

extension FileEntityMapper on FileTreeEntity {
  FileTreeModel toFileTreeModel() {
    return FileTreeModel(
        id: id,
        name: name,
        type: type,
        children: children.toModel(),
        path: path);
  }
}

extension FileListMapper on List<FileTreeEntity> {
  List<FileTreeModel> toModel() {
    return map((e) => e.toFileTreeModel()).toList();
  }
}

extension NodeMapper on FileTreeModel {
  Node toNode() {
    return Node(key: id, label: name, children: children.toNodeList());
  }

  FileTreeEntity toEntity() {
    return FileTreeEntity(id: id, name: name, type: type, path: path, children: [], mode: '');
  }
}

extension NodeListMapper on List<FileTreeModel> {
  List<Node> toNodeList() {
    return map((e) => e.toNode()).toList();
  }
}
