import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/search_model.dart';

import '../../../../core/models/resource.dart';
import '../../../../injection.dart';
import '../../domain/usecases/search_document_use_case.dart';

final searchStateNotifierProvider =
    StateNotifierProvider<SearchController, Resource<List<SearchModel>>>(
        (ref) => SearchController(ref));

class SearchController extends StateNotifier<Resource<List<SearchModel>>> {

  SearchController(Ref ref)
      : super(const Resource<List<SearchModel>>.initial('initial_search'));

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

  String getPath(int index) {
    var itemFound = state.data?[index];
    if (kDebugMode) {
      print('search item found : ${itemFound?.document?.filePath}');
    }
    return itemFound?.document?.filePath.replaceAll('/', '%2F') ?? '';
  }
}
