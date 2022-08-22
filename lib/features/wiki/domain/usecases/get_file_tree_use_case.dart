import 'package:grimoire/core/usecases/no_params.dart';
import 'package:grimoire/core/usecases/usecase.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFileTreeUseCase extends UseCase<List<FileTreeEntity>?, NoParams> {
  GetFileTreeUseCase(this._wikiRepository);

  final WikiRepository _wikiRepository;

  @override
  Future<List<FileTreeEntity>?> useCase(NoParams params) async {
    var result = await _wikiRepository.getFileTree(true, 100);
    var filteredResult = result
        .where((element) =>
            !element.name.startsWith('.') &&
            (element.name.contains('.md') || element.type == 'tree'))
        .toList();
    var tree = List<FileTreeEntity>.empty(growable: true);
    for (var fileTree in filteredResult) {
      if (fileTree.type == 'tree') {
        tree.add(fileTree);
        filteredResult.remove(fileTree);
      }
    }
    for (var fileTree in filteredResult) {
      if (fileTree.path.contains('/')) {
        var dir = fileTree.path.split('/');
        var dirIdx = tree.indexWhere((element) => element.name == dir[0]);
        tree[dirIdx].children.add(fileTree);
      }
    }
    return tree;
  }
}
