import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grimoire/features/wiki/data/sources/local/objects/commit_object.dart';
import 'package:grimoire/features/wiki/data/sources/local/objects/file_object.dart';
import 'package:hive/hive.dart';

import 'package:grimoire/features/wiki/data/sources/local/local_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/catcher.dart';

@Singleton(as: LocalDataSource)
class LocalDataSourceImpl extends LocalDataSource {
  Uint8List? encryptionKey;

  static const String documentBox = 'documentBox';
  static const String projectBox = 'projectBox';

  LocalDataSourceImpl() {
    Hive.registerAdapter(CommitObjectAdapter());
    Hive.registerAdapter(FileObjectAdapter());
    _initializeSecureStorage();
  }

  void _initializeSecureStorage() async {
    try {
      const secureStorage = FlutterSecureStorage();
      // if key not exists return null
      final secureKey = await secureStorage.read(key: 'key');
      if (secureKey == null) {
            final key = Hive.generateSecureKey();
            await secureStorage.write(
              key: 'key',
              value: base64UrlEncode(key),
            );
          }
      final key = await secureStorage.read(key: 'key');
      encryptionKey = base64Url.decode(key!);
      print('Encryption key: $encryptionKey');
    } catch (e) {
      Catcher.captureException(e);
    }
  }

  @override
  void saveDocument(FileObject fileObject) async {
    var encryptedBox = await Hive.openBox(documentBox,
        encryptionCipher: HiveAesCipher(encryptionKey!));
    var id = '${fileObject.blobId}${fileObject.filePath}';
    encryptedBox.put(id, fileObject);
  }

  @override
  Future<FileObject?> getDocument(String id) async {
    var encryptedBox = await Hive.openBox(documentBox,
        encryptionCipher: HiveAesCipher(encryptionKey!));
    return encryptedBox.get(id);
  }

  @override
  Future<String?> loadProject() async {
    var encryptedBox = await Hive.openBox(projectBox,
        encryptionCipher: HiveAesCipher(encryptionKey!));
    return encryptedBox.get('project_id');
  }

  @override
  void saveProject(String projectId) async {
    var encryptedBox = await Hive.openBox(projectBox,
        encryptionCipher: HiveAesCipher(encryptionKey!));
    encryptedBox.put('project_id', projectId);
  }
}
