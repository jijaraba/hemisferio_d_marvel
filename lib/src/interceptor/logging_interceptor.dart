// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method;
    final path = options.path;

    print('REQUEST[$method] => PATH: $path');
    print('REQUEST BODY: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final path = response.requestOptions.path;

    print('RESPONSE[$statusCode] => PATH: $path');
    print('RESPONSE DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;

    print('ERROR[$statusCode] => PATH: $path');
    print('ERROR RESPONSE: ${err.response?.data}');
    super.onError(err, handler);
  }
}
