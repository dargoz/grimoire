import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_document_use_case.dart';
import 'package:grimoire/features/wiki/domain/usecases/search_document_use_case.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/search_model.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/injection.dart';

class DocumentController extends GetxController {
  final GetDocumentUseCase _getDocumentUseCase = getIt<GetDocumentUseCase>();
  final SearchDocumentUseCase _searchDocumentUseCase = getIt<
      SearchDocumentUseCase>();

  var data = const Resource<DocumentModel>.initial('initial').obs;
  var searchData = const Resource<List<SearchModel>>.initial('initial_search')
      .obs;
  var documentWidgetSections = List<Section>.empty(growable: true);
  var documentAnchorSections = List<Section>.empty(growable: true);

  void getDocument(FileTreeModel fileTreeModel) async {
    documentWidgetSections.clear();
    documentAnchorSections.clear();
    data.value = const Resource<DocumentModel>.loading('fetch data');
    var result =
    await _getDocumentUseCase.executeUseCase(fileTreeModel.toEntity());
    data.value = result.map((e) => e!.toDocumentModel());
  }

  void redirect(String text, String? href, List<FileTreeModel> fileTreeModels) {
    if (kDebugMode) {
      print('text : $text');
      print('href : $href');
    }
    if (href?.indexOf('.') == 0) {
      href = href?.substring(2);
    }
    if (href != null) {
      var node =
      fileTreeModels.findNodeByPath(models: fileTreeModels, path: href);
      getDocument(node!);
    }
  }

  List<Section> parseDocumentSections(String? content) {
    documentAnchorSections = List<Section>.empty(growable: true);
    if (content != null) {
      var contents = content.split('\n');
      for (var section in contents) {
        if (section.startsWith('#')) {
          var trimSection = section.replaceAll('#', '').trim();
          var key = GlobalKey();
          documentAnchorSections.add(Section(
              id: '${key.hashCode}', label: trimSection, sectionKey: key));
        }
      }
    }

    return documentAnchorSections;
  }

  void scrollTo(Section section) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var targetContext = section.sectionKey.currentContext;
      if (kDebugMode) print('targetContext : $targetContext');
      if (targetContext != null) {
        Scrollable.ensureVisible(targetContext);
      }
    });
  }

  void onSectionClick(String nodeKey) {
    var sectionIndex =
    documentAnchorSections.indexWhere((element) => element.id == nodeKey);
    var section = documentWidgetSections.elementAt(sectionIndex);
    scrollTo(section);
  }

  void onQueryChanged(String query) async {
    var searchResult = await _searchDocumentUseCase.executeUseCase(query);
    searchData.value = searchResult.map((data) =>
        data!.map((item) => item.toSearchModel()).toList());
  }
}
