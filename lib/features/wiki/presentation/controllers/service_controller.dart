import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/domain/entities/repository_entity.dart';

import '../../../../core/models/resource.dart';
import '../../../../core/usecases/usecase.dart';

final serviceStateNotifierProvider =
    StateNotifierProvider<ServiceController, Resource<dynamic>>(
        (ref) => ServiceController(ref));

class ServiceController extends StateNotifier<Resource<dynamic>> {
  ServiceController(Ref ref)
      : super(const Resource<dynamic>.initial('initial'));

  bool isRefresh = false;

  RepositoryEntity repository = RepositoryEntity(projectId: '', ref: 'main');

  Future<Resource<dynamic>> executeService(
      UseCase useCase, dynamic params) async {
    state =
        Resource<dynamic>.loading('executing use case ${useCase.toString()}');
    state = await useCase.executeUseCase(params);
    return state;
  }

  showError(String errorMessage) {
    state = Resource<dynamic>.error(errorMessage, data: state.data);
  }

  void showLoading(String message) {
    state = Resource<dynamic>.loading(message, data: state.data);
  }

  void hideLoading(String message) {
    state = Resource<dynamic>.initial(message, data: state.data);
  }

  void reset() {
    state = Resource<dynamic>.initial('page init', data: state.data);
  }
}
