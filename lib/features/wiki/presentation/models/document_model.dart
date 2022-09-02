import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/features/wiki/presentation/models/version_model.dart';

class DocumentModel {
  DocumentModel(
      {required this.versionModel,
      required this.sections,
      required this.fileName,
      required this.filePath,
      required this.size,
      required this.content});

  VersionModel? versionModel;
  List<Section> sections;
  String fileName;
  String filePath;
  int size;
  String content;
}
