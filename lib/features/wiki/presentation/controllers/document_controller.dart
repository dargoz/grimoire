import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/presentation/controllers/section_controller.dart';
import 'package:grimoire/features/wiki/presentation/controllers/sub_document_controller.dart';
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

final documentStateNotifierProvider = StateNotifierProvider<DocumentController,
    AsyncValue<Resource<DocumentModel>>>((ref) => DocumentController(ref));

class DocumentController
    extends StateNotifier<AsyncValue<Resource<DocumentModel>>> {
  final GetDocumentUseCase _getDocumentUseCase = getIt<GetDocumentUseCase>();
  final GetImageUseCase _getImageUseCase = getIt<GetImageUseCase>();

  var documentWidgetSections = List<Section>.empty(growable: true);
  var widgetSectionsOffset = List<double?>.empty(growable: true);
  String? section;

  AutoScrollController scrollController = AutoScrollController();

  DocumentController(this.ref) : super(const AsyncValue.loading()) {
    var fileTreeData = ref.read(fileTreeStateNotifierProvider);
    var model = fileTreeData.value?.data?.fileTree.findNodeByPath(
        path: 'README.md', models: fileTreeData.value?.data?.fileTree ?? []);
    print('document controller model $model');
    scrollController.addListener(() {
      try {
        if (widgetSectionsOffset.isEmpty) {
          setDocumentWidgetSectionOffset();
        }

        var context = documentWidgetSections.last.sectionKey.currentContext;
        if (context != null) {
          var newOffset = getWidgetOffset(context);
          if (newOffset != widgetSectionsOffset.last) {
            setDocumentWidgetSectionOffset();
          }
        }

        if (widgetSectionsOffset.isNotEmpty) {
          var nearest = widgetSectionsOffset
              .where((e) => (e ?? 0) <= (scrollController.offset + 50))
              .toList()
            ..sort((a, b) => b!.compareTo(a!));
          int? activeSectionIndex;
          if (nearest.isNotEmpty) {
            activeSectionIndex = widgetSectionsOffset
                .indexWhere((element) => element == nearest.first);
          }
          Future(() {
            ref
                .read(sectionStateNotifierProvider.notifier)
                .setActiveSection(activeSectionIndex);
          });
        }
      } catch (e) {
        print('Scroll Listener Error: $e');
      }
    });
    if (model != null) {
      log('model not null in document controller init state');
      _fetchDocument(model);
    }
  }

  final Ref ref;

  double getWidgetOffset(BuildContext context) {
    var renderBox = context.findRenderObject();
    RenderAbstractViewport viewport = RenderAbstractViewport.of(renderBox);
    var revealedOffset = viewport.getOffsetToReveal(renderBox!, 0);
    return revealedOffset.offset;
  }

  void setDocumentWidgetSectionOffset() {
    if (documentWidgetSections.isNotEmpty) {
      if (documentWidgetSections[0].sectionKey.currentContext != null) {
        widgetSectionsOffset = documentWidgetSections.map((e) {
          return (e.sectionKey.currentContext != null)
              ? getWidgetOffset(e.sectionKey.currentContext!)
              : null;
        }).toList();
      }
    }
  }

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
    log('fetch Document tree model : $fileTreeModel');
    if (state.value?.data?.filePath == fileTreeModel.path) return;
    state = await AsyncValue.guard(() async {
      var result =
          await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
      return result.map((e) => e?.toDocumentModel());
    });
  }

  Future getDocument(FileTreeModel fileTreeModel) async {
    log('getDocument tree model : $fileTreeModel');
    if (state.value?.data?.filePath == fileTreeModel.path) return;
    _loading();
    state = await AsyncValue.guard(() async {
      var result =
          await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
      return result.map((e) => e?.toDocumentModel());
    });
  }

  Future getDocumentFromPath(String path) async {
    var fileTreeData = ref.read(fileTreeStateNotifierProvider);
    log('try to find path : $path');
    var model = fileTreeData.value?.data?.fileTree.findNodeByPath(
        path: path, models: fileTreeData.value?.data?.fileTree ?? []);
    print('document controller model $model');
    if (model != null && fileTreeData.value?.status != Status.loading) {
      _loading();
      state = await AsyncValue.guard(() async {
        var result = await _getDocumentUseCase.executeUseCase(model.toEntity());
        return result.map((e) => e?.toDocumentModel());
      });
    } else {
      _error('no data');
    }
  }

  Future<Resource<DocumentModel>> getSubDocument(String identifier) async {
    var fileTreeData = ref.read(fileTreeStateNotifierProvider);
    var currentFilePath = state.value?.data?.filePath;
    var requestedFilePath = currentFilePath?.split('.').join('.$identifier.');
    print('requested file path : $requestedFilePath');
    var model = fileTreeData.value?.data?.hiddenFileTree.findNodeByPath(
        models: fileTreeData.value?.data?.hiddenFileTree ?? [],
        path: requestedFilePath ?? '');
    if (model != null) {
      print('model $model');
      var result = await _getDocumentUseCase.executeUseCase(model.toEntity());
      return result.map((e) => e?.toDocumentModel());
    }
    return const Resource.error("no data");
  }

  void clear() {
    globalSectionIndex = 0;
    documentWidgetSections.clear();
    Future(() {
      ref.read(sectionStateNotifierProvider.notifier).setActiveSection(null);
    });
    widgetSectionsOffset.clear();
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
      if (node != null) {
        getDocument(node);
      } else {
        _error('file not found');
      }
    }
  }

  void scrollTo(int index) {
    scrollController.scrollToIndex(index,
        duration: const Duration(milliseconds: 5),
        preferPosition: AutoScrollPosition.begin);
  }

  void onSectionClick(String nodeKey) {
    var sectionIndex = ref
            .read(subDocumentStateNotifierProvider)
            ?.value
            ?.data
            ?.sections
            .indexWhere((element) => element.id == nodeKey) ??
        0;
    scrollTo(sectionIndex);
  }

  Future<Widget> getImage(String parentPath, String imageSource,
      {double? width, double? height}) async {
    var model = FileTreeModel(
        id: '',
        name: imageSource,
        type: 'blob',
        path:
            '${parentPath.substring(0, parentPath.lastIndexOf('/'))}/$imageSource');
    var result = await _getImageUseCase.executeUseCase(model.toEntity());
    if (result.status == Status.completed) {
      var bytes = base64.decode(result.data!.content);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    } else {
      return const Icon(Icons.broken_image_outlined);
    }
  }
}
