import 'package:grimoire/features/wiki/domain/entities/commit_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/section_entity.dart';

class DocumentEntity {
  DocumentEntity(
      {this.commitEntity,
      this.sections = const [],
      required this.fileName,
      required this.filePath,
      required this.size,
      required this.content,
      required this.contentSha256,
      required this.blobId,
      required this.commitId,
      required this.executeFilemode});

  CommitEntity? commitEntity;
  List<SectionEntity>? sections;
  String fileName;
  String filePath;
  int size;
  String content;
  String contentSha256;
  String blobId;
  String commitId;
  bool executeFilemode;

  @override
  String toString() {
    return 'DocumentEntity{'
        'commitEntity: $commitEntity, '
        'fileName: $fileName, '
        'filePath: $filePath, '
        'size: $size, content: $content, '
        'contentSha256: $contentSha256, '
        'blobId: $blobId, '
        'commitId: $commitId, '
        'executeFilemode: $executeFilemode}';
  }
}
