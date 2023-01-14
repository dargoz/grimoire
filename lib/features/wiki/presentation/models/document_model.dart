import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/features/wiki/presentation/models/version_model.dart';

class DocumentModel {
  DocumentModel(
      {required this.versionModel,
      required this.sections,
      required this.blobId,
      required this.fileName,
      required this.filePath,
      required this.size,
      required this.content,
      required this.contentSha256,
      required this.commitId,
      required this.executeFilemode});

  VersionModel? versionModel;
  List<Section> sections;
  String blobId;
  String fileName;
  String filePath;
  int size;
  String content;
  String contentSha256;
  String commitId;
  bool executeFilemode;
}
