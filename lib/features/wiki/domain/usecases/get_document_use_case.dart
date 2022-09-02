import 'dart:convert' show base64, utf8;

import 'package:flutter/foundation.dart';
import 'package:grimoire/core/usecases/usecase.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/section_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/search_repository.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDocumentUseCase extends UseCase<DocumentEntity, FileTreeEntity> {
  GetDocumentUseCase(this._wikiRepository, this._searchRepository);

  final WikiRepository _wikiRepository;
  final SearchRepository _searchRepository;

  @override
  Future<DocumentEntity> useCase(FileTreeEntity params) async {
    params.path = params.path.replaceAll('/', '%2F');
    params.path = params.path.replaceAll('.', '%2E');
    var document = await _wikiRepository.getDocument(params.id, params.path);
    var contentCodeUnits = base64.decode(document.content);
    String decodedContent = utf8.decode(contentCodeUnits);
    document.content = decodedContent;
    document.sections = _parseDocumentSections(decodedContent);
    await _searchRepository.addDocument(document);
    if (kDebugMode) {
      print('indexing done');
    }
    return document;
  }

  List<SectionEntity> _parseDocumentSections(String? content) {
    var sections = List<SectionEntity>.empty(growable: true);
    if (content != null) {
      var contents = content.split('\n');
      for (var section in contents) {

        if (section.startsWith('#')) {
          var attr = section.lastIndexOf('#') + 1;
          var trimSection = section.replaceAll('#', '').trim();
          sections.add(SectionEntity(attr: '$attr', label: trimSection));
        }
      }
    }

    return sections;
  }
}
