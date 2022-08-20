import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    print('body : ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      print(err.response?.data);
      print(err.response?.headers);
      print(err.response?.requestOptions.data);
      print(err.response?.statusCode);
    }
    switch (err.response?.statusCode) {
      case 500:
      case 400:
      case 403:
        return handler.resolve(Response<dynamic>(
            requestOptions: err.response!.requestOptions,
            statusCode: 200,
        data: err.response?.data));
      default:
        super.onError(err, handler);
        break;
    }
  }
}
