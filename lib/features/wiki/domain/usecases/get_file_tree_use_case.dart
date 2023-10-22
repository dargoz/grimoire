import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/project_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/repository_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@injectable
class GetFileTreeUseCase extends UseCase<ProjectEntity, RepositoryEntity> {
  GetFileTreeUseCase(this._wikiRepository);

  final WikiRepository _wikiRepository;

  @override
  Future<ProjectEntity> useCase(RepositoryEntity params) async {
    var result = await _wikiRepository.getFileTree(
      true,
      100,
      projectId: params.projectId,
      ref: params.ref,
    );
    List<FileTreeEntity> hiddenChildren = List.empty(growable: true);
    var filteredResult = result.where((element) {
      if (isGeneralMarkdown(element)) {
        return true;
      } else {
        hiddenChildren.add(element);
        return false;
      }
    }).toList();
    var tree = List<FileTreeEntity>.empty(growable: true);
    for (var fileTree in filteredResult) {
      var paths = fileTree.path.split('/');
      _add(paths: paths, tree: tree, entity: fileTree);
    }
    return ProjectEntity(
        projectId: params.projectId,
        ref: params.ref,
        fileTree: tree,
        hiddenFileTree: hiddenChildren);
  }

  bool isGeneralMarkdown(FileTreeEntity element) {
    return element.name != 'merge_request_templates' &&
        !element.name.startsWith('.') &&
        !element.name.contains('.spec.') &&
        !element.name.contains('.usage.') &&
        (element.name.contains('.md') || element.type == 'tree');
  }

  void _add(
      {required List<String> paths,
      int position = 0,
      int pathIndex = -1,
      required List<FileTreeEntity> tree,
      required FileTreeEntity entity}) {
    pathIndex = tree.indexWhere((element) => element.name == paths[position]);
    if (pathIndex == -1 || position == paths.length - 1) {
      tree.add(entity);
    } else {
      _add(
          paths: paths,
          position: ++position,
          pathIndex: pathIndex,
          tree: tree[pathIndex].children,
          entity: entity);
    }
  }
}
