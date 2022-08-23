import 'objects/file_object.dart';

abstract class LocalDataSource {
  void saveDocument(FileObject fileObject);
  Future<FileObject?> getDocument(String id);
}