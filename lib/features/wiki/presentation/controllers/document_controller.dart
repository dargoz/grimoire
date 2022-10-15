import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:grimoire/features/wiki/domain/usecases/get_document_use_case.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_image_use_case.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/injection.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/models/resource.dart';
import '../utils/html_custom_render.dart';

class DocumentController extends StateNotifier<Resource<DocumentModel>> {
  final GetDocumentUseCase _getDocumentUseCase = getIt<GetDocumentUseCase>();
  final GetImageUseCase _getImageUseCase = getIt<GetImageUseCase>();

  var documentWidgetSections = List<Section>.empty(growable: true);

  AutoScrollController scrollController = AutoScrollController();

  DocumentController(Ref ref)
      : super(const Resource<DocumentModel>.initial('initial'));

  void getDocument(FileTreeModel fileTreeModel) async {
    log('tree model : $fileTreeModel');
    if (state.data?.filePath == fileTreeModel.path) return;
    documentWidgetSections.clear();
    globalSectionIndex = 0;
    state = const Resource<DocumentModel>.loading('fetch data');
    var result =
    await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
    state = result.map((e) => e?.toDocumentModel());
  }

  void getHomeDocument(FileTreeModel fileTreeModel) async {
    documentWidgetSections.clear();
    globalSectionIndex = 0;
    state = const Resource<DocumentModel>.loading('fetch data');
    var result =
    await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
    state = result.map((e) => e?.toDocumentModel());
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
      getHomeDocument(node!);
    }
  }

  void scrollTo(int index) {
    scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  void onSectionClick(String nodeKey) {
    var sectionIndex =
        state.data?.sections.indexWhere((element) => element.id == nodeKey) ??
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
