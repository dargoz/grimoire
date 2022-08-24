import 'package:flutter/material.dart';
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
    return Node(
        key: id,
        label: name,
        icon: type == 'tree' ? Icons.folder : Icons.file_present,
        children: children.toNodeList());
  }

  FileTreeEntity toEntity() {
    return FileTreeEntity(
        id: id, name: name, type: type, path: path, children: [], mode: '');
  }
}

extension NodeListMapper on List<FileTreeModel> {
  List<Node> toNodeList() {
    return map((e) => e.toNode()).toList();
  }

  FileTreeModel? findNode(
      {required List<FileTreeModel> models, required String nodeKey}) {
    FileTreeModel? node;
    for (var element in models) {
      if (element.id == nodeKey) {
        node = element;
        break;
      }
      if (element.children.isNotEmpty) {
        node = findNode(models: element.children, nodeKey: nodeKey);
      }
    }
    return node;
  }

  FileTreeModel? findNodeByPath(
      {required List<FileTreeModel> models, required String path}) {
    FileTreeModel? node;
    for (var element in models) {
      if (element.path == path) {
        node = element;
        break;
      }
      if (element.children.isNotEmpty) {
        node = findNodeByPath(models: element.children, path: path);
      }
    }
    return node;
  }
}
