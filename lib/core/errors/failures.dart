abstract class Failure {
  String errorCode;
  String errorMessage;

  Failure({required this.errorCode, required this.errorMessage});
}

class ServerApiFailure extends Failure {
  ServerApiFailure({required super.errorCode, required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorCode, required super.errorMessage});
}
