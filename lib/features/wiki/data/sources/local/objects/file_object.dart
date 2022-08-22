import 'package:grimoire/features/wiki/data/sources/local/objects/commit_object.dart';
import 'package:hive/hive.dart';

part 'file_object.g.dart';

@HiveType(typeId: 0)
class FileObject extends HiveObject {
  FileObject(
      {required this.fileName,
      required this.filePath,
      required this.size,
      required this.encoding,
      required this.content,
      required this.contentSha256,
      required this.ref,
      required this.blobId,
      required this.commitId,
      required this.lastCommitId,
      required this.executeFilemode,
      required this.commitObject});

  @HiveField(0)
  String fileName;
  @HiveField(1)
  String filePath;
  @HiveField(2)
  int size;
  @HiveField(3)
  String encoding;
  @HiveField(4)
  String content;
  @HiveField(5)
  String contentSha256;
  @HiveField(6)
  String ref;
  @HiveField(7)
  String blobId;
  @HiveField(8)
  String commitId;
  @HiveField(9)
  String lastCommitId;
  @HiveField(10)
  bool executeFilemode;
  @HiveField(11)
  CommitObject commitObject;

  @override
  String toString() {
    return 'FileObject{fileName: $fileName, filePath: $filePath, size: $size, encoding: $encoding, content: $content, contentSha256: $contentSha256, ref: $ref, blobId: $blobId, commitId: $commitId, lastCommitId: $lastCommitId, executeFilemode: $executeFilemode}';
  }
}
