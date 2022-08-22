import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/core/usecases/no_params.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_file_tree_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/repository_controller.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/injection.dart';

class FileTreeController extends GetxController {
  final GetFileTreeUseCase _getFileTreeUseCase = getIt<GetFileTreeUseCase>();

  final RepositoryController _repositoryController = Get.find();

  var state = const Resource<List<FileTreeModel>>.initial('initial').obs;

  void getFileTree() async {
    var result = await _getFileTreeUseCase.executeUseCase(NoParams());
    var newState =
        Resource<List<FileTreeModel>>.completed(result.data!.toModel());
    state.value = newState;
  }

  void onNodeTap(String nodeKey) {
    if (kDebugMode) {
      print('node : $nodeKey');
    }

    FileTreeModel? node;

    state.value.data?.forEach((element) {
      if (element.children.isNotEmpty) {
        for (var childElement in element.children) {
          print('iterate name : ${childElement.name}');
          if (childElement.id == nodeKey) {
            node = childElement;
            break;
          }
        }
      }
      if (node != null) return;
      if (element.id == nodeKey) node = element;
    });

    print('node founded : ${node?.name ?? 'not found'}');
    _repositoryController.getDocument(node!);
  }
}
