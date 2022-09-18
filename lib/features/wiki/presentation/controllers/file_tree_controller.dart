import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_file_tree_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/document_controller.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/injection.dart';

class FileTreeController extends GetxController {
  final GetFileTreeUseCase _getFileTreeUseCase = getIt<GetFileTreeUseCase>();

  final DocumentController _repositoryController = Get.find();

  var state = const Resource<List<FileTreeModel>>.initial('initial').obs;

  void getFileTree(String projectId) async {
    var result = await _getFileTreeUseCase.executeUseCase(projectId);
    var newState = result.map((e) => e?.toModel());
    state.value = newState;
  }

  void onNodeTap(String nodeKey) {
    if (kDebugMode) {
      print('node : $nodeKey');
    }
    FileTreeModel? node =
        state.value.data?.findNode(models: state.value.data!, nodeKey: nodeKey);

    print('node founded : ${node?.name ?? 'not found'}');
    _repositoryController.getDocument(node!);
  }

  void getHomeDocument() {
    var node = state.value.data?.findNodeByPath(models: state.value.data!, path: 'README.md');
    if (node != null) {
      _repositoryController.getHomeDocument(node);
    }

  }

  FileTreeModel? findReference(FileTreeModel content) {
    return state.value.data?.findNodeByPath(models: state.value.data!, path: content.path);
  }
}
