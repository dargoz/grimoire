import 'dart:io';

String getString(String fileName) =>
    File('test/data/$fileName').readAsStringSync();
