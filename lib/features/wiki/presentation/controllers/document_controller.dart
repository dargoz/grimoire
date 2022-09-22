
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/usecases/get_document_use_case.dart';

import 'package:grimoire/injection.dart';


class DocumentController extends GetxController {
  final GetDocumentUseCase _getDocumentUseCase = getIt<GetDocumentUseCase>();


  BuildContext? dialogContext;



  void getDocument() async {

    print('executing _getDocumentUseCase .... ');
    var result =
        await _getDocumentUseCase.executeUseCase(FileTreeEntity(id: '', name: 'README.md', type: 'blob', path: 'README.md', children: [], mode: ''));
    print('result : $result');
  }



}
