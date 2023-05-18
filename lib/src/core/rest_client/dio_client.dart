import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dw10/src/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:dw10/src/core/rest_client/rest_client.dart';
import 'package:dw10/src/core/storage/storage.dart';
import 'package:dw10/src/core/utils/env.dart';
// import 'package:uno/uno.dart';

class DioClient implements RestClient {
  final dio = DioForBrowser(BaseOptions(baseUrl: Env.URL));

  late final AuthInterceptor _authInterceptor;

  DioClient(Storage storage) {
    _authInterceptor = AuthInterceptor(storage: storage);
  }

  @override
  Future<dynamic> delete(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? query}) async {
    final res = await dio.delete(path, data: data, queryParameters: query);
    dio.interceptors.remove(_authInterceptor);
    return res.data;
  }

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? query}) async {
    final res = await dio.get(path, data: data, queryParameters: query);
    dio.interceptors.remove(_authInterceptor);

    return res.data;
  }

  @override
  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? query}) async {
    final res =
        await dio.post(path, data: data ?? formData, queryParameters: query);
    dio.interceptors.remove(_authInterceptor);

    return res.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> put(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? query}) async {
    final res = await dio.put(path, data: data, queryParameters: query);
    dio.interceptors.remove(_authInterceptor);

    return res.data as Map<String, dynamic>;
  }

  @override
  RestClient get unAuth => this;

  @override
  RestClient get auth {
    final contains = dio.interceptors.contains(_authInterceptor);
    if (!contains) dio.interceptors.add(_authInterceptor);
    return this;
  }
}
