import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../../core/usecases/usecase.dart';
import 'package:grimoire/features/wiki/domain/entities/document_entity.dart';
import 'package:grimoire/features/wiki/domain/entities/file_tree_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositories/wiki_repository.dart';

@injectable
class GetImageUseCase extends UseCase<DocumentEntity, FileTreeEntity> {
  GetImageUseCase(this._wikiRepository);

  final WikiRepository _wikiRepository;

  @override
  Future<DocumentEntity> useCase(FileTreeEntity params) async {
    var document = await _wikiRepository.getImage(params.id, params.path);
    return document;
  }
}
