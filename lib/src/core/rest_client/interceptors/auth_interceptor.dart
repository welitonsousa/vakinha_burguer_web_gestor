import 'package:dio/dio.dart';
import 'package:dw10/src/core/storage/storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthInterceptor extends Interceptor {
  final Storage storage;
  AuthInterceptor({required this.storage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = storage.getData(StorageKeys.ACCESS_TOKEN);
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      storage.clear();
      Modular.to.navigate('/sign?unauthorized=true');
    }
    handler.next(err);
  }
}
