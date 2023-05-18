import 'package:dw10/src/core/storage/session_storage.dart';
import 'package:dw10/src/core/storage/storage.dart';
import 'package:dw10/src/repositories/auth/auth_repository.dart';
import 'package:dw10/src/services/auth/auth_service.dart';

class AuthServiceImp implements AuthService {
  final AuthRepository _authRepository;
  final SessionStorage _sessionStorage;

  AuthServiceImp(this._authRepository, this._sessionStorage);

  @override
  Future<void> sign(String email, String password) async {
    final res = await _authRepository.sign(email, password);
    _sessionStorage.setData(StorageKeys.ACCESS_TOKEN, res.accessToken);
  }
}
