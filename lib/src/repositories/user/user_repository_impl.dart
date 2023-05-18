import 'dart:developer';

import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/core/rest_client/rest_client.dart';
import 'package:dw10/src/models/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;

  UserRepositoryImpl(this._restClient);

  @override
  Future<UserModel> findById(int id) async {
    try {
      final res = await _restClient.auth.get('/users/$id');
      return UserModel.fromJson(res);
    } catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      throw RestClientException(message: 'Erro ao buscar usuário');
    }
  }
}
