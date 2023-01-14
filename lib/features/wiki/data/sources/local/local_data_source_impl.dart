import 'package:grimoire/features/wiki/data/sources/local/objects/commit_object.dart';
import 'package:grimoire/features/wiki/data/sources/local/objects/file_object.dart';
import 'package:hive/hive.dart';

import 'package:grimoire/features/wiki/data/sources/local/local_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/db/hive_data_source.dart';

@Singleton(as: LocalDataSource)
class LocalDataSourceImpl extends HiveDataSource implements LocalDataSource {
  static const String documentBox = 'documentBox';
  static const String projectBox = 'projectBox';

  LocalDataSourceImpl() : super() {
    Hive.registerAdapter(CommitObjectAdapter());
    Hive.registerAdapter(FileObjectAdapter());
  }

  @override
  void saveDocument(FileObject fileObject) async {
    var encryptedBox = await openBox(documentBox);
    var id = '${fileObject.blobId}${fileObject.filePath}';
    encryptedBox.put(id, fileObject);
  }

  @override
  Future<FileObject?> getDocument(String id) async {
    var encryptedBox = await openBox(documentBox);
    return encryptedBox.get(id);
  }

  @override
  Future<String?> loadProject() async {
    var encryptedBox = await openBox(projectBox);
    return encryptedBox.get('project_id');
  }

  @override
  void saveProject(String projectId) async {
    var encryptedBox = await Hive.openBox(projectBox);
    encryptedBox.put('project_id', projectId);
  }
}
