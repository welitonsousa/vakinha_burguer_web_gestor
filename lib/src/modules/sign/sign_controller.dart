import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/services/auth/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'sign_controller.g.dart';

class SignController = _SignControllerBase with _$SignController;

enum SignState { initial, loading, success, error }

abstract class _SignControllerBase with Store {
  final AuthService service;
  _SignControllerBase(this.service);

  @readonly
  String _message = "";

  @readonly
  SignState _state = SignState.initial;

  @action
  Future<void> sign({required String email, required String password}) async {
    try {
      _state = SignState.loading;
      await Future.delayed(const Duration(seconds: 3));
      await service.sign(email, password);
      _state = SignState.success;
    } on UnAuthorizeException {
      _message = "Usuário ou senha inválidos";
      _state = SignState.error;
    } on RestClientException {
      _message = "Erro ao se comunicar com o servidor";
      _state = SignState.error;
    } catch (e) {
      _message = "Erro inesperado";
      _state = SignState.error;
    }
  }
}
