import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:grimoire/features/wiki/domain/entities/commit_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/version_model.dart';

import '../../domain/entities/document_entity.dart';

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

extension CommitEntityMapper on CommitEntity {

  VersionModel toVersionModel() {
    return VersionModel(title: title,
        message: message,
        authorName: authorName,
        authorEmail: authorEmail,
        authoredDate: authoredDate,
        committerName: committerName,
        committerEmail: committerEmail,
        committedDate: committedDate);
  }

}

extension DocumentEntityMapper on DocumentEntity {

  DocumentModel toDocumentModel() {
    return DocumentModel(versionModel: commitEntity!.toVersionModel(),
        fileName: fileName,
        filePath: filePath,
        size: size,
        content: content);
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
        id: id,
        name: name,
        type: type,
        path: path,
        children: [],
        mode: '');
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
