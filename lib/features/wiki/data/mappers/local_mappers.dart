import 'package:grimoire/features/wiki/data/sources/local/objects/commit_object.dart';
import 'package:grimoire/features/wiki/data/sources/local/objects/file_object.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/commit_response.dart';
import 'package:grimoire/features/wiki/data/sources/remote/responses/file_response.dart';
import 'package:grimoire/features/wiki/domain/entities/commit_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';

extension FileMapper on FileObject {
  DocumentEntity toDocumentEntity() {
    return DocumentEntity(
        fileName: fileName,
        filePath: filePath,
        size: size,
        content: content,
        contentSha256: contentSha256,
        blobId: blobId,
        commitId: commitId,
        executeFilemode: executeFilemode,
        commitEntity: commitObject.toCommitEntity());
  }
}

extension DocumentMapper on FileResponse {
  FileObject toFileObject() {
    return FileObject(
        fileName: fileName,
        filePath: filePath,
        size: size,
        encoding: encoding,
        content: content,
        contentSha256: contentSha256,
        ref: ref,
        blobId: blobId,
        commitId: commitId,
        lastCommitId: lastCommitId,
        executeFilemode: executeFilemode,
        commitObject: CommitObject());
  }
}

extension CommitResponseMapper on CommitResponse {
  CommitObject toCommitObject() {
    return CommitObject(
      id: id,
      shortId: shortId,
      createdAt: createdAt,
      parentIds: parentIds,
      title: title,
      message: message,
      authorName: authorName,
      authorEmail: authorEmail,
      authoredDate: authoredDate,
      committerName: committerName,
      committerEmail: committerEmail,
      committedDate: committedDate,
    );
  }
}

extension CommitObjectMapper on CommitObject {
  CommitEntity toCommitEntity() {
    return CommitEntity(
        title: title ?? 'unknown',
        message: message,
        authorName: authorName!,
        authorEmail: authorEmail ?? 'unknown',
        authoredDate: authoredDate ?? 'unknown',
        committerName: committerName ?? 'unknown',
        committerEmail: committerEmail ?? 'unknown',
        committedDate: committedDate ?? 'unknown',
        trailers: '',
        webUrl: '');
  }
}
