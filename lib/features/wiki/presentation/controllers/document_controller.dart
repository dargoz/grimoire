import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_document_use_case.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_image_use_case.dart';
import 'package:grimoire/features/wiki/domain/usecases/search_document_use_case.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/search_model.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/injection.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentController extends GetxController {
  final GetDocumentUseCase _getDocumentUseCase = getIt<GetDocumentUseCase>();
  final GetImageUseCase _getImageUseCase = getIt<GetImageUseCase>();
  final SearchDocumentUseCase _searchDocumentUseCase =
      getIt<SearchDocumentUseCase>();

  BuildContext? dialogContext;

  var data = const Resource<DocumentModel>.initial('initial').obs;
  var searchData =
      const Resource<List<SearchModel>>.initial('initial_search').obs;
  var documentWidgetSections = List<Section>.empty(growable: true);

  void getDocument(FileTreeModel fileTreeModel) async {
    print('tree model : $fileTreeModel');
    if (data.value.data?.filePath == fileTreeModel.path) return;
    documentWidgetSections.clear();
    data.value = const Resource<DocumentModel>.loading('fetch data');
    var result =
        await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
    data.value = result.map((e) => e?.toDocumentModel());
  }

  void getHomeDocument(FileTreeModel fileTreeModel) async {
    documentWidgetSections.clear();
    data.value = const Resource<DocumentModel>.loading('fetch data');
    var result =
    await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
    data.value = result.map((e) => e?.toDocumentModel());
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
        scrollTo(documentWidgetSections.elementAt(sectionIndex));
      }
    } else if (href != null) {
      var node =
          fileTreeModels.findNodeByPath(models: fileTreeModels, path: href);
      getDocument(node!);
    }
  }

  void scrollTo(Section section) {
    print('scroll to');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var targetContext = section.sectionKey.currentContext;
      if (kDebugMode) print('targetContext : $targetContext');
      if (targetContext != null) {
        Scrollable.ensureVisible(targetContext);
      }
    });
  }

  void onSectionClick(String nodeKey) {
    var sectionIndex = data.value.data?.sections
            .indexWhere((element) => element.id == nodeKey) ??
        0;
    var section = documentWidgetSections.elementAt(sectionIndex);
    scrollTo(section);
  }

  void onQueryChanged(String query) async {
    if (query.isNotEmpty) {
      var searchResult = await _searchDocumentUseCase.executeUseCase(query);
      searchData.value = searchResult
          .map((data) => data!.map((item) => item.toSearchModel()).toList());
    } else {
      searchData.value = const Resource.initial('reset');
    }
  }

  void onSearchResultTap(int index) {
    var itemFound = searchData.value.data?[index];
    print('search item found : ${itemFound?.document?.filePath}');
    getDocument(itemFound!.document!.toFileTreeModel());
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
