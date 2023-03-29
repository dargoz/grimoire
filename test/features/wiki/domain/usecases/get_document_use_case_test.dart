import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_document_use_case.dart';

import '../../../../data/fake_search_repository.dart';
import '../../../../data/fake_wiki_repository.dart';

void main() {
  test('Get Document Tree with README Test', () async {
    var useCase =
    GetDocumentUseCase(FakeWikiRepository(), FakeSearchRepository());
    var actualResult = await useCase.executeUseCase(FileTreeEntity(
        id: 'id',
        name: 'name',
        type: 'tree',
        path: 'path',
        children: [
          FileTreeEntity(
              id: 'id',
              name: 'README.md',
              type: 'tree',
              path: 'path/README.md',
              children: [],
              mode: 'mode'),
          FileTreeEntity(
              id: 'id',
              name: 'file1',
              type: 'bob',
              path: 'path/file1',
              children: [],
              mode: 'mode')
        ],
        mode: 'mode'));
    var expectedResult = '# notes\n'
        '\n'
        'personal notes\n'
        '\n'
        '## Table of Content:\n'
        '1. [M1 - Improper Platform Use](./docs/improper-platform-use.md)\n'
        '2. [M2 - Unintended Data Leakage](./docs/unintended-data-leakage.md) \n'
        '   - [Insecure Data Storage](./docs/insecure-data-storage.md)\n'
        '3. [M3 - Insecure Communication](./docs/insecure-communication.md)\n'
        '   - [Insufficient Transport Layer Protection](./docs/insecure-communication.md#insufficient-transport-layer-protection---trusting-self-signed-or-untrusted-certificates)\n'
        '4. [M4 - Insecure Authentication](./docs/insecure-authentication.md)\n'
        '5. [M5 - Insufficient Cryptography](./docs/insufficient-cryptography.md)\n'
        '6. [M6 - Insecure Authorization](./docs/insecure-authorization.md)\n'
        '7. [M7 - Client Code Quality](./docs/m7/client-code-quality.md)\n'
        '8. [M8 - Code Tampering](./docs/code-tampering.md)\n'
        '9. [M9 - Reverse Engineering](./docs/reverse-engineering.md)\n'
        '10. [M10 - Extraneous Functionality](./docs/extraneous-functionality.md)\n'
        '';
    expect(actualResult.data?.content, expectedResult);
  });

  test('Get Document Tree with Default Content Test', () async {
    var useCase =
        GetDocumentUseCase(FakeWikiRepository(), FakeSearchRepository());
    var actualResult = await useCase.executeUseCase(FileTreeEntity(
        id: 'id',
        name: 'name',
        type: 'tree',
        path: 'path',
        children: [
          FileTreeEntity(
              id: 'id',
              name: 'file0',
              type: 'tree',
              path: 'path/file0',
              children: [],
              mode: 'mode'),
          FileTreeEntity(
              id: 'id',
              name: 'file1',
              type: 'bob',
              path: 'path',
              children: [],
              mode: 'mode')
        ],
        mode: 'mode'));
    var expectedResult = '# name\n'
        '&&&\n'
        '{"id":"id","name":"file0","type":"tree","path":"path/file0","children":[],"mode":"mode"}\n'
        '{"id":"id","name":"file1","type":"bob","path":"path","children":[],"mode":"mode"}\n'
        '&&&';
    expect(actualResult.data?.content, expectedResult);
  });

  test('Get Document Section Count Test', () async {
    var useCase =
        GetDocumentUseCase(FakeWikiRepository(), FakeSearchRepository());
    var actualResult = await useCase.executeUseCase(FileTreeEntity(
        id: 'id',
        name: 'name',
        type: 'blob',
        path: 'path',
        children: [],
        mode: 'mode'));
    expect(actualResult.data?.sections?.length, 2);
  });

  test('parse heading', () {
    var testData = '# data 1\n'
        '---tabs\n'
        'overview\n'
        'spec\n'
        'usage\n'
        '---\n'
        'lorem ipsum';
    RegExp exp = RegExp(r'---([\s\S]*?)---');
    Iterable<Match> matches = exp.allMatches(testData);
    for (Match match in matches) {
      print(match.group(1));
    }
    testData = testData.replaceFirstMapped(exp, (match) => "");
    print('test data : $testData');

  });
}
