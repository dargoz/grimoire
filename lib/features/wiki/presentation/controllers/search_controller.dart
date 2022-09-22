import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/search_model.dart';

import '../../../../injection.dart';
import '../../domain/usecases/search_document_use_case.dart';
import '../pages/grimoire_home_page.dart';
import 'document_controller.dart';

class SearchController extends StateNotifier<Resource<List<SearchModel>>> {
  late final DocumentController _documentController;

  SearchController(Ref ref)
      : super(const Resource<List<SearchModel>>.initial('initial_search')) {
    _documentController = ref.read(documentStateNotifierProvider.notifier);
  }

  final SearchDocumentUseCase _searchDocumentUseCase =
      getIt<SearchDocumentUseCase>();

  void onQueryChanged(String query) async {
    if (query.isNotEmpty) {
      var searchResult = await _searchDocumentUseCase.executeUseCase(query);
      state = searchResult
          .map((data) => data?.map((item) => item.toSearchModel()).toList());
    } else {
      state = const Resource.initial('reset');
    }
  }

  void onSearchResultTap(int index) {
    var itemFound = state.data?[index];
    print('search item found : ${itemFound?.document?.filePath}');
    _documentController.getDocument(itemFound!.document!.toFileTreeModel());
  }
}
