import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../errors/catcher.dart';

class HiveDataSource {
  Uint8List? encryptionKey;

  HiveDataSource() {
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
    } catch (e) {
      Catcher.captureException(e,
          hint: 'may not using https on hosting platform');
    }
  }

  Future<Box> openBox(String name) async {
    Box box;
    if (encryptionKey == null) {
      box = await Hive.openBox(name);
    } else {
      box = await Hive.openBox(name,
          encryptionCipher: HiveAesCipher(encryptionKey!));
    }
    return box;
  }
}
