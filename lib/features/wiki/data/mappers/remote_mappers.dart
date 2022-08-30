import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/schema_model.dart';
import 'package:typesense/typesense.dart';

import '../sources/remote/gitlab/responses/commit_response.dart';
import '../sources/remote/gitlab/responses/file_response.dart';
import '../sources/remote/gitlab/responses/repository_tree_response.dart';
import 'package:grimoire/features/wiki/domain/entities/commit_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';

extension DocumentMapper on FileResponse {
  DocumentEntity toDocumentEntity() {
    return DocumentEntity(
        fileName: fileName,
        filePath: filePath,
        size: size,
        content: content,
        contentSha256: contentSha256,
        blobId: blobId,
        commitId: lastCommitId,
        executeFilemode: executeFilemode);
  }
}

extension CommitMapper on CommitResponse {
  CommitEntity toCommitEntity() {
    return CommitEntity(
        title: title ?? '',
        message: message,
        authorName: authorName ?? 'unknown',
        authorEmail: authorEmail ?? 'unknown',
        authoredDate: authoredDate ?? 'unknown',
        committerName: committerName ?? 'unknown',
        committerEmail: committerEmail ?? 'unknown',
        committedDate: committedDate ?? 'unknown',
        trailers: trailers,
        webUrl: webUrl ?? 'unknown');
  }
}

extension FileTreeMapper on RepositoryTreeResponse {
  FileTreeEntity toFileTreeEntity() {
    return FileTreeEntity(
        id: id,
        name: name,
        type: type,
        path: path,
        children: List.empty(growable: true),
        mode: mode);
  }
}

extension SchemaMapper on SchemaModel {
  Schema toSchema() {
    return Schema(name, fields);
  }
}

extension FieldSchemaMapper on FileResponse {
  SchemaModel toSchemaModel() {
    var fields = <Field>{};
    toJson().forEach((key, value) {
      Field field;
      if (value is String) {
        field = Field(key, Type.string);
      } else if (value is bool) {
        field = Field(key, Type.bool);
      } else if (value is int) {
        field = Field(key, Type.int32);
      } else if (value is double) {
        field = Field(key, Type.float);
      } else {
        field = Field(key, Type.stringify);
      }
      fields.add(field);
    });
    return SchemaModel('files', fields);
  }
}
