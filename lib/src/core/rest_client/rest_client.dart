import 'package:dio/dio.dart';

abstract class RestClient {
  Future<dynamic> get(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? query});

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? query,
  });

  Future<Map<String, dynamic>> put(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? query});

  Future<dynamic> delete(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? query});

  RestClient get auth;
  RestClient get unAuth;
}
