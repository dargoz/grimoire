import 'package:flutter/material.dart';
import 'package:grimoire/features/wiki/domain/entities/commit_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/highlight_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/section_entity.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/marker_model.dart';
import 'package:grimoire/features/wiki/presentation/models/search_model.dart';
import 'package:grimoire/features/wiki/presentation/models/version_model.dart';

import '../../domain/entities/document_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../models/section.dart';

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
    return VersionModel(
        title: title,
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
    return DocumentModel(
        versionModel: commitEntity?.toVersionModel(),
        blobId: blobId,
        sections: sections?.map((e) => e.toSection()).toList() ?? [],
        fileName: fileName,
        filePath: filePath,
        size: size,
        content: content);
  }
}

extension DocumentModelMapper on DocumentModel {
  FileTreeModel toFileTreeModel() {
    return FileTreeModel(
        id: blobId, name: fileName, type: 'blob', path: filePath);
  }
}

extension SectionEntityMapper on SectionEntity {
  Section toSection() {
    var key = GlobalKey();
    return Section(
        id: '${key.hashCode}', label: label, sectionKey: key, attr: attr);
  }
}

extension NodeMapper on FileTreeModel {

  FileTreeEntity toEntity() {
    return FileTreeEntity(
        id: id, name: name, type: type, path: path, children: [], mode: '');
  }
}

extension NodeListMapper on List<FileTreeModel> {

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
        if (node != null) break;
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


extension MarkerModelMapper on HighlightEntity {
  MarkerModel toMarkerModel() {
    return MarkerModel(
        field: field, matchedTokens: matchedTokens, snippet: snippet);
  }
}

extension SearchModelMapper on SearchResultEntity {
  SearchModel toSearchModel() {
    return SearchModel(
        document: documentEntity?.toDocumentModel(),
        marker: highlights?.map((e) => e.toMarkerModel()).toList() ?? [],
        textMatch: textMatch);
  }
}
