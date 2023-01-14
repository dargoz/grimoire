class Catcher {
  static CatcherHandler? _catcherHandler;

  Catcher._();

  static void init(CatcherHandler catcherHandler) {
    _catcherHandler = catcherHandler;
  }

  static void captureException(e, {String? hint}) {
    _catcherHandler?.captureException(e);
  }
}

abstract class CatcherHandler {
  void captureException(dynamic e);

  void captureMessage();
}
