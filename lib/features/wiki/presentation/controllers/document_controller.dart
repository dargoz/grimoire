import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_document_use_case.dart';
import 'package:grimoire/features/wiki/presentation/mappers/presentation_mappers.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/injection.dart';

class DocumentController extends GetxController {
  final GetDocumentUseCase _getDocumentUseCase = getIt<GetDocumentUseCase>();

  var data = const Resource<DocumentModel>.initial('initial').obs;

  void getDocument(FileTreeModel fileTreeModel) async {
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
}
