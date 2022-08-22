import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${'glpat-6VtJb2k-Ns8SXGApxzbb'}';
    if (kDebugMode) {
      print(
          '[INTERCEPTOR] REQUEST[${options.method}] => PATH: ${options.path}');
      print('[INTERCEPTOR] HEADER ==> ${options.headers.toString()}');
      print('[INTERCEPTOR] BODY ==> ${options.data}');
    }
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
      print('[ERROR] data : ${err.response?.data}');
      print('[ERROR] data : ${err.response?.headers}');
      print('[ERROR] data : ${err.response?.requestOptions.data}');
      print('[ERROR] data : ${err.response?.statusCode}');
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
