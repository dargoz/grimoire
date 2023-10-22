import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:grimoire/routes/app_route.dart';

import '../configuration/configs.dart';

class CustomInterceptors extends Interceptor {
  CustomInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.accessControlAllowHeadersHeader] =
        HttpHeaders.authorizationHeader;
    options.headers[HttpHeaders.accessControlAllowMethodsHeader] =
        'GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS';
    options.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
    options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${globalConfig.accessToken}';
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
    if (kDebugMode) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      print('[ERROR] data : ${err.response?.data}');
      print('[ERROR] headers : ${err.response?.headers}');
      print('[ERROR] request options : ${err.response?.requestOptions.data}');
      print('[ERROR] status code : ${err.response?.statusCode}');
    }
    switch (err.response?.statusCode) {
      case 500:
      case 400:
      case 401:
        appRouter.go('/login');
        break;
      case 403:
        return handler.resolve(Response<dynamic>(
            requestOptions: err.response!.requestOptions,
            statusCode: err.response?.statusCode,
            data: err.response?.data));
      case 404:
        return handler.resolve(Response<dynamic>(
            requestOptions: err.response!.requestOptions,
            statusCode: err.response?.statusCode,
            data: []));
      default:
        super.onError(err, handler);
        break;
    }
  }
}
