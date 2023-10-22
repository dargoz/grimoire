
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/resource.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';

final subDocumentStateNotifierProvider = StateNotifierProvider<
    SubDocumentController,
    AsyncValue<Resource<DocumentModel>>?>((ref) => SubDocumentController(ref));

class SubDocumentController
    extends StateNotifier<AsyncValue<Resource<DocumentModel>>?> {

  SubDocumentController(Ref ref) : super(const AsyncValue.loading());

  Future setSubDocument(Resource<DocumentModel> model) async {
    state = await AsyncValue.guard(() async {
      return model;
    });
  }

  void clear() {
    state = null;
  }
}
