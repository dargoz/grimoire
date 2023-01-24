import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_file_tree_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/service_controller.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/injection.dart';

import '../../../../core/models/resource.dart';

final fileTreeStateNotifierProvider = StateNotifierProvider.autoDispose<
        FileTreeController, AsyncValue<Resource<List<FileTreeModel>>>>(
    (ref) => FileTreeController(ref));

class FileTreeController
    extends StateNotifier<AsyncValue<Resource<List<FileTreeModel>>>> {
  FileTreeController(this.ref) : super(const AsyncValue.loading()) {
    serviceController = ref.read(serviceStateNotifierProvider.notifier);
    log('init file controller');
    _fetchFileTree();
  }

  final Ref ref;
  late final ServiceController serviceController;
  final GetFileTreeUseCase _getFileTreeUseCase = getIt<GetFileTreeUseCase>();

  BuildContext? dialogContext;

  Future _fetchFileTree() async {
    state = await AsyncValue.guard(() async {
      var result =
          await _getFileTreeUseCase.executeUseCase(serviceController.repository);
      var newState = result.map((e) => e?.toModel());
      return newState;
    });
  }

  Future _loading() async {
    state = await AsyncValue.guard(() async {
      var result = Resource<List<FileTreeEntity>?>.loading(
          'fetch document data',
          data: state.value?.data?.map((e) => e.toEntity()).toList());
      return result
          .map((data) => data?.map((e) => e.toFileTreeModel()).toList());
    });
  }

  FileTreeModel? findReference(FileTreeModel content) {
    return state.value?.data
        ?.findNodeByPath(models: state.value!.data!, path: content.path);
  }

  void refresh() {
    _loading();
    _fetchFileTree();
  }
}
