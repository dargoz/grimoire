import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/resource.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_document_use_case.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_image_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/file_tree_controller.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/injection.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/html_custom_render.dart';

final documentStateNotifierProvider = StateNotifierProvider.autoDispose<
    DocumentController,
    AsyncValue<Resource<DocumentModel>>>((ref) => DocumentController(ref));

class DocumentController
    extends StateNotifier<AsyncValue<Resource<DocumentModel>>> {
  final GetDocumentUseCase _getDocumentUseCase = getIt<GetDocumentUseCase>();
  final GetImageUseCase _getImageUseCase = getIt<GetImageUseCase>();

  var documentWidgetSections = List<Section>.empty(growable: true);

  AutoScrollController scrollController = AutoScrollController();

  DocumentController(this.ref) : super(const AsyncValue.loading()) {
    var fileTreeData = ref.read(fileTreeStateNotifierProvider);
    var model = fileTreeData.value?.data?.findNodeByPath(
        path: 'README.md', models: fileTreeData.value?.data ?? []);
    print('document controller model $model');
    if (model != null) {
      print('model not null in document controller init state');
      _fetchDocument(model);
    }
  }

  final Ref ref;

  Future _loading() async {
    state = await AsyncValue.guard(() async {
      var result = Resource<DocumentEntity>.loading('fetch document data',
          data: state.value?.data?.toEntity());
      return result.map((e) => e?.toDocumentModel());
    });
  }

  Future _error(String message) async {
    state = await AsyncValue.guard(() async {
      var result = Resource<DocumentEntity>.error(message,
          data: state.value?.data?.toEntity());
      return result.map((e) => e?.toDocumentModel());
    });
  }

  Future _fetchDocument(FileTreeModel fileTreeModel) async {
    log('tree model : $fileTreeModel');
    if (state.value?.data?.filePath == fileTreeModel.path) return;
    documentWidgetSections.clear();
    globalSectionIndex = 0;
    state = await AsyncValue.guard(() async {
      var result =
          await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
      return result.map((e) => e?.toDocumentModel());
    });
  }

  Future getDocument(FileTreeModel fileTreeModel) async {
    log('tree model : $fileTreeModel');
    if (state.value?.data?.filePath == fileTreeModel.path) return;
    documentWidgetSections.clear();
    globalSectionIndex = 0;
    _loading();
    state = await AsyncValue.guard(() async {
      var result =
          await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
      return result.map((e) => e?.toDocumentModel());
    });
  }

  Future getDocumentFromPath(String path) async {
    var fileTreeData = ref.read(fileTreeStateNotifierProvider);
    print('try to find path : $path');
    var model = fileTreeData.value?.data
        ?.findNodeByPath(path: path, models: fileTreeData.value?.data ?? []);
    print('document controller model $model');
    if (model != null) {
      getDocument(model);
    } else {
      _error('no data');
    }
  }

  void redirect(
      String text, String? href, List<FileTreeModel> fileTreeModels) async {
    if (kDebugMode) {
      print('text : $text');
      print('href : $href');
    }
    if (href?.indexOf('.') == 0) {
      href = href?.substring(2);
    }
    if (href?.startsWith('http') ?? text.startsWith('http')) {
      if (!await launchUrl(Uri.parse(text))) {
        throw 'Could not launch $href';
      }
    } else if (href?.startsWith('#') ?? text.startsWith('#')) {
      String ref = text.substring(1);
      int sectionIndex =
          documentWidgetSections.indexWhere((element) => element.label == ref);
      if (sectionIndex != -1) {
        scrollTo(sectionIndex);
      }
    } else if (href != null) {
      var node =
          fileTreeModels.findNodeByPath(models: fileTreeModels, path: href);
      getDocument(node!);
    }
  }

  void scrollTo(int index) {
    scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  void onSectionClick(String nodeKey) {
    var sectionIndex = state.value?.data?.sections
            .indexWhere((element) => element.id == nodeKey) ??
        0;
    scrollTo(sectionIndex);
  }

  Future<Widget> getImage(String parentPath, String imageSource) async {
    var model = FileTreeModel(
        id: '',
        name: imageSource,
        type: 'blob',
        path:
            '${parentPath.substring(0, parentPath.lastIndexOf('/'))}/$imageSource');
    var result = await _getImageUseCase.executeUseCase(model.toEntity());
    if (result.status == Status.completed) {
      return Image.memory(base64.decode(result.data!.content));
    } else {
      return const Icon(Icons.broken_image_outlined);
    }
  }
}
