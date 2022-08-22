import 'dart:convert' show base64, utf8;

import 'package:grimoire/core/usecases/usecase.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:grimoire/features/wiki/domain/repositories/wiki_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDocumentUseCase extends UseCase<DocumentEntity, FileTreeEntity> {
  GetDocumentUseCase(this._wikiRepository);

  final WikiRepository _wikiRepository;

  @override
  Future<DocumentEntity> useCase(FileTreeEntity params) async {
    params.path = params.path.replaceAll('/', '%2F');
    params.path = params.path.replaceAll('.', '%2E');
    var document = await _wikiRepository.getDocument(params.id, params.path);
    var contentCodeUnits = base64.decode(document.content);
    String decodedContent = utf8.decode(contentCodeUnits);
    document.content = decodedContent;
    return document;
  }
}
