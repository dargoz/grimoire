import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/core/usecases/no_params.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_file_tree_use_case.dart';

import '../../../../data/fake_wiki_repository.dart';

void main() {
  test('Get File Tree Use Case Test', () async {
    var useCase = GetFileTreeUseCase(FakeWikiRepository());
    var actualResult = await useCase.executeUseCase(NoParams());
    var expectedResult = List<FileTreeEntity>.empty(growable: true);
    addExpectedData(expectedResult);
    expect(actualResult.data!.toString(), expectedResult.toString());
  });
}

void addExpectedData(List<FileTreeEntity> expectedResult) {
  expectedResult.add(FileTreeEntity(
      id: 'd564d0bc3dd917926892c55e3706cc116d5b165e',
      name: 'files',
      type: 'tree',
      path: 'files',
      children: [
        FileTreeEntity(
            id: 'a1e8f8d745cc87e3a9248358d9352bb7f9a0aeba',
            name: 'html',
            type: 'tree',
            path: 'files/html',
            children: [],
            mode: '040000'),
        FileTreeEntity(
            id: '4535904260b1082e14f867f7a24fd8c21495bde3',
            name: 'images',
            type: 'tree',
            path: 'files/images',
            children: [],
            mode: '040000'),
        FileTreeEntity(
            id: '31405c5ddef582c5a9b7a85230413ff90e2fe720',
            name: 'js',
            type: 'tree',
            path: 'files/js',
            children: [],
            mode: '040000'),
        FileTreeEntity(
            id: 'cc71111cfad871212dc99572599a568bfe1e7e00',
            name: 'lfs',
            type: 'tree',
            path: 'files/lfs',
            children: [],
            mode: '040000'),
        FileTreeEntity(
            id: 'fd581c619bf59cfdfa9c8282377bb09c2f897520',
            name: 'markdown',
            type: 'tree',
            path: 'files/markdown',
            children: [
              FileTreeEntity(
                  id: '74c2630ab6ca21f0dee785f71810d9f411b85c5c',
                  name: 'extraneous-functionality.md',
                  type: 'blob',
                  path: 'files/markdown/extraneous-functionality.md',
                  children: [],
                  mode: '100644')
            ],
            mode: '040000'),
        FileTreeEntity(
            id: '23ea4d11a4bdd960ee5320c5cb65b5b3fdbc60db',
            name: 'ruby',
            type: 'tree',
            path: 'files/ruby',
            children: [],
            mode: '040000')
      ],
      mode: '040000'));
  expectedResult.add(FileTreeEntity(
      id: '6f9895bf008468e63baa636483f49686473dd362',
      name: 'improper-platform-use.md',
      type: 'blob',
      path: 'improper-platform-use.md',
      children: [],
      mode: '100644'));
}
