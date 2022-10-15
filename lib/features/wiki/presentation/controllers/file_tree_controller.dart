import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_file_tree_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/document_controller.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/pages/grimoire_home_page.dart';
import 'package:grimoire/injection.dart';

import '../../../../core/models/resource.dart';

class FileTreeController extends StateNotifier<Resource<List<FileTreeModel>>> {
  final GetFileTreeUseCase _getFileTreeUseCase = getIt<GetFileTreeUseCase>();
  late final DocumentController _documentController;

  BuildContext? dialogContext;

  FileTreeController(Ref ref)
      : super(const Resource<List<FileTreeModel>>.initial('initial')) {
    _documentController = ref.read(documentStateNotifierProvider.notifier);
  }

  void getFileTree(String projectId) async {
    print('start get file tree');
    var result = await _getFileTreeUseCase.executeUseCase(projectId);
    print('result file tree $result');
    var newState = result.map((e) => e?.toModel());
    print('map to state $newState');
    state = newState;
    print('state updated');
  }

  void onNodeTap(String nodeKey) {
    if (kDebugMode) {
      print('node : $nodeKey');
    }
    FileTreeModel? node =
        state.data?.findNode(models: state.data!, nodeKey: nodeKey);

    print('node founded : ${node?.name ?? 'not found'}');
    _documentController.getDocument(node!);
  }

  FileTreeModel? findReference(FileTreeModel content) {
    return state.data?.findNodeByPath(models: state.data!, path: content.path);
  }

  void success() {
    state =
        Resource<List<FileTreeModel>>.initial('page init', data: state.data);
  }
}
