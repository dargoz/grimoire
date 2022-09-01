import 'package:grimoire/features/wiki/presentation/models/marker_model.dart';

import 'document_model.dart';

class SearchModel {
  SearchModel(
      {required this.document,
      required this.marker,
      required this.textMatch});

  DocumentModel? document;
  List<MarkerModel> marker;
  int textMatch;
}
