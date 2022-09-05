import 'package:grimoire/core/usecases/usecase.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFileTreeUseCase extends UseCase<List<FileTreeEntity>?, String> {
  GetFileTreeUseCase(this._wikiRepository);

  final WikiRepository _wikiRepository;

  @override
  Future<List<FileTreeEntity>?> useCase(String params) async {
    var result = await _wikiRepository.getFileTree(true, 100, projectId: params);
    var filteredResult = result
        .where((element) =>
            !element.name.startsWith('.') &&
            (element.name.contains('.md') || element.type == 'tree'))
        .toList();
    var tree = List<FileTreeEntity>.empty(growable: true);
    for (var fileTree in filteredResult) {
      var paths = fileTree.path.split('/');
      add(paths: paths, tree: tree, entity: fileTree);
    }
    return tree;
  }

  void add(
      {required List<String> paths,
      int position = 0,
      int pathIndex = -1,
      required List<FileTreeEntity> tree,
      required FileTreeEntity entity}) {
    pathIndex = tree.indexWhere((element) => element.name == paths[position]);
    if (pathIndex == -1 || position == paths.length - 1) {
      tree.add(entity);
    } else {
      add(
          paths: paths,
          position: ++position,
          pathIndex: pathIndex,
          tree: tree[pathIndex].children,
          entity: entity);
    }
  }
}
