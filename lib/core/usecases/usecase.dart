import 'package:dio/dio.dart';
import 'package:grimoire/core/errors/failures.dart';
import '../models/resource.dart';

abstract class UseCase<Type, Params> {
  String? resourceMessage;

  Future<Type> useCase(Params params);

  Future<Resource<Type>> executeUseCase(Params params) async {
    try {
      var response = await useCase(params);
      validateResult(response);
      return Resource.completed(response, message: resourceMessage);
    } on DioError catch (dioError) {
      return Resource.error(dioError.response?.data.toString());
    } on FormatException catch (formatException) {
      return Resource.error(formatException.message);
    } on Failure catch (failure) {
      return Resource.error(failure.errorMessage, errorCode: failure.errorCode);
    } on Exception catch (exception) {
      return Resource.error(exception.toString());
    }
  }

  void validateResult(Type data) {}
}
