import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/domain/entities/repository_entity.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_file_tree_use_case.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_version_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/service_controller.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/project_model.dart';
import 'package:grimoire/injection.dart';

import '../../../../core/models/resource.dart';
import '../../domain/entities/project_entity.dart';

final fileTreeStateNotifierProvider = StateNotifierProvider.autoDispose<
    FileTreeController,
    AsyncValue<Resource<ProjectModel>>>((ref) => FileTreeController(ref));

class FileTreeController
    extends StateNotifier<AsyncValue<Resource<ProjectModel>>> {
  FileTreeController(this.ref) : super(const AsyncValue.loading()) {
    serviceController = ref.read(serviceStateNotifierProvider.notifier);
    log('init file controller');
    _fetchFileTree();
  }

  final Ref ref;
  late final ServiceController serviceController;
  final GetFileTreeUseCase _getFileTreeUseCase = getIt<GetFileTreeUseCase>();
  final GetVersionUseCase _getVersionUseCase = getIt<GetVersionUseCase>();

  BuildContext? dialogContext;

  Future _fetchFileTree() async {
    state = await AsyncValue.guard(() async {
      var result = await _getFileTreeUseCase
          .executeUseCase(serviceController.repository);
      var newState = result.map((e) => e?.toModel());
      return newState;
    });
  }

  Future _loading() async {
    state = await AsyncValue.guard(() async {
      var result = Resource<ProjectEntity>.loading('fetch document data',
          data: state.value?.data?.toEntity());
      return result.map((data) => data?.toModel());
    });
  }

  FileTreeModel? findReference(FileTreeModel content) {
    return state.value?.data?.fileTree.findNodeByPath(
        models: state.value!.data!.fileTree, path: content.path);
  }

  void refresh() {
    _loading();
    _fetchFileTree();
  }

  Future<List<String>> getBranchList(String text) async {
    var result = await _getVersionUseCase
        .executeUseCase(serviceController.repository.projectId);
    return result.data ?? [];
  }
}
