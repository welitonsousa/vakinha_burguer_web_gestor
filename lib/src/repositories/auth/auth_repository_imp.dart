import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/core/rest_client/rest_client.dart';
import 'package:dw10/src/models/auth_model.dart';
import 'package:dw10/src/repositories/auth/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final RestClient _restClient;
  AuthRepositoryImp(this._restClient);

  @override
  Future<AuthModel> sign(String email, String password) async {
    try {
      final res = await _restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
        'admin': true,
      });
      final auth = AuthModel.fromMap(res);
      return auth;
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) throw UnAuthorizeException();
      log('auth error', error: e, stackTrace: s);
      throw RestClientException();
    }
  }
}
