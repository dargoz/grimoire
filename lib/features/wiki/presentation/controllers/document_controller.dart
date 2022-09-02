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
  final SearchDocumentUseCase _searchDocumentUseCase =
      getIt<SearchDocumentUseCase>();

  var data = const Resource<DocumentModel>.initial('initial').obs;
  var searchData =
      const Resource<List<SearchModel>>.initial('initial_search').obs;
  var documentWidgetSections = List<Section>.empty(growable: true);
  var hovers = List<bool>.empty(growable: true).obs;

  void getDocument(FileTreeModel fileTreeModel) async {
    documentWidgetSections.clear();
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
    var sectionIndex = data.value.data?.sections
            .indexWhere((element) => element.id == nodeKey) ??
        0;
    var section = documentWidgetSections.elementAt(sectionIndex);
    scrollTo(section);
  }

  void onQueryChanged(String query) async {
    if (query.isNotEmpty) {
      var searchResult = await _searchDocumentUseCase.executeUseCase(query);
      hovers.value = List<bool>.filled(searchResult.data?.length ?? 0, false,
          growable: true);
      searchData.value = searchResult
          .map((data) => data!.map((item) => item.toSearchModel()).toList());
    } else {
      searchData.value = const Resource.initial('reset');
    }
  }

  onItemHover(int index, bool flag) {
    hovers[index] = flag;
  }
}
